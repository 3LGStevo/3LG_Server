# 3LG_Server
All server files associated with the old 3LG server for Arma 3 Altis Life.

Any support for these files are no longer provided by Three Lions Gaming, or any members associated with Three Lions Gaming.

Any remaining bugs in the files must be addressed by any new administrators of the files.

Please note; the ASM executable has not been provided and will need to be tracked down.
All instructions below are to be used on a DEDICATED SERVER HOST only, and adaptations of the process will need to be followed for non-dedidcated hosts.

===========================================================================

Server Installation

1. Download all files from the "3LG_Server" branch.
2. Download all files from the "Commands" branch.
3. Ensure you have all the prerequisites installed for Arma 3 Server (SteamCMD, MySQL etc...)
4. Edit the server_check.cmd command file, where "User" is your steam username, and "Password" is your steam account password
5. Run the server_check.cmd file to generate the Arma 3 Server
6. Copy the following folders into your Arma 3 Server directory: @ExtDB, ASM, Battleye, Users
7. Inside the ASM folder, copy each of the files out to your root directory, as well as the @ASM folder
8. Copy the CONFIG_Server.cfg file into the directory

Database Installation
1. Make a connection to your local MySQL database
2. Import the server_create.sql file
3. Execute the script

Mission File Installation
1. Download all files from the "3LG Life RPG.Altis" branch
2. Pack all files into a PBO file (PBO manager required)
3. Copy the PBO File into the MPMissions folder inside your Arma 3 Server Directory

Life Server Installation
1. Download all files from the "Life_Server" branch
2. Inside the Addons folder, pack the Life_Server folder into a PBO file
3. Create a folder in your Arma 3 Server Directory called @life_server
4. Inside the @life_server folder, create another folder - addons
5. Inside the addons folder, insert the life_server.pbo file

Execution
- A Windows Scheduled task has been provided to allow for server scheduled server restarts, import this into your Windows Task Scheduler, and amend the properties as required (this may take a bit of tweaking).
- To execute the server as system, run the scheduled task.
- To execute the server as the logged on user, inside the "Commands" directory, run the "Server_check.ps1" powershell script file.
