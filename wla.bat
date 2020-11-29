@echo off

set mypath=%CD%
set prjdir=%mypath%\project
set emudir=%mypath%\emu
set bindir=%mypath%\bin
set scrdir="%mypath%\script"
set libdir=%mypath%\src
set path=%bindir%

set COLOR_DEFAULT=07
set COLOR_DIRECTORY=09
set COLOR_FILE=0A
set COLOR_PATH=06
set COLOR_WLA=02

goto main

:reset_menu
set menuoption=nul
cls
color %COLOR_DEFAULT%

if %1 == 0 set wla_type="INPUT"
if %1 == 1 set wla_type="OPTION"
if %1 == 2 set wla_type="INPUT/OPTION"
if %1 == 3 set wla_type="PENDING"

setlocal EnableDelayedExpansion
set "wladir=!cd:%mypath%=~!"
set "wladir=%wladir:\=/%"
title %wladir%
echoc %COLOR_WLA% "WLA:%wla_type% "
echoc %COLOR_PATH% "%wladir%"
echo.
endlocal

echoc %COLOR_DEFAULT%
exit /b

:main
cd %mypath%
call :reset_menu 1
echo=
echo   1. Application
echo   2. Library
echo=
echo   Q  Quit
echo=
set /p menuoption=$ 
if "%menuoption%" == "q" goto exit_wla
if "%menuoption%" == "Q" goto exit_wla
if "%menuoption%" == "1" goto select_project
if "%menuoption%" == "2" goto select_library
goto main

:select_project
cd %prjdir%
call :reset_menu 2
echo.
echo   1. List directories
echo.
echo   P  Previous
echo   Q  Quit
echo.
set /p menuoption=$ 
if "%menuoption%" == "1" goto listfolders
if "%menuoption%" == "p" (goto main) else if "%menuoption%" == "P" (goto main)
if "%menuoption%" == "q" (goto exit_wla) else if "%menuoption%" == "Q" (goto exit_wla)
if exist "%prjdir%\%menuoption%\makefile" goto pre_project
goto select_project

:select_library
cd %libdir%
call :reset_menu 2
echo.
echo   1. List directories
echo.
echo   P  Previous
echo   Q  Quit
echo.
set /p menuoption=$ 
if "%menuoption%" == "1" goto listlibraries
if "%menuoption%" == "p" (goto main) else if "%menuoption%" == "P" (goto main)
if "%menuoption%" == "q" (goto exit_wla) else if "%menuoption%" == "Q" (goto exit_wla)
if exist "%libdir%\%menuoption%\makefile" goto pre_library
goto select_library

:listlibraries
call :reset_menu 3
echo.
echoc %COLOR_DIRECTORY%
dir /AD /B /ON
echoc %COLOR_DEFAULT%
echo.
pause
goto select_library

:listfolders
call :reset_menu 3
echo.
echoc %COLOR_DIRECTORY%
dir /AD /B /ON
echoc %COLOR_DEFAULT%
echo.
pause
goto select_project

:pre_library
set libname=%menuoption%
set mylibdir=%libdir%\%libname%
cd %libname%
goto in_library

:pre_project
set prjname=%menuoption%
set myprjdir=%prjdir%\%prjname%
cd %prjname%
goto in_project

:in_library
call :reset_menu 1
echo.
echo   1. Assemble library
echo   2. Assemble library (debug)
echo   3. Cleanup library
echo   4. Execute make with arguments
echo   5. Install library
echo.
echo   P  Previous
echo   Q  Quit
echo.
set /p menuoption=$ 
if "%menuoption%" == "1" call :execute_make
if "%menuoption%" == "2" call :execute_make debug
if "%menuoption%" == "3" call :execute_make clean
if "%menuoption%" == "4" goto execute_make_args_lib
if "%menuoption%" == "5" call :execute_make install
if "%menuoption%" == "p" (goto select_library) else if "%menuoption%" == "P" (goto select_library)
if "%menuoption%" == "q" (goto exit_wla) else if "%menuoption%" == "Q" (goto exit_wla)
goto in_library

:in_project
call :reset_menu 1
echo.
echo   1. Assemble project
echo   2. Assemble project (debug)
echo   3. Cleanup project
echo   4. Execute make with arguments
echo   5. Execute script
echo   6. Start debugger
echo.
echo   P  Previous
echo   Q  Quit
echo.
set /p menuoption=$ 
if "%menuoption%" == "1" call :execute_make
if "%menuoption%" == "2" call :execute_make debug
if "%menuoption%" == "3" call :execute_make clean
if "%menuoption%" == "4" goto execute_make_args
if "%menuoption%" == "5" goto script_options
if "%menuoption%" == "6" call :execute_debugger
if "%menuoption%" == "p" (goto select_project) else if "%menuoption%" == "P" (goto select_project)
if "%menuoption%" == "q" (goto exit_wla) else if "%menuoption%" == "Q" (goto exit_wla)
goto in_project

:execute_make_args_lib
call :reset_menu 3
echo.
set /p menuoption=$ 
echo Executing "make %menuoption%"
echo.
make %menuoption%
echo.
pause
goto in_library

:execute_make
call :reset_menu 3
echo.
set timestart=%TIME%
make %1
set timeend=%TIME%
echo.
if not "%1" == "clean" echoc 0E "Assembly time: start--%timestart% finish--%timeend%" & echo.
pause
exit /b

:execute_make_args
call :reset_menu 3
echo.
set /p menuoption=$ 
echo Executing "make %menuoption%"
echo.
make %menuoption%
echo.
pause
goto in_project

:script_options
call :reset_menu 2
echo.
echo   1. List scripts
echo.
echo   P  Previous
echo   Q  Quit
echo.
set /p menuoption=$ 
if "%menuoption%" == "1" goto listscripts
if "%menuoption%" == "p" (goto in_project) else if "%menuoption%" == "P" (goto in_project)
if "%menuoption%" == "q" (goto exit_wla) else if "%menuoption%" == "Q" (goto exit_wla)
call :parse_script %menuoption%
goto script_options

:listscripts
call :reset_menu 3
echo.
echoc %COLOR_FILE%
dir /A-D /B /ON %scrdir%\*.bat %scrdir%\*.cmd
echoc %COLOR_DEFAULT%
echo.
pause
goto script_options

:parse_script
set scriptname=%scrdir%\%1
set scriptcmd=%menuoption%
if exist %scriptname%\ exit /b
if not exist %scriptname% exit /b
call :reset_menu 3
echo.
echo Running script: "%scriptcmd%"
echo.
call %scrdir%\%scriptcmd%
echo.
set scriptname=nul
set scriptcmd=nul
cd %myprjdir%
pause
exit /b

:execute_debugger
set temp=%cd%
cd %emudir%
if exist emu.exe start emu.exe
cd %temp%
exit /b

:exit_wla
exit
