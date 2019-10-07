:: --------------------------------------------
:: 	     Changes backup info here
:: --------------------------------------------

set MYSQL_FOLDER="D:\xampp\mysql\bin"
set MYSQL_USER="okaa"
set MYSQL_PASSWORD="1234"
set MYSQL_DATABASE_NAME="test"

set BACKUP_FOLDER="C:\\mysql-backup"
set BACKUP_TIME="00:00"
set BACKUP_TASK_SCHEDULE_NAME="MySQL\Backup"



:: --------------------------------------------
::      DO NOT EDIT THE FOLLOWING CODE!!!
:: --------------------------------------------

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

cd %~dp0
schtasks /query > tmp
findstr /B /I %BACKUP_TASK_SCHEDULE_NAME% tmp

if %errorlevel%==1 goto :delete
goto :create

:delete
schtasks /delete /tn %BACKUP_TASK_SCHEDULE_NAME% /f

:create
schtasks /create /sc daily /tn %BACKUP_TASK_SCHEDULE_NAME% /tr "C:/%~nx0" /st %BACKUP_TIME%

del tmp

:: start backup mysql database
if not exist %BACKUP_FOLDER% mkdir %BACKUP_FOLDER%

if [%MYSQL_PASSWORD] == [] (
    %MYSQL_FOLDER%\\mysqldump -u%MYSQL_USER% %MYSQL_DATABASE_NAME% -p%MYSQL_PASSWORD% > "%BACKUP_FOLDER%\\%date:~0,4%-%date:~5,2%-%date:~8,2%.sql.bak"
)else(
    %MYSQL_FOLDER%\\mysqldump -u%MYSQL_USER% %MYSQL_DATABASE_NAME% > "%BACKUP_FOLDER%\\%date:~0,4%-%date:~5,2%-%date:~8,2%.sql.bak"
) 

move %~nx0 C:/
