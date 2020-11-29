@ECHO OFF

..\..\bin\patch ..\..\project\sns-mw\bank_0.asm bank_0.diff
..\..\bin\patch ..\..\project\sns-mw\bank_3.asm bank_3.diff
..\..\bin\patch ..\..\project\sns-mw\bank_4.asm bank_4.diff
..\..\bin\patch ..\..\project\sns-mw\main.asm main.diff
XCOPY /S definitions ..\..\project\sns-mw\definitions
XCOPY /S graphics ..\..\project\sns-mw\graphics
XCOPY /S images ..\..\project\sns-mw\images

GOTO EXIT

:EXIT
@PAUSE
EXIT
