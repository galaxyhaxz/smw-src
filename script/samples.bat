set logging=0
if "%2" == "/l" set logging=1
if "%1" == "/r" goto create_default
if "%1" == "/e" goto ENCODE_BRR
if "%1" == "/d" goto DECODE_BRR
echoc 1A "Encodes and decodes samples." & echo=
echoc 0E "Usage: [/R | /E | /D] /L" && echo=
echo=
echo   /E    Encode samples
echo   /D    Decode samples
echo   /L    Enable logging
echo   /R    Reset configuration
exit /b

:DECODE_BRR
SET program=brr_decoder
SET intype=brr
SET outtype=wav
GOTO BRRMAIN

:ENCODE_BRR
SET program=brr_encoder
SET intype=wav
SET outtype=brr
GOTO BRRMAIN

:encode_file
if %2 == 1 set testfuck=-l
if %2 == 0 set testfuck=
set testfuck2=%1
set "testfuck2=%testfuck2:.brr=.wav%"
if not exist %testfuck2% echoc 0C "failed (file not found)" & echo= & exit /b
if %logging% == 1 >>%~dpn0\%prjname%.log %program% %testfuck% %testfuck2% %1.tmp
if %logging% == 0 >nul %program% %testfuck% %testfuck2% %1.tmp
>nul move /Y %~dpn1.brr.tmp %~dpn1.brr
del %testfuck2%
exit /b

:decode_file
if not exist %1 echoc 0C "failed (file not found)" & echo= & exit /b
if %logging% == 1 >>%~dpn0\%prjname%.log %program% %1 %1.tmp
if %logging% == 0 >nul %program% %1 %1.tmp
>nul move /Y %1.tmp %~dpn1.wav
del %1
exit /b

:fuckmefuck
if %program% == brr_encoder call :encode_file %1 %2
if %program% == brr_decoder call :decode_file %1
echoc 0A "success!" & echo=
exit /b

:BRR_FILE
FOR /F "eol=; tokens=1,2* delims=, " %%f in (%~dpn0\%prjname%.ini) do (
if %program% == brr_encoder echoc 07 "Encoding %%f... "
if %program% == brr_decoder echoc 07 "Decoding %%f... "
call :fuckmefuck %%f %%g
)
exit /b

:strip_prj_path
set "stripdir=%1"
setlocal enabledelayedexpansion
set "stripdir=!stripdir:%myprjdir%\=!"
echo %stripdir%,0 >> %~dpn0\%prjname%.ini
endlocal
exit /b

:create_default
echo=
if exist %~dpn0\%prjname%.ini del %~dpn0\%prjname%.ini
dir /A-D /B /ON /S "%myprjdir%\*.brr" > %~dpn0\%prjname%.tmp
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

:BRRMAIN
if not exist "%~dpn0\\" mkdir "%~dpn0"
if not exist "%~dpn0\\" echoc 0C "failed to make dir"
if not exist "%~dpn0\%prjname%.ini" goto errormefuck
if exist "%~dpn0\%prjname%.log" del "%~dpn0\%prjname%.log"
if %logging% == 1 echo %program% log > %~dpn0\%prjname%.log
echo.
echo Press any key to begin!!
pause
CALL :BRR_FILE
echo.
echo All done!
exit /b
