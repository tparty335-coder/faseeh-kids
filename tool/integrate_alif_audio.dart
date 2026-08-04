import 'dart:io';

/// Maps extracted audio files to Faseeh Kids AudioRegistry keys
/// Based on deep analysis of SWF module structure and sound durations.
///
/// Module mapping (discovered via reverse engineering):
/// - ahdaf_a2: الحركات والمدود والكلمات (the richest module)
///   → Sound IDs by play order and duration analysis:
///     ID 1 (8.7KB, 0.6s) = very short = letter sound أَ or click
///     IDs 2-6 = long narrations = story/instructions about harakat
///     IDs 7-8,13-14 = medium = individual word pronunciations  
///     IDs 9-12 = long = harakat explanations (fatha, kasra, damma groups)
///     IDs 16,29-32 = very long = complete harakat demonstrations
///     IDs 20,42 = tiny = click/transition sounds
///
/// - ahdaf_a4: تعليم الكتابة (tracing instructions)  
///   → IDs 1-20 (~12-15KB each, ~0.8-1s) = step-by-step tracing voice cues
///   → ID 21 (85KB) = complete writing instruction narration
///   → ID 22 (29.5KB) = summary/praise
///
/// - Main.swf: الشاشة الرئيسية
///   → ID 1 (250KB) = opening narration / welcome
///   → ID 3 (209KB) = letter introduction "هذا حرف الألف"
///   → ID 4 (115KB) = educational goal narration

