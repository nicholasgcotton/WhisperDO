@echo off
REM Updated 2022-12-01 to add loop for multiple files so items can be queued to run one after another. 
IF "%~1" == "" (GOTO NoSource)
:loop
IF "%~1" == "" (GOTO :Complete)
Set filename="%1"
For %%A in ("%filename%") do (
    Set Name=%%~nA
)
set RunTime=%time::=%
set RunTime=%RunTime:~0,-5%
set target_dir="%USERPROFILE%\Desktop\Transcripts\%date% %RunTime% %Name%"
set short_dir="Desktop\Transcripts\%date% %RunTime% %Name%"
echo ------------------------------------------
echo Target File: %1
echo Running Whisper --model base.en --language English --task transcribe --output_dir %short_dir%
mkdir %target_dir%
python -c "import whisper; from whisper.transcribe import cli; cli()" %1 --task transcribe --model small.en --language English --task transcribe --output_dir %target_dir%
echo Transcription complete. Files have been saved to %short_dir%
shift
Goto :loop
:NoSource
echo Error: No source file provided. This script will now exit.
pause
exit /b
:Complete
echo Transcription(s) complete.
pause
exit /b
