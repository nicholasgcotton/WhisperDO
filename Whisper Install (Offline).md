# Whisper Full (& Offline) Install Process for Windows 10/11 
Purpose: These instructions cover the steps not explicitly set out on the main [Whisper](https://github.com/openai/whisper) page, e.g. for those who have never used python code/apps before and do not have the prerequisite software already installed. 

## Requirements: 
- Full admin rights on your computer.
- A PC with a CUDA-capable dedicated GPU with at least 4GB of VRAM (but more VRAM is better).  See: [Available models and languages](https://github.com/openai/whisper#available-models-and-languages)
- For online installation: An Internet connection for the initial download and setup.
- For offline installation: Download on another computer and then install manually using the "OPTIONAL/OFFLINE" instructions below.

## Installation

### Step 1: Unlisted Pre-Requisites
- Before you can run whisper you must download and install the follopwing items. (For offline installation just download the files on another machine and move them to your offline machine to install them.) 
    - NVIDIA CUDA drivers: https://developer.nvidia.com/cuda-downloads 
    -  Python 3.9 or 3.10 (x64 version) from https://www.python.org/ (Whisper claims to run with >3.7 but as of 2023-01-18 some dependencies require >3.7 but <3.11).
    - FFMPEG
        - To install via Scoop (https://scoop.sh/), in powershell run
            - Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
            - irm get.scoop.sh | iex
            - scoop install ffmpeg
        - OPTIONAL/OFFLINE: Follow instructions here: [How to install and use FFMPEG](https://www.thewindowsclub.com/how-to-install-ffmpeg-on-windows-10) and make sure not to skip the part about adding FFMPEG to the Windows PATH variable. 
    -  Git for windows from https://gitforwindows.org/
- Reboot after installing these items.

### Step 2B: Whipser Install (Online Install for Online Use)
-  Open a command prompt and type this command:
    - <code>pip install git+https://github.com/openai/whisper.git</code>
- You may now use Whisper online and no further steps are required. 

### Step 2B: Whipser Install (Online Install for later Offline Use)

- Open a command prompt and type these commands:
  - <code>pip install git+https://github.com/openai/whisper.git</code>
  - <code>pip install blobfile</code>
- Continue to <b>Step 3: Download Other Required Files</b>

### Step 2C: Whipser Install (Offline Install for later Offline Use)
- <b>Option 1:</b> Get the most up to date version of Whisper: 
    - Install Python and Git from Step 1 on an second computer you can connect to the internet and reboot to ensure both are working. 
    - On the ONLINE machine open a command prompt in any empty folder and type the following commands:
        - <code>pip download git+https://github.com/openai/whisper.git</code>
        - <code>pip download blobfile</code>
- <b>Option 2:</b> Download all the necessary files from here [OPENAI-Whisper-20230314 Offline Install Package](https://github.com/nicholasgcotton/WhisperDO/releases/tag/20230314)
- Copy the files to your OFFLINE machine and open a command prompt in that folder where you put the files, and run
    - <code>pip install openai-whisper-20230314.zip</code> (note the date may have changed if you used Option 1 above).
    - <code>pip install blobfile-2.0.2-py3-none-any.whl</code>. (note the version may have changed if you used Option 1 above).
- Continue to <b>Step 3: Download Other Required Files</b>

### Step 3: Download Other Required Files (for Offline Use)
- Download Whisper's Language Model files place them in <code>C:\Users\[Username]\\.cache\whisper</code> Note: If the links are dead updated links can be found at lines 17-27 here: [__init__.py]( https://github.com/openai/whisper/blob/main/whisper/__init__.py) 
    -  [Tiny.En](https://openaipublic.azureedge.net/main/whisper/models/d3dd57d32accea0b295c96e26691aa14d8822fac7d9d27d5dc00b4ca2826dd03/tiny.en.pt)
    -  [Tiny](https://openaipublic.azureedge.net/main/whisper/models/65147644a518d12f04e32d6f3b26facc3f8dd46e5390956a9424a650c0ce22b9/tiny.pt)
    -  [Base.En](https://openaipublic.azureedge.net/main/whisper/models/25a8566e1d0c1e2231d1c762132cd20e0f96a85d16145c3a00adf5d1ac670ead/base.en.pt)
    -  [Base](https://openaipublic.azureedge.net/main/whisper/models/ed3a0b6b1c0edf879ad9b11b1af5a0e6ab5db9205f891f668f8b0e6c6326e34e/base.pt)
    -  [Small.En](https://openaipublic.azureedge.net/main/whisper/models/f953ad0fd29cacd07d5a9eda5624af0f6bcf2258be67c92b79389873d91e0872/small.en.pt)
    -  [Small](https://openaipublic.azureedge.net/main/whisper/models/9ecf779972d90ba49c06d968637d720dd632c55bbf19d441fb42bf17a411e794/small.pt)
    -  [Medium.En](https://openaipublic.azureedge.net/main/whisper/models/d7440d1dc186f76616474e0ff0b3b6b879abc9d1a4926b7adfa41db2d497ab4f/medium.en.pt)
    -  [Medium](https://openaipublic.azureedge.net/main/whisper/models/345ae4da62f9b3d59415adc60127b97c714f32e89e936602e85993674d08dcb1/medium.pt)
    -  [Large-v1](https://openaipublic.azureedge.net/main/whisper/models/e4b87e7e0bf463eb8e6956e646f1e277e901512310def2c24bf0e11bd3c28e9a/large.pt)
    -  [Large-v2](https://openaipublic.azureedge.net/main/whisper/models/81f7c96c852ee8fc832187b0132e569d6c3065a3252ed18e56effd0b6a73e524/large-v2.pt) ([Annoucing the large-v2 model](https://github.com/openai/whisper/discussions/661))
- Download Whisper's vocabulary and encoder files. (Per [issue 1399](https://github.com/openai/whisper/discussions/1399)).
    - Download [Vocab.bpe](https://openaipublic.blob.core.windows.net/gpt-2/encodings/main/vocab.bpe)
    - Download [Encoder.json](https://openaipublic.blob.core.windows.net/gpt-2/encodings/main/encoder.json)
    - Install the files to a folder of your choosing, e.g. <code>C:\Users\[Username]\\.cache\whisper</code>.
    - Update file links in your local copy of openai_public.py which will be installed in your python folder e.g. <code>C:\Users\[UserName]\\AppData\Local\Programs\Python\Python310-32\Lib\site-packagespython3.9/site-packages/tiktoken_ext/openai_public.py</code> to point to where you downloaded the files.
        - Remove the URL <code>"https://openaipublic.blob.core.windows.net/gpt-2/encodings/main/"</code> and replace it with your local copy, e.g. <code>"C:/Users/[Username]/.cache/whisper/vocab.bpe"</code> and <code>"C:/Users/[Username]/.cache/whisper/encoder.json"</code>
       
```python
def gpt2():
    mergeable_ranks = data_gym_to_mergeable_bpe_ranks(
        vocab_bpe_file="C:/Users/nic/.cache/whisper/vocab.bpe",
        encoder_json_file="C:/Users/nic/.cache/whisper/encoder.json",
    )
```
### Alternative Offline Method

See the pre-compiled .exe version of Whisper provided here: [Purfview / Whisper Standalone](https://github.com/Purfview/whisper-standalone-win)
