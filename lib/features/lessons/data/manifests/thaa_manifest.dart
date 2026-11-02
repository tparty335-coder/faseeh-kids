import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الثاء (ث) — Pilot 2 على المحرك الموحّد ────────────────────
// الصوت: حقيقي من الأسطوانة (thaa/final/)   |   الصور: placeholder حتى الاستخراج
// ────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/thaa/';
const String _audio = 'audio/lessons/thaa/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest thaaManifest = LetterUnitManifest(
  letter: 'ث',
  unitTitle: 'الْوَحْدَةُ الرَّابِعَةُ | حَرْفُ الثَّاءِ (ث)',
  topBarColor: Color(0xFF6A1B9A), // بنفسجي غامق — لون الثاء في الأسطوانة
  highlightColor: Color(0xFFF3E5F5), // بنفسجي فاتح جداً
  mascotEmoji: '🦁', // ثعلب — كلمة تبدأ بالثاء (placeholder ← استبدل بثعلب)
  unitIndex: 4,
  nextLetter: 'ج',

  // ── الأهداف ──────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}thaa_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الثَّاءِ (ث)',
      'أَنْطِقُ حَرْفَ الثَّاءِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الثَّاءِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الثَّاءِ',
      'أَتَتَبَّعُ حَرْفَ الثَّاءِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الثَّاءِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الثَّاءِ',
    ],
  ),

  // ── القصة ────────────────────────────────────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_1.png',
        audioPath: '${_audio}thaa_story_1.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_2.png',
        audioPath: '${_audio}thaa_story_2.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_3.png',
        audioPath: '${_audio}thaa_story_3.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_4.png',
        audioPath: '${_audio}thaa_story_4.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_5.png',
        audioPath: '${_audio}thaa_story_5.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_6.png',
        audioPath: '${_audio}thaa_story_6.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_nasheed.png',
        audioPath: '${_audio}thaa_nasheed.mp3',
        isNasheed: true,
      ),
    ],
  ),

  // ── الأصوات ──────────────────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ث',
    items: [
      VowelItem(
        displayChar: 'ثَ',
        fathaAudio: '${_vowelsAudio}thaa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}thaa_damma.mp3',
        kasraAudio: '${_vowelsAudio}thaa_kasra.mp3',
      ),
    ],
  ),

  // ── المدود ───────────────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ث',
    items: [
      MaddItem(
        displayChar: 'ثَا',
        audioPath: '${_maddAudio}thaa_madd_demo.mp3',
        imagePath: '${_dir}thaa_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'ثِي',
        audioPath: '${_maddAudio}thaa_madd_demo.mp3',
        imagePath: '${_dir}thaa_madd_ii.png',
      ),
      MaddItem(
        displayChar: 'ثُو',
        audioPath: '${_maddAudio}thaa_madd_demo.mp3',
        imagePath: '${_dir}thaa_madd_uu.png',
      ),
    ],
  ),

  // ── الكتابة ───────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ث',
    audioIntroPath: '${_audio}thaa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}thaa_write_step_1.png',
      '${_dir}thaa_write_step_2.png',
      '${_dir}thaa_write_step_3.png',
      '${_dir}thaa_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف — 5 صفحات × 4 كلمات ─────────────────────────────────────
  // كلمات الثاء: ثَعْلَب، ثَوْر، ثَلَاثَة، ثَلْج، ثِيَاب، ثُعْبَان، ثَمَر، ثُرَيَّا
  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}thaa_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'ثَعْلَب',
            cardImagePath: '${_dir}thaa_words_p1_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p1_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَوْر',
            cardImagePath: '${_dir}thaa_words_p1_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p1_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَلَاثَة',
            cardImagePath: '${_dir}thaa_words_p1_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p1_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَلْج',
            cardImagePath: '${_dir}thaa_words_p1_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p1_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}thaa_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'ثِيَاب',
            cardImagePath: '${_dir}thaa_words_p2_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p2_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثُعْبَان',
            cardImagePath: '${_dir}thaa_words_p2_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p2_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَمَر',
            cardImagePath: '${_dir}thaa_words_p2_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p2_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثُرَيَّا',
            cardImagePath: '${_dir}thaa_words_p2_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p2_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}thaa_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'ثَمِين',
            cardImagePath: '${_dir}thaa_words_p3_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p3_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَانِي',
            cardImagePath: '${_dir}thaa_words_p3_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p3_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثِقَة',
            cardImagePath: '${_dir}thaa_words_p3_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p3_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثُقُوب',
            cardImagePath: '${_dir}thaa_words_p3_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p3_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}thaa_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'ثِقِيل',
            cardImagePath: '${_dir}thaa_words_p4_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p4_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَرْوَة',
            cardImagePath: '${_dir}thaa_words_p4_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p4_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَمَانِيَة',
            cardImagePath: '${_dir}thaa_words_p4_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p4_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَعْلَبَة',
            cardImagePath: '${_dir}thaa_words_p4_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p4_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}thaa_words_p5_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'ثَمَرَة',
            cardImagePath: '${_dir}thaa_words_p5_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p5_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثُلُوج',
            cardImagePath: '${_dir}thaa_words_p5_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p5_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثِيرَان',
            cardImagePath: '${_dir}thaa_words_p5_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p5_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'ثَنَايَا',
            cardImagePath: '${_dir}thaa_words_p5_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}thaa_word_p5_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
    ],
  ),

  // ── الألعاب ───────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'ثَعْلَب', imagePath: '${_gamesDir}fishing/thaa/thaa_fishing_1.png', audioPath: '${_gamesAudio}fishing/thaa/thaa_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بَاب', imagePath: '${_gamesDir}fishing/thaa/thaa_fishing_2.png', audioPath: '${_gamesAudio}fishing/thaa/thaa_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'ثَوْر', imagePath: '${_gamesDir}fishing/thaa/thaa_fishing_3.png', audioPath: '${_gamesAudio}fishing/thaa/thaa_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'أَسَد', imagePath: '${_gamesDir}fishing/thaa/thaa_fishing_4.png', audioPath: '${_gamesAudio}fishing/thaa/thaa_fishing_4.mp3', isCorrect: false),
    ],
    beehive: [
      BeehiveRound(word: 'ثَعْلَب', imagePath: '${_gamesDir}beehive/thaa/thaa_beehive_1.png', audioPath: '${_gamesAudio}beehive/thaa/thaa_beehive_1.mp3'),
      BeehiveRound(word: 'ثَلْج', imagePath: '${_gamesDir}beehive/thaa/thaa_beehive_2.png', audioPath: '${_gamesAudio}beehive/thaa/thaa_beehive_2.mp3'),
      BeehiveRound(word: 'ثَوْر', imagePath: '${_gamesDir}beehive/thaa/thaa_beehive_3.png', audioPath: '${_gamesAudio}beehive/thaa/thaa_beehive_3.mp3'),
    ],
    circus: [
      CircusRound(word: 'ثَعْلَب', imagePath: '${_gamesDir}circus/thaa/thaa_circus_1.png', audioPath: '${_gamesAudio}circus/thaa/thaa_circus_1.mp3'),
      CircusRound(word: 'ثَلَاثَة', imagePath: '${_gamesDir}circus/thaa/thaa_circus_2.png', audioPath: '${_gamesAudio}circus/thaa/thaa_circus_2.mp3'),
      CircusRound(word: 'ثَوْر', imagePath: '${_gamesDir}circus/thaa/thaa_circus_3.png', audioPath: '${_gamesAudio}circus/thaa/thaa_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'ثَعْلَب', imagePath: '${_gamesDir}match/thaa/thaa_match_1.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_1.mp3'),
      WordsMatchPair(word: 'ثَوْر', imagePath: '${_gamesDir}match/thaa/thaa_match_2.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_2.mp3'),
      WordsMatchPair(word: 'ثَلْج', imagePath: '${_gamesDir}match/thaa/thaa_match_3.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_3.mp3'),
      WordsMatchPair(word: 'ثَلَاثَة', imagePath: '${_gamesDir}match/thaa/thaa_match_4.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'ثَعْلَب',
        bgImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_word_1.png',
        introAudioPath: '${_gamesAudio}coloring/thaa/thaa_intro_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/thaa/thaa_reveal_1.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1_s1.png', color: Color(0xFFE53935)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1_s2.png', color: Color(0xFFFF8F00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1_s3.png', color: Color(0xFF795548)),
        ],
      ),
    ],
  ),
);
