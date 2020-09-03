
## Patch Notes v3.02 - 09/3/2020

GoTT is now moving to beta version 3.0

* Starting a server will now prompt new dialogue box to enter console session. This makes it more intuitive when especially if you're booting up a server instance.

* Stopping a server will now prompt new dialogue box to confirm action. This prevents accidental mishaps from happening.

File - gott.sh

* configuration file will be loaded before libraries are loaded. This ensures all variable settings from the config can be accessed by the libraries when initialising. 

* Interface house keeping. Adding spaces between lines to make it more readable.

File - gott-ux.sh

* Interface now prints the accurate date. Why would you need it? Because GoTT is a fancy tool. 

## Patch Notes v3.01 - 09/1/2020

GoTT is now moving to beta version 3.0

* Gott has a major menu overhaul. Please refer to the how to section on how to navigate through the new interface.

* Gott automatically runs setup dialogue if no existing configuration is detected. 

File - gott.sh

* server backup function has now been streamlined through the interface. The user will be prompt with a dialogue menu  to run a "forced" backup if GoTT detects players on the server.

File - gott-setup.sh

* UX functions have now been moved to gott-ux.sh 

File - gott-ux.sh

* UX or user-interface functions will now be house in this .sh file as an include lib in main gott execuatble.

* A spanking new splash page for GoTT's main menu. Future stream lines will be made should funtionality expand.


## Patch Notes v2.01 - 09/1/2020

File - gott.sh

* function players_online has been totally re-written to check_players. Function will obtain the player count from the minecraft server. A failsafe is also put in place. Should the server not respond within 3 attemps, the process will abort to prevent perpetual loop wait cycle. After obtaining the player count, function will return true / false. 

* function server_backup_safe has been re-written. Function will check for existing players on server. If server is populated, backup will abort unless the force switch is used. To help the minecraft server log the backup process, the function will broadcast within the server a 3 second countdown before the backup process starts. Upon completion, a final broadcast message will be sent into the server informing of a successful backup. (This will be useful when the server is still populated with players. 

* function create_backup_archive has updated. Function will check for existing "backups" folder within the minecraft path. This ensures a writable folder for the archives to be stored in. Tar settings have been updated to add verbose output from the terminal. ( This is to see the progress of the backup happening and force manual a termination if there is an error ) 

* Added a switch `isempty` to ping the server for player count. 

File - gott-setup.sh

* function create_setup_file backup folder variable has been added and a future option to change this variable will be added into the setup menus.
