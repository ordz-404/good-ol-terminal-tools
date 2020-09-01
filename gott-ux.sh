echo "Loading UX lib..."


function show_splash() {

cat << "EOF"
#     ______      ______ ________  
#    / ____/____ /_  __//_  __/\ \ 
#   / / __ / __ \ / /    / /    \ \
#  / /_/ // /_/ // /    / /     / /
#  \____/ \____//_/    /_/     /_/ 
#                                  
#  " Good Ol' Terminal Tools >> "

EOF

}

function print_name_date() {

max_char=80
spacer='     '
cur_date=$(date "+ %A %B %d %Y")
welcome_line="‖ ${spacer} Welcome back, Papabear. Today it is$cur_date"
char_count=$(printf '%s\n' "$welcome_line" | wc -c)
	
diff_count=`expr $max_char - $char_count + 1`

for (( c=0; c<=$diff_count; c++ ))
do  
   welcome_line+=' '
done

welcome_line+='‖'

printf '%s\n' "$welcome_line"
	
} 

function show_splash_special() {

echo ""

cat <<"EOF" | sed  's/\n/foo\n/' 
................................................................................
‖                                                                              ‖
‖                                                                              ‖
EOF
print_name_date
cat <<"EOF" | sed  's/\n/foo\n/'
‖                                                                              ‖
‖                                                                              ‖
‖                  .g8"""bgd             7MMMMMM9´`7MMMMMM9´                   ‖
‖                .dP´     `M                MM        MM                       ‖
‖                dm´       `    ,pW"Wq.     MM        MM                       ‖
‖                MM            6W´   `Wb    MM        MM                       ‖
‖                MM.    `7MMF´ 8M     MB    MM        MM                       ‖
‖                `Mb      MM   YA.   ,A9    MM        MM                       ‖
‖                  `"bmmmdPY    `Ybmd9´   .JMML.    .JMML.                     ‖
‖                                                                              ‖
‖                        "Good Ol' Terminal Tools"                             ‖
‖                                                                              ‖
‖        Select an action to perform from the list below.                      ‖
‖                                                                              ‖
‖     ╏ (1)Start Server - Starts a new GoTT Minecraft server instance.         ‖
‖     ╏ (2)Stop Server - Stops the current active server instance.             ‖
‖     ╏ (3)Access Console - Resumes console session of an active instance.     ‖
‖     ╏ (4)Backup Server - Runs GoTT backup utility.                           ‖
‖     ╏ (5)Show Players - Checks the server for number of online players.      ‖
‖     ╏ (6)Show Config - Displays current GoTT config file information.        ‖
‖     ╏ (7)Setup GoTT - Reconfigures the GoTT settings in the config file.     ‖
‖     ╏ (8)Show Version - Displays current version information of GoTT.        ‖
‖     ╏ (0)Quit GoTT - Quit GoTT and return to shell.                          ‖
‖                                                                              ‖
EOF

}

function show_classic_menu() {

	echo ""
	echo "GoTT Menu Selector"
	echo ""
	echo "(1) Start Minecraft server."
	echo "(2) Stop Minecraft server."
	echo "(3) Access Minecraft server console."
	echo "(4) Backup Minecraft server."
	echo "(5) Show current player(s) on Minecraft server."	
	echo "(6) Display current GoTT config file values."
	echo "(7) Reconfigure GoTT config settings."
	echo "(8) Show GoTT version information."
	echo "(0) Exit GoTT."
	echo ""

}

function show_splash_special2() {

cat <<"EOF" | sed  's/\n/foo\n/' 
................................................................................
‖                                                                              ‖
‖                                                                              ‖
‖         Welcome back, ANONYMOUS. Today it is Wednesday 26 August 2020!       ‖
‖                                                                              ‖
‖                                                                              ‖
‖                  .g8"""bgd             7MMMMMM9´`7MMMMMM9´                   ‖
‖                .dP´     `M                MM        MM                       ‖
‖                dm´       `    ,pW"Wq.     MM        MM                       ‖
‖                MM            6W´   `Wb    MM        MM                       ‖
‖                MM.    `7MMF´ 8M     MB    MM        MM                       ‖
‖                `Mb      MM   YA.   ,A9    MM        MM                       ‖
‖                  `"bmmmdPY    `Ybmd9´   .JMML.    .JMML.                     ‖
‖                                                                              ‖
‖                        "Good Ol' Terminal Tools"                             ‖
‖                                                                              ‖
‖        Select an action to perform from the list below.                      ‖
‖                                                                              ‖
‖     ╏ (1)Start Server - Starts a new GoTT Minecraft server instance.         ‖
‖     ╏ (2)Stop Server - Stops the current active server instance.             ‖
‖     ╏ (3)Access Console - Resumes console session of an active instance.     ‖
‖     ╏ (4)Backup Server - Runs GoTT backup utility.                           ‖
‖     ╏ (5)Show Players - Checks the server for number of online players.      ‖
‖     ╏ (6)Show Config - Displays current GoTT config file information.        ‖
‖     ╏ (7)Setup GoTT - Reconfigures the GoTT settings in the config file.     ‖
‖     ╏ (8)Show Version - Displays current version information of GoTT.        ‖
‖     ╏ (0)Quit GoTT - Quit GoTT and return to shell.                          ‖
‖                                                                              ‖
‖        What is your search string? [                                   ]     ‖

EOF

}