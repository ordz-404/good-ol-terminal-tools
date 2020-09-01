#!/bin/bash

cd $(dirname $0)

temp=$( realpath "$0"  ) && folderpath=$(dirname "$temp")

clear

echo "Initialising...GOTT from " $folderpath
echo ""
echo "Loading Libraries..."

#New libraries to go below here

. gott-setup.sh
. gott-ux.sh

echo "Libraries initialisation successful."
echo ""

sleep 1

#Check for existing config file.

echo "Scanning for existing GoTT configuration..."
echo ""

if [ -e "gott.conf" ]
	then
		
		source "gott.conf"
		echo "Configuration file loaded successfully."
		echo ""
		
		sleep 1
		
	else
		#Runs the setup configurator dialog.
		init_setup_dialog
		
		#exit 1
fi

#Check for existing log file
echo "Checking for existing server log file in" $LOGFILE "..."

if [ -r $LOGFILE ]
	then
		echo "Minecraft server log file located... "
		#echo ""
		
	else
		echo "Gott requires access to latest.log, please check that file exists in configuration path."
		exit 1
fi


function backup_hook_example {
	bup -d $CUR_BACK_DIR ls -l $BACKUP_NAME/latest/var/minecraft
}


function send_cmd () {
	tmux -S $TMUX_SOCKET send -t $TMUX_WINDOW "$1" enter
}

function assert_running() {
	if server_running; then
		echo ""
		echo "An active Minecraft server instance has been detected." 
		echo "Please use option (3) if you wish to access the server console."
		
		#Return to selection menu
		return_to_menu
		
		
		
	fi
}

function assert_not_running() {
	if ! server_running; then
		echo "Server not running"
		exit 1
	fi
}

function server_start() {
	assert_running

	if [ ! -f "eula.txt" ]
	then
		echo "eula.txt not found. Creating and accepting EULA."
		echo "eula=true" > "eula.txt"
	fi

	tmux -S $TMUX_SOCKET new-session -s $TMUX_WINDOW -d \
		$JRE_JAVA $JVM_ARGS -jar $JAR $JAR_ARGS
	pid=`tmux -S $TMUX_SOCKET list-panes -t $TMUX_WINDOW -F "#{pane_pid}"`
	echo $pid > $PIDFILE
	echo Started with PID $pid
	exit
}

function server_stop() {
	# Allow success even if server is not running
	#trap "exit 0" EXIT

	assert_not_running
	send_cmd "stop"

	local RET=1
	while [ ! $RET -eq 0 ]
	do
		sleep 1
		ps -p $(cat $PIDFILE) > /dev/null
		RET=$?
	done

	echo "stopped the server"

	rm -f $PIDFILE

	exit
}

function server_attach() {
	assert_not_running
	
	echo "Now attempting to resume existing session..."
	sleep 1
	tmux -S $TMUX_SOCKET attach -t $TMUX_WINDOW
	exit
}

function server_running() {
	if [ -f $PIDFILE ] && [ "$(cat $PIDFILE)" != "" ]; then
		ps -p $(cat $PIDFILE) > /dev/null
		return
	fi
	
	false
}

function server_status() {
	if server_running
	then
		echo "Server is running"
	else
		echo "Server is not running"
	fi
	exit
}


function check_players() {

	echo "Checking number of online players..."

	failsafe=0
	send_cmd "list"
	
	#Failsafe measure to ensure server prints the player count into chat logs. Wait on server 
	
		while [ $(tail -n 3 "$LOGFILE" | grep -c "players online") -lt 1 ]
	do
		echo "Still waiting on server response..."
				
		if [ $failsafe -ge 4 ]; then

			echo "Retry limit reached."
			echo "Unable to determine players online."
				
			exit
			
		else 	
			failsafe=$(( failsafe+1 ))
		fi
	
		sleep 1
	done
	
	#On success, we now determine if there are 0 or more players. 
	
	output=$(grep "players online." $LOGFILE | tail -n 1)
			
		if [[ $output =~ "There are 0" ]]; then	
	
		echo "There are no players on the server."
		return
	
	else			
		echo "Players exist on the server"		
		echo $output
	fi	
		
	false
	
}

function server_backup_safe() {
	force=$1
			
	echo "Detected running server. Checking if players online..."
	
	# Call the function to check for players.
		
	if (! check_players) ; then
	
		if [[ $force == "true" ]]; then
		
			echo "Forced switch detected..."
			echo "Backup will still continue with players in server..."
	
		else
	
			echo "There are currently players on the server, backup will now abort." 
			echo "To force a backup session, use instead fbackup."
			echo "Backup is aborting..."
			
			return
		
		fi	
		
	else 
		
		echo "Checking complete..."
			
	fi

	echo "Disabling minecraft server autosave..."
	send_cmd "save-off"
	send_cmd "save-all flush"
	echo "Waiting for save... If froze, run /save-on to re-enable autosave!!"
	
	sleep 1
	
	while [ $(tail -n 3 "$LOGFILE" | grep -c "Saved the game") -lt 1 ]
	do
		sleep 1
	done
	sleep 2
	
	#Use Minecraft console command to broadcast backup start.
	send_cmd "say Minecraft Tools will commence backup in ... 3"
	sleep 1
	send_cmd "say Minecraft Tools will commence backup in ... 2"
	sleep 1
	send_cmd "say Minecraft Tools will commence backup in ... 1"
	sleep 1
	send_cmd "say Minecraft Tools is backing up server. Please stand-by..."
	
	echo "Minecraft server instance is being written to local disk..."

	if [ $USE_BUP = "YES" ]; then
	
		#create_bup_backup
		echo "Hello"
		
	else
	
		create_backup_archive
				
	fi
	
	local RET=$?

	echo "Re-enabling auto-save"
	send_cmd "save-on"

	#echo $RET "status code..."

	if [ $RET -eq 0 ]
	then
		#echo Running backup hook
		
		#Return code 0 success
		echo "Backup process has completed..."
		send_cmd "say Minecraft Tools has successfully backed up the server. "
		
	fi
}

