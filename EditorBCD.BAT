@echo off
title Editor BCD
goto ComprobarPermisos

:ComprobarPermisos
    echo Es necesario que este programa se ejecute como administrador.

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Permisos de administracion concedidos.
	goto Menu
    ) else (
        echo No se esta ejecutando como administrador.
    )

    pause >nul

pause

:Menu
cls
echo ********************
echo **                **
echo **   Editor BCD   **
echo **                **
echo ********************
echo.
echo Selecciona una opcion
echo.
echo 1. Editar el nombre de la particion actual
echo 2. Editar la posicion de la particion actual
echo 3. Ver particiones
echo 4. Modificar el tiempo de espera del gestor de arranque
echo 5. Salir

set /p var=
if %var%==1 goto :EditarNombre
if %var%==2 goto :EditarPosicion
if %var%==3 goto :Ver
if %var%==4 goto :ModificarTiempo
if %var%==5 goto exit
if %var% GTR 3 echo Error
goto :Menu

:EditarNombre
cls
echo Introduce un nombre para la particion actual y pulsa Enter.
set /p nombre=
bcdedit /set {current} Description "%nombre%"
pause
goto :Menu


:EditarPosicion
cls
echo Selecciona una opcion y pulsa Enter.
echo.
echo 1. Situar la particion actual en primer lugar
echo 2. Situar la particion actual en ultimo lugar
set /p posicion=
if %posicion%==1 goto :PrimerLugar
if %posicion%==2 goto :UltimoLugar
if %posicion%==3 goto exit
bcdedit /set {current} Description "%nombre%"
pause
goto :Menu

:PrimerLugar
bcdedit /displayorder {current} /addfirst
pause
goto :Menu

:UltimoLugar
bcdedit /displayorder {current} /addlast
pause
goto :Menu

:Ver
cls
bcdedit | findstr description
pause
goto :Menu

:ModificarTiempo
cls
echo Introduce el tiempo de espera en segundos y pulsa Enter.
set /p tiempo=
bcdedit /set {bootmgr} timeout "%tiempo%"
pause
goto :Menu