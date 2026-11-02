import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الراء (ر) — المحرك الموحّد ──────────────────────────────────
// المصدر: d:\Projects\faseeh\scratch\extracted_all\raa\audio\module_*.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/raa/';
const String _audio = 'audio/lessons/raa/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الراء — أصوات أصيلة من module_*.swf، صور placeholder
const LetterUnitManifest raaManifest = LetterUnitManifest(
  letter: 'ر',
  unitTitle: 'الْوَحْدَةُ الْعَاشِرَةُ | حَرْفُ الرَّاءِ (ر)',
  topBarColor: Color(0xFFC2185B), // وردي قرمزي داكن
  highlightColor: Color(0xFFF48FB1), // وردي فاتح
  mascotEmoji: '🦌', // ريم
  unitIndex: 10,
  nextLetter: 'ز',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}raa_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الرَّاءِ (ر)',
      'أَنْطِقُ حَرْفَ الرَّاءِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الرَّاءِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الرَّاءِ',
      'أَتَتَبَّعُ حَرْفَ الرَّاءِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الرَّاءِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الرَّاءِ',
    ],
  ),

  // ── القصة (6 مشاهد + النشيد) ──────────────────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(imagePath: '${_dir}raa_cd_story_1.png', audioPath: '${_audio}raa_story_1.mp3'),
      StoryScene(imagePath: '${_dir}raa_cd_story_2.png', audioPath: '${_audio}raa_story_2.mp3'),
      StoryScene(imagePath: '${_dir}raa_cd_story_3.png', audioPath: '${_audio}raa_story_3.mp3'),
      StoryScene(imagePath: '${_dir}raa_cd_story_4.png', audioPath: '${_audio}raa_story_4.mp3'),
      StoryScene(imagePath: '${_dir}raa_cd_story_5.png', audioPath: '${_audio}raa_story_5.mp3'),
      StoryScene(imagePath: '${_dir}raa_cd_story_6.png', audioPath: '${_audio}raa_story_6.mp3'),
      StoryScene(imagePath: '${_dir}raa_cd_story_nasheed.png', audioPath: '${_audio}raa_nasheed.mp3', isNasheed: true),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ر',
    items: [
      VowelItem(
        displayChar: 'رَ',
        fathaAudio: '${_vowelsAudio}raa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}raa_damma.mp3',
        kasraAudio: '${_vowelsAudio}raa_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ر',
    items: [
      MaddItem(displayChar: 'رَا', audioPath: '${_maddAudio}raa_madd_demo.mp3', imagePath: '${_dir}raa_madd_aa.png'),
      MaddItem(displayChar: 'رِي', audioPath: '${_maddAudio}raa_madd_demo.mp3', imagePath: '${_dir}raa_madd_ii.png'),
      MaddItem(displayChar: 'رُو', audioPath: '${_maddAudio}raa_madd_demo.mp3', imagePath: '${_dir}raa_madd_uu.png'),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ر',
    audioIntroPath: '${_audio}raa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}raa_write_step_1.png',
      '${_dir}raa_write_step_2.png',
      '${_dir}raa_write_step_3.png',
      '${_dir}raa_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف (5 صفحات × 4 كلمات) ─────────────────────────────────────
  words: WordsSpec(
    pages: [
      // صفحة 1: رَجُل، رُمَّان، رِيشَة، رَمْل
      WordsPage(
        listImagePath: '${_dir}raa_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'رَجُل',   cardImagePath: '${_dir}raa_words_p1_card_1.png', cardHeight: 380, audioPath: '${_audio}raa_word_p1_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رُمَّان',  cardImagePath: '${_dir}raa_words_p1_card_2.png', cardHeight: 380, audioPath: '${_audio}raa_word_p1_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رِيشَة',  cardImagePath: '${_dir}raa_words_p1_card_3.png', cardHeight: 380, audioPath: '${_audio}raa_word_p1_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رَمْل',   cardImagePath: '${_dir}raa_words_p1_card_4.png', cardHeight: 380, audioPath: '${_audio}raa_word_p1_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 2: رَبِيع، رَسَّام، رَكْض، رِيم
      WordsPage(
        listImagePath: '${_dir}raa_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'رَبِيع',  cardImagePath: '${_dir}raa_words_p2_card_1.png', cardHeight: 380, audioPath: '${_audio}raa_word_p2_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رَسَّام', cardImagePath: '${_dir}raa_words_p2_card_2.png', cardHeight: 380, audioPath: '${_audio}raa_word_p2_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رَكْض',   cardImagePath: '${_dir}raa_words_p2_card_3.png', cardHeight: 380, audioPath: '${_audio}raa_word_p2_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رِيم',    cardImagePath: '${_dir}raa_words_p2_card_4.png', cardHeight: 380, audioPath: '${_audio}raa_word_p2_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 3: رَفِيق، رَحْلَة، رُكُوب، رِعَايَة
      WordsPage(
        listImagePath: '${_dir}raa_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'رَفِيق',  cardImagePath: '${_dir}raa_words_p3_card_1.png', cardHeight: 380, audioPath: '${_audio}raa_word_p3_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رَحْلَة', cardImagePath: '${_dir}raa_words_p3_card_2.png', cardHeight: 380, audioPath: '${_audio}raa_word_p3_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رُكُوب',  cardImagePath: '${_dir}raa_words_p3_card_3.png', cardHeight: 380, audioPath: '${_audio}raa_word_p3_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رِعَايَة', cardImagePath: '${_dir}raa_words_p3_card_4.png', cardHeight: 380, audioPath: '${_audio}raa_word_p3_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 4: بَحْر، صَقْر، قَمَر، زَهْرَة
      WordsPage(
        listImagePath: '${_dir}raa_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'بَحْر',   cardImagePath: '${_dir}raa_words_p4_card_1.png', cardHeight: 380, audioPath: '${_audio}raa_word_p4_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'صَقْر',   cardImagePath: '${_dir}raa_words_p4_card_2.png', cardHeight: 380, audioPath: '${_audio}raa_word_p4_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'قَمَر',   cardImagePath: '${_dir}raa_words_p4_card_3.png', cardHeight: 380, audioPath: '${_audio}raa_word_p4_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'زَهْرَة', cardImagePath: '${_dir}raa_words_p4_card_4.png', cardHeight: 380, audioPath: '${_audio}raa_word_p4_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
      // صفحة 5: رَاح، رُوح، رِيح (مد) + رَبِيع
      WordsPage(
        listImagePath: '${_dir}raa_words_p5_list.png',
        listImageHeight: 503,
        words: [
          WordItem(word: 'رَاح',   cardImagePath: '${_dir}raa_words_p5_card_1.png', cardHeight: 380, audioPath: '${_audio}raa_word_p5_1.mp3', hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رُوح',   cardImagePath: '${_dir}raa_words_p5_card_2.png', cardHeight: 380, audioPath: '${_audio}raa_word_p5_2.mp3', hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رِيح',   cardImagePath: '${_dir}raa_words_p5_card_3.png', cardHeight: 380, audioPath: '${_audio}raa_word_p5_3.mp3', hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
          WordItem(word: 'رَبِيع', cardImagePath: '${_dir}raa_words_p5_card_4.png', cardHeight: 380, audioPath: '${_audio}raa_word_p5_4.mp3', hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32), speakerOffset: Offset(0.15, 0.82), closeOffset: Offset(0.85, 0.08)),
        ],
      ),
    ],
  ),

  // ── الألعاب ────────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'رُمَّان', imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/raa/raa_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بَاب',   imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/raa/raa_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'رِيشَة',  imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/raa/raa_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'كِتَاب', imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/raa/raa_fishing_4.mp3', isCorrect: false),
    ],
    beehive: [
      BeehiveRound(word: 'رَجُل',  imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/raa/raa_beehive_1.mp3'),
      BeehiveRound(word: 'رُمَّان', imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/raa/raa_beehive_2.mp3'),
      BeehiveRound(word: 'رِيشَة', imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/raa/raa_beehive_3.mp3'),
      BeehiveRound(word: 'بَحْر',  imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/raa/raa_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'رُمَّان', imagePath: '${_gamesDir}circus/raa/raa_circus_round_1.png', audioPath: '${_gamesAudio}circus/raa/raa_circus_1.mp3'),
      CircusRound(word: 'رِيم',   imagePath: '${_gamesDir}circus/raa/raa_circus_round_2.png', audioPath: '${_gamesAudio}circus/raa/raa_circus_2.mp3'),
      CircusRound(word: 'رَجُل',  imagePath: '${_gamesDir}circus/raa/raa_circus_round_3.png', audioPath: '${_gamesAudio}circus/raa/raa_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'رِيم',   imagePath: '${_gamesDir}match/raa/raa_match_1.png', audioPath: '${_gamesAudio}match/raa/raa_match_1.mp3'),
      WordsMatchPair(word: 'رُمَّان', imagePath: '${_gamesDir}match/raa/raa_match_2.png', audioPath: '${_gamesAudio}match/raa/raa_match_2.mp3'),
      WordsMatchPair(word: 'رَجُل',  imagePath: '${_gamesDir}match/raa/raa_match_3.png', audioPath: '${_gamesAudio}match/raa/raa_match_3.mp3'),
      WordsMatchPair(word: 'بَحْر',  imagePath: '${_gamesDir}match/raa/raa_match_4.png', audioPath: '${_gamesAudio}match/raa/raa_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'رَاح',
        bgImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/raa/raa_coloring_word_1.png',
        introAudioPath: '${_audio}raa_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_raah.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1_slice_1.png', color: Color(0xFFC2185B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1_slice_2.png', color: Color(0xFFE91E63)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1_slice_3.png', color: Color(0xFFF48FB1)),
        ],
      ),
      ColoringRound(
        word: 'رُوح',
        bgImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/raa/raa_coloring_word_2.png',
        introAudioPath: '${_audio}raa_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_rooh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2_slice_1.png', color: Color(0xFF880E4F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2_slice_2.png', color: Color(0xFFAD1457)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2_slice_3.png', color: Color(0xFFF06292)),
        ],
      ),
      ColoringRound(
        word: 'رِيح',
        bgImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/raa/raa_coloring_word_3.png',
        introAudioPath: '${_audio}raa_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_reeh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3_slice_1.png', color: Color(0xFFD81B60)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3_slice_2.png', color: Color(0xFFEC407A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3_slice_3.png', color: Color(0xFFF8BBD0)),
        ],
      ),
    ],
  ),
);