function server_backup_unsafe() {
	echo "No running server detected. Running Backup"

	if [ $USE_BUP = "YES" ]; then
		create_bup_backup
	else
		create_backup_archive
	fi

	if [ $? -eq 0 ]
	then
		echo Running backup hook
		$BACKUP_HOOK
	fi
}

function create_bup_backup() {
	BACKUP_DIR="mc-backups"
	CUR_BACK_DIR="mc-backups/$CUR_YEAR"

	if [ ! -d "$CUR_BACK_DIR" ]; then
	mkdir -p "$CUR_BACK_DIR"
	fi


	bup -d "$CUR_BACK_DIR" index "$WORLD_NAME"
	status=$?
	if [ $status -eq 1 ]; then
	bup -d "$CUR_BACK_DIR" init
	bup -d "$CUR_BACK_DIR" index "$WORLD_NAME"
	fi

	bup -d "$CUR_BACK_DIR" save -n "$BACKUP_NAME" "$WORLD_NAME"

	echo "Backup using bup to $CUR_BACK_DIR is complete"
}

# TODO: Make default .tar with optional bup

function create_backup_archive() {

	# Checks for existing directory.
	# Current directory is hardcoded

	#Directory is made incase it is missing.	
	mkdir -p $BACKUP_FOLDER

	ARCHNAME="$BACKUP_FOLDER/$WORLD_NAME-backup_`date +%d-%m-%y-%T`.tar.gz"
	echo "Backup is in progress... This may take a while... please wait..."
	
	# TAR settings to exclude backup folder, so it doesn't back up itself adding file size.
	tar --exclude=$BACKUP_FOLDER -czvf "$ARCHNAME" "$folderpath" 	

	echo "Zip processes ended"

	tarexitcode=$?

	if [ $tarexitcode != 0 ] 
	then
	
		if [ $tarexitcode != 1 ] 
		then	
		echo "TAR failed. No Backup created."		
		rm $ARCHNAME #remove (probably faulty) archive
		#return 1		
		fi
		
	else
		echo "Minecraft server has successfully been backed up @ "
		echo $ARCHNAME 
	fi
}

function backup_running() {
	systemctl is-active --quiet mc-backup.service
}

function fbackup_running() {
	systemctl is-active --quiet mc-fbackup.service
}

function server_backup() {
	force=$1

	if [ "$force" = "true" ]; then
        if backup_running; then
            echo "A backup is running. Aborting..."
            return
        fi
    else
        if fbackup_running; then
            echo "A force backup is running. Aborting..."
            return
        fi
	fi

	if server_running; then 
		server_backup_safe "$force"
	else 
		server_backup_unsafe
	fi

	exit
}

function show_config() {

	echo ""
	echo "Printing current GOTT config file"
	echo ""
	
	less -FX gott.conf
	
	echo ""

}

function ls_bup() {
	bup -d "mc-backups/${CUR_YEAR}" ls "mc-sad-squad/$1"
}

function create_selection_menu() {

	failsafe=0
	selection_menu="null"

	while [[ $selection_menu != "0" ]]; do

		#show_splash
		
		show_splash_special
			
		read -p "‖        What is your input option? " selection_menu_in
									
		selection_menu=${selection_menu_in^^}					
					

						
		if [[ $selection_menu == "0" ]]; 
			then
			
			# if selector detects 0, immediate quit. If not, run case values.
			
			echo ""
			echo "Quitting GoTT."
			exit 1

			else

			case $selection_menu in
			
				"1")
				server_start
				return_to_menu
				;;
				"2")
				server_stop
				;;
				"3")
				server_attach
				;;
				"4")
				server_backup
				;;
				"status")
				server_status
				return_to_menu
				;;		
				"5")
				check_players
				return_to_menu
				;;		
				"fbackup")
				server_backup "true"
				;;
				"7")
				config_setup
				;;
				"6")
				show_config
				return_to_menu				
				;;
				"9")
				show_splash_special
				return_to_menu				
				;;					
				"ls")
				ls_bup $2
				;;
				*)
							
				# After Passing through all arguments and selection is not any of the above.
				
				if [[ $selection_menu != "0" ]];
					then
					echo ""
					echo "Invalid response, retrying..."
					sleep 1
					clear
			
					failsafe=$(( failsafe+1 ))						
					
				fi			
				
				if [ $failsafe -ge 3 ];
				then
				echo "Maximum amount of retries reached."
				echo "Quitting GoTT."
				exit 1
					
				fi									
				;;
			
			esac

			#Reset screen before returning
			clear

		fi					
			
	done
		
}

function return_to_menu() {

	
			#Since this routine is only run once, you don't need to re-init this sequence.
			returnto_in="null"
			returnto="null"
			
			while [[ $returnto != "Y" ]]; do
			
				read -p "Press any key, and hit enter to return to main menu." returnto_in
									
				returnto="Y"			
				clear
			
			done
				
	create_selection_menu

}


case $1 in
	"start")
		server_start
		;;
	"stop")
		server_stop
		;;
	"attach")
		server_attach
		;;
	"backup")
		server_backup
		;;
	"status")
		server_status
		;;		
	"isempty")
		check_players
		;;		
	"fbackup")
		server_backup "true"
		;;
	"setup")
		config_setup
		;;
	"showconfig")
		show_config
		;;				
	"ls")
		ls_bup $2
		;;
	*)
		create_selection_menu
		#echo "Usage: $0 start|stop|attach|status|backup|isempty"
		;;
esac
