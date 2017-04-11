$Running = (Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server_Test\*'}).Count -gt 0
if(!$Running)
{
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-enableHT -profiles=C:\Servers\Arma3\3LG_Server_Test\ -BEpath=C:\Servers\Arma3\3LG_Server_Test\battleye -port=2312 -cfg=Users\Administrator\arma3.cfg -config=CONFIG_server.cfg -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle -autoinit"
    Start-Sleep 60
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-client -connect=127.0.0.1:2312 -password=info -profiles=C:\Servers\Arma3\3LG_Server_Test\Users\HC1 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-client -connect=127.0.0.1:2312 -password=info -profiles=C:\Servers\Arma3\3LG_Server_Test\Users\HC2 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-client -connect=127.0.0.1:2312 -password=info -profiles=C:\Servers\Arma3\3LG_Server_Test\Users\HC3 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
}
else
{
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server_Test\*'}| Stop-Process
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server_Test\*'}| Stop-Process
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server_Test\*'}| Stop-Process
    Get-Process arma3server | Where-Object {$_.Path -like '*C:\Servers\Arma3\3LG_Server_Test\*'}| Stop-Process
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-enableHT -profiles=C:\Servers\Arma3\3LG_Server_Test\ -BEpath=C:\Servers\Arma3\3LG_Server_Test\battleye -port=2312 -cfg=Users\Administrator\arma3.cfg -config=CONFIG_server.cfg -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle -autoinit"
    Start-Sleep 60
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-client -connect=127.0.0.1:2312 -password=info -profiles=C:\Servers\Arma3\3LG_Server_Test\Users\HC1 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-client -connect=127.0.0.1:2312 -password=info -profiles=C:\Servers\Arma3\3LG_Server_Test\Users\HC2 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
    Start-Process C:\Servers\Arma3\3LG_Server_Test\arma3server.exe "-client -connect=127.0.0.1:2312 -password=info -profiles=C:\Servers\Arma3\3LG_Server_Test\Users\HC3 -mod=@extDB;@life_server;@asm;curator;kart;heli;mark;expansion;dlcbundle"
}

