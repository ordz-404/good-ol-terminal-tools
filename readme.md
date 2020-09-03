# Good Ol' Terminal Tools (GoTT) BETA

GoTT is a command line interface minecraft server management tool. This tool is intentionally made in a "command line" style and is an ode to old-school computing before graphic user interfaces were designed in modern computing and is reminiscent of "MS-DOS". Note that GoTT is in active development and there will be minor changes daily until a release version has been published. 

Special thanks and credits to Jonas Gunz for the original Source code https://github.com/kompetenzbolzen/minecraft-server-tools   

## Core Features

* Intuitively runs setup and configuration dialogues on "first run"

* Resumable Minecraft console session. Disconnect and reconnect to running instance anytime. 

* Check the operational status of a particular minecraft instance. 

* Intelligent Backup - Performs a full backup to a specified folder within the minecraft directory compressed in TAR format, with "forced" mode to perform backup even if server isn't empty.


## Requirements & Pre-requisites

GoTT requires access to read the "latest.log" to function properly. This file is located in the "logs" directory by default. By default, minecraft servers have enabled logging by default. Should GoTT be unable to access the log, this utility will not be able to perform its intended functions. It is a requirement that an administrator account is used to run GoTT, with read/write/execute privileges within minecraft and it's sub-folders.

* Root, Admin or Sudo access.

* Access to minecraft's server logs. Please ensure that your server is actively logging server activity into the "latest.logs" file. 

* Some basic knowledge for terminal/shell usage.


## Platform Compatability
Tested on Ubuntu 18.04

Platform: AWS

## How to use

GoTT 3.0 comes with a newly built in user interface. Please see screenshot for further instructions. 

`To start GoTT, run the commant 'sudo ./gott.sh' to initialise the tool`

![Image of Howtouse](https://github.com/ordz-404/good-ol-terminal-tools/blob/master/howtouse-small.png)

## Patch Notes v3.1 - 09/4/2020

GoTT is now moving to beta version 3.1

* GoTT Interface menu now displays colour coded server status.

* Interface menu now shows current version. 

File - gott-ux.sh

* Functions have been added to display new status and version number. 

File - gott.ver

* Added versioning file to GoTT. This file will contain the version number packed with official releases.

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
