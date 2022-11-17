@echo off
set model=large
set lang=French
set task=translate
REM Change lines 2-4 to make a new version of the batch file for another language. Don't forget to rename the new file to Whisper-LANGUAGE.bat
REM You should NOT change anything below this point.
IF "%~1" == "" (GOTO NoSource)
Set filename="%1"
For %%A in ("%filename%") do (
    Set Name=%%~nA
)
set RunTime=%time::=%
set RunTime=%RunTime:~0,-5%
set target_dir="%USERPROFILE%\Desktop\Transcripts\%date% %RunTime% %Name%"
set short_dir="Desktop\Transcripts\%date% %RunTime% %Name%"
echo Target File: %1
echo Running Whisper --model %model% --language %lang% --task %task% --output_dir %short_dir%
mkdir %target_dir%
python -c "import whisper; from whisper.transcribe import cli; cli()" %1 --model %model% --language %lang% --task %task% --output_dir %target_dir%
echo Translation completed. Files have been saved to %short_dir%
pause
exit /b
:NoSource
echo Error: No source file provided. This script will now exit.
pause
exit /b
