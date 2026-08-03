#!/usr/bin/env python3
"""
Faseeh Kids Audio Generator
Generates all Arabic audio files using edge-tts (free Microsoft TTS)
Voice: ar-EG-ShakirNeural (Egyptian Arabic male, clear for children)

Usage:
    pip install edge-tts
    python scripts/generate_audio.py
"""

import asyncio
import os
import edge_tts

# Voice selection — clear Egyptian Arabic
VOICE = "ar-EG-ShakirNeural"

# Output directories
LETTERS_DIR = os.path.join("assets", "audio", "letters")
FEEDBACK_DIR = os.path.join("assets", "audio", "feedback")
SFX_DIR = os.path.join("assets", "audio", "sfx")

# ═══════════════════════════════════════════════
# P3-T006: Letter Names (28 files)
# ═══════════════════════════════════════════════
LETTER_NAMES = {
    "alif_name": "ألف",
    "baa_name": "باء",
    "taa_name": "تاء",
    "thaa_name": "ثاء",
    "jeem_name": "جيم",
    "haa_h_name": "حاء",
    "khaa_name": "خاء",
    "daal_name": "دال",
    "dhaal_name": "ذال",
    "raa_name": "راء",
    "zaay_name": "زاي",
    "seen_name": "سين",
    "sheen_name": "شين",
    "saad_name": "صاد",
    "daad_name": "ضاد",
    "taa_t_name": "طاء",
    "dhaa_dh_name": "ظاء",
    "ain_name": "عين",
    "ghain_name": "غين",
    "faa_name": "فاء",
    "qaaf_name": "قاف",
    "kaaf_name": "كاف",
    "laam_name": "لام",
    "meem_name": "ميم",
    "noon_name": "نون",
    "haa_name": "هاء",
    "waaw_name": "واو",
    "yaa_name": "ياء",
}

# ═══════════════════════════════════════════════
# P3-T007: Letter Sounds (28 files)
# ═══════════════════════════════════════════════
LETTER_SOUNDS = {
    "alif_sound": "أَ",
    "baa_sound": "بَ",
    "taa_sound": "تَ",
    "thaa_sound": "ثَ",
    "jeem_sound": "جَ",
    "haa_h_sound": "حَ",
    "khaa_sound": "خَ",
    "daal_sound": "دَ",
    "dhaal_sound": "ذَ",
    "raa_sound": "رَ",
    "zaay_sound": "زَ",
    "seen_sound": "سَ",
    "sheen_sound": "شَ",
    "saad_sound": "صَ",
    "daad_sound": "ضَ",
    "taa_t_sound": "طَ",
    "dhaa_dh_sound": "ظَ",
    "ain_sound": "عَ",
    "ghain_sound": "غَ",
    "faa_sound": "فَ",
    "qaaf_sound": "قَ",
    "kaaf_sound": "كَ",
    "laam_sound": "لَ",
    "meem_sound": "مَ",
    "noon_sound": "نَ",
    "haa_sound": "هَ",
    "waaw_sound": "وَ",
    "yaa_sound": "يَ",
}

# ═══════════════════════════════════════════════
# P3-T008: Fatha Variants (28 files)
# ═══════════════════════════════════════════════
LETTER_FATHA = {
    "alif_fatha": "أَ",
    "baa_fatha": "بَ",
    "taa_fatha": "تَ",
    "thaa_fatha": "ثَ",
    "jeem_fatha": "جَ",
    "haa_h_fatha": "حَ",
    "khaa_fatha": "خَ",
    "daal_fatha": "دَ",
    "dhaal_fatha": "ذَ",
    "raa_fatha": "رَ",
    "zaay_fatha": "زَ",
    "seen_fatha": "سَ",
    "sheen_fatha": "شَ",
    "saad_fatha": "صَ",
    "daad_fatha": "ضَ",
    "taa_t_fatha": "طَ",
    "dhaa_dh_fatha": "ظَ",
    "ain_fatha": "عَ",
    "ghain_fatha": "غَ",
    "faa_fatha": "فَ",
    "qaaf_fatha": "قَ",
    "kaaf_fatha": "كَ",
    "laam_fatha": "لَ",
    "meem_fatha": "مَ",
    "noon_fatha": "نَ",
    "haa_fatha": "هَ",
    "waaw_fatha": "وَ",
    "yaa_fatha": "يَ",
}

