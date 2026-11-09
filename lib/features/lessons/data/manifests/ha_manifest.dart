import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الحاء (ح) — المحرك الموحّد ──────────────────────────────────
// المصدر: d:\Projects\faseeh\scratch\extracted_all\haa\audio\module_*.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/ha/';
const String _audio = 'audio/lessons/ha/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الحاء — أصوات أصيلة من module_*.swf، صور placeholder
const LetterUnitManifest haManifest = LetterUnitManifest(
  letter: 'ح',
  unitTitle: 'الْوَحْدَةُ السَّادِسَةُ | حَرْفُ الْحَاءِ (ح)',
  topBarColor: Color(0xFF0277BD), // أزرق عميق
  highlightColor: Color(0xFFB3E5FC), // أزرق فاتح
  mascotEmoji: '🐴', // حصان
  unitIndex: 6,
  nextLetter: 'خ',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}ha_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الْحَاءِ (ح)',
      'أَنْطِقُ حَرْفَ الْحَاءِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الْحَاءِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الْحَاءِ',
      'أَتَتَبَّعُ حَرْفَ الْحَاءِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الْحَاءِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الْحَاءِ',
    ],
  ),

  // ── القصة (6 مشاهد + النشيد) ──────────────────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(imagePath: '${_dir}ha_cd_story_1.png', audioPath: '${_audio}ha_story_1.mp3'),
      StoryScene(imagePath: '${_dir}ha_cd_story_2.png', audioPath: '${_audio}ha_story_2.mp3'),
      StoryScene(imagePath: '${_dir}ha_cd_story_3.png', audioPath: '${_audio}ha_story_3.mp3'),
      StoryScene(imagePath: '${_dir}ha_cd_story_4.png', audioPath: '${_audio}ha_story_4.mp3'),
      StoryScene(imagePath: '${_dir}ha_cd_story_5.png', audioPath: '${_audio}ha_story_5.mp3'),
      StoryScene(imagePath: '${_dir}ha_cd_story_nasheed.png', audioPath: '${_audio}ha_nasheed.mp3', isNasheed: true),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ح',
    items: [
      VowelItem(
        displayChar: 'حَ',
        fathaAudio: '${_vowelsAudio}haa_h_fatha.mp3',
        dammaAudio: '${_vowelsAudio}haa_h_damma.mp3',
        kasraAudio: '${_vowelsAudio}haa_h_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ح',
    items: [
      MaddItem(displayChar: 'حَا', audioPath: '${_maddAudio}haa_h_madd_demo.mp3', imagePath: '${_dir}ha_madd_aa.png'),
      MaddItem(displayChar: 'حِي', audioPath: '${_maddAudio}haa_h_madd_demo.mp3', imagePath: '${_dir}ha_madd_ii.png'),
      MaddItem(displayChar: 'حُو', audioPath: '${_maddAudio}haa_h_madd_demo.mp3', imagePath: '${_dir}ha_madd_uu.png'),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ح',
    audioIntroPath: '${_audio}ha_write_intro.mp3',
    stepImagePaths: [
      '${_dir}ha_write_step_1.png',
      '${_dir}ha_write_step_2.png',
      '${_dir}ha_write_step_3.png',
      '${_dir}ha_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف (5 صفحات × 4 كلمات) ─────────────────────────────────────
  words: WordsSpec(
    pages: [
      // صفحة 1: حَمَل، حَجَر، حَصَان، حَال
      WordsPage(
        listImagePath: '${_dir}ha_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'حَمَل',  cardImagePath: '${_dir}ha_words_p1_card_1.png', cardHeight: 380, audioPath: '${_audio}ha_word_p1_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حَجَر',  cardImagePath: '${_dir}ha_words_p1_card_2.png', cardHeight: 380, audioPath: '${_audio}ha_word_p1_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حَصَان', cardImagePath: '${_dir}ha_words_p1_card_3.png', cardHeight: 380, audioPath: '${_audio}ha_word_p1_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حَال',   cardImagePath: '${_dir}ha_words_p1_card_4.png', cardHeight: 380, audioPath: '${_audio}ha_word_p1_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 2: حِمَار، حِصَان، حِجَاب، حِيلَة
      WordsPage(
        listImagePath: '${_dir}ha_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'حِمَار', cardImagePath: '${_dir}ha_words_p2_card_1.png', cardHeight: 380, audioPath: '${_audio}ha_word_p2_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حِصَان', cardImagePath: '${_dir}ha_words_p2_card_2.png', cardHeight: 380, audioPath: '${_audio}ha_word_p2_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حِجَاب', cardImagePath: '${_dir}ha_words_p2_card_3.png', cardHeight: 380, audioPath: '${_audio}ha_word_p2_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حِيلَة', cardImagePath: '${_dir}ha_words_p2_card_4.png', cardHeight: 380, audioPath: '${_audio}ha_word_p2_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 3: حُوت، حُجْرَة، حُبٌّ، حُلُم
      WordsPage(
        listImagePath: '${_dir}ha_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'حُوت',   cardImagePath: '${_dir}ha_words_p3_card_1.png', cardHeight: 380, audioPath: '${_audio}ha_word_p3_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حُجْرَة', cardImagePath: '${_dir}ha_words_p3_card_2.png', cardHeight: 380, audioPath: '${_audio}ha_word_p3_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حُبٌّ',   cardImagePath: '${_dir}ha_words_p3_card_3.png', cardHeight: 380, audioPath: '${_audio}ha_word_p3_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'حُلُم',  cardImagePath: '${_dir}ha_words_p3_card_4.png', cardHeight: 380, audioPath: '${_audio}ha_word_p3_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 4: نَحْل، بَحْر، فَرَح، صَحْن
      WordsPage(
        listImagePath: '${_dir}ha_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'نَحْل',  cardImagePath: '${_dir}ha_words_p4_card_1.png', cardHeight: 380, audioPath: '${_audio}ha_word_p4_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'بَحْر',  cardImagePath: '${_dir}ha_words_p4_card_2.png', cardHeight: 380, audioPath: '${_audio}ha_word_p4_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'فَرَح',  cardImagePath: '${_dir}ha_words_p4_card_3.png', cardHeight: 380, audioPath: '${_audio}ha_word_p4_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'صَحْن',  cardImagePath: '${_dir}ha_words_p4_card_4.png', cardHeight: 380, audioPath: '${_audio}ha_word_p4_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      
    ],
  ),

  // ── الألعاب ────────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'حَمَل',  imagePath: '${_gamesDir}fishing/ha/ha_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/ha/ha_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'كِتَاب', imagePath: '${_gamesDir}fishing/ha/ha_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/ha/ha_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'حِصَان', imagePath: '${_gamesDir}fishing/ha/ha_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/ha/ha_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'أَسَد',  imagePath: '${_gamesDir}fishing/ha/ha_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/ha/ha_fishing_4.mp3', isCorrect: false),
    ],
    beehive: [
      BeehiveRound(word: 'حَمَل',  imagePath: '${_gamesDir}beehive/ha/ha_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/ha/ha_beehive_1.mp3'),
      BeehiveRound(word: 'حِمَار', imagePath: '${_gamesDir}beehive/ha/ha_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/ha/ha_beehive_2.mp3'),
      BeehiveRound(word: 'حُوت',  imagePath: '${_gamesDir}beehive/ha/ha_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/ha/ha_beehive_3.mp3'),
      BeehiveRound(word: 'نَحْل',  imagePath: '${_gamesDir}beehive/ha/ha_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/ha/ha_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'حَمَل',  imagePath: '${_gamesDir}circus/ha/ha_circus_round_1.png', audioPath: '${_gamesAudio}circus/ha/ha_circus_1.mp3'),
      CircusRound(word: 'حِصَان', imagePath: '${_gamesDir}circus/ha/ha_circus_round_2.png', audioPath: '${_gamesAudio}circus/ha/ha_circus_2.mp3'),
      CircusRound(word: 'حِمَار', imagePath: '${_gamesDir}circus/ha/ha_circus_round_3.png', audioPath: '${_gamesAudio}circus/ha/ha_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'حَمَل',  imagePath: '${_gamesDir}match/ha/ha_match_1.png', audioPath: '${_gamesAudio}match/ha/ha_match_1.mp3'),
      WordsMatchPair(word: 'حِصَان', imagePath: '${_gamesDir}match/ha/ha_match_2.png', audioPath: '${_gamesAudio}match/ha/ha_match_2.mp3'),
      WordsMatchPair(word: 'حِمَار', imagePath: '${_gamesDir}match/ha/ha_match_3.png', audioPath: '${_gamesAudio}match/ha/ha_match_3.mp3'),
      WordsMatchPair(word: 'حُوت',  imagePath: '${_gamesDir}match/ha/ha_match_4.png', audioPath: '${_gamesAudio}match/ha/ha_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'حَال',
        bgImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/ha/ha_coloring_word_1.png',
        introAudioPath: '${_audio}ha_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ha/ha_reveal_haal.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_1_slice_1.png', color: Color(0xFF42A5F5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_1_slice_2.png', color: Color(0xFF0277BD)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_1_slice_3.png', color: Color(0xFFFFD54F)),
        ],
      ),
      ColoringRound(
        word: 'حُوت',
        bgImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/ha/ha_coloring_word_2.png',
        introAudioPath: '${_audio}ha_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ha/ha_reveal_hoot.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_2_slice_2.png', color: Color(0xFF80DEEA)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_2_slice_3.png', color: Color(0xFF90A4AE)),
        ],
      ),
      ColoringRound(
        word: 'حِيلَة',
        bgImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/ha/ha_coloring_word_3.png',
        introAudioPath: '${_audio}ha_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ha/ha_reveal_heela.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_3_slice_1.png', color: Color(0xFFFF7043)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_3_slice_2.png', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ha/ha_coloring_round_3_slice_3.png', color: Color(0xFFFFF176)),
        ],
      ),
    ],
  ),
);
