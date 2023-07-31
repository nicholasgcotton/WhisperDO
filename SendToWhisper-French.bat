@echo off
setlocal enabledelayedexpansion
set model=large
set lang=French
set task=translate
set model_dir="C:\Users\T2User\.cache\whisper"
REM Change lines 3-6 (and ONLY 3-6) to make a new version of the batch file for other languages/models/tasks. 
REM Don't forget to rename the new file to reflect the language/model/task. (e.g. SendToWhisper-French).
IF "%~a1" == "" (
		GOTO NoSource
		) ELSE IF "%~a1"=="d----------" (
		set TARGET=%1
		GOTO loopfordir
		) ELSE if "%~a1"=="--a--------" (
		set TARGET=%1
		GOTO loopforfiles
		) ELSE (
		GOTO NoSource
		)
:loopforfiles
	IF "%~1" == "" (GOTO :Complete)
	Set filename="%1"
	For %%A in ("%filename%") do (
		Set Name=%%~nA
	)
	set RunTime=%time::=%
	set RunTime=%RunTime:~0,-5%
	set target_dir="%USERPROFILE%\Desktop\Transcripts\%date% %RunTime% %Name%"
	set short_dir="Desktop\Transcripts2\%date% %RunTime% %Name%"
	echo -----------------------------Begin New Item----------------------------------------
	echo Target File: %1
	echo Target Folder: %target_dir%
	echo Running Whisper --model_dir %model_dir% --model %model% --language %lang% --task %task% --output_dir %short_dir%
	mkdir %target_dir%
	python -c "import whisper; from whisper.transcribe import cli; cli()" %1 --task %task% --model_dir %model_dir% --model %model% --language %lang% --output_dir %target_dir%
	echo -----------------------------Transcription complete.------------------------------- 
	shift
	GOTO loopforfiles
:loopfordir
	IF "%~1" == "" (GOTO :Complete)
	set RunTime=%time::=%
	set RunTime=%RunTime:~0,-5%
	for %%i in (%1\*.*) do (
	set filename=%%i
	for %%A in ("!filename!") do (
		set name=%%~nxA
		echo -----------------------------Begin New Item----------------------------------------
		echo Target File: !name!
		set target_dir="%USERPROFILE%\Desktop\Transcripts\!date! !RunTime! !name!"
		echo Target Folder: !target_dir!
		set short_dir="Desktop\Transcripts2\!date! !RunTime! !name!"
		echo Running Whisper --model_dir %model_dir% --model %model% --language %lang% --task %task% --output_dir !short_dir!
		mkdir !target_dir!
		python -c "import whisper; from whisper.transcribe import cli; cli()" %%A --task %task% --model_dir %model_dir% --model %model% --language %lang% --output_dir !target_dir!
		echo -----------------------------Transcription complete.-------------------------------
		)
	)
	shift
	GOTO loopfordir
:NoSource
echo ******************************************************************************
echo **Error: No source file(s) or directory provided. This script will now exit.**
echo ******************************************************************************
endlocal
pause
exit /b
:Complete
echo *****************************************************************************
echo *******************All transcription(s) complete.****************************
echo *****************************************************************************
endlocal
pause
exit /b