void main() async {
  final srcDir = r'd:\Projects\faseeh_kids\scratch\extracted_alif\audio';
  final dstLetters = r'd:\Projects\faseeh_kids\assets\audio\letters';
  final dstFeedback = r'd:\Projects\faseeh_kids\assets\audio\feedback';
  final dstInstructions = r'd:\Projects\faseeh_kids\assets\audio\instructions';
  final dstStories = r'd:\Projects\faseeh_kids\assets\audio\stories';

  // Ensure directories exist
  for (final d in [dstLetters, dstFeedback, dstInstructions, dstStories]) {
    await Directory(d).create(recursive: true);
  }

  int copied = 0;

  Future<void> cp(String src, String dst) async {
    final srcFile = File('$srcDir/$src');
    if (await srcFile.exists()) {
      await srcFile.copy(dst);
      final kb = (await srcFile.length()) / 1024;
      print('  ✅ $src → ${dst.split(Platform.pathSeparator).last} (${kb.toStringAsFixed(1)} KB)');
      copied++;
    } else {
      print('  ❌ MISSING: $src');
    }
  }

  print('╔══════════════════════════════════════════════════════════════╗');
  print('║  ALIF AUDIO INTEGRATION INTO FASEEH KIDS                   ║');
  print('╚══════════════════════════════════════════════════════════════╝\n');

  // ═══════════════════════════════════════════════════
  // 1. CORE LETTER SOUNDS (AudioRegistry keys)
  // ═══════════════════════════════════════════════════
  print('📌 [1/6] Core Letter Sounds (alif_name, alif_sound, etc.)');
  print('─────────────────────────────────────────────────────────');

  // alif_name → "ألف" - the letter name spoken clearly
  // From ahdaf_a1, sound 5 (12.5KB, ~0.8s) - short, likely just "ألف"
  await cp('ahdaf_a1_sound_0005.mp3', '$dstLetters/alif_name.mp3');

  // alif_sound → The sound of the letter أَ
  // From ahdaf_a2, sound 1 (8.7KB, 0.6s) - very short, pure letter sound
  await cp('ahdaf_a2_sound_0001.mp3', '$dstLetters/alif_sound.mp3');

  // alif_fatha → أَ with fatha
  // From ahdaf_a2, sound 3 (23.8KB, ~1.5s) - short haraka demonstration
  await cp('ahdaf_a2_sound_0003.mp3', '$dstLetters/alif_fatha.mp3');

  // alif_kasra → إِ with kasra
  // From ahdaf_a2, sound 4 (22.2KB, ~1.4s) - short haraka demonstration
  await cp('ahdaf_a2_sound_0004.mp3', '$dstLetters/alif_kasra.mp3');

  // alif_damma → أُ with damma
  // From ahdaf_a2, sound 7 (24.2KB, ~1.5s) - short haraka demonstration
  await cp('ahdaf_a2_sound_0007.mp3', '$dstLetters/alif_damma.mp3');

  // alif_word → Example word أَرْنَب
  // From ahdaf_a2, sound 8 (32.4KB, ~2s) - medium, word pronunciation
  await cp('ahdaf_a2_sound_0008.mp3', '$dstLetters/alif_word.mp3');

  // alif_sentence → Example sentence with the letter
  // From ahdaf_a2, sound 9 (50.3KB, ~3.2s) - longer, sentence with context
  await cp('ahdaf_a2_sound_0009.mp3', '$dstLetters/alif_sentence.mp3');

  // ═══════════════════════════════════════════════════
  // 2. EXTENDED LETTER SOUNDS (Rich content)
  // ═══════════════════════════════════════════════════
  print('\n📌 [2/6] Extended Letter Sounds (harakat, mudud, positions)');
  print('─────────────────────────────────────────────────────────');

  // Harakat long demonstrations from ahdaf_a2
  await cp('ahdaf_a2_sound_0010.mp3', '$dstLetters/alif_fatha_demo.mp3');
  await cp('ahdaf_a2_sound_0011.mp3', '$dstLetters/alif_kasra_demo.mp3');
  await cp('ahdaf_a2_sound_0012.mp3', '$dstLetters/alif_damma_demo.mp3');

  // Mudud (long vowels)
  await cp('ahdaf_a2_sound_0005.mp3', '$dstLetters/alif_madd_alif.mp3');
  await cp('ahdaf_a2_sound_0006.mp3', '$dstLetters/alif_madd_demo.mp3');

  // Additional words with Alef
  await cp('ahdaf_a2_sound_0013.mp3', '$dstLetters/alif_word2.mp3');
  await cp('ahdaf_a2_sound_0014.mp3', '$dstLetters/alif_word3.mp3');
  await cp('ahdaf_a2_sound_0015.mp3', '$dstLetters/alif_word4.mp3');

  // Letter positions from ahdaf_a3
  await cp('ahdaf_a3_sound_0001.mp3', '$dstLetters/alif_pos_start.mp3');
  await cp('ahdaf_a3_sound_0002.mp3', '$dstLetters/alif_pos_middle.mp3');
  await cp('ahdaf_a3_sound_0004.mp3', '$dstLetters/alif_pos_end.mp3');

  // Sukoon
  await cp('ahdaf_a2_sound_0023.mp3', '$dstLetters/alif_sukoon.mp3');

  // ═══════════════════════════════════════════════════
  // 3. WRITING INSTRUCTIONS (Trace screen)
  // ═══════════════════════════════════════════════════
  print('\n📌 [3/6] Writing/Tracing Instructions');
  print('─────────────────────────────────────────────────────────');

  // Step-by-step tracing guidance from ahdaf_a4
  for (int i = 1; i <= 20; i++) {
    final padded = i.toString().padLeft(4, '0');
    await cp('ahdaf_a4_sound_$padded.mp3', '$dstInstructions/alif_trace_step_${i.toString().padLeft(2, "0")}.mp3');
  }
  // Complete writing narration
  await cp('ahdaf_a4_sound_0021.mp3', '$dstInstructions/alif_trace_full.mp3');
  await cp('ahdaf_a4_sound_0022.mp3', '$dstInstructions/alif_trace_praise.mp3');

  // ═══════════════════════════════════════════════════
  // 4. STORY & EXPLORATION (Listen screen)
  // ═══════════════════════════════════════════════════
  print('\n📌 [4/6] Story & Exploration Audio');
  print('─────────────────────────────────────────────────────────');

  // Main welcome and introduction
  await cp('Main_sound_0001.mp3', '$dstStories/alif_welcome.mp3');
  await cp('Main_sound_0003.mp3', '$dstStories/alif_intro.mp3');
  await cp('Main_sound_0004.mp3', '$dstStories/alif_goal.mp3');

  // Story segments from ahdaf_a1
  await cp('ahdaf_a_sound_0001.mp3', '$dstStories/alif_story_full.mp3');
  await cp('ahdaf_a1_sound_0001.mp3', '$dstStories/alif_explore_01.mp3');
  await cp('ahdaf_a1_sound_0002.mp3', '$dstStories/alif_explore_02.mp3');
  await cp('ahdaf_a1_sound_0003.mp3', '$dstStories/alif_explore_03.mp3');
  await cp('ahdaf_a1_sound_0004.mp3', '$dstStories/alif_explore_04.mp3');
  await cp('ahdaf_a1_sound_0009.mp3', '$dstStories/alif_explore_05.mp3');
  await cp('ahdaf_a1_sound_0015.mp3', '$dstStories/alif_explore_06.mp3');
  await cp('ahdaf_a1_sound_0016.mp3', '$dstStories/alif_explore_07.mp3');
  await cp('ahdaf_a1_sound_0018.mp3', '$dstStories/alif_explore_08.mp3');
  await cp('ahdaf_a1_sound_0022.mp3', '$dstStories/alif_explore_09.mp3');

  // Full harakat demonstration narrations from ahdaf_a2
  await cp('ahdaf_a2_sound_0002.mp3', '$dstStories/alif_harakat_full.mp3');
  await cp('ahdaf_a2_sound_0016.mp3', '$dstStories/alif_harakat_demo.mp3');
  await cp('ahdaf_a2_sound_0029.mp3', '$dstStories/alif_mudud_full.mp3');
  await cp('ahdaf_a2_sound_0030.mp3', '$dstStories/alif_words_demo.mp3');
  await cp('ahdaf_a2_sound_0031.mp3', '$dstStories/alif_sentences_demo.mp3');
  await cp('ahdaf_a2_sound_0032.mp3', '$dstStories/alif_review.mp3');

  // ═══════════════════════════════════════════════════
  // 5. QUIZ & GAME AUDIO
  // ═══════════════════════════════════════════════════
  print('\n📌 [5/6] Quiz & Game Audio');
  print('─────────────────────────────────────────────────────────');

  // Quiz instructions from game modules
  await cp('ahdaf_a5_bee_sound_0001.mp3', '$dstInstructions/alif_quiz_bee_intro.mp3');
  await cp('ahdaf_a5_bee_sound_0007.mp3', '$dstInstructions/alif_quiz_bee_explain.mp3');
  await cp('ahdaf_a5_cir_sound_0001.mp3', '$dstInstructions/alif_quiz_circle_intro.mp3');
  await cp('ahdaf_a5_fish_sound_0001.mp3', '$dstInstructions/alif_quiz_fish_intro.mp3');
  await cp('ahdaf_a5_fish_sound_0002.mp3', '$dstInstructions/alif_quiz_fish_explain.mp3');
  await cp('ahdaf_a5_paint_sound_0001.mp3', '$dstInstructions/alif_paint_intro.mp3');
  await cp('ahdaf_a5_paint_sound_0002.mp3', '$dstInstructions/alif_paint_explain.mp3');
  await cp('ahdaf_a5_words_sound_0001.mp3', '$dstInstructions/alif_words_intro.mp3');

  // Phoneme quiz options (short sounds used in games)
  await cp('ahdaf_a5_bee_sound_0009.mp3', '$dstInstructions/alif_quiz_option_a.mp3');
  await cp('ahdaf_a5_bee_sound_0010.mp3', '$dstInstructions/alif_quiz_option_b.mp3');
  await cp('ahdaf_a5_bee_sound_0011.mp3', '$dstInstructions/alif_quiz_option_c.mp3');
  await cp('ahdaf_a5_bee_sound_0012.mp3', '$dstInstructions/alif_quiz_option_d.mp3');

  // ═══════════════════════════════════════════════════
  // 6. FEEDBACK & ENCOURAGEMENT (shared across letters)
  // ═══════════════════════════════════════════════════
  print('\n📌 [6/6] Feedback & Encouragement Sounds');
  print('─────────────────────────────────────────────────────────');

  // From ahdaf_a3 (positions module often has praise sounds)
  await cp('ahdaf_a3_sound_0003.mp3', '$dstFeedback/excellent.mp3');
  await cp('ahdaf_a3_sound_0007.mp3', '$dstFeedback/great.mp3');
  await cp('ahdaf_a3_sound_0017.mp3', '$dstFeedback/wonderful.mp3');
  await cp('ahdaf_a3_sound_0019.mp3', '$dstFeedback/try_again.mp3');
  await cp('ahdaf_a3_sound_0020.mp3', '$dstFeedback/close.mp3');
  await cp('ahdaf_a3_sound_0021.mp3', '$dstFeedback/champion.mp3');

  // Correct/wrong from game modules
  await cp('ahdaf_a5_bee_sound_0005.mp3', '$dstFeedback/correct.mp3');
  await cp('ahdaf_a5_bee_sound_0006.mp3', '$dstFeedback/wow.mp3');
  await cp('ahdaf_a5_cir_sound_0005.mp3', '$dstFeedback/continue.mp3');
  await cp('ahdaf_a5_cir_sound_0003.mp3', '$dstFeedback/smart.mp3');

  // ═══════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════
  print('\n══════════════════════════════════════════════════════════');
  print('🎯 INTEGRATION COMPLETE: $copied audio files deployed');
  print('══════════════════════════════════════════════════════════');

  // Count files in each directory
  for (final dir in [dstLetters, dstFeedback, dstInstructions, dstStories]) {
    final count = Directory(dir).listSync().whereType<File>().length;
    final totalKb = Directory(dir).listSync().whereType<File>()
        .map((f) => f.lengthSync())
        .fold<int>(0, (a, b) => a + b) / 1024;
    final dirName = dir.split(Platform.pathSeparator).last;
    print('  📁 $dirName: $count files (${totalKb.toStringAsFixed(1)} KB)');
  }
}
