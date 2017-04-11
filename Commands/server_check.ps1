$Running = (Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server\*'}).Count -gt 0
if(!$Running)
{
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-enableHT -profiles=C:\Servers\Arma3\3LG_Server\ -BEpath=C:\Servers\Arma3\3LG_Server\battleye -port=2302 -cfg=Users\Administrator\arma3.cfg -config=CONFIG_server.cfg -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle -autoinit"
    Start-Sleep 120
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-client -connect=127.0.0.1:2302 -profiles=C:\Servers\Arma3\3LG_Server\Users\HC1 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-client -connect=127.0.0.1:2302 -profiles=C:\Servers\Arma3\3LG_Server\Users\HC2 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-client -connect=127.0.0.1:2302 -profiles=C:\Servers\Arma3\3LG_Server\Users\HC3 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
}
else
{
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server\*'}| Stop-Process
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server\*'}| Stop-Process
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server\*'}| Stop-Process
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server\*'}| Stop-Process
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-enableHT -profiles=C:\Servers\Arma3\3LG_Server\ -BEpath=C:\Servers\Arma3\3LG_Server\battleye -port=2302 -cfg=Users\Administrator\arma3.cfg -config=CONFIG_server.cfg -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle -autoinit"
    Start-Sleep 120
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-client -connect=127.0.0.1:2302 -profiles=C:\Servers\Arma3\3LG_Server\Users\HC1 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-client -connect=127.0.0.1:2302 -profiles=C:\Servers\Arma3\3LG_Server\Users\HC2 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server\Arma3Server.exe "-client -connect=127.0.0.1:2302 -profiles=C:\Servers\Arma3\3LG_Server\Users\HC3 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
}

