@echo off
set model=large
set lang=French
set task=translate
REM Change lines 2-4 to make a new version of the batch file for another language. Don't forget to rename the new file to Whisper-LANGUAGE.bat
REM You should NOT change anything below this point.
REM Updated 2022-12-01 to add loop for mulitple files of the same language, so items can be queued to run one after another. 
REM For offline models you must add --model_dir to the Whisper command. E.g. "--model_dir "C:\Users\Nicholas\.cache\whisper"
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
echo Running Whisper --model %model% --language %lang% --task %task% --output_dir %short_dir%
mkdir %target_dir%
python -c "import whisper; from whisper.transcribe import cli; cli()" %1 --model %model% --language %lang% --task %task% --output_dir %target_dir%
echo Task complete. Files have been saved to %short_dir%
shift
Goto :loop
:NoSource
echo Error: No source file provided. This script will now exit.
pause
exit /b
:Complete
echo Task(s) complete.
pause
exit /b
