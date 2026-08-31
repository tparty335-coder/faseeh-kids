import os
import io
import speech_recognition as sr
from pydub import AudioSegment

r = sr.Recognizer()
dir_path = r'D:\Projects\faseeh_kids\scratch\extracted_alif\audio'

with open('transcripts_paint.txt', 'w', encoding='utf-8') as f:
    for file in os.listdir(dir_path):
        if file.startswith('ahdaf_a5_paint') and file.endswith('.mp3'):
            path = os.path.join(dir_path, file)
            try:
                sound = AudioSegment.from_file(path)
                buf = io.BytesIO()
                sound.export(buf, format="wav")
                buf.seek(0)
                with sr.AudioFile(buf) as source:
                    audio_data = r.record(source)
                    text = r.recognize_google(audio_data, language='ar-SA')
                    f.write(f'{file}: {text}\n')
            except sr.UnknownValueError:
                f.write(f'{file}: [Unintelligible]\n')
            except Exception as e:
                f.write(f'{file}: Error {e}\n')
