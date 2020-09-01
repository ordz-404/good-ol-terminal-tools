# Good Ol' Terminal Tools (GoTT) BETA

GoTT is a command line interface minecraft server management tool. This tool is intentionally made in a "command line" style and is an ode to old-school computing before graphic user interfaces were designed in modern computing and is reminiscent of "MS-DOS". 

Original Source code and credits: https://github.com/kompetenzbolzen/minecraft-server-tools by Jonas Gunz 

## Features

* Allows administrators to resume a console "session" if disconnected from shell.

* Check the operational status of a particular minecraft instance. 

* One command backup - Performs a full backup to a specified folder within the minecraft directory compressed in TAR  format.


## Requirements & Pre-requisites
GoTT requires access to read the "latest.log" to function properly. This file is located in the "logs" directory by default. By default, minecraft servers have enabled logging by default. Should GoTT be unable to access the log, this utility will not be able to perform its intended functions.


## Platform Compatability
Tested on Ubuntu 18.04

Platform: AWS

## How to use

GoTT 3.0 comes with a newly built in user interface. Please see screenshot for further instructions. 

![Image of Howtouse](https://github.com/ordz-404/good-ol-terminal-tools/blob/master/howtouse-small.png)

## Patch Notes 3.01 - 09/1/2020

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


## Patch Notes 2.01 - 09/1/2020

File - gott.sh

* function players_online has been totally re-written to check_players. Function will obtain the player count from the minecraft server. A failsafe is also put in place. Should the server not respond within 3 attemps, the process will abort to prevent perpetual loop wait cycle. After obtaining the player count, function will return true / false. 

* function server_backup_safe has been re-written. Function will check for existing players on server. If server is populated, backup will abort unless the force switch is used. To help the minecraft server log the backup process, the function will broadcast within the server a 3 second countdown before the backup process starts. Upon completion, a final broadcast message will be sent into the server informing of a successful backup. (This will be useful when the server is still populated with players. 

* function create_backup_archive has updated. Function will check for existing "backups" folder within the minecraft path. This ensures a writable folder for the archives to be stored in. Tar settings have been updated to add verbose output from the terminal. ( This is to see the progress of the backup happening and force manual a termination if there is an error ) 

* Added a switch `isempty` to ping the server for player count. 

File - gott-setup.sh

* function create_setup_file backup folder variable has been added and a future option to change this variable will be added into the setup menus.

## Disclaimer & Limited Warranty

#### No Warranties
The Author of this Software expressly disclaims any warranty for the SOFTWARE PRODUCT. The SOFTWARE PRODUCT and any related documentation is provided “as is” without warranty of any kind, either express or implied, including, without limitation, the implied warranties or merchantability, fitness for a particular purpose, or noninfringement. The entire risk arising out of use or performance of the SOFTWARE PRODUCT remains with you.

#### No Liability For Damages
In no event shall the author of this Software be liable for any special, consequential, incidental or indirect damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or any other pecuniary loss) arising out of the use of or inability to use this product, even if the Author of this Software is aware of the possibility of such damages and known defects.

### Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
CC-BY-NC-SA This license requires that reusers give credit to the creator. It allows reusers to distribute, remix, adapt, and build upon the material in any medium or format, for noncommercial purposes only. If others modify or adapt the material, they must license the modified material under identical terms.

BY: Credit must be given to you, the creator.
NC: Only noncommercial use of your work is permitted.
SA: Adaptations must be shared under the same terms.