# ═══════════════════════════════════════════════
# P3-T009: Kasra Variants (28 files)
# ═══════════════════════════════════════════════
LETTER_KASRA = {
    "alif_kasra": "إِ",
    "baa_kasra": "بِ",
    "taa_kasra": "تِ",
    "thaa_kasra": "ثِ",
    "jeem_kasra": "جِ",
    "haa_h_kasra": "حِ",
    "khaa_kasra": "خِ",
    "daal_kasra": "دِ",
    "dhaal_kasra": "ذِ",
    "raa_kasra": "رِ",
    "zaay_kasra": "زِ",
    "seen_kasra": "سِ",
    "sheen_kasra": "شِ",
    "saad_kasra": "صِ",
    "daad_kasra": "ضِ",
    "taa_t_kasra": "طِ",
    "dhaa_dh_kasra": "ظِ",
    "ain_kasra": "عِ",
    "ghain_kasra": "غِ",
    "faa_kasra": "فِ",
    "qaaf_kasra": "قِ",
    "kaaf_kasra": "كِ",
    "laam_kasra": "لِ",
    "meem_kasra": "مِ",
    "noon_kasra": "نِ",
    "haa_kasra": "هِ",
    "waaw_kasra": "وِ",
    "yaa_kasra": "يِ",
}

# ═══════════════════════════════════════════════
# P3-T010: Damma Variants (28 files)
# ═══════════════════════════════════════════════
LETTER_DAMMA = {
    "alif_damma": "أُ",
    "baa_damma": "بُ",
    "taa_damma": "تُ",
    "thaa_damma": "ثُ",
    "jeem_damma": "جُ",
    "haa_h_damma": "حُ",
    "khaa_damma": "خُ",
    "daal_damma": "دُ",
    "dhaal_damma": "ذُ",
    "raa_damma": "رُ",
    "zaay_damma": "زُ",
    "seen_damma": "سُ",
    "sheen_damma": "شُ",
    "saad_damma": "صُ",
    "daad_damma": "ضُ",
    "taa_t_damma": "طُ",
    "dhaa_dh_damma": "ظُ",
    "ain_damma": "عُ",
    "ghain_damma": "غُ",
    "faa_damma": "فُ",
    "qaaf_damma": "قُ",
    "kaaf_damma": "كُ",
    "laam_damma": "لُ",
    "meem_damma": "مُ",
    "noon_damma": "نُ",
    "haa_damma": "هُ",
    "waaw_damma": "وُ",
    "yaa_damma": "يُ",
}

# ═══════════════════════════════════════════════
# P3-T011: Example Words (28 files)
# ═══════════════════════════════════════════════
LETTER_WORDS = {
    "alif_word": "أَرْنَب",
    "baa_word": "بَيْت",
    "taa_word": "تُفَّاحَة",
    "thaa_word": "ثَعْلَب",
    "jeem_word": "جَمَل",
    "haa_h_word": "حِصَان",
    "khaa_word": "خَرُوف",
    "daal_word": "دُبّ",
    "dhaal_word": "ذِئْب",
    "raa_word": "رُمَّان",
    "zaay_word": "زَرَافَة",
    "seen_word": "سَمَكَة",
    "sheen_word": "شَجَرَة",
    "saad_word": "صَقْر",
    "daad_word": "ضِفْدَع",
    "taa_t_word": "طَائِر",
    "dhaa_dh_word": "ظَرْف",
    "ain_word": "عِنَب",
    "ghain_word": "غَزَال",
    "faa_word": "فِيل",
    "qaaf_word": "قِطَّة",
    "kaaf_word": "كَلْب",
    "laam_word": "لَيْمُون",
    "meem_word": "مَوْز",
    "noon_word": "نَحْلَة",
    "haa_word": "هِلَال",
    "waaw_word": "وَرْدَة",
    "yaa_word": "يَد",
}

