import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست وحدة حرف السين (س) ───
// المصدر الصوتي: d:\Projects\faseeh\scratch\extracted_all\seen\audio\module_*.swf

const String _dir = 'assets/images/lessons/seen/';
const String _audio = 'audio/lessons/seen/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف السين كامل
const LetterUnitManifest seenManifest = LetterUnitManifest(
  letter: 'س',
  unitTitle: 'الوحدة الثانية عشرة | حرف السين (س)',
  topBarColor: Color(0xFF2E7D32), // أخضر زمردي داكن
  highlightColor: Color(0xFFA5D6A7), // أخضر فاتح
  mascotEmoji: '🐢', // سلحفاة
  unitIndex: 12,
  nextLetter: 'ش',

  // ── الأهداف ──
  objectives: ObjectivesSpec(
    audioPath: '${_audio}seen_goal.mp3',
    objectives: [
      'التعرف على شكل وصوت حرف السين (س)',
      'التمييز بين الحركات القصيرة والطويلة',
      'كتابة حرف السين في مواضعه المختلفة',
      'قراءة كلمات تبدأ أو تحتوي على حرف السين',
      'التفاعل مع قصة ونشيد حرف السين',
      'تطبيق المهارات المكتسبة عبر ألعاب تفاعلية',
      'إتقان نطق حرف السين بمخارجه الصحيحة',
    ],
  ),

  // ── القصة (6 مشاهد + نشيد) ──
  story: StorySpec(
    scenes: [
      StoryScene(imagePath: '${_dir}seen_cd_story_1.png', audioPath: '${_audio}seen_story_1.mp3'),
      StoryScene(imagePath: '${_dir}seen_cd_story_2.png', audioPath: '${_audio}seen_story_2.mp3'),
      StoryScene(imagePath: '${_dir}seen_cd_story_3.png', audioPath: '${_audio}seen_story_3.mp3'),
      StoryScene(imagePath: '${_dir}seen_cd_story_4.png', audioPath: '${_audio}seen_story_4.mp3'),
      StoryScene(imagePath: '${_dir}seen_cd_story_5.png', audioPath: '${_audio}seen_story_5.mp3'),
      StoryScene(imagePath: '${_dir}seen_cd_story_6.png', audioPath: '${_audio}seen_story_6.mp3'),
      StoryScene(imagePath: '${_dir}seen_cd_story_nasheed.png', audioPath: '${_audio}seen_nasheed.mp3', isNasheed: true),
    ],
  ),

  // ── الحركات ──
  vowels: VowelsSpec(
    letterChar: 'س',
    items: [
      VowelItem(
        displayChar: 'س',
        fathaAudio: '${_vowelsAudio}seen_fatha.mp3',
        dammaAudio: '${_vowelsAudio}seen_damma.mp3',
        kasraAudio: '${_vowelsAudio}seen_kasra.mp3',
      ),
    ],
  ),

  // ── المدود ──
  madd: MaddSpec(
    letterChar: 'س',
    items: [
      MaddItem(displayChar: 'سَا', audioPath: '${_maddAudio}seen_madd_demo.mp3', imagePath: '${_dir}seen_madd_aa.png'),
      MaddItem(displayChar: 'سِي', audioPath: '${_maddAudio}seen_madd_demo.mp3', imagePath: '${_dir}seen_madd_ii.png'),
      MaddItem(displayChar: 'سُو', audioPath: '${_maddAudio}seen_madd_demo.mp3', imagePath: '${_dir}seen_madd_uu.png'),
    ],
  ),

  // ── التخطيط والكتابة ──
  tracing: TracingSpec(
    letterChar: 'س',
    audioIntroPath: '${_audio}seen_write_intro.mp3',
    stepImagePaths: [
      '${_dir}seen_write_step_1.png',
      '${_dir}seen_write_step_2.png',
      '${_dir}seen_write_step_3.png',
      '${_dir}seen_write_step_4.png',
    ],
  ),

  // ── بنك الكلمات (5 صفحات × 4 كلمات) ──
  words: WordsSpec(
    pages: [
      // صفحة 1: كلمات بالفتحة
      WordsPage(
        listImagePath: '${_dir}seen_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'سَمَكَة', cardImagePath: '${_dir}seen_words_p1_card_1.png', cardHeight: 380, audioPath: '${_audio}seen_word_p1_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سَفِينَة', cardImagePath: '${_dir}seen_words_p1_card_2.png', cardHeight: 380, audioPath: '${_audio}seen_word_p1_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سَاعَة', cardImagePath: '${_dir}seen_words_p1_card_3.png', cardHeight: 380, audioPath: '${_audio}seen_word_p1_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سَيَّارَة', cardImagePath: '${_dir}seen_words_p1_card_4.png', cardHeight: 380, audioPath: '${_audio}seen_word_p1_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 2: كلمات بالضمة
      WordsPage(
        listImagePath: '${_dir}seen_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'سُكَّر', cardImagePath: '${_dir}seen_words_p2_card_1.png', cardHeight: 380, audioPath: '${_audio}seen_word_p2_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سُلَحْفَاة', cardImagePath: '${_dir}seen_words_p2_card_2.png', cardHeight: 380, audioPath: '${_audio}seen_word_p2_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سُور', cardImagePath: '${_dir}seen_words_p2_card_3.png', cardHeight: 380, audioPath: '${_audio}seen_word_p2_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سُوق', cardImagePath: '${_dir}seen_words_p2_card_4.png', cardHeight: 380, audioPath: '${_audio}seen_word_p2_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 3: كلمات بالكسرة
      WordsPage(
        listImagePath: '${_dir}seen_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'سِرْوَال', cardImagePath: '${_dir}seen_words_p3_card_1.png', cardHeight: 380, audioPath: '${_audio}seen_word_p3_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سِتَار', cardImagePath: '${_dir}seen_words_p3_card_2.png', cardHeight: 380, audioPath: '${_audio}seen_word_p3_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سِبَاق', cardImagePath: '${_dir}seen_words_p3_card_3.png', cardHeight: 380, audioPath: '${_audio}seen_word_p3_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سِكِّين', cardImagePath: '${_dir}seen_words_p3_card_4.png', cardHeight: 380, audioPath: '${_audio}seen_word_p3_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 4: السين في مواضع مختلفة
      WordsPage(
        listImagePath: '${_dir}seen_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'مَسْجِد', cardImagePath: '${_dir}seen_words_p4_card_1.png', cardHeight: 380, audioPath: '${_audio}seen_word_p4_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'جِسْر', cardImagePath: '${_dir}seen_words_p4_card_2.png', cardHeight: 380, audioPath: '${_audio}seen_word_p4_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'شَمْس', cardImagePath: '${_dir}seen_words_p4_card_3.png', cardHeight: 380, audioPath: '${_audio}seen_word_p4_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'فَرَس', cardImagePath: '${_dir}seen_words_p4_card_4.png', cardHeight: 380, audioPath: '${_audio}seen_word_p4_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 5: كلمات المد + مراجعة
      WordsPage(
        listImagePath: '${_dir}seen_words_p5_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'سَارَ', cardImagePath: '${_dir}seen_words_p5_card_1.png', cardHeight: 380, audioPath: '${_audio}seen_word_p5_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سُوق', cardImagePath: '${_dir}seen_words_p5_card_2.png', cardHeight: 380, audioPath: '${_audio}seen_word_p5_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'سِير', cardImagePath: '${_dir}seen_words_p5_card_3.png', cardHeight: 380, audioPath: '${_audio}seen_word_p5_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'نَسْر', cardImagePath: '${_dir}seen_words_p5_card_4.png', cardHeight: 380, audioPath: '${_audio}seen_word_p5_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
    ],
  ),

  // ── الألعاب ──
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'سَمَكَة', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بَاب', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'سَفِينَة', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'قَلَم', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_4.mp3', isCorrect: false),
    ],
    beehive: [
      BeehiveRound(word: 'سَمَكَة', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_1.mp3'),
      BeehiveRound(word: 'سُكَّر', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_2.mp3'),
      BeehiveRound(word: 'سِرْوَال', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_3.mp3'),
      BeehiveRound(word: 'مَسْجِد', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'سَمَكَة', imagePath: '${_gamesDir}circus/seen/seen_circus_round_1.png', audioPath: '${_gamesAudio}circus/seen/seen_circus_1.mp3'),
      CircusRound(word: 'سُلَحْفَاة', imagePath: '${_gamesDir}circus/seen/seen_circus_round_2.png', audioPath: '${_gamesAudio}circus/seen/seen_circus_2.mp3'),
      CircusRound(word: 'سَيَّارَة', imagePath: '${_gamesDir}circus/seen/seen_circus_round_3.png', audioPath: '${_gamesAudio}circus/seen/seen_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'سَمَكَة', imagePath: '${_gamesDir}match/seen/seen_match_1.png', audioPath: '${_gamesAudio}match/seen/seen_match_1.mp3'),
      WordsMatchPair(word: 'سَفِينَة', imagePath: '${_gamesDir}match/seen/seen_match_2.png', audioPath: '${_gamesAudio}match/seen/seen_match_2.mp3'),
      WordsMatchPair(word: 'سُلَحْفَاة', imagePath: '${_gamesDir}match/seen/seen_match_3.png', audioPath: '${_gamesAudio}match/seen/seen_match_3.mp3'),
      WordsMatchPair(word: 'سَيَّارَة', imagePath: '${_gamesDir}match/seen/seen_match_4.png', audioPath: '${_gamesAudio}match/seen/seen_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'سَارَ',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_1.png',
        introAudioPath: '${_audio}seen_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_saah.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_1.png', color: Color(0xFF1B5E20)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_2.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_3.png', color: Color(0xFF4CAF50)),
        ],
      ),
      ColoringRound(
        word: 'سُوق',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_2.png',
        introAudioPath: '${_audio}seen_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_sooh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_1.png', color: Color(0xFF33691E)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_2.png', color: Color(0xFF558B2F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_3.png', color: Color(0xFF7CB342)),
        ],
      ),
      ColoringRound(
        word: 'سِير',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_3.png',
        introAudioPath: '${_audio}seen_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_seeh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_1.png', color: Color(0xFF004D40)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_2.png', color: Color(0xFF00796B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_3.png', color: Color(0xFF4DB6AC)),
        ],
      ),
    ],
  ),
);
