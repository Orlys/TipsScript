:: -----------------------------------------------------------------------
:: 
::　　　　　　　　 This script is just for research to use.
::
:: 
:: This script will download
:: 1. 7-zip
:: 2. Chrome
:: And setup the 
:: 1. Windows RDP and allow firewall port at 8889 (change it by yourself)
:: 2. Remove system volume icon
:: 3. Add Control panel to desktop
:: 4. Add This-pc to desktop
:: Before installed, this script will reboot your server.
:: -----------------------------------------------------------------------

@echo off
set /a port=8889


goto check_Permissions
:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Administrative permissions confirmed.

	:: download 7-zip
	bitsadmin /transfer 7zip /download /priority normal "https://www.7-zip.org/a/7z1900-x64.exe" "7z.exe"
	7z.exe 
	
	:: ----------------------------------------
	:: download Windows cracker
	:: UNNUCCESSARY, OR MAYBE NOT :)
	:: IF YOU REALLY NEED THIS, YOU SHOULD DIS-
	:: ABLE ANTI-VIRUS SOFTWARE.
	:: ----------------------------------------
	:: bitsadmin /transfer Crarker/download /priority normal "http://download2326.mediafire.com/tbgz65fm12bg/92u5ky0mse8qnnl/microsoft-toolkit-Activator.rar" "cracker.exe"
	:: cracker.exe
	:: pause


	:: ----------------------------------------
	:: add firewall rule, allow TCP port %port%
	:: ----------------------------------------
        netsh advfirewall firewall add rule name="RDP" protocol="TCP" dir="in" localport=%port% action="allow" 
	

	:: ----------------------------------------
	:: enable RDP and change port to %port%
	:: ----------------------------------------
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "PortNumber" /t REG_DWORD /d %port% /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v "PortNumber" /t REG_DWORD /d %port% /f
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

	:: ----------------------------------------
	:: add "Control Panel" to desktop	
	:: ----------------------------------------
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d "0" /f
	
	:: ----------------------------------------
	:: add "This-PC" to desktop
	:: ----------------------------------------
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d "0" /f

	:: ----------------------------------------
	:: remove Volume icon
	:: ----------------------------------------
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAVolume /t REG_DWORD /d "1" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAVolume /t REG_DWORD /d "1" /f

	:: ----------------------------------------
	:: download chrome 
	:: ----------------------------------------
	bitsadmin /transfer ChromeSetup /download /priority normal "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BADDA5EA2-FD7C-C17A-D780-E9DE51DF755F%7D%26lang%3Dzh-TW%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe" "ChromeSetup.exe"
	ChromeSetup.exe

	:: ----------------------------------------
	:: cleanup all of the temp
	:: ----------------------------------------
	forfiles /p %windir%\Temp /c "cmd /c if @isdir==TRUE ( rd/s/q @path ) else ( del/q @path )"
	forfiles /p %TMP% /c "cmd /c if @isdir==TRUE ( rd/s/q @path ) else ( del/q @path )"

	:: ----------------------------------------
	:: delete chrome file
	:: ----------------------------------------
	del /q chrome.exe
	del /q crack.exe
	
	:: ----------------------------------------
	:: reboot
	:: ----------------------------------------
	shutdown -r -t 0
    ) else (
        echo Current permissions inadequate.
    )

    pause >nul
