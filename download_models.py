from whisper import load_model
import subprocess

subprocess.run(["python", "-m", "demucs",
               "pretrained", "htdemucs"], check=True)

load_model('base')
