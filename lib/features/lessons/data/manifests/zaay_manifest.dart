import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست وحدة حرف الزاي (ز) ───
// المصدر الصوتي: d:\Projects\faseeh\scratch\extracted_all\zaay\audio\module_*.swf

const String _dir = 'assets/images/lessons/zaay/';
const String _audio = 'audio/lessons/zaay/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الزاي كامل
const LetterUnitManifest zaayManifest = LetterUnitManifest(
  letter: 'ز',
  unitTitle: 'الوحدة الحادية عشرة | حرف الزاي (ز)',
  topBarColor: Color(0xFF00838F), // تيل سيان داكن
  highlightColor: Color(0xFF80DEEA), // سيان فاتح
  mascotEmoji: '🌸', // زهرة
  unitIndex: 11,
  nextLetter: 'س',

  // ── الأهداف ──
  objectives: ObjectivesSpec(
    audioPath: '${_audio}zaay_goal.mp3',
    objectives: [
      'التعرف على شكل وصوت حرف الزاي (ز)',
      'التمييز بين الحركات القصيرة والطويلة',
      'كتابة حرف الزاي في مواضعه المختلفة',
      'قراءة كلمات تبدأ أو تحتوي على حرف الزاي',
      'التفاعل مع قصة ونشيد حرف الزاي',
      'تطبيق المهارات المكتسبة عبر ألعاب تفاعلية',
      'إتقان نطق حرف الزاي بمخارجه الصحيحة',
    ],
  ),

  // ── القصة (6 مشاهد + نشيد) ──
  story: StorySpec(
    scenes: [
      StoryScene(imagePath: '${_dir}zaay_cd_story_1.png', audioPath: '${_audio}zaay_story_1.mp3'),
      StoryScene(imagePath: '${_dir}zaay_cd_story_2.png', audioPath: '${_audio}zaay_story_2.mp3'),
      StoryScene(imagePath: '${_dir}zaay_cd_story_3.png', audioPath: '${_audio}zaay_story_3.mp3'),
      StoryScene(imagePath: '${_dir}zaay_cd_story_4.png', audioPath: '${_audio}zaay_story_4.mp3'),
      StoryScene(imagePath: '${_dir}zaay_cd_story_5.png', audioPath: '${_audio}zaay_story_5.mp3'),
      StoryScene(imagePath: '${_dir}zaay_cd_story_6.png', audioPath: '${_audio}zaay_story_6.mp3'),
      StoryScene(imagePath: '${_dir}zaay_cd_story_nasheed.png', audioPath: '${_audio}zaay_nasheed.mp3', isNasheed: true),
    ],
  ),

  // ── الحركات ──
  vowels: VowelsSpec(
    letterChar: 'ز',
    items: [
      VowelItem(
        displayChar: 'ز',
        fathaAudio: '${_vowelsAudio}zaay_fatha.mp3',
        dammaAudio: '${_vowelsAudio}zaay_damma.mp3',
        kasraAudio: '${_vowelsAudio}zaay_kasra.mp3',
      ),
    ],
  ),

  // ── المدود ──
  madd: MaddSpec(
    letterChar: 'ز',
    items: [
      MaddItem(displayChar: 'زَا', audioPath: '${_maddAudio}zaay_madd_demo.mp3', imagePath: '${_dir}zaay_madd_aa.png'),
      MaddItem(displayChar: 'زِي', audioPath: '${_maddAudio}zaay_madd_demo.mp3', imagePath: '${_dir}zaay_madd_ii.png'),
      MaddItem(displayChar: 'زُو', audioPath: '${_maddAudio}zaay_madd_demo.mp3', imagePath: '${_dir}zaay_madd_uu.png'),
    ],
  ),

  // ── التخطيط والكتابة ──
  tracing: TracingSpec(
    letterChar: 'ز',
    audioIntroPath: '${_audio}zaay_write_intro.mp3',
    stepImagePaths: [
      '${_dir}zaay_write_step_1.png',
      '${_dir}zaay_write_step_2.png',
      '${_dir}zaay_write_step_3.png',
      '${_dir}zaay_write_step_4.png',
    ],
  ),

  // ── بنك الكلمات (5 صفحات × 4 كلمات) ──
  words: WordsSpec(
    pages: [
      // صفحة 1: كلمات بالفتحة
      WordsPage(
        listImagePath: '${_dir}zaay_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'زَهْرَة', cardImagePath: '${_dir}zaay_words_p1_card_1.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p1_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَيْتُون', cardImagePath: '${_dir}zaay_words_p1_card_2.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p1_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَرَافَة', cardImagePath: '${_dir}zaay_words_p1_card_3.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p1_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زِنْبَق', cardImagePath: '${_dir}zaay_words_p1_card_4.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p1_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 2: كلمات بالضمة
      WordsPage(
        listImagePath: '${_dir}zaay_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'زَبِيب', cardImagePath: '${_dir}zaay_words_p2_card_1.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p2_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زُمُرُّد', cardImagePath: '${_dir}zaay_words_p2_card_2.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p2_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَرَع', cardImagePath: '${_dir}zaay_words_p2_card_3.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p2_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زِيَارَة', cardImagePath: '${_dir}zaay_words_p2_card_4.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p2_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 3: كلمات بالكسرة
      WordsPage(
        listImagePath: '${_dir}zaay_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'زَلْزَال', cardImagePath: '${_dir}zaay_words_p3_card_1.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p3_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زُقَاق', cardImagePath: '${_dir}zaay_words_p3_card_2.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p3_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَيْت', cardImagePath: '${_dir}zaay_words_p3_card_3.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p3_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَوْرَق', cardImagePath: '${_dir}zaay_words_p3_card_4.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p3_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 4: الزاي في مواضع مختلفة
      WordsPage(
        listImagePath: '${_dir}zaay_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'خِزَانَة', cardImagePath: '${_dir}zaay_words_p4_card_1.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p4_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'مِيزَان', cardImagePath: '${_dir}zaay_words_p4_card_2.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p4_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'عِزَّة', cardImagePath: '${_dir}zaay_words_p4_card_3.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p4_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'لَوْز', cardImagePath: '${_dir}zaay_words_p4_card_4.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p4_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 5: كلمات المد + مراجعة
      WordsPage(
        listImagePath: '${_dir}zaay_words_p5_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'زَاد', cardImagePath: '${_dir}zaay_words_p5_card_1.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p5_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زُور', cardImagePath: '${_dir}zaay_words_p5_card_2.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p5_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زِين', cardImagePath: '${_dir}zaay_words_p5_card_3.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p5_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَهْرَة', cardImagePath: '${_dir}zaay_words_p5_card_4.png', cardHeight: 380, audioPath: '${_audio}zaay_word_p5_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
    ],
  ),

  // ── الألعاب ──
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'زَهْرَة', imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بَاب', imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'زَيْتُون', imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'قَلَم', imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_4.mp3', isCorrect: false),
    ],
    beehive: [
      BeehiveRound(word: 'زَهْرَة', imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_1.mp3'),
      BeehiveRound(word: 'زُمُرُّد', imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_2.mp3'),
      BeehiveRound(word: 'زِيَارَة', imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_3.mp3'),
      BeehiveRound(word: 'مِيزَان', imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'زَهْرَة', imagePath: '${_gamesDir}circus/zaay/zaay_circus_round_1.png', audioPath: '${_gamesAudio}circus/zaay/zaay_circus_1.mp3'),
      CircusRound(word: 'زَرَافَة', imagePath: '${_gamesDir}circus/zaay/zaay_circus_round_2.png', audioPath: '${_gamesAudio}circus/zaay/zaay_circus_2.mp3'),
      CircusRound(word: 'زَيْتُون', imagePath: '${_gamesDir}circus/zaay/zaay_circus_round_3.png', audioPath: '${_gamesAudio}circus/zaay/zaay_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'زَهْرَة', imagePath: '${_gamesDir}match/zaay/zaay_match_1.png', audioPath: '${_gamesAudio}match/zaay/zaay_match_1.mp3'),
      WordsMatchPair(word: 'زَرَافَة', imagePath: '${_gamesDir}match/zaay/zaay_match_2.png', audioPath: '${_gamesAudio}match/zaay/zaay_match_2.mp3'),
      WordsMatchPair(word: 'زَيْتُون', imagePath: '${_gamesDir}match/zaay/zaay_match_3.png', audioPath: '${_gamesAudio}match/zaay/zaay_match_3.mp3'),
      WordsMatchPair(word: 'مِيزَان', imagePath: '${_gamesDir}match/zaay/zaay_match_4.png', audioPath: '${_gamesAudio}match/zaay/zaay_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'زَاد',
        bgImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_word_1.png',
        introAudioPath: '${_audio}zaay_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zaah.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1_slice_1.png', color: Color(0xFF00838F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1_slice_2.png', color: Color(0xFF00ACC1)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1_slice_3.png', color: Color(0xFF80DEEA)),
        ],
      ),
      ColoringRound(
        word: 'زُور',
        bgImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_word_2.png',
        introAudioPath: '${_audio}zaay_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zooh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2_slice_1.png', color: Color(0xFF004D40)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2_slice_2.png', color: Color(0xFF00695C)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2_slice_3.png', color: Color(0xFF4DB6AC)),
        ],
      ),
      ColoringRound(
        word: 'زِين',
        bgImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_word_3.png',
        introAudioPath: '${_audio}zaay_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zeeh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3_slice_1.png', color: Color(0xFF00897B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3_slice_2.png', color: Color(0xFF26C6DA)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3_slice_3.png', color: Color(0xFFB2EBF2)),
        ],
      ),
    ],
  ),
);