# ═══════════════════════════════════════════════
# Sentence entries (28 files) — example sentences
# ═══════════════════════════════════════════════
LETTER_SENTENCES = {
    "alif_sentence": "الألف هو أول حرف في الأبجدية العربية",
    "baa_sentence": "البيت كبير وجميل",
    "taa_sentence": "التفاحة حمراء ولذيذة",
    "thaa_sentence": "الثعلب حيوان ذكي",
    "jeem_sentence": "الجمل يعيش في الصحراء",
    "haa_h_sentence": "الحصان يركض بسرعة",
    "khaa_sentence": "الخروف له صوف ناعم",
    "daal_sentence": "الدب يحب العسل",
    "dhaal_sentence": "الذئب يعوي في الليل",
    "raa_sentence": "الرمان فاكهة لذيذة",
    "zaay_sentence": "الزرافة رقبتها طويلة",
    "seen_sentence": "السمكة تسبح في البحر",
    "sheen_sentence": "الشجرة كبيرة وخضراء",
    "saad_sentence": "الصقر طائر قوي",
    "daad_sentence": "الضفدع يقفز في الماء",
    "taa_t_sentence": "الطائر يغرد على الشجرة",
    "dhaa_dh_sentence": "الظرف فيه رسالة",
    "ain_sentence": "العنب فاكهة حلوة",
    "ghain_sentence": "الغزال سريع وجميل",
    "faa_sentence": "الفيل حيوان ضخم",
    "qaaf_sentence": "القطة تحب اللعب",
    "kaaf_sentence": "الكلب صديق وفي",
    "laam_sentence": "الليمون حامض ومفيد",
    "meem_sentence": "الموز فاكهة مغذية",
    "noon_sentence": "النحلة تصنع العسل",
    "haa_sentence": "الهلال يظهر في رمضان",
    "waaw_sentence": "الوردة جميلة ورائحتها طيبة",
    "yaa_sentence": "اليد بها خمس أصابع",
}

# ═══════════════════════════════════════════════
# P3-T012: Feedback Phrases (10 files)
# ═══════════════════════════════════════════════
FEEDBACK_PHRASES = {
    "excellent": "أحسنت!",
    "great": "ممتاز!",
    "wonderful": "رائع!",
    "try_again": "لنجرب مرة أخرى!",
    "close": "قريب جداً!",
    "champion": "بطل!",
    "wow": "يا سلام!",
    "correct": "صحيح!",
    "continue": "هيا نكمل!",
    "smart": "أنت ذكي!",
}


async def generate_audio(text: str, output_path: str, voice: str = VOICE):
    """Generate a single audio file using edge-tts."""
    communicate = edge_tts.Communicate(text, voice)
    await communicate.save(output_path)


async def main():
    """Generate all audio files."""
    # Ensure output directories exist
    for d in [LETTERS_DIR, FEEDBACK_DIR, SFX_DIR]:
        os.makedirs(d, exist_ok=True)

    # Combine all letter entries
    all_letters = {}
    all_letters.update(LETTER_NAMES)
    all_letters.update(LETTER_SOUNDS)
    all_letters.update(LETTER_FATHA)
    all_letters.update(LETTER_KASRA)
    all_letters.update(LETTER_DAMMA)
    all_letters.update(LETTER_WORDS)
    all_letters.update(LETTER_SENTENCES)

    total = len(all_letters) + len(FEEDBACK_PHRASES)
    generated = 0
    skipped = 0
    errors = 0

    print(f"[*] Generating {total} audio files with voice: {VOICE}")
    print(f"   Letters: {len(all_letters)} files")
    print(f"   Feedback: {len(FEEDBACK_PHRASES)} files")
    print()

    # Generate letter audio files
    for key, text in all_letters.items():
        output_path = os.path.join(LETTERS_DIR, f"{key}.mp3")
        if os.path.exists(output_path):
            skipped += 1
            continue
        try:
            await generate_audio(text, output_path)
            generated += 1
            print(f"  [OK] [{generated}/{total}] {key}")
        except Exception as e:
            errors += 1
            print(f"  [ERR] [{key}] Error: {e}")

    # Generate feedback audio files
    for key, text in FEEDBACK_PHRASES.items():
        output_path = os.path.join(FEEDBACK_DIR, f"{key}.mp3")
        if os.path.exists(output_path):
            skipped += 1
            continue
        try:
            await generate_audio(text, output_path)
            generated += 1
            print(f"  [OK] [{generated}/{total}] feedback_{key}")
        except Exception as e:
            errors += 1
            print(f"  [ERR] [feedback_{key}] Error: {e}")

    print()
    print(f"[DONE] Generated: {generated}, Skipped: {skipped}, Errors: {errors}")
    print(f"   Total files in letters/: {len(os.listdir(LETTERS_DIR))}")
    print(f"   Total files in feedback/: {len(os.listdir(FEEDBACK_DIR))}")


if __name__ == "__main__":
    asyncio.run(main())
