if "%1" == "/e" goto ENCODE_BRR
if "%1" == "/d" goto DECODE_BRR
echo Invalid arguments.
echo /e to encode
echo /d to decode
exit /b

:DECODE_BRR
SET program=brr_decoder
SET intype=brr
SET outtype=wav
GOTO BRR_MAIN2

:ENCODE_BRR
SET program=brr_encoder
SET intype=wav
SET outtype=brr
GOTO BRR_MAIN

:BRR_MAIN2
ECHO Sample 00
%program% spc700\samples\flute.%intype% spc700\samples\flute.%outtype%
ECHO Sample 01
%program% spc700\samples\violin.%intype% spc700\samples\violin.%outtype%
ECHO Sample 02
%program% spc700\samples\glockenspiel.%intype% spc700\samples\glockenspiel.%outtype%
ECHO Sample 03
%program% spc700\samples\xylophone.%intype% spc700\samples\xylophone.%outtype%
ECHO Sample 04
%program% spc700\samples\cello.%intype% spc700\samples\cello.%outtype%
ECHO Sample 05
%program% spc700\samples\acoustic_bass.%intype% spc700\samples\acoustic_bass.%outtype%
ECHO Sample 06
%program% spc700\samples\cymbal.%intype% spc700\samples\cymbal.%outtype%
ECHO Sample 07
%program% spc700\samples\steel_guitar.%intype% spc700\samples\steel_guitar.%outtype%
ECHO Sample 08
%program% spc700\samples\trumpet.%intype% spc700\samples\trumpet.%outtype%
ECHO Sample 09
%program% spc700\samples\steel_drum.%intype% spc700\samples\steel_drum.%outtype%
ECHO Sample 0A
%program% spc700\samples\acoustic_piano.%intype% spc700\samples\acoustic_piano.%outtype%
ECHO Sample 0B
%program% spc700\samples\snare_drum.%intype% spc700\samples\snare_drum.%outtype%
ECHO Sample 0C
%program% spc700\samples\electric_piano.%intype% spc700\samples\electric_piano.%outtype%
ECHO Sample 0D
%program% spc700\samples\slap_bass.%intype% spc700\samples\slap_bass.%outtype%
ECHO Sample 0E
%program% spc700\samples\woodblock.%intype% spc700\samples\woodblock.%outtype%
ECHO Sample 0F
%program% spc700\samples\bass_drum.%intype% spc700\samples\bass_drum.%outtype%
ECHO Sample 10
%program% spc700\samples\bongo.%intype% spc700\samples\bongo.%outtype%
ECHO Sample 11
%program% spc700\samples\distortion_guitar.%intype% spc700\samples\distortion_guitar.%outtype%
ECHO Sample 12
%program% spc700\samples\orchestra_hit.%intype% spc700\samples\orchestra_hit.%outtype%
ECHO Sample 13
%program% spc700\samples\thunder.%intype% spc700\samples\thunder.%outtype%

DEL spc700\samples\*.%intype%
GOTO exitme

:BRR_MAIN
ECHO Sample 00
%program% -l spc700\samples\flute.%intype% spc700\samples\flute.%outtype%
ECHO Sample 01
%program% -l spc700\samples\violin.%intype% spc700\samples\violin.%outtype%
ECHO Sample 02
%program% -l spc700\samples\glockenspiel.%intype% spc700\samples\glockenspiel.%outtype%
ECHO Sample 03
%program% -l spc700\samples\xylophone.%intype% spc700\samples\xylophone.%outtype%
ECHO Sample 04
%program% -l spc700\samples\cello.%intype% spc700\samples\cello.%outtype%
ECHO Sample 05
%program% -l spc700\samples\acoustic_bass.%intype% spc700\samples\acoustic_bass.%outtype%
ECHO Sample 06
%program% spc700\samples\cymbal.%intype% spc700\samples\cymbal.%outtype%
ECHO Sample 07
%program% -l spc700\samples\steel_guitar.%intype% spc700\samples\steel_guitar.%outtype%
ECHO Sample 08
%program% -l spc700\samples\trumpet.%intype% spc700\samples\trumpet.%outtype%
ECHO Sample 09
%program% -l spc700\samples\steel_drum.%intype% spc700\samples\steel_drum.%outtype%
ECHO Sample 0A
%program% spc700\samples\acoustic_piano.%intype% spc700\samples\acoustic_piano.%outtype%
ECHO Sample 0B
%program% spc700\samples\snare_drum.%intype% spc700\samples\snare_drum.%outtype%
ECHO Sample 0C
%program% -l spc700\samples\electric_piano.%intype% spc700\samples\electric_piano.%outtype%
ECHO Sample 0D
%program% -l spc700\samples\slap_bass.%intype% spc700\samples\slap_bass.%outtype%
ECHO Sample 0E
%program% -l spc700\samples\woodblock.%intype% spc700\samples\woodblock.%outtype%
ECHO Sample 0F
%program% spc700\samples\bass_drum.%intype% spc700\samples\bass_drum.%outtype%
ECHO Sample 10
%program% spc700\samples\bongo.%intype% spc700\samples\bongo.%outtype%
ECHO Sample 11
%program% -l spc700\samples\distortion_guitar.%intype% spc700\samples\distortion_guitar.%outtype%
ECHO Sample 12
%program% spc700\samples\orchestra_hit.%intype% spc700\samples\orchestra_hit.%outtype%
ECHO Sample 13
%program% spc700\samples\thunder.%intype% spc700\samples\thunder.%outtype%

DEL spc700\samples\*.%intype%

:exitme
echo.
echo All done!
exit /b
