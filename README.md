# WhisperDO
For use with OpenAI's [Whisper](https://github.com/openai/whisper).

A method to call the Whisper’s python code from the command line without using the CLI (.exe) version of Whisper, in order to solve the issue discussed here: [Stops working after long gap with no speech? #29](https://github.com/openai/whisper/discussions/29). 

In short, where the audio being transcribed or translated includes any significant gaps the CLI version of Whisper can fail to resume transcoding after the silence, this effect seems most noticeable when the audio is multilingual. 

## Whisper Install Process for Windows 10/11 
Purpose: These instructions cover the steps not explicitly set out on the main [Whisper](https://github.com/openai/whisper) page, e.g. for those who have never used python code/apps before and do not have the prerequisite software already installed. 

### Requirements: 
- Full admin rights on your computer.
- A PC with a CUDA-capable dedicated GPU with at least 4GB of VRAM (but more VRAM is better).  See: [Available models and languages](https://github.com/openai/whisper#available-models-and-languages)
- For online installation: An Internet connection for the initial download and setup.
- For offline installation: Download on another computer and then install manually using the "OPTIONAL/OFFLINE" instructions below.
### Installation
1) Download the following items (OPTIONAL/OFFLINE, download them on a different computer and move them to your secure machine).
    1) NVIDIA CUDA drivers: https://developer.nvidia.com/cuda-downloads 
    2) Python 3.7 or higher (x64 version) from https://www.python.org/
    3) FFMPEG for Windows from https://ffmpeg.org/download.html
2) Add Python and FFMPEG to the system PATH variable ([Instructions](https://linuxhint.com/add-directory-to-path-environment-variables-windows/))
    1) FFMPEG is wherever you put it (e.g. c:\ffmpeg)
    2) Python is probably at C:\Users\\[username]\AppData\Local\Programs\Python\Python[version#]  
    e.g. C:\Users\nic\AppData\Local\Programs\Python\Python37
3) Reboot
4) Install Whisper 
    1) If you're online you can use pip (it's part of Python), open a command line and type  
    <code>pip install git+https://github.com/openai/whisper.git </code>
    2) OPTIONAL/OFFLINE: 
        1) Install Python on another computer with an internet connection, then you can use pip to download (but not install) Whisper so you can move it to your secure machine. Use <code>pip download -r requirements.txt</code> using the [Whisper requirements.txt](https://github.com/openai/whisper/blob/main/requirements.txt).
        2) Copy the files + the requirements.txt to your offline machine and then run <code>pip install --no-index --find-links c:\\[LOCATION OF DOWNLOADED FILES] requirements.txt</code>
5) Download [WhisperDO.py](https://github.com/nicholasgcotton/WhisperDO/blob/main/WhisperDO.py) and put it in your working directory with your audio file(s).
6) OPTIONAL/OFFLINE: If you are setting up a computer that is offline you also need to download the following model files and place them in C:\Users\[username]\.cache\whisper e.g. C:\Users\nic\\.cache\whisper.  
If you do not download these models ahead of time Whisper will attempt to download them as needed, and will fail if there is no active internet connection.
    1) [Tiny.En](https://openaipublic.azureedge.net/main/whisper/models/d3dd57d32accea0b295c96e26691aa14d8822fac7d9d27d5dc00b4ca2826dd03/tiny.en.pt)
    2) [Tiny](https://openaipublic.azureedge.net/main/whisper/models/65147644a518d12f04e32d6f3b26facc3f8dd46e5390956a9424a650c0ce22b9/tiny.pt)
    3) [Base.En](https://openaipublic.azureedge.net/main/whisper/models/25a8566e1d0c1e2231d1c762132cd20e0f96a85d16145c3a00adf5d1ac670ead/base.en.pt)
    4) [Base](https://openaipublic.azureedge.net/main/whisper/models/ed3a0b6b1c0edf879ad9b11b1af5a0e6ab5db9205f891f668f8b0e6c6326e34e/base.pt)
    5) [Small.En](https://openaipublic.azureedge.net/main/whisper/models/f953ad0fd29cacd07d5a9eda5624af0f6bcf2258be67c92b79389873d91e0872/small.en.pt)
    6) [small](https://openaipublic.azureedge.net/main/whisper/models/9ecf779972d90ba49c06d968637d720dd632c55bbf19d441fb42bf17a411e794/small.pt)
    7) [Medium.En](https://openaipublic.azureedge.net/main/whisper/models/d7440d1dc186f76616474e0ff0b3b6b879abc9d1a4926b7adfa41db2d497ab4f/medium.en.pt)
    8) [Medium](https://openaipublic.azureedge.net/main/whisper/models/345ae4da62f9b3d59415adc60127b97c714f32e89e936602e85993674d08dcb1/medium.pt)
    9) [Large](https://openaipublic.azureedge.net/main/whisper/models/e4b87e7e0bf463eb8e6956e646f1e277e901512310def2c24bf0e11bd3c28e9a/large.pt)

Note: If the links are dead updated links can be found at lines 17-27 here: [__init__.py]( https://github.com/openai/whisper/blob/f296bcd3fac41525f1c5ab467062776f8e13e4d0/whisper/__init__.py)

## WhisperDO Usage

To use WhisperDO.py you simply use it in place of Whisper as shown below:

<code>whisper japanese.wav --language Japanese --task translate</code>  
becomes  
<code>python whisperdo.py japanese.wav --language Japanese --task translate</code>  

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
