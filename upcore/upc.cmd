rem -- http://www.upupw.net
rem -- webmaster@upupw.net
set up_vs=UP-20140326
set up_php=PHP5.4
set apache_vc=UPUPW_Apache
set apache_port=80
set mysql_vc=UPUPW_MariaDB_A
set mysql_port=3306
for /d %%d in (*) do (
 if exist %%d\upcore.exe set upcore_dir=%%d
 if exist %%d\bin\httpd.exe set apache_dir=%%d&& set apache_exe=httpd.exe&& set apache_vs=2.4.9
 if exist %%d\php.exe set php_dir=%%d&& set php_vc=5.4.26
 if exist %%d\pm.exe set pm_dir=%%d&& set pm_vc=4.1.8
 if exist %%d\bin\mysqld.exe set mysql_dir=%%d&& set mysql_exe=mysqld.exe&& set mysql_vs=5.5.36
 if exist %%d\memcached.exe set mem_dir=%%d&& set mem_vs=1.2.6
 if exist %%d\FileZilla_server.exe set fz_dir=%%d&& set fz_exe=FileZilla_server.exe&& set fz_vs=0.9.41
)
if "%upcore_dir%"=="" echo # upcore Not Found. & pause & exit /b
if "%apache_dir%"=="" echo # Apache Not Found. & pause & exit /b
if "%php_dir%"=="" echo # PHP Not Found. & pause & exit /b
if "%mysql_dir%"=="" echo # MariaDB Not Found. & pause & exit /b
if "%mem_dir%"=="" echo # memcached Not Found. & pause & exit /b
set php=%php_dir%\php.exe -d extension_dir=.\ext -d date.timezone=UTC -n %upcore_dir%\up.dll
set pause=%php% echo ` - 按任意键继续...`; ^&^& pause^>nul
set vhosts_conf=%apache_dir%\conf\httpd-vhosts.conf
set upcore=%upcore_dir%
set cfg_bak_zip=Backup\cfg_bak.zip
set cfg_sckf_zip=Backup\cfg_sckf.zip
set cfg_xnsp_zip=Backup\cfg_xnsp.zip
set Sys32=%SystemRoot%\system32
set Path=%Sys32%;%Sys32%\wbem;%SystemRoot%
set net=%Sys32%\net.exe
if not exist %net% set net=%Sys32%\net1.exe
if not exist %net% echo  # 缺少 %Sys32%\net.exe, 不可继续. &%pause%&set php=&exit /b
%php% "chk_path(getcwd());" || %pause% && set php=
