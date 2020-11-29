@ECHO OFF

..\..\bin\patch ..\..\project\sns-mw\header.asm header.diff
..\..\bin\patch ..\..\project\sns-mw\main.asm main.diff
COPY definitions\mapper.asm ..\..\project\sns-mw\definitions

GOTO EXIT

:EXIT
@PAUSE
EXIT
