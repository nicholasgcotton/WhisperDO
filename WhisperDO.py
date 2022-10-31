# A short python script to use the python version of Whisper instead of the CLI version, which has issues with non-English audio. 
import whisper
from whisper.transcribe import cli
cli()
