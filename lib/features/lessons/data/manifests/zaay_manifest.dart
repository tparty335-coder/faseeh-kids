import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الزاي (ز) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_ز.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: start.swf, write.swf, ka1..ka4.swf, sto1..sto2.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/zaay/';
const String _audio = 'audio/lessons/zaay/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
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
    audioPath: 'audio/letters/core/zaay_name.mp3',
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
        imagePath: '${_dir}zaay_cd_story_1.webp',
        audioPath: '${_audio}zaay_story_1.mp3',
      ), // أراد زاهر أن يروح عن نفسه ، فطلب من أبيه أن يذهب إلى القرية ليزور أولاد عمه مرزوق
      StoryScene(
        imagePath: '${_dir}zaay_cd_story_2.webp',
        audioPath: '${_audio}zaay_story_2.mp3',
      ), // فقد زارهم عدة مرات ، فهناك يلعب مع أولاد عمه ويستمع بزينة الحقول ، ويعود سعيدًا.
      StoryScene(
        imagePath: '${_dir}zaay_cd_story_nasheed.webp',
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
        audioPath: 'audio/letters/long_vowels/zaay_madd_alif.mp3',
        imagePath: '${_dir}zaay_madd_aa.webp',
      ),
      MaddItem(
        displayChar: 'زُو',
        audioPath: 'audio/lessons/zaay/madd/zaay_madd_waw.mp3',
        imagePath: '${_dir}zaay_madd_uu.webp',
      ),
      MaddItem(
        displayChar: 'زِي',
        audioPath: 'audio/lessons/zaay/madd/zaay_madd_yaa.mp3',
        imagePath: '${_dir}zaay_madd_ii.webp',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ز',
    audioIntroPath: 'audio/lessons/raa/final/raa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}zaay_write_step_1.webp',
      '${_dir}zaay_write_step_2.webp',
      '${_dir}zaay_write_step_3.webp',
      '${_dir}zaay_write_step_4.webp',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية) ────────────────────────
  words: WordsSpec(
    pages: [
      // ── صفحة 1 (ka1.swf): زَاهِر، جَزَر، زِينَة، يَزُور ──
      WordsPage(
        listImagePath: '${_dir}zaay_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'زَاهِر',
            cardImagePath: '${_dir}zaay_words_p1_card_1.webp',
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
            cardImagePath: '${_dir}zaay_words_p1_card_2.webp',
            cardHeight: 474,
            audioPath: 'audio/games/match/zaay/zaay_match_2.mp3',
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
            cardImagePath: '${_dir}zaay_words_p1_card_3.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/zaay/sounds/word_zeen.mp3',
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
            cardImagePath: '${_dir}zaay_words_p1_card_4.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/zaay/sounds/word_zoor.mp3',
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
        listImagePath: '${_dir}zaay_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'مَرْزُوق',
            cardImagePath: '${_dir}zaay_words_p2_card_1.webp',
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
            cardImagePath: '${_dir}zaay_words_p2_card_2.webp',
            cardHeight: 474,
            audioPath: 'audio/games/beehive/zaay/zaay_beehive_3.mp3',
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
            cardImagePath: '${_dir}zaay_words_p2_card_3.webp',
            cardHeight: 474,
            audioPath: 'audio/games/beehive/zaay/zaay_beehive_4.mp3',
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
            cardImagePath: '${_dir}zaay_words_p2_card_4.webp',
            cardHeight: 474,
            audioPath: 'audio/games/fishing/zaay/zaay_fishing_2.mp3',
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
        listImagePath: '${_dir}zaay_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'زَيْتُون',
            cardImagePath: '${_dir}zaay_words_p3_card_1.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/zaay/sounds/word_zaytoon.mp3',
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
            cardImagePath: '${_dir}zaay_words_p3_card_2.webp',
            cardHeight: 474,
            audioPath: 'audio/games/match/zaay/zaay_match_1.mp3',
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
            cardImagePath: '${_dir}zaay_words_p3_card_3.webp',
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
            cardImagePath: '${_dir}zaay_words_p3_card_4.webp',
            cardHeight: 474,
            audioPath: 'audio/games/match/zaay/zaay_match_3.mp3',
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
        listImagePath: '${_dir}zaay_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'زَهْرَة',
            cardImagePath: '${_dir}zaay_words_p4_card_1.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/zaay/sounds/word_zahra.mp3',
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
            cardImagePath: '${_dir}zaay_words_p4_card_2.webp',
            cardHeight: 474,
            audioPath: 'audio/games/match/zaay/zaay_match_4.mp3',
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
            cardImagePath: '${_dir}zaay_words_p4_card_3.webp',
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
            cardImagePath: '${_dir}zaay_words_p4_card_4.webp',
            cardHeight: 474,
            audioPath: 'audio/games/beehive/zaay/zaay_beehive_2.mp3',
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
    fishingIntroAudio: 'audio/letters/short_vowels/ha_fatha.mp3',
    fishingWrongAudio: 'audio/feedback/try_again.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/5_khalea2.mp3',
    beehiveWrongAudio: 'audio/feedback/try_again.mp3',
    circusWrongAudio: 'audio/feedback/try_again.mp3',
    wordsMatchPromptAudio: 'audio/instructions/words_drag_instruction.mp3',
    wordsMatchWrongAudio: 'audio/feedback/try_again.mp3',
    coloringIntroAudio: 'audio/instructions/alif_paint_intro.mp3',
    coloringStep1Audio: 'audio/instructions/alif_paint_explain.mp3',
    coloringStep2Audio: '${_gamesAudio}coloring/2_qu3.mp3',
    coloringWrongAudio: '${_gamesAudio}coloring/5_al23.mp3',
    praiseFinishAudio: 'audio/feedback/correct.mp3',
    fishing: [
      FishingRound(
        word: 'زَيْت',
        imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_1.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 485,
        zones: [
          GameZoneChoice(label: 'زَيْت', isCorrect: true, px: 120, py: 420, w: 215, h: 90),
          GameZoneChoice(label: 'تُوت', isCorrect: false, px: 382, py: 380, w: 220, h: 90),
          GameZoneChoice(label: 'تِين', isCorrect: false, px: 625, py: 420, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'غَزَال',
        imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_2.webp',
        audioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 485,
        zones: [
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 120, py: 420, w: 215, h: 90),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 382, py: 380, w: 220, h: 90),
          GameZoneChoice(label: 'غَزَال', isCorrect: true, px: 625, py: 420, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'حَازِم',
        imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_3.webp',
        audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 485,
        zones: [
          GameZoneChoice(label: 'حُسَام', isCorrect: false, px: 120, py: 420, w: 215, h: 90),
          GameZoneChoice(label: 'حَازِم', isCorrect: true, px: 382, py: 380, w: 220, h: 90),
          GameZoneChoice(label: 'حَاتِم', isCorrect: false, px: 625, py: 420, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'جَزَر',
        imagePath: '${_gamesDir}fishing/zaay/zaay_fishing_round_4.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 800,
        imgH: 485,
        zones: [
          GameZoneChoice(label: 'جَرَس', isCorrect: false, px: 120, py: 420, w: 215, h: 90),
          GameZoneChoice(label: 'جَذْر', isCorrect: false, px: 382, py: 380, w: 220, h: 90),
          GameZoneChoice(label: 'جَزَر', isCorrect: true, px: 625, py: 420, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'جَزَر',
        imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_1.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_2.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'زُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'زَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'زِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'زْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'حَازِم',
        imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_2.webp',
        audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'زُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'زَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'زِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'زْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'زُجَاجَة',
        imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_3.webp',
        audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'زُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'زَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'زِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'زْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مَزْرَعَة',
        imagePath: '${_gamesDir}beehive/zaay/zaay_beehive_round_4.webp',
        audioPath: '${_gamesAudio}beehive/zaay/zaay_beehive_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'زُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'زَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'زِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'زْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'جَزَر',
        imagePath: '${_gamesDir}circus/zaay/zaay_circus_round_1.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_2.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'تُفَّاحَة', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'مَانْجُو', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'جَزَر', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}match/zaay/zaay_match_2.mp3'),
        ],
      ),
      CircusRound(
        word: 'زَرَافَة',
        imagePath: '${_gamesDir}circus/zaay/zaay_circus_round_2.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_1.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'ذِئْب', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'زَرَافَة', isCorrect: true, px: 272, py: 240, wordAudio: '${_gamesAudio}match/zaay/zaay_match_1.mp3'),
          GameZoneChoice(label: 'حِمَار', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'مَوْز',
        imagePath: '${_gamesDir}circus/zaay/zaay_circus_round_3.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_4.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'بِطِّيخَة', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'مَوْز', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}match/zaay/zaay_match_4.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'زَرَافَة',
        imagePath: '${_gamesDir}match/zaay/zaay_match_1.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'فِيل', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'زَرَافَة', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'غَزَالَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'جَزَر',
        imagePath: '${_gamesDir}match/zaay/zaay_match_2.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'جَزَر', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'جَذْر', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'جَرَس', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'زَيْت',
        imagePath: '${_gamesDir}match/zaay/zaay_match_3.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'مَوْز', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'خُبْز', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'زَيْت', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مَوْز',
        imagePath: '${_gamesDir}match/zaay/zaay_match_4.webp',
        audioPath: '${_gamesAudio}match/zaay/zaay_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'مَوْز', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'خُبْز', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'جَزَر', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'غَزَال',
        bgImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_word_1.webp',
        introAudioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zaah.mp3',
        wordAudioPath: '${_gamesAudio}fishing/zaay/zaay_fishing_2.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'جَزَر', isCorrect: false),
          GameZoneChoice(label: 'خُبْز', isCorrect: false),
          GameZoneChoice(label: 'غَزَال', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1_slice_1.webp', color: Color(0xFF00838F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1_slice_2.webp', color: Color(0xFF00ACC1)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_1_slice_3.webp', color: Color(0xFF80DEEA)),
        ],
      ),
      ColoringRound(
        word: 'زَيْت',
        bgImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_word_2.webp',
        introAudioPath: '${_gamesAudio}match/zaay/zaay_match_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zooh.mp3',
        wordAudioPath: '${_gamesAudio}match/zaay/zaay_match_3.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'زَيْت', isCorrect: true),
          GameZoneChoice(label: 'زَهْرَة', isCorrect: false),
          GameZoneChoice(label: 'زَرْع', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2_slice_1.webp', color: Color(0xFF004D40)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2_slice_2.webp', color: Color(0xFF00695C)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_2_slice_3.webp', color: Color(0xFF4DB6AC)),
        ],
      ),
      ColoringRound(
        word: 'تَزُور',
        bgImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_word_3.webp',
        introAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zeeh.mp3',
        revealAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zeeh.mp3',
        wordAudioPath: '${_gamesAudio}coloring/zaay/zaay_reveal_zeeh.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'جَزَر', isCorrect: false),
          GameZoneChoice(label: 'زَهْرَة', isCorrect: false),
          GameZoneChoice(label: 'تَزُور', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3_slice_1.webp', color: Color(0xFF00897B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3_slice_2.webp', color: Color(0xFF26C6DA)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/zaay/zaay_coloring_round_3_slice_3.webp', color: Color(0xFFB2EBF2)),
        ],
      ),
    ],
  ),
);
