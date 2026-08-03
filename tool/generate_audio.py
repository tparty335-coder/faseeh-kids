# -*- coding: utf-8 -*-
"""
Faseeh Audio Generator — Professional Arabic TTS using Microsoft Edge Neural Voices.
Generates deterministic filenames using a sequential key map matching audio_registry.dart.
Run: python generate_audio.py
"""

import os
import asyncio

try:
    import edge_tts
except ImportError:
    print("Installing edge-tts...")
    os.system("pip install edge-tts")
    import edge_tts

import json

# ====================================================================
# MASTER REGISTRY: key → arabic_text
# Loads from tool/audio_strings.json dynamically.
# ====================================================================
with open(os.path.join(os.path.dirname(__file__), 'audio_strings.json'), 'r', encoding='utf-8') as f:
    AUDIO_MAP = json.load(f)


VOICE = "ar-EG-ShakirNeural"   # Masculine, natural Egyptian Arabic — Microsoft Neural
RATE  = "-12%"                  # Slightly slower for pedagogical clarity

AUDIO_DIR = os.path.join("..", "assets", "audio")


async def generate_all():
    os.makedirs(AUDIO_DIR, exist_ok=True)
    generated = 0
    skipped   = 0

    for key, text in AUDIO_MAP.items():
        filepath = os.path.join(AUDIO_DIR, f"{key}.mp3")
        if os.path.exists(filepath):
            print(f"  [OK] {key}.mp3")
            skipped += 1
            continue

        print(f"  [GEN] {key}.mp3 -> {text[:50]}")
        try:
            communicate = edge_tts.Communicate(text, VOICE, rate=RATE)
            await communicate.save(filepath)
            generated += 1
        except Exception as e:
            print(f"  [ERR] {key}: {e}")

    print(f"\nDone: {generated} generated, {skipped} already existed.")
    print("Next step: flutter run")


if __name__ == "__main__":
    asyncio.run(generate_all())
