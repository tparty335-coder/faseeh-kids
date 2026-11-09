import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الدال (د) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_د.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ka1..ka4.swf, sto1..sto3.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/dal/';
const String _audio = 'audio/lessons/dal/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الدال — أصول وأصوات أصلية 100% من أسطوانة الوزارة
const LetterUnitManifest dalManifest = LetterUnitManifest(
  letter: 'د',
  unitTitle: 'الْوَحْدَةُ الثَّامِنَةُ | حَرْفُ الدَّالِ (د)',
  topBarColor: Color(0xFF00695C), // تيل داكن
  highlightColor: Color(0xFF80CBC4), // تيل فاتح
  mascotEmoji: '🐻', // دب
  unitIndex: 8,
  nextLetter: 'ذ',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}dal_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الدَّالِ (د)',
      'أَنْطِقُ حَرْفَ الدَّالِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الدَّالِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الدَّالِ',
      'أَتَتَبَّعُ حَرْفَ الدَّالِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الدَّالِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الدَّالِ',
    ],
  ),

  // ── القصة (5 مشاهد + النشيد = 6 مشاهد أصلية) ───────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}dal_cd_story_1.png',
        audioPath: '${_audio}dal_story_1.mp3',
      ), // استيقظت دلال على صوت الديك وهو يصيح .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_2.png',
        audioPath: '${_audio}dal_story_2.mp3',
      ), // صياح الديك يوقظ دلال
      StoryScene(
        imagePath: '${_dir}dal_cd_story_3.png',
        audioPath: '${_audio}dal_story_3.mp3',
      ), // فخرجت إلى الشرفة وسمعت صوت آذان الفجر .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_4.png',
        audioPath: '${_audio}dal_story_4.mp3',
      ), // والناس يدخلون المسجد يصلون الفجر .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_5.png',
        audioPath: '${_audio}dal_story_5.mp3',
      ), // أحبت دلال الديك وكانت تسميه مؤذن الفجر .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_nasheed.png',
        audioPath: '${_audio}dal_nasheed.mp3',
        isNasheed: true,
      ), // دال ديك فوق الدار ... يؤذن فجراً يوقظ جاره
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'د',
    items: [
      VowelItem(
        displayChar: 'دَ',
        fathaAudio: '${_vowelsAudio}daal_fatha.mp3',
        dammaAudio: '${_vowelsAudio}daal_damma.mp3',
        kasraAudio: '${_vowelsAudio}daal_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'د',
    items: [
      MaddItem(
        displayChar: 'دَا',
        audioPath: '${_maddAudio}daal_madd_demo.mp3',
        imagePath: '${_dir}dal_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'دُو',
        audioPath: '${_maddAudio}daal_madd_demo.mp3',
        imagePath: '${_dir}dal_madd_uu.png',
      ),
      MaddItem(
        displayChar: 'دِي',
        audioPath: '${_maddAudio}daal_madd_demo.mp3',
        imagePath: '${_dir}dal_madd_ii.png',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'د',
    audioIntroPath: '${_audio}dal_write_intro.mp3',
    stepImagePaths: [
      '${_dir}dal_write_step_1.png',
      '${_dir}dal_write_step_2.png',
      '${_dir}dal_write_step_3.png',
      '${_dir}dal_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية من ka1..ka4.swf) ────
  // الإحداثيات نسبية (0.0..1.0) — الصور 800×474 بكسل مطابقة للأسطوانة
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka1.swf): دَلَال (أحمر)، دِيك (برتقالي)، مَسْجِد (أخضر)، دَالْيَا (أزرق)
      WordsPage(
        listImagePath: '${_dir}dal_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'دَلَالُ',
            cardImagePath: '${_dir}dal_words_p1_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p1_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دِيكٌ',
            cardImagePath: '${_dir}dal_words_p1_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p1_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مَسْجِدٌ',
            cardImagePath: '${_dir}dal_words_p1_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p1_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَالْيَا',
            cardImagePath: '${_dir}dal_words_p1_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p1_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 2 (ka2.swf): صُنْدُوق (أحمر)، حَدِيقَة (برتقالي)، دُشّ (أخضر)، دِمَاغ (أزرق)
      WordsPage(
        listImagePath: '${_dir}dal_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'صُنْدُوق',
            cardImagePath: '${_dir}dal_words_p2_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p2_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'حَدِيقَة',
            cardImagePath: '${_dir}dal_words_p2_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p2_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دُشّ',
            cardImagePath: '${_dir}dal_words_p2_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p2_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دِمَاغ',
            cardImagePath: '${_dir}dal_words_p2_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p2_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 3 (ka3.swf): دُبّ (أحمر)، دَجَاجَة (برتقالي)، دَرَاجَة (أخضر)، هُدْهُد (أزرق)
      WordsPage(
        listImagePath: '${_dir}dal_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'دُبّ',
            cardImagePath: '${_dir}dal_words_p3_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p3_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَجَاجَة',
            cardImagePath: '${_dir}dal_words_p3_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p3_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَرَاجَة',
            cardImagePath: '${_dir}dal_words_p3_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p3_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'هُدْهُد',
            cardImagePath: '${_dir}dal_words_p3_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p3_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 4 (ka4.swf): أَسَد (أحمر)، دَبَّابَة (برتقالي)، دَوَاء (أخضر)، مُهَنْدِس (أزرق)
      WordsPage(
        listImagePath: '${_dir}dal_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'أَسَدُ',
            cardImagePath: '${_dir}dal_words_p4_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p4_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَبَّابَة',
            cardImagePath: '${_dir}dal_words_p4_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p4_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَوَاء',
            cardImagePath: '${_dir}dal_words_p4_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p4_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مُهَنْدِس',
            cardImagePath: '${_dir}dal_words_p4_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dal_word_p4_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
    ],
  ),

  // ── الألعاب ────────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(
        word: 'دُبّ',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_1.mp3',
        isCorrect: true,
      ),
      FishingRound(
        word: 'كِتَاب',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_2.mp3',
        isCorrect: false,
      ),
      FishingRound(
        word: 'دِيك',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_3.mp3',
        isCorrect: true,
      ),
      FishingRound(
        word: 'قَلَم',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_4.mp3',
        isCorrect: false,
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'دَالْيَا',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/dal/dal_beehive_1.mp3',
      ),
      BeehiveRound(
        word: 'دِيك',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/dal/dal_beehive_2.mp3',
      ),
      BeehiveRound(
        word: 'دُبّ',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/dal/dal_beehive_3.mp3',
      ),
      BeehiveRound(
        word: 'أَسَد',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/dal/dal_beehive_4.mp3',
      ),
    ],
    circus: [
      CircusRound(
        word: 'دُبّ',
        imagePath: '${_gamesDir}circus/dal/dal_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/dal/dal_circus_1.mp3',
      ),
      CircusRound(
        word: 'دِيك',
        imagePath: '${_gamesDir}circus/dal/dal_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/dal/dal_circus_2.mp3',
      ),
      CircusRound(
        word: 'دَرَاجَة',
        imagePath: '${_gamesDir}circus/dal/dal_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/dal/dal_circus_3.mp3',
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'دُبّ',
        imagePath: '${_gamesDir}match/dal/dal_match_1.png',
        audioPath: '${_gamesAudio}match/dal/dal_match_1.mp3',
      ),
      WordsMatchPair(
        word: 'دِيك',
        imagePath: '${_gamesDir}match/dal/dal_match_2.png',
        audioPath: '${_gamesAudio}match/dal/dal_match_2.mp3',
      ),
      WordsMatchPair(
        word: 'دَجَاجَة',
        imagePath: '${_gamesDir}match/dal/dal_match_3.png',
        audioPath: '${_gamesAudio}match/dal/dal_match_3.mp3',
      ),
      WordsMatchPair(
        word: 'أَسَد',
        imagePath: '${_gamesDir}match/dal/dal_match_4.png',
        audioPath: '${_gamesAudio}match/dal/dal_match_4.mp3',
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'دَالْيَا',
        bgImagePath: '${_gamesDir}coloring/dal/dal_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/dal/dal_coloring_word_1.png',
        introAudioPath: '${_audio}dal_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dal/dal_reveal_daar.mp3',
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_1_slice_1.png',
            color: Color(0xFF00897B),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_1_slice_2.png',
            color: Color(0xFF004D40),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_1_slice_3.png',
            color: Color(0xFFFFD54F),
          ),
        ],
      ),
      ColoringRound(
        word: 'دِيك',
        bgImagePath: '${_gamesDir}coloring/dal/dal_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/dal/dal_coloring_word_2.png',
        introAudioPath: '${_audio}dal_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dal/dal_reveal_deek.mp3',
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_2_slice_1.png',
            color: Color(0xFF26A69A),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_2_slice_2.png',
            color: Color(0xFF80CBC4),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_2_slice_3.png',
            color: Color(0xFF90A4AE),
          ),
        ],
      ),
      ColoringRound(
        word: 'هُدْهُد',
        bgImagePath: '${_gamesDir}coloring/dal/dal_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/dal/dal_coloring_word_3.png',
        introAudioPath: '${_audio}dal_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dal/dal_reveal_dood.mp3',
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_3_slice_1.png',
            color: Color(0xFFFF7043),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_3_slice_2.png',
            color: Color(0xFF4CAF50),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_3_slice_3.png',
            color: Color(0xFFFFF176),
          ),
        ],
      ),
    ],
  ),
);
