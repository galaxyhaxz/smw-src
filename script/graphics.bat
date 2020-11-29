set logging=0
if "%2" == "/l" set logging=1
if "%1" == "/r" goto create_default
if "%1" == "/c" goto COMPRESS_GRAPHICS
if "%1" == "/d" goto DECOMPRESS_GRAPHICS
echoc 1A "Compresses and decompress graphic files." & echo=
echoc 0E "Usage: [/R | /C | /D] /L" && echo=
echo=
echo   /C    Compress graphics
echo   /D    Decrompress graphics
echo   /L    Enable logging
echo   /R    Reset configuration
exit /b

:DECOMPRESS_GRAPHICS
SET program=decomp
GOTO GRAPHICS_ROUTINE

:COMPRESS_GRAPHICS
SET program=recomp
GOTO GRAPHICS_ROUTINE

:fuckmefuck
if %logging% == 1 >>%~dpn0\%prjname%.log %program% %1 %1.tmp 0 1 0
if %logging% == 0 >nul %program% %1 %1.tmp 0 1 0
REM start /B >nul %program% %1 %1.tmp 0 1 0
REM if %program% == recomp >nul TASKKILL /F /IM recomp.exe
REM if %program% == decomp >nul TASKKILL /F /IM decomp.exe
del %1
>nul move /Y %1.tmp %1
echoc 0A "success!" & echo=
exit /b

:GR_FILE
FOR /F "eol=; tokens=1* delims=, " %%f in (%~dpn0\%prjname%.ini) do (
if %program% == recomp echoc 07 "Compressing %%f... "
if %program% == decomp echoc 07 "Decompressing %%f... "
if exist %%f call :fuckmefuck %%f
if not exist %%f echoc 0C "failed (file not found)" & echo=
)
exit /b 0

:strip_prj_path
set "stripdir=%1"
setlocal enabledelayedexpansion
set "stripdir=!stripdir:%myprjdir%\=!"
echo %stripdir%,0,1,1 >> %~dpn0\%prjname%.ini
endlocal
exit /b

:create_default
echo=
if exist %~dpn0\%prjname%.ini del %~dpn0\%prjname%.ini
dir /A-D /B /ON /S "%myprjdir%\*.lz2" > %~dpn0\%prjname%.tmp
FOR /F "delims=  " %%f in (%~dpn0\%prjname%.tmp) do call :strip_prj_path "%%f"
del %~dpn0\%prjname%.tmp
echo done, modify file to your settings
pause
exit /b

:errormefuck
echo=
echoc 0C "Error: " & echoc 07 "script configuration file " & echoc 0D "\"%prjname%.ini\"" & echoc 07 " not found." & echo=
echo=
echo "Do you want to create this file now? [y/n]"
set /p scriptoption=$ 
if "%scriptoption%" == "y" goto create_default
if "%scriptoption%" == "Y" goto create_default
if "%scriptoption%" == "n" goto no_default
if "%scriptoption%" == "N" goto no_default
cls
goto errormefuck

:no_default
exit /b

:GRAPHICS_ROUTINE
if not exist "%~dpn0\\" mkdir "%~dpn0"
if not exist "%~dpn0\\" echoc 0C "failed to make dir"
if not exist "%~dpn0\%prjname%.ini" goto errormefuck
if exist "%~dpn0\%prjname%.log" del "%~dpn0\%prjname%.log"
if %logging% == 1 echo %program% log > %~dpn0\%prjname%.log
echo.
echo Press any key to begin!!
pause
CALL :GR_FILE
echo.
echo All done!
exit /b
