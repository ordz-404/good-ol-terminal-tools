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

## Setup & How to use

Please refer to https://github.com/ordz-404/MC-server-terminal-tools/blob/ordz-404-patch-1/how-to-setup.md for how to set up.

Please refer to https://github.com/ordz-404/MC-server-terminal-tools/blob/ordz-404-patch-1/how-to-use.md on param usages. 

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
