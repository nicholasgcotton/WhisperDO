# WhisperDO
For use with OpenAI's [Whisper](https://github.com/openai/whisper).

A method to call the Whisper’s python code from the command line without using the CLI (.exe) version of Whisper, in order to solve the issue discussed here: [Issue 29: Stops working after long gap with no speech?](https://github.com/openai/whisper/discussions/29). 

In short, where the audio being transcribed or translated includes any significant gaps the CLI version of Whisper can fail to resume transcoding after the silence, this effect seems most noticeable when the audio is multilingual. 

## Whisper Full (& Offline) Install Process for Windows 10/11 
Purpose: These instructions cover the steps not explicitly set out on the main [Whisper](https://github.com/openai/whisper) page, e.g. for those who have never used python code/apps before and do not have the prerequisite software already installed. 

### Requirements: 
- Full admin rights on your computer.
- A PC with a CUDA-capable dedicated GPU with at least 4GB of VRAM (but more VRAM is better).  See: [Available models and languages](https://github.com/openai/whisper#available-models-and-languages)
- For online installation: An Internet connection for the initial download and setup.
- For offline installation: Download on another computer and then install manually using the "OPTIONAL/OFFLINE" instructions below.
### Installation
1. Download the following items (OPTIONAL/OFFLINE, download them on a different computer and move them to your offline machine).
    1. NVIDIA CUDA drivers: https://developer.nvidia.com/cuda-downloads 
    2. Python 3.9 or 3.10 (x64 version) from https://www.python.org/ (Whisper claims to run with >3.7 but as of 2023-01-18 some dependencies require >3.7 but <3.11).
    3. FFMPEG 
        1. To install via Scoop (https://scoop.sh/), in powershell run
            1. Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
            2. irm get.scoop.sh | iex
            3. scoop install ffmpeg
        2. OPTIONAL/OFFLINE: Follow instructions here: [How to install and use FFMPEG](https://www.thewindowsclub.com/how-to-install-ffmpeg-on-windows-10) and make sure not to skip the part about adding FFMPEG to the Windows PATH variable. 
    4. Git for windows from https://gitforwindows.org/
2. Reboot after installing these items.
3. Install Whisper: If you're online you can use pip (it's part of Python), open a command line and type <code>pip install git+https://github.com/openai/whisper.git</code>.
    1. OPTIONAL/OFFLINE: Install Python on another computer with an internet connection, then you can use pip to download (but not install) Whisper and its dependencies so you can move them to your offline machine. 
        1.  Get whisper <code>pip download git+https://github.com/openai/whisper.git</code>
        2.  Get unlisted dependency required for offline use <code>pip download blobfile</code>
        3.  Copy the files to your offline machine and then run <code>pip install openai-whisper-20230314.zip</code> and <code>pip install blobfile-2.0.2-py3-none-any.whl</code>. Note that date/version may change when downloaded.
5. Install Other Required files: If you are setting up a computer that is offline you also need to download the following files:
    1. Model files place them in C:\Users\[username]\\.cache\whisper e.g. C:\Users\nic\\.cache\whisper. Note: If the links are dead updated links can be found at lines 17-27 here: [__init__.py]( https://github.com/openai/whisper/blob/main/whisper/__init__.py) 
    If you do not download these models ahead of time Whisper will attempt to download them as needed, and will fail if there is no active internet connection.
         1. [Tiny.En](https://openaipublic.azureedge.net/main/whisper/models/d3dd57d32accea0b295c96e26691aa14d8822fac7d9d27d5dc00b4ca2826dd03/tiny.en.pt)
         2. [Tiny](https://openaipublic.azureedge.net/main/whisper/models/65147644a518d12f04e32d6f3b26facc3f8dd46e5390956a9424a650c0ce22b9/tiny.pt)
         3. [Base.En](https://openaipublic.azureedge.net/main/whisper/models/25a8566e1d0c1e2231d1c762132cd20e0f96a85d16145c3a00adf5d1ac670ead/base.en.pt)
         4. [Base](https://openaipublic.azureedge.net/main/whisper/models/ed3a0b6b1c0edf879ad9b11b1af5a0e6ab5db9205f891f668f8b0e6c6326e34e/base.pt)
         5. [Small.En](https://openaipublic.azureedge.net/main/whisper/models/f953ad0fd29cacd07d5a9eda5624af0f6bcf2258be67c92b79389873d91e0872/small.en.pt)
         6. [Small](https://openaipublic.azureedge.net/main/whisper/models/9ecf779972d90ba49c06d968637d720dd632c55bbf19d441fb42bf17a411e794/small.pt)
         7. [Medium.En](https://openaipublic.azureedge.net/main/whisper/models/d7440d1dc186f76616474e0ff0b3b6b879abc9d1a4926b7adfa41db2d497ab4f/medium.en.pt)
         8. [Medium](https://openaipublic.azureedge.net/main/whisper/models/345ae4da62f9b3d59415adc60127b97c714f32e89e936602e85993674d08dcb1/medium.pt)
         9. [Large-v1](https://openaipublic.azureedge.net/main/whisper/models/e4b87e7e0bf463eb8e6956e646f1e277e901512310def2c24bf0e11bd3c28e9a/large.pt)
         10. [Large-v2](https://openaipublic.azureedge.net/main/whisper/models/81f7c96c852ee8fc832187b0132e569d6c3065a3252ed18e56effd0b6a73e524/large-v2.pt) ([Annoucing the large-v2 model](https://github.com/openai/whisper/discussions/661))
     2. NEW OFFLINE REQUIREMENTS. (See [issue 1399](https://github.com/openai/whisper/discussions/1399) As of some recent changes Whisper now calls to the internet for vocab files. Downloading the vocab.bpe and encoder.json files from the URLs specified in [openai_public.py](https://github.com/openai/tiktoken/blob/main/tiktoken_ext/openai_public.py) and updating some local code will re-enable offline usage.
         1. Download [Vocab.bpe](https://openaipublic.blob.core.windows.net/gpt-2/encodings/main/vocab.bpe)
         2. Download [Encoder.json](https://openaipublic.blob.core.windows.net/gpt-2/encodings/main/encoder.json)
         3. Install the files to a folder of your choosing, for ease of use I recommend C:\Users\[username]\\.cache\whisper e.g. C:\Users\nic\\.cache\whisper.
         4. You will then need to change your local copy of openai_public.py which will be installed in your python folder e.g. python3.9/site-packages/tiktoken_ext/openai_public.py to point to where you downloaded the files. Change lines 11 and 12 to remove the URL "https://openaipublic.blob.core.windows.net/gpt-2/encodings/main/" and replace it with your local copy, e.g. "C:/Users/nic/.cache/whisper"
         5. Note: If you did not use the offline pip install mathod you will also need to run <code>pip install blobfile</code> as changing the code within Whisper in the above line triggers a new dependency requirement which is not automatically installed. If you did run the method at 3(i) above this has already been done. 

### Alternative Offline Method

See the pre-compiled .exe version of Whisper provided here: [Purfview / Whisper Standalone](https://github.com/Purfview/whisper-standalone-win)

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
