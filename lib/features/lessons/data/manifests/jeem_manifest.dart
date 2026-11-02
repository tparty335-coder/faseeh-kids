import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الجيم (ج) — المحرك الموحّد ─────────────────────────────────
// المصدر: d:\Projects\faseeh\scratch\extracted_all\jeem\
// نمط الصوت: ahdaf_a*.swf (نمط ألف / جيم بالإحداثيات الدلالية)
// ────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/jeem/';
const String _audio = 'audio/lessons/jeem/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الجيم — أصوات حقيقية من الأسطوانة، صور placeholder
const LetterUnitManifest jeemManifest = LetterUnitManifest(
  letter: 'ج',
  unitTitle: 'الْوَحْدَةُ الْخَامِسَةُ | حَرْفُ الْجِيمِ (ج)',
  topBarColor: Color(0xFF00695C), // أخضر زمردي
  highlightColor: Color(0xFFB2DFDB), // أخضر فاتح
  mascotEmoji: '🐫', // جمل — كلمة تبدأ بالجيم
  unitIndex: 5,
  nextLetter: 'ح',

  // ── الأهداف ──────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}jeem_goal.mp3', // ✅ أصلي من الأسطوانة
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الْجِيمِ (ج)',
      'أَنْطِقُ حَرْفَ الْجِيمِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الْجِيمِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الْجِيمِ',
      'أَتَتَبَّعُ حَرْفَ الْجِيمِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الْجِيمِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الْجِيمِ',
    ],
  ),

  // ── القصة (6 مشاهد + النشيد) ─────────────────────────────────────────────
  // الصوت من: module_1..7.swf/1.mp3 → jeem_story_1..6.mp3
  // النشيد من: ahdaf_a1.swf/22_bg_sound.mp3 → jeem_nasheed.mp3
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_1.png',
        audioPath: '${_audio}jeem_story_1.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_2.png',
        audioPath: '${_audio}jeem_story_2.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_3.png',
        audioPath: '${_audio}jeem_story_3.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_4.png',
        audioPath: '${_audio}jeem_story_4.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_5.png',
        audioPath: '${_audio}jeem_story_5.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_6.png',
        audioPath: '${_audio}jeem_story_6.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_nasheed.png',
        audioPath: '${_audio}jeem_nasheed.mp3', // ✅ أصلي — ahdaf_a1.swf/22_bg_sound.mp3
        isNasheed: true,
      ),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ج',
    items: [
      VowelItem(
        displayChar: 'جَ',
        fathaAudio: '${_vowelsAudio}jeem_fatha.mp3',
        dammaAudio: '${_vowelsAudio}jeem_damma.mp3',
        kasraAudio: '${_vowelsAudio}jeem_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ─────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ج',
    items: [
      MaddItem(
        displayChar: 'جَا',
        audioPath: '${_maddAudio}jeem_madd_demo.mp3',
        imagePath: '${_dir}jeem_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'جِي',
        audioPath: '${_maddAudio}jeem_madd_demo.mp3',
        imagePath: '${_dir}jeem_madd_ii.png',
      ),
      MaddItem(
        displayChar: 'جُو',
        audioPath: '${_maddAudio}jeem_madd_demo.mp3',
        imagePath: '${_dir}jeem_madd_uu.png',
      ),
    ],
  ),

  // ── الكتابة ───────────────────────────────────────────────────────────────
  // الصوت من: ahdaf_a.swf/203.mp3 → jeem_write_intro.mp3
  tracing: TracingSpec(
    letterChar: 'ج',
    audioIntroPath: '${_audio}jeem_write_intro.mp3', // ✅ أصلي
    stepImagePaths: [
      '${_dir}jeem_write_step_1.png',
      '${_dir}jeem_write_step_2.png',
      '${_dir}jeem_write_step_3.png',
      '${_dir}jeem_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف (5 صفحات × 4 كلمات) ────────────────────────────────────
  // الصوت من: ahdaf_a4.swf/1_one4r.mp3..20_one4b.mp3 (positional)
  words: WordsSpec(
    pages: [
      // صفحة 1: جَمَل، جَبَل، جَزَرَة، جَرَس
      WordsPage(
        listImagePath: '${_dir}jeem_words_p1_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'جَمَل',
            cardImagePath: '${_dir}jeem_words_p1_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p1_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَبَل',
            cardImagePath: '${_dir}jeem_words_p1_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p1_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَزَرَة',
            cardImagePath: '${_dir}jeem_words_p1_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p1_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَرَس',
            cardImagePath: '${_dir}jeem_words_p1_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p1_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      // صفحة 2: جَوَال، جَاكِيت، جَدِيد، جَمِيل
      WordsPage(
        listImagePath: '${_dir}jeem_words_p2_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'جَوَال',
            cardImagePath: '${_dir}jeem_words_p2_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p2_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَاكِيت',
            cardImagePath: '${_dir}jeem_words_p2_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p2_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَدِيد',
            cardImagePath: '${_dir}jeem_words_p2_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p2_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَمِيل',
            cardImagePath: '${_dir}jeem_words_p2_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p2_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      // صفحة 3: جِدَار، جِرَاب، جِسْر، جِلْد
      WordsPage(
        listImagePath: '${_dir}jeem_words_p3_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'جِدَار',
            cardImagePath: '${_dir}jeem_words_p3_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p3_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جِرَاب',
            cardImagePath: '${_dir}jeem_words_p3_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p3_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جِسْر',
            cardImagePath: '${_dir}jeem_words_p3_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p3_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جِلْد',
            cardImagePath: '${_dir}jeem_words_p3_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p3_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      // صفحة 4: جُنَيْنَة، جُمْلَة، جُوَال، جُنْدِي
      WordsPage(
        listImagePath: '${_dir}jeem_words_p4_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'جُنَيْنَة',
            cardImagePath: '${_dir}jeem_words_p4_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p4_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جُمْلَة',
            cardImagePath: '${_dir}jeem_words_p4_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p4_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جُوَال',
            cardImagePath: '${_dir}jeem_words_p4_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p4_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جُنْدِي',
            cardImagePath: '${_dir}jeem_words_p4_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p4_4.mp3',
            hotspot: WordHotspot(left: 0.52, top: 0.08, right: 0.97, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
        ],
      ),
      // صفحة 5: جَاج، جَنَاح، جَانِب، جَابِر
      WordsPage(
        listImagePath: '${_dir}jeem_words_p5_list.png',
        listImageHeight: 503,
        words: [
          WordItem(
            word: 'جَاج',
            cardImagePath: '${_dir}jeem_words_p5_card_1.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p5_1.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.08, right: 0.50, bottom: 0.32),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَنَاح',
            cardImagePath: '${_dir}jeem_words_p5_card_2.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p5_2.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.33, right: 0.50, bottom: 0.57),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَانِب',
            cardImagePath: '${_dir}jeem_words_p5_card_3.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p5_3.mp3',
            hotspot: WordHotspot(left: 0.04, top: 0.58, right: 0.50, bottom: 0.80),
            speakerOffset: Offset(0.15, 0.82),
            closeOffset: Offset(0.85, 0.08),
          ),
          WordItem(
            word: 'جَابِر',
            cardImagePath: '${_dir}jeem_words_p5_card_4.png',
            cardHeight: 380,
            audioPath: '${_audio}jeem_word_p5_4.mp3',
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
    // لعبة صيد الكلمات — ahdaf_a5_fish.swf
    fishing: [
      FishingRound(word: 'جَمَل', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/jeem/jeem_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بَاب', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/jeem/jeem_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'جَبَل', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/jeem/jeem_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'أَسَد', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/jeem/jeem_fishing_4.mp3', isCorrect: false),
    ],
    // لعبة خلية النحل — ahdaf_a5_bee.swf
    // jeem_bee_wrong.mp3 ✅ أصلي من ahdaf_a5_bee.swf
    beehive: [
      BeehiveRound(word: 'جَمَل', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_1.mp3'),
      BeehiveRound(word: 'جَبَل', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_2.mp3'),
      BeehiveRound(word: 'جَزَرَة', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_3.mp3'),
      BeehiveRound(word: 'جَرَس', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_4.mp3'),
    ],
    // لعبة السيرك — ahdaf_a5_cir.swf
    circus: [
      CircusRound(word: 'جَمَل', imagePath: '${_gamesDir}circus/jeem/jeem_circus_round_1.png', audioPath: '${_gamesAudio}circus/jeem/jeem_circus_1.mp3'),
      CircusRound(word: 'جَبَل', imagePath: '${_gamesDir}circus/jeem/jeem_circus_round_2.png', audioPath: '${_gamesAudio}circus/jeem/jeem_circus_2.mp3'),
      CircusRound(word: 'جَزَرَة', imagePath: '${_gamesDir}circus/jeem/jeem_circus_round_3.png', audioPath: '${_gamesAudio}circus/jeem/jeem_circus_3.mp3'),
    ],
    // لعبة مطابقة الكلمات — ahdaf_a5_words.swf
    wordsMatch: [
      WordsMatchPair(word: 'جَمَل', imagePath: '${_gamesDir}match/jeem/jeem_match_1.png', audioPath: '${_gamesAudio}match/jeem/jeem_match_1.mp3'),
      WordsMatchPair(word: 'جَبَل', imagePath: '${_gamesDir}match/jeem/jeem_match_2.png', audioPath: '${_gamesAudio}match/jeem/jeem_match_2.mp3'),
      WordsMatchPair(word: 'جَزَرَة', imagePath: '${_gamesDir}match/jeem/jeem_match_3.png', audioPath: '${_gamesAudio}match/jeem/jeem_match_3.mp3'),
      WordsMatchPair(word: 'جَرَس', imagePath: '${_gamesDir}match/jeem/jeem_match_4.png', audioPath: '${_gamesAudio}match/jeem/jeem_match_4.mp3'),
    ],
    // لعبة التلوين — ahdaf_a5_paint.swf
    // paint_word1/2/3.mp3 ✅ أصلي
    coloring: [
      ColoringRound(
        word: 'جَمَل',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_1.png',
        introAudioPath: '${_audio}jeem_paint_word1.mp3', // ✅ أصلي
        revealAudioPath: '${_gamesAudio}coloring/jeem/jeem_reveal_jamal.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_1_slice_1.png', color: Color(0xFFC8A96E)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_1_slice_2.png', color: Color(0xFF8D6E63)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_1_slice_3.png', color: Color(0xFFFFD54F)),
        ],
      ),
      ColoringRound(
        word: 'جَبَل',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_2.png',
        introAudioPath: '${_audio}jeem_paint_word2.mp3', // ✅ أصلي
        revealAudioPath: '${_gamesAudio}coloring/jeem/jeem_reveal_jabal.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_2_slice_1.png', color: Color(0xFF78909C)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_2_slice_2.png', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_2_slice_3.png', color: Color(0xFF90A4AE)),
        ],
      ),
      ColoringRound(
        word: 'جَزَرَة',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_3.png',
        introAudioPath: '${_audio}jeem_paint_word3.mp3', // ✅ أصلي
        revealAudioPath: '${_gamesAudio}coloring/jeem/jeem_reveal_jazara.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_3_slice_1.png', color: Color(0xFFFF7043)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_3_slice_2.png', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_round_3_slice_3.png', color: Color(0xFFFFF176)),
        ],
      ),
    ],
  ),
);
