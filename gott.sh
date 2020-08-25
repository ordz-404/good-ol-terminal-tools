echo "Loading setup lib..."


function create_setup_file() {

	cat <<EOF > gott.conf
# gott.conf 
# Configuration information for GOTT (Good Ol Terminal Tools)
# Config file created on : `date "+%A %B %d %T %y"`
# Please only modify these values if you know what they are for.

#JRE-RUNTIME
JRE_JAVA="java"

#Server Config Params
JAR="$instance_file_name"
JVM_ARGS="-Xms1024M -Xmx1024M" 
JAR_ARGS="$jar_args"
WORLD_NAME="$instance_name"

#TMUX - Terminal Multipliexer settings
TMUX_WINDOW="minecraft"
TMUX_SOCKET="mc_tmux_socket"
PIDFILE="minecraft-screen.pid"

#Backup Settings
BACKUP_FOLDER="backups"
BACKUP_NAME="\${WORLD_NAME}_backup"
LOGFILE="logs/latest.log"
USE_BUP="NO"

#Constants
EOF

echo 'CUR_YEAR=`date +%Y`' >> gott.conf

}

function ls_bup() {
	bup -d "mc-backups/${CUR_YEAR}" ls "mc-sad-squad/$1"
}


# Note do not move this function above. 


function config_setup() {

	#Check for existing config file, If it exists, prompt over write or abort

	#init_dialogues

	if [ -f "gott.conf" ]
			then
			
			failsafe=0
			#Since this routine is only run once, you don't need to re-init this sequence.
			#overwrite_in="null"
			#overwrite="null"
			
			while [[ $overwrite != "Y" ]]; do
			
				read -p "Config file exists, do you want to overwrite existing file? (Y/N): " overwrite_in 
									
				overwrite=${overwrite_in^^}					
									
				if [[ $overwrite == "N" ]]; 
					then
					echo "Setup Aborting..."
					exit 1

					else
					
						if [[ $overwrite != "Y" ]];
						then
						echo "Invalid response, retrying..."
						failsafe=$(( failsafe+1 ))						
						fi
					
				fi
				
				if [ $failsafe -ge 3 ];
					then
					echo "Maximum amount of retries reached."
					echo "Aborting setup..."
					exit 1
					
				fi
				
			
			done
		
	fi

	#Get inputs to start generating config file.

	while [ 1 ]; do
    
		seqfail=0
	
		echo ""
		read -p "Input Minecraft Instance Name :  " instance_name	
		read -p "Input Minecraft JAR Filename (case-sensitive) :  " instance_file_name	
		read -p "Input JVM Arguments : " jvm_args		
		read -p "Input JAR Arguments : " jar_args
	
		#$instnace_file_name=$instance_file_name | sed 's/ *$//g'
	
		#Pull up confirmation dialogue
			
		failsafe=0	
		
		confirm="null"	
		confirm_in="null"
		
		while [[ $confirm != "Y" ]]; do
	
			#Display input variables
			
			echo ""
			echo $instance_name
			echo $instance_file_name
			echo $jvm_args
			echo $jar_args	
			echo ""
	
				read -p "Is the configuration above correct (Y/N):  "  confirm_in
									
				confirm=${confirm_in^^}						
									
				if [[ $confirm == "N" ]]; 
					then
					
					# Throw in Retry dialogue
					
					failsafe=0
					seqretry="null"
					seqretry_in="null"
					
					while [[ $seqretry != "Y" ]]; do
			
						read -p "Do you wish to re-enter configuration parameters? (Y/N): " seqretry_in
			
						seqretry=${seqretry_in^^}
			
						if [[ $seqretry == "Y" ]]; then
							echo "Initiating retry..."
							clear
							failsafemaster=$(( failsafemaster+1 ))
							config_setup							
						fi
						
						if [[ $seqretry == "N" ]]; 
						then
						echo "Setup Aborting..."
						exit 1

						else
							if [[ $seqretry != "Y" ]];
								then
								echo "Invalid response, retrying..."
								failsafe=$(( failsafe+1 ))						
							fi					
						fi
				
						if [ $failsafe -ge 3 ];
							then
							echo "Maximum amount of retries reached."
							echo "Aborting setup..."
							exit 1
					
						fi	
				
					done	
					
					echo "Setup Aborting..."
					exit 1

				else
					
					if [[ $confirm != "Y" ]];
						then
						echo "Invalid response, retrying..."
						echo ""
						failsafe=$(( failsafe+1 ))						
					fi
					
				fi
				
				if [ $failsafe -ge 3 ];
					then
					echo "Maximum amount of retries reached."
					echo "Aborting setup..."
					exit 1
					
				fi
				
			
		done
		
		#Check if specified server Jar exists
	
		if [ -f "$instance_file_name" ]
			then
			echo "Server JAR file found..."
			echo "Generating new config file..."
			create_setup_file
		else
			echo "Server JAR file not found..."
			echo "setting seqfail=1"
			seqfail=1	
		fi
		
		#If the parameters have error, throw a retry dialogue
		
		if [ $seqfail -ge 1 ]
			then
			
			failsafe=0
			seqretry="null"
			seqretry_in="null"
			
			while [[ $seqretry != "Y" ]]; do
			
				read -p "Config error, Do you want to retry? (Y/N): " seqretry_in
			
				seqretry=${seqretry_in^^}
			
				if [[ $seqretry == "Y" ]]; then
					echo "Initiating retry..."
					clear
					failsafemaster=$(( failsafemaster+1 ))
					config_setup							
				fi
						
				if [[ $seqretry == "N" ]]; 
					then
					echo "Setup Aborting..."
					exit 1

				else
					if [[ $seqretry != "Y" ]];
						then
						echo "Invalid response, retrying..."
						failsafe=$(( failsafe+1 ))						
					fi					
				fi
				
				if [ $failsafe -ge 3 ];
					then
					echo "Maximum amount of retries reached."
					echo "Aborting setup..."
					exit 1
					
				fi	
				
			done				
 			
		fi 
		
		
		
		echo "Setup complete..."
				
		exit
		
		
	
	done

}
