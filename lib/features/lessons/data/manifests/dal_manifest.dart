import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الدال (د) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_د.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ka1..ka4.swf, sto1..sto3.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/dal/';
const String _audio = 'audio/lessons/dal/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
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
    audioPath: 'audio/letters/core/daal_name.mp3',
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
        imagePath: '${_dir}dal_cd_story_1.webp',
        audioPath: '${_audio}dal_story_1.mp3',
      ), // استيقظت دلال على صوت الديك وهو يصيح .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_2.webp',
        audioPath: '${_audio}dal_story_2.mp3',
      ), // صياح الديك يوقظ دلال
      StoryScene(
        imagePath: '${_dir}dal_cd_story_3.webp',
        audioPath: '${_audio}dal_story_3.mp3',
      ), // فخرجت إلى الشرفة وسمعت صوت آذان الفجر .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_4.webp',
        audioPath: '${_audio}dal_story_4.mp3',
      ), // والناس يدخلون المسجد يصلون الفجر .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_5.webp',
        audioPath: '${_audio}dal_story_5.mp3',
      ), // أحبت دلال الديك وكانت تسميه مؤذن الفجر .
      StoryScene(
        imagePath: '${_dir}dal_cd_story_nasheed.webp',
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
        audioPath: 'audio/letters/long_vowels/daal_madd_alif.mp3',
        imagePath: '${_dir}dal_madd_aa.webp',
      ),
      MaddItem(
        displayChar: 'دُو',
        audioPath: 'audio/lessons/dal/madd/dal_madd_waw.mp3',
        imagePath: '${_dir}dal_madd_uu.webp',
      ),
      MaddItem(
        displayChar: 'دِي',
        audioPath: 'audio/lessons/dal/madd/dal_madd_yaa.mp3',
        imagePath: '${_dir}dal_madd_ii.webp',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'د',
    audioIntroPath: '${_audio}dal_write_intro.mp3',
    stepImagePaths: [
      '${_dir}dal_write_step_1.webp',
      '${_dir}dal_write_step_2.webp',
      '${_dir}dal_write_step_3.webp',
      '${_dir}dal_write_step_4.webp',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية من ka1..ka4.swf) ────
  // الإحداثيات نسبية (0.0..1.0) — الصور 800×474 بكسل مطابقة للأسطوانة
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka1.swf): دَلَال (أحمر)، دِيك (برتقالي)، مَسْجِد (أخضر)، دَالْيَا (أزرق)
      WordsPage(
        listImagePath: '${_dir}dal_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'دَلَالُ',
            cardImagePath: '${_dir}dal_words_p1_card_1.webp',
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
            cardImagePath: '${_dir}dal_words_p1_card_2.webp',
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
            cardImagePath: '${_dir}dal_words_p1_card_3.webp',
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
            cardImagePath: '${_dir}dal_words_p1_card_4.webp',
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
        listImagePath: '${_dir}dal_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'صُنْدُوق',
            cardImagePath: '${_dir}dal_words_p2_card_1.webp',
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
            cardImagePath: '${_dir}dal_words_p2_card_2.webp',
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
            cardImagePath: '${_dir}dal_words_p2_card_3.webp',
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
            cardImagePath: '${_dir}dal_words_p2_card_4.webp',
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
        listImagePath: '${_dir}dal_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'دُبّ',
            cardImagePath: '${_dir}dal_words_p3_card_1.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/dal/sounds/word_dubb.mp3',
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
            cardImagePath: '${_dir}dal_words_p3_card_2.webp',
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
            cardImagePath: '${_dir}dal_words_p3_card_3.webp',
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
            cardImagePath: '${_dir}dal_words_p3_card_4.webp',
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
        listImagePath: '${_dir}dal_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'أَسَدُ',
            cardImagePath: '${_dir}dal_words_p4_card_1.webp',
            cardHeight: 474,
            audioPath: 'audio/instructions/alif_trace_step_18.mp3',
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
            cardImagePath: '${_dir}dal_words_p4_card_2.webp',
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
            cardImagePath: '${_dir}dal_words_p4_card_3.webp',
            cardHeight: 474,
            audioPath: 'audio/games/match/dal/dal_match_3.mp3',
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
            cardImagePath: '${_dir}dal_words_p4_card_4.webp',
            cardHeight: 474,
            audioPath: 'audio/games/match/dal/dal_match_2.mp3',
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
    fishing: [
      FishingRound(
        word: 'صُنْدُوق',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_1.webp',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'كَتْكُوت', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ثُوم', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'دِمَاغ',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_2.webp',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'ثِمَار', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'تُوت', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'دِمَاغ', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'حَدِيقَة',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_3.webp',
        audioPath: '${_gamesAudio}fishing/dal/dal_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'بُرْج', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'حَدِيقَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'بَاب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'دَوَاء',
        imagePath: '${_gamesDir}fishing/dal/dal_fishing_round_4.webp',
        audioPath: 'audio/games/match/dal/dal_match_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'حُوت', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'خِيَار', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'دَوَاء', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    // لعبة خلية النحل (أبعاد 800×440 — دُ (692,181)، دَ (546,269)، دِ (739,255)، دْ (595,350))
    beehive: [
      BeehiveRound(
        word: 'دَوَاء',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_1.webp',
        audioPath: 'audio/games/match/dal/dal_match_3.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 138,
        cells: [
          GameZoneChoice(label: 'دُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'دَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'دِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'دْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_2.webp',
        audioPath: 'audio/games/match/dal/dal_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 138,
        cells: [
          GameZoneChoice(label: 'دُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'دَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'دِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'دْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'دُشّ',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_3.webp',
        audioPath: 'audio/games/match/dal/dal_match_4.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 138,
        cells: [
          GameZoneChoice(label: 'دُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'دَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'دِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'دْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'هُدْهُد',
        imagePath: '${_gamesDir}beehive/dal/dal_beehive_round_4.webp',
        audioPath: 'audio/games/match/dal/dal_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 138,
        cells: [
          GameZoneChoice(label: 'دُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'دَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'دِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'دْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'دُبّ',
        imagePath: '${_gamesDir}circus/dal/dal_circus_round_1.webp',
        audioPath: '${_gamesAudio}circus/dal/dal_circus_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'فِيل', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'زَرَافَة', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(
            label: 'دُبّ',
            isCorrect: true,
            px: 135,
            py: 373,
            wordAudio: '${_gamesAudio}circus/dal/dal_circus_1.mp3',
          ),
        ],
      ),
      CircusRound(
        word: 'مَسْجِد',
        imagePath: '${_gamesDir}circus/dal/dal_circus_round_2.webp',
        audioPath: '${_gamesAudio}circus/dal/dal_circus_2.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'فُرْشَاة', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(
            label: 'مَسْجِد',
            isCorrect: true,
            px: 272,
            py: 240,
            wordAudio: '${_gamesAudio}circus/dal/dal_circus_2.mp3',
          ),
          GameZoneChoice(label: 'شُبَّاك', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'دِيك',
        imagePath: '${_gamesDir}circus/dal/dal_circus_round_3.webp',
        audioPath: '${_gamesAudio}circus/dal/dal_circus_3.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(
            label: 'دِيك',
            isCorrect: true,
            px: 137,
            py: 98,
            wordAudio: '${_gamesAudio}circus/dal/dal_circus_3.mp3',
          ),
          GameZoneChoice(label: 'فَأْر', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'كَتْكُوت', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'هُدْهُد',
        imagePath: '${_gamesDir}match/dal/dal_match_1.webp',
        audioPath: '${_gamesAudio}match/dal/dal_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cardPx: 170,
        cardPyList: [128, 236, 353],
        dropPx: 550,
        dropPy: 420,
        cards: [
          GameZoneChoice(label: 'تِمْسَاح', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'هُدْهُد', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}match/dal/dal_match_2.webp',
        audioPath: '${_gamesAudio}match/dal/dal_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 446,
        cardPx: 170,
        cardPyList: [128, 236, 353],
        dropPx: 550,
        dropPy: 420,
        cards: [
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مُحَامِي', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'دَوَاء',
        imagePath: '${_gamesDir}match/dal/dal_match_3.webp',
        audioPath: '${_gamesAudio}match/dal/dal_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 446,
        cardPx: 170,
        cardPyList: [128, 236, 353],
        dropPx: 550,
        dropPy: 420,
        cards: [
          GameZoneChoice(label: 'بُرْج', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'دَوَاء', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'ثَلْج', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'دُشّ',
        imagePath: '${_gamesDir}match/dal/dal_match_4.webp',
        audioPath: '${_gamesAudio}match/dal/dal_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cardPx: 170,
        cardPyList: [128, 236, 353],
        dropPx: 550,
        dropPy: 420,
        cards: [
          GameZoneChoice(label: 'دُشّ', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'جَزَر', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'دَالْيَا',
        bgImagePath: '${_gamesDir}coloring/dal/dal_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/dal/dal_coloring_word_1.webp',
        introAudioPath: '${_audio}dal_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dal/dal_reveal_daar.mp3',
        wordAudioPath: '${_audio}dal_word_p1_4.mp3',
        imgW: 800,
        imgH: 450,
        wordX: 162,
        wordY: 175,
        wordW: 384,
        wordH: 125,
        cardCx: 68,
        cardCyList: [94, 219, 347],
        cardW: 114,
        cardH: 92,
        options: [
          GameZoneChoice(label: 'جِلْد', isCorrect: false),
          GameZoneChoice(label: 'دَالْيَا', isCorrect: true),
          GameZoneChoice(label: 'دُبّ', isCorrect: false),
        ],
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_1_slice_1.webp',
            color: Color(0xFF00897B),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_1_slice_2.webp',
            color: Color(0xFF004D40),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_1_slice_3.webp',
            color: Color(0xFFFFD54F),
          ),
        ],
      ),
      ColoringRound(
        word: 'حَدِيقَة',
        bgImagePath: '${_gamesDir}coloring/dal/dal_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/dal/dal_coloring_word_2.webp',
        introAudioPath: '${_gamesAudio}fishing/dal/dal_fishing_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dal/dal_reveal_deek.mp3',
        wordAudioPath: '${_gamesAudio}fishing/dal/dal_fishing_3.mp3',
        imgW: 800,
        imgH: 450,
        wordX: 162,
        wordY: 175,
        wordW: 384,
        wordH: 125,
        cardCx: 68,
        cardCyList: [94, 219, 347],
        cardW: 114,
        cardH: 92,
        options: [
          GameZoneChoice(label: 'مَسْجِد', isCorrect: false),
          GameZoneChoice(label: 'مِدْفَع', isCorrect: false),
          GameZoneChoice(label: 'حَدِيقَة', isCorrect: true),
        ],
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_2_slice_1.webp',
            color: Color(0xFF26A69A),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_2_slice_2.webp',
            color: Color(0xFF80CBC4),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_2_slice_3.webp',
            color: Color(0xFF90A4AE),
          ),
        ],
      ),
      ColoringRound(
        word: 'صُنْدُوق',
        bgImagePath: '${_gamesDir}coloring/dal/dal_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/dal/dal_coloring_word_3.webp',
        introAudioPath: '${_audio}dal_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dal/dal_reveal_dood.mp3',
        wordAudioPath: '${_gamesAudio}fishing/dal/dal_fishing_1.mp3',
        imgW: 800,
        imgH: 450,
        wordX: 162,
        wordY: 175,
        wordW: 384,
        wordH: 125,
        cardCx: 68,
        cardCyList: [94, 219, 347],
        cardW: 114,
        cardH: 92,
        options: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: true),
          GameZoneChoice(label: 'هُدْهُد', isCorrect: false),
          GameZoneChoice(label: 'دُشّ', isCorrect: false),
        ],
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_3_slice_1.webp',
            color: Color(0xFFFF7043),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_3_slice_2.webp',
            color: Color(0xFF4CAF50),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dal/dal_coloring_round_3_slice_3.webp',
            color: Color(0xFFFFF176),
          ),
        ],
      ),
    ],
  ),
);
