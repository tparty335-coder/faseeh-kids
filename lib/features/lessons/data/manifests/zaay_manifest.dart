import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الزاي (ز) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_ز.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: start.swf, write.swf, ka1..ka4.swf, sto1..sto2.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/zaay/';
const String _audio = 'audio/lessons/zaay/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الزاي — أصول وأصوات أصلية 100% من أسطوانة الوزارة
const LetterUnitManifest zaayManifest = LetterUnitManifest(
  letter: 'ز',
  unitTitle: 'الْوَحْدَةُ الْحَادِيَةُ عَشْرَةَ | حَرْفُ الزَّايِ (ز)',
  topBarColor: Color(0xFF00838F), // تيل سيان داكن
  highlightColor: Color(0xFF80DEEA), // سيان فاتح
  mascotEmoji: '🌸', // زهرة
  unitIndex: 11,
  nextLetter: 'س',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}zaay_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الزَّايِ (ز)',
      'أَنْطِقُ حَرْفَ الزَّايِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الزَّايِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الزَّايِ',
      'أَتَتَبَّعُ حَرْفَ الزَّايِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الزَّايِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الزَّايِ',
    ],
  ),

  // ── القصة (مشهدان + النشيد = 3 مشاهد أصلية) ────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}zaay_cd_story_1.png',
        audioPath: '${_audio}zaay_story_1.mp3',
      ), // أراد زاهر أن يروح عن نفسه ، فطلب من أبيه أن يذهب إلى القرية ليزور أولاد عمه مرزوق
      StoryScene(
        imagePath: '${_dir}zaay_cd_story_2.png',
        audioPath: '${_audio}zaay_story_2.mp3',
      ), // فقد زارهم عدة مرات ، فهناك يلعب مع أولاد عمه ويستمع بزينة الحقول ، ويعود سعيدًا.
      StoryScene(
        imagePath: '${_dir}zaay_cd_story_nasheed.png',
        audioPath: '${_audio}zaay_nasheed.mp3',
        isNasheed: true,
      ), // زاي زهرة في البستان ... تنشر عطراً في الأوطان
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ز',
    items: [
      VowelItem(
        displayChar: 'زَ',
        fathaAudio: '${_vowelsAudio}zaay_fatha.mp3',
        dammaAudio: '${_vowelsAudio}zaay_damma.mp3',
        kasraAudio: '${_vowelsAudio}zaay_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ز',
    items: [
      MaddItem(
        displayChar: 'زَا',
        audioPath: '${_maddAudio}zaay_madd_demo.mp3',
        imagePath: '${_dir}zaay_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'زُو',
        audioPath: '${_maddAudio}zaay_madd_demo.mp3',
        imagePath: '${_dir}zaay_madd_uu.png',
      ),
      MaddItem(
        displayChar: 'زِي',
        audioPath: '${_maddAudio}zaay_madd_demo.mp3',
        imagePath: '${_dir}zaay_madd_ii.png',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
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

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية) ────────────────────────
  words: WordsSpec(
    pages: [
      // ── صفحة 1 (ka1.swf): زَاهِر، جَزَر، زِينَة، يَزُور ──
      WordsPage(
        listImagePath: '${_dir}zaay_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'زَاهِر',
            cardImagePath: '${_dir}zaay_words_p1_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p1_1.mp3',
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
            word: 'جَزَر',
            cardImagePath: '${_dir}zaay_words_p1_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p1_2.mp3',
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
            word: 'زِينَة',
            cardImagePath: '${_dir}zaay_words_p1_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p1_3.mp3',
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
            word: 'يَزُور',
            cardImagePath: '${_dir}zaay_words_p1_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p1_4.mp3',
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

      // ── صفحة 2 (ka2.swf): مَرْزُوق، زُجَاجَة، مَزْرَعَة، غَزَال ──
      WordsPage(
        listImagePath: '${_dir}zaay_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'مَرْزُوق',
            cardImagePath: '${_dir}zaay_words_p2_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p2_1.mp3',
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
            word: 'زُجَاجَة',
            cardImagePath: '${_dir}zaay_words_p2_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p2_2.mp3',
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
            word: 'مَزْرَعَة',
            cardImagePath: '${_dir}zaay_words_p2_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p2_3.mp3',
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
            word: 'غَزَال',
            cardImagePath: '${_dir}zaay_words_p2_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p2_4.mp3',
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

      // ── صفحة 3 (ka3.swf): زَيْتُون، زَرَافَة، زَرْع، زَيْت ──
      WordsPage(
        listImagePath: '${_dir}zaay_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'زَيْتُون',
            cardImagePath: '${_dir}zaay_words_p3_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p3_1.mp3',
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
            word: 'زَرَافَة',
            cardImagePath: '${_dir}zaay_words_p3_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p3_2.mp3',
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
            word: 'زَرْع',
            cardImagePath: '${_dir}zaay_words_p3_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p3_3.mp3',
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
            word: 'زَيْت',
            cardImagePath: '${_dir}zaay_words_p3_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p3_4.mp3',
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

      // ── صفحة 4 (ka4.swf): زَهْرَة، مَوْز، خُبْز، حَازِم ──
      WordsPage(
        listImagePath: '${_dir}zaay_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'زَهْرَة',
            cardImagePath: '${_dir}zaay_words_p4_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p4_1.mp3',
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
            word: 'مَوْز',
            cardImagePath: '${_dir}zaay_words_p4_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p4_2.mp3',
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
            word: 'خُبْز',
            cardImagePath: '${_dir}zaay_words_p4_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p4_3.mp3',
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
            word: 'حَازِم',
            cardImagePath: '${_dir}zaay_words_p4_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}zaay_word_p4_4.mp3',
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
