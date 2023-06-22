# Whisper Full (& Offline) Installation Instructions

Moved to [Whisper Install (Offline).md](https://github.com/nicholasgcotton/WhisperDO/blob/main/Whisper%20Install%20(Offline).md)

# WhisperDO
For use with OpenAI's [Whisper](https://github.com/openai/whisper).

A method to call the Whisper’s python code from the command line without using the CLI (.exe) version of Whisper, in order to solve the issue discussed here: [Issue 29: Stops working after long gap with no speech?](https://github.com/openai/whisper/discussions/29). 

In short, where the audio being transcribed or translated includes any significant gaps the CLI version of Whisper can fail to resume transcoding after the silence, this effect seems most noticeable when the audio is multilingual. 

## WhisperDO Usage

To use WhisperDO.py you simply use it in place of Whisper as shown below:

<code>whisper japanese.wav --language Japanese --task translate</code>  
becomes  
<code>python whisperdo.py japanese.wav --language Japanese --task translate</code>  

For offline usage add the path to the model you want to use:

<Code>python whisperdo.py japanese.wav --language Japanese --model_dir "PATH" --model SIZE --task trasnalate</code>

Usage can be pulled from whisper via "-h" and will show you the following options:

> usage: whisper [-h]  
>                [--model {tiny.en,tiny,base.en,base,small.en,small,medium.en,medium,large}]  
>                [--device DEVICE] [--output_dir OUTPUT_DIR] [--verbose VERBOSE]  
>                [--task {transcribe,translate}]  
>                 [--language {af,am,ar,as,az,ba,be,bg,bn,bo,br,bs,ca,cs,cy,da,de,el,en,es,et,eu,fa,fi,fo,fr,gl,gu,ha,haw,hi,hr,ht,hu,hy,id,is,it,iw,ja,jw,ka,kk,km,kn,ko,la,lb,ln,lo,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,my,ne,nl,nn,no,oc,pa,pl,ps,pt,ro,ru,sa,sd,si,sk,sl,sn,so,sq,sr,su,sv,sw,ta,te,tg,th,tk,tl,tr,tt,uk,ur,uz,vi,yi,yo,zh,Afrikaans,Albanian,Amharic,Arabic,Armenian,Assamese,Azerbaijani,Bashkir,Basque,Belarusian,Bengali,Bosnian,Breton,Bulgarian,Burmese,Castilian,Catalan,Chinese,Croatian,Czech,Danish,Dutch,English,Estonian,Faroese,Finnish,Flemish,French,Galician,Georgian,German,Greek,Gujarati,Haitian,Haitian Creole,Hausa,Hawaiian,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Italian,Japanese,Javanese,Kannada,Kazakh,Khmer,Korean,Lao,Latin,Latvian,Letzeburgesch,Lingala,Lithuanian,Luxembourgish,Macedonian,Malagasy,Malay,Malayalam,Maltese,Maori,Marathi,Moldavian,Moldovan,Mongolian,Myanmar,Nepali,Norwegian,Nynorsk,Occitan,Panjabi,Pashto,Persian,Polish,Portuguese,Punjabi,Pushto,Romanian,Russian,Sanskrit,Serbian,Shona,Sindhi,Sinhala,Sinhalese,Slovak,Slovenian,Somali,Spanish,Sundanese,Swahili,Swedish,Tagalog,Tajik,Tamil,Tatar,Telugu,Thai,Tibetan,Turkish,Turkmen,Ukrainian,Urdu,Uzbek,Valencian,Vietnamese,Welsh,Yiddish,Yoruba}]  
>                [--temperature TEMPERATURE] [--best_of BEST_OF]  
>                [--beam_size BEAM_SIZE] [--patience PATIENCE]  
>                [--length_penalty LENGTH_PENALTY]  
>                [--suppress_tokens SUPPRESS_TOKENS]  
>                [--initial_prompt INITIAL_PROMPT]  
>                [--condition_on_previous_text CONDITION_ON_PREVIOUS_TEXT]  
>                [--fp16 FP16]  
>                [--temperature_increment_on_fallback TEMPERATURE_INCREMENT_ON_FALLBACK]  
>                [--compression_ratio_threshold COMPRESSION_RATIO_THRESHOLD]  
>                [--logprob_threshold LOGPROB_THRESHOLD]  
>                [--no_speech_threshold NO_SPEECH_THRESHOLD]  
>                audio [audio ...]  
>               

##  Windows Batch Files for use with Whisper
### SendToWhisper-English.bat Usage

(For those who do not want to use the command line interface.)

To use SendToWhisper-English.bat simpy save it to your computer and drag and drop any English language audio/video file onto the batch file. It can also be installed to the right-click "SendTo" menu in Windows. From the Desktop hit [Windows]+R (run) and then type "shell:SendTo" and hit Enter, then copy the batch file into the folder that appears.

SendToWhisper-English.bat will use the small.en model to transcribe the file and will save the results to the user's Desktop in a new subfolder.
To avoid duplicate folder names (since Whisper will not let us change the transcript file name) the foldername will include the date and time the transcription was started, as well as the file name of the audio file: Desktop\Transcript\[DATE] [TIME] [AUDIOFILENAME].

This batch script will also accept multiple inputs, so you can select and send-to multiple files and Whisper will process them in series.

### SendToWhisper-French.bat Usage

To use SendToWhisper-French.bat simpy save it to your computer and drag and drop any French language audio file onto the batch file. It can also be installed to the right-click "SendTo" menu in Windows. From the Desktop hit [Windows]+R (run) and then type "shell:SendTo" and hit Enter, then copy the batch file into the folder that appears.

The translated transcript will be saved to a new folder on the user's dekstop. To avoid duplicate folder names (since Whisper will not let us change the transcript file name) the foldername will include the date and time the translation was started, as well as the file name of the audio file: Desktop\Transcript\[DATE] [TIME] [AUDIOFILENAME].

### Modifying for other languages

This file can be modified for use with any other language that Whisper supports. The first four lines of the batch file are:
```
@echo off
set model=large
set lang=French
set task=translate
```
Simply change the language or model or task to create a new version of the batch file for your needs, and save the file with a new name. 

This batch script will also accept multiple inputs, so you can select and send-to multiple files and Whisper will process them in series. Make sure all submissions are in the same language.
