import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الذال (ذ) — المحرك الموحّد ──────────────────────────────────
// المصدر: d:\Projects\faseeh\scratch\extracted_all\dhaal\audio\module_*.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/dhaal/';
const String _audio = 'audio/lessons/dhaal/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الذال — أصوات أصيلة من module_*.swf، صور placeholder
const LetterUnitManifest dhaalManifest = LetterUnitManifest(
  letter: 'ذ',
  unitTitle: 'الْوَحْدَةُ التَّاسِعَةُ | حَرْفُ الذَّالِ (ذ)',
  topBarColor: Color(0xFFE65100), // عنبري ذهبي داكن
  highlightColor: Color(0xFFFFB74D), // عنبري فاتح
  mascotEmoji: '🐺', // ذئب
  unitIndex: 9,
  nextLetter: 'ر',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}dhaal_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الذَّالِ (ذ)',
      'أَنْطِقُ حَرْفَ الذَّالِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الذَّالِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الذَّالِ',
      'أَتَتَبَّعُ حَرْفَ الذَّالِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الذَّالِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الذَّالِ',
    ],
  ),

  // ── القصة (6 مشاهد + النشيد) ──────────────────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(imagePath: '${_dir}dhaal_cd_story_1.png', audioPath: '${_audio}dhaal_story_1.mp3'),
      StoryScene(imagePath: '${_dir}dhaal_cd_story_2.png', audioPath: '${_audio}dhaal_story_2.mp3'),
      StoryScene(imagePath: '${_dir}dhaal_cd_story_3.png', audioPath: '${_audio}dhaal_story_3.mp3'),
      StoryScene(imagePath: '${_dir}dhaal_cd_story_4.png', audioPath: '${_audio}dhaal_story_4.mp3'),
      StoryScene(imagePath: '${_dir}dhaal_cd_story_5.png', audioPath: '${_audio}dhaal_story_5.mp3'),
      StoryScene(imagePath: '${_dir}dhaal_cd_story_6.png', audioPath: '${_audio}dhaal_story_6.mp3'),
      StoryScene(imagePath: '${_dir}dhaal_cd_story_nasheed.png', audioPath: '${_audio}dhaal_nasheed.mp3', isNasheed: true),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ذ',
    items: [
      VowelItem(
        displayChar: 'ذَ',
        fathaAudio: '${_vowelsAudio}dhaal_fatha.mp3',
        dammaAudio: '${_vowelsAudio}dhaal_damma.mp3',
        kasraAudio: '${_vowelsAudio}dhaal_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ذ',
    items: [
      MaddItem(displayChar: 'ذَا', audioPath: '${_maddAudio}dhaal_madd_demo.mp3', imagePath: '${_dir}dhaal_madd_aa.png'),
      MaddItem(displayChar: 'ذِي', audioPath: '${_maddAudio}dhaal_madd_demo.mp3', imagePath: '${_dir}dhaal_madd_ii.png'),
      MaddItem(displayChar: 'ذُو', audioPath: '${_maddAudio}dhaal_madd_demo.mp3', imagePath: '${_dir}dhaal_madd_uu.png'),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ذ',
    audioIntroPath: '${_audio}dhaal_write_intro.mp3',
    stepImagePaths: [
      '${_dir}dhaal_write_step_1.png',
      '${_dir}dhaal_write_step_2.png',
      '${_dir}dhaal_write_step_3.png',
      '${_dir}dhaal_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف (5 صفحات × 4 كلمات) ─────────────────────────────────────
  words: WordsSpec(
    pages: [
      // صفحة 1: ذِئْب، ذُرَة، ذَهَب، ذَيْل
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'ذِئْب',  cardImagePath: '${_dir}dhaal_words_p1_card_1.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p1_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذُرَة',  cardImagePath: '${_dir}dhaal_words_p1_card_2.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p1_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذَهَب',  cardImagePath: '${_dir}dhaal_words_p1_card_3.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p1_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذَيْل',  cardImagePath: '${_dir}dhaal_words_p1_card_4.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p1_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 2: ذِرَاع، ذُبَابَة، ذِكْر، ذَكِيّ
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'ذِرَاع',  cardImagePath: '${_dir}dhaal_words_p2_card_1.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p2_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذُبَابَة', cardImagePath: '${_dir}dhaal_words_p2_card_2.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p2_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذِكْر',   cardImagePath: '${_dir}dhaal_words_p2_card_3.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p2_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذَكِيّ',   cardImagePath: '${_dir}dhaal_words_p2_card_4.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p2_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 3: ذُوق، ذُرْوَة، ذُبُول، ذُعَاف
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'ذُوق',   cardImagePath: '${_dir}dhaal_words_p3_card_1.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p3_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذُرْوَة', cardImagePath: '${_dir}dhaal_words_p3_card_2.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p3_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذُبُول',  cardImagePath: '${_dir}dhaal_words_p3_card_3.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p3_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذُعَاف', cardImagePath: '${_dir}dhaal_words_p3_card_4.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p3_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 4: قُنْفُذ، جَذْر، بَذْرَة، أُسْتَاذ
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'قُنْفُذ', cardImagePath: '${_dir}dhaal_words_p4_card_1.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p4_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'جَذْر',   cardImagePath: '${_dir}dhaal_words_p4_card_2.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p4_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'بَذْرَة', cardImagePath: '${_dir}dhaal_words_p4_card_3.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p4_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'أُسْتَاذ', cardImagePath: '${_dir}dhaal_words_p4_card_4.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p4_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 5: ذَاب، ذُوق، مَذِيع (مد) + ذَهَب
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p5_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'ذَاب',   cardImagePath: '${_dir}dhaal_words_p5_card_1.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p5_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذُوق',   cardImagePath: '${_dir}dhaal_words_p5_card_2.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p5_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'مَذِيع', cardImagePath: '${_dir}dhaal_words_p5_card_3.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p5_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'ذَهَب',  cardImagePath: '${_dir}dhaal_words_p5_card_4.png', cardHeight: 380, audioPath: '${_audio}dhaal_word_p5_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
    ],
  ),

  // ── الألعاب ────────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'ذِئْب',  imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'كِتَاب', imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'ذَهَب',  imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'قَلَم',  imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_4.mp3', isCorrect: false),
    ],
    beehive: [
      BeehiveRound(word: 'ذَهَب',  imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_1.mp3'),
      BeehiveRound(word: 'ذِئْب',  imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_2.mp3'),
      BeehiveRound(word: 'ذُرَة',  imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_3.mp3'),
      BeehiveRound(word: 'جَذْر',  imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'ذِئْب',  imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_1.png', audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_1.mp3'),
      CircusRound(word: 'ذُرَة',  imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_2.png', audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_2.mp3'),
      CircusRound(word: 'ذَهَب',  imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_3.png', audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'ذِئْب',  imagePath: '${_gamesDir}match/dhaal/dhaal_match_1.png', audioPath: '${_gamesAudio}match/dhaal/dhaal_match_1.mp3'),
      WordsMatchPair(word: 'ذُرَة',  imagePath: '${_gamesDir}match/dhaal/dhaal_match_2.png', audioPath: '${_gamesAudio}match/dhaal/dhaal_match_2.mp3'),
      WordsMatchPair(word: 'ذَهَب',  imagePath: '${_gamesDir}match/dhaal/dhaal_match_3.png', audioPath: '${_gamesAudio}match/dhaal/dhaal_match_3.mp3'),
      WordsMatchPair(word: 'قُنْفُذ', imagePath: '${_gamesDir}match/dhaal/dhaal_match_4.png', audioPath: '${_gamesAudio}match/dhaal/dhaal_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'ذَاب',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_word_1.png',
        introAudioPath: '${_audio}dhaal_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaal/dhaal_reveal_thaab.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_1.png', color: Color(0xFFE65100)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_2.png', color: Color(0xFFFF8F00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_3.png', color: Color(0xFFFFD54F)),
        ],
      ),
      ColoringRound(
        word: 'ذُوق',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_word_2.png',
        introAudioPath: '${_audio}dhaal_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaal/dhaal_reveal_thooq.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_1.png', color: Color(0xFFF57C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_2.png', color: Color(0xFFFFB74D)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_3.png', color: Color(0xFF90A4AE)),
        ],
      ),
      ColoringRound(
        word: 'مَذِيع',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_word_3.png',
        introAudioPath: '${_audio}dhaal_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaal/dhaal_reveal_matheea.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_1.png', color: Color(0xFFFF7043)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_2.png', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_3.png', color: Color(0xFFFFF176)),
        ],
      ),
    ],
  ),
);
