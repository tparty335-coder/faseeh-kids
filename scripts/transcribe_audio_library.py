import os
import io
import json
import speech_recognition as sr
from pydub import AudioSegment

r = sr.Recognizer()

def transcribe_file(file_path):
    try:
        sound = AudioSegment.from_file(file_path)
        buf = io.BytesIO()
        sound.export(buf, format="wav")
        buf.seek(0)
        with sr.AudioFile(buf) as source:
            audio_data = r.record(source)
            for lang in ["ar-EG", "ar-SA"]:
                try:
                    text = r.recognize_google(audio_data, language=lang)
                    if text:
                        return text.strip()
                except sr.UnknownValueError:
                    continue
                except Exception:
                    pass
            return "[غير منطوق أو غير واضح / Non-verbal SFX]"
    except Exception as e:
        return f"[خطأ: {e}]"

def main():
    base_dir = "assets/audio"
    audio_files = []
    
    for root, dirs, files in os.walk(base_dir):
        rel_root = os.path.relpath(root, base_dir)
        # Skip purely repetitive single letter sound files to prioritize instructions & stories
        if "letters\\short_vowels" in rel_root or "letters\\core" in rel_root:
            continue
        for f in files:
            if f.endswith(".mp3") or f.endswith(".wav"):
                full_path = os.path.join(root, f).replace("\\", "/")
                audio_files.append(full_path)
                
    results = {}
    for idx, f in enumerate(audio_files, 1):
        text = transcribe_file(f)
        results[f] = text
        print(f"Processed {idx}/{len(audio_files)}: {f}")
        
    os.makedirs("docs", exist_ok=True)
    with open("docs/audio_transcripts_index.json", "w", encoding="utf-8") as jf:
        json.dump(results, jf, ensure_ascii=False, indent=2)
        
    with open("docs/audio_transcripts_index.md", "w", encoding="utf-8") as mf:
        mf.write("# دليل وفهرس التفريغ الصوتي الشامل (Audio Transcripts Index)\n\n")
        mf.write(f"إجمالي الملفات المفهرسة: `{len(results)}` ملف صوتي.\n\n")
        mf.write("| المسار (File Path) | النص المفرغ (Transcript) |\n")
        mf.write("| :--- | :--- |\n")
        for path, transcript in sorted(results.items()):
            mf.write(f"| `{path}` | **{transcript}** |\n")
            
    print("FINISHED_INDEXING")

if __name__ == "__main__":
    main()
