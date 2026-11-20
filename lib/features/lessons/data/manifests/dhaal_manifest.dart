import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الذال (ذ) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_ذ.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ka1..ka4.swf, sto1..sto4.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/dhaal/';
const String _audio = 'audio/lessons/dhaal/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الذال — أصول وأصوات أصلية 100% من أسطوانة الوزارة
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
    audioPath: 'audio/letters/core/dhaal_name.mp3',
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

  // ── القصة (5 مشاهد + النشيد = 6 مشاهد أصلية) ──────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_1.webp',
        audioPath: '${_audio}dhaal_story_1.mp3',
      ), // ذهب معاذ بغنمه إلى المرعى وكان الذئب يراقبه من بعيد.
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_2.webp',
        audioPath: '${_audio}dhaal_story_2.mp3',
      ), // جلس معاذ تحت الشجرة يستظل بها
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_3.webp',
        audioPath: '${_audio}dhaal_story_3.mp3',
      ), // حاول الذئب الهجوم على الغنم .
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_4.webp',
        audioPath: '${_audio}dhaal_story_4.mp3',
      ), // ولكن معاذ رآه فأسرع نحوه بالعصا.
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_5.webp',
        audioPath: '${_audio}dhaal_story_5.mp3',
      ), // ففر الذئب هاربًا.
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_nasheed.webp',
        audioPath: '${_audio}dhaal_nasheed.mp3',
        isNasheed: true,
      ),
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
      MaddItem(
        displayChar: 'ذَا',
        audioPath: 'audio/letters/long_vowels/dhaal_madd_alif.mp3',
        imagePath: '${_dir}dhaal_madd_aa.webp',
      ),
      MaddItem(
        displayChar: 'ذُو',
        audioPath: 'audio/lessons/dhaal/madd/dhaal_madd_waw.mp3',
        imagePath: '${_dir}dhaal_madd_uu.webp',
      ),
      MaddItem(
        displayChar: 'ذِي',
        audioPath: 'audio/lessons/dhaal/madd/dhaal_madd_yaa.mp3',
        imagePath: '${_dir}dhaal_madd_ii.webp',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ذ',
    audioIntroPath: '${_audio}dhaal_write_intro.mp3',
    stepImagePaths: [
      '${_dir}dhaal_write_step_1.webp',
      '${_dir}dhaal_write_step_2.webp',
      '${_dir}dhaal_write_step_3.webp',
      '${_dir}dhaal_write_step_4.webp',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية) ────────────────────────
  words: WordsSpec(
    pages: [
      // ── صفحة 1: ذِئْب، مُعَاذ، ذَيْل، أُذُن ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ذِئْب',
            cardImagePath: '${_dir}dhaal_words_p1_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_1.mp3',
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
            word: 'مُعَاذ',
            cardImagePath: '${_dir}dhaal_words_p1_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_2.mp3',
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
            word: 'ذَيْل',
            cardImagePath: '${_dir}dhaal_words_p1_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_3.mp3',
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
            word: 'أُذُن',
            cardImagePath: '${_dir}dhaal_words_p1_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_4.mp3',
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

      // ── صفحة 2: بُذُور، ذُرَة، ذَهَب، تُذَاكِر ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'بُذُور',
            cardImagePath: '${_dir}dhaal_words_p2_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p2_1.mp3',
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
            word: 'ذُرَة',
            cardImagePath: '${_dir}dhaal_words_p2_card_2.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/dhaal/sounds/word_dhura.mp3',
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
            word: 'ذَهَب',
            cardImagePath: '${_dir}dhaal_words_p2_card_3.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/dhaal/sounds/word_dhahab.mp3',
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
            word: 'تُذَاكِر',
            cardImagePath: '${_dir}dhaal_words_p2_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p2_4.mp3',
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

      // ── صفحة 3: مِئْذَنَة، تِلْمِيذ، أُسْتَاذ، تَأْخُذ ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'مِئْذَنَة',
            cardImagePath: '${_dir}dhaal_words_p3_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_1.mp3',
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
            word: 'تِلْمِيذ',
            cardImagePath: '${_dir}dhaal_words_p3_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_2.mp3',
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
            word: 'أُسْتَاذ',
            cardImagePath: '${_dir}dhaal_words_p3_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_3.mp3',
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
            word: 'تَأْخُذ',
            cardImagePath: '${_dir}dhaal_words_p3_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_4.mp3',
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

      // ── صفحة 4: ذِرَاع، جِذْر، غِذَاء، مُذِيع ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ذِرَاع',
            cardImagePath: '${_dir}dhaal_words_p4_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_1.mp3',
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
            word: 'جِذْر',
            cardImagePath: '${_dir}dhaal_words_p4_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_2.mp3',
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
            word: 'غِذَاء',
            cardImagePath: '${_dir}dhaal_words_p4_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_3.mp3',
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
            word: 'مُذِيع',
            cardImagePath: '${_dir}dhaal_words_p4_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_4.mp3',
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
        word: 'بُذُور',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_1.webp',
        audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'بُذُور', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'قِطَار', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'مُذِيع',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_2.webp',
        audioPath: 'audio/lessons/dhaal/sounds/word_mudhee.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'مُذِيع', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'غِذَاء',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_3.webp',
        audioPath: 'audio/lessons/dhaal/sounds/word_ghidha.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'سَفِينَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'غِذَاء', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'كِتَاب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'تِلْمِيذ',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_4.webp',
        audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'أُمِّي', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'جَابِر', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'تِلْمِيذ', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'ذَيْل',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_1.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_2.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'ذُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ذَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'ذِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ذْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ذِرَاع',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_2.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_4.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'ذُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ذَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ذِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'ذْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'أُذُن',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_3.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'ذُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'ذَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ذِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ذْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'جِذْر',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_4.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'ذُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ذَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ذِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ذْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'ذَيْل',
        imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_1.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_2.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 474,
        zones: [
          GameZoneChoice(label: 'رِجْل', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'ذَيْل', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}match/dhaal/dhaal_match_2.mp3'),
        ],
      ),
      CircusRound(
        word: 'ذِئْب',
        imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_2.webp',
        audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 474,
        zones: [
          GameZoneChoice(label: 'سَمَكَة', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'ذِئْب', isCorrect: true, px: 272, py: 240, wordAudio: '${_gamesAudio}circus/dhaal/dhaal_circus_2.mp3'),
          GameZoneChoice(label: 'فِيل', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'غِذَاء',
        imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_3.webp',
        audioPath: 'audio/lessons/dhaal/sounds/word_ghidha.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 474,
        zones: [
          GameZoneChoice(label: 'فِنْجَان', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'غِذَاء', isCorrect: true, px: 135, py: 373, wordAudio: 'audio/lessons/dhaal/sounds/word_ghidha.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'جِذْر',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_1.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'خِيَار', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'جِذْر', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'خُبْز', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ذَيْل',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_2.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'ذَيْل', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بَاب', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'ثَلْج', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'أُذُن',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_3.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'رَأْس', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'رِجْل', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'أُذُن', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ذِرَاع',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_4.webp',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'ذِرَاع', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فَأْس', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'تُوت', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'غِذَاء',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1.webp',
        wordRevealImagePath:
            '${_gamesDir}coloring/dhaal/dhaal_coloring_word_1.webp',
        introAudioPath: '${_audio}dhaal_paint_word1.mp3',
        revealAudioPath: '${_audio}dhaal_paint_word1.mp3',
        wordAudioPath: 'audio/lessons/dhaal/sounds/word_ghidha.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'غِذَاء', isCorrect: true),
          GameZoneChoice(label: 'جِذْر', isCorrect: false),
          GameZoneChoice(label: 'ذُرَة', isCorrect: false),
        ],
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_1.webp',
            color: Color(0xFFE65100),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_2.webp',
            color: Color(0xFFFF8F00),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_3.webp',
            color: Color(0xFFFFD54F),
          ),
        ],
      ),
      ColoringRound(
        word: 'بُذُور',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2.webp',
        wordRevealImagePath:
            '${_gamesDir}coloring/dhaal/dhaal_coloring_word_2.webp',
        introAudioPath: '${_audio}dhaal_paint_word2.mp3',
        revealAudioPath: '${_audio}dhaal_paint_word2.mp3',
        wordAudioPath: '${_audio}dhaal_word_p2_1.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'ذَهَب', isCorrect: false),
          GameZoneChoice(label: 'مِئْذَنَة', isCorrect: false),
          GameZoneChoice(label: 'بُذُور', isCorrect: true),
        ],
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_1.webp',
            color: Color(0xFFF57C00),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_2.webp',
            color: Color(0xFFFFB74D),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_3.webp',
            color: Color(0xFF90A4AE),
          ),
        ],
      ),
      ColoringRound(
        word: 'مُذِيع',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3.webp',
        wordRevealImagePath:
            '${_gamesDir}coloring/dhaal/dhaal_coloring_word_3.webp',
        introAudioPath: '${_audio}dhaal_paint_word3.mp3',
        revealAudioPath: '${_audio}dhaal_paint_word3.mp3',
        wordAudioPath: 'audio/lessons/dhaal/sounds/word_mudhee.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'ذِئْب', isCorrect: false),
          GameZoneChoice(label: 'أُذُن', isCorrect: false),
          GameZoneChoice(label: 'مُذِيع', isCorrect: true),
        ],
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_1.webp',
            color: Color(0xFFFF7043),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_2.webp',
            color: Color(0xFF4CAF50),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_3.webp',
            color: Color(0xFFFFF176),
          ),
        ],
      ),
    ],
  ),
);
