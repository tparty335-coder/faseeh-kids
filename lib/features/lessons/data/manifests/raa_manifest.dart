import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الراء (ر) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_ر.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ahdaf_a.swf, write.swf, ka1..ka4.swf, sto1..sto2.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/raa/';
const String _audio = 'audio/lessons/raa/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الراء — أصول وأصوات أصلية 100% من أسطوانة الوزارة
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
    audioPath: 'audio/letters/core/raa_name.mp3',
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

  // ── القصة (6 مشاهد + النشيد = 7 مشاهد أصلية) ───────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}raa_cd_story_1.webp',
        audioPath: '${_audio}raa_story_1.mp3',
      ), // ذات يوم كانت الرمانة تجلس مع أخواتها من ثمار الفواكة فقالت:
      StoryScene(
        imagePath: '${_dir}raa_cd_story_2.webp',
        audioPath: '${_audio}raa_story_2.mp3',
      ), // أنا الأجمل لوناً ، والأحلى طعماً.
      StoryScene(
        imagePath: '${_dir}raa_cd_story_3.webp',
        audioPath: '${_audio}raa_story_3.mp3',
      ), // فردت البطيخة قائلة : أنا حمراء مثلك وطعمى أحلى من طعمك .
      StoryScene(
        imagePath: '${_dir}raa_cd_story_4.webp',
        audioPath: '${_audio}raa_story_4.mp3',
      ), // وأثناء ذلك مرت ريم وقالت للرمانة : لونك جميل طعمك حلو .
      StoryScene(
        imagePath: '${_dir}raa_cd_story_5.webp',
        audioPath: '${_audio}raa_story_5.mp3',
      ), // وقالت للبطيخة : طعمك حلو ، لونك جميل .
      StoryScene(
        imagePath: '${_dir}raa_cd_story_6.webp',
        audioPath: '${_audio}raa_story_6.mp3',
      ), // يا رفاق لونكم جميل ويستفيد منكم الجسم . ثم أخذت الرمانة وضحكت الفواكة .
      StoryScene(
        imagePath: '${_dir}raa_cd_story_nasheed.webp',
        audioPath: '${_audio}raa_nasheed.mp3',
        isNasheed: true,
      ), // راء رجل يدفع ثمنا ... يرفع علما يحمي وطنا
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
      MaddItem(
        displayChar: 'رَا',
        audioPath: 'audio/letters/long_vowels/raa_madd_alif.mp3',
        imagePath: '${_dir}raa_madd_aa.webp',
      ),
      MaddItem(
        displayChar: 'رُو',
        audioPath: 'audio/lessons/raa/madd/raa_madd_waw.mp3',
        imagePath: '${_dir}raa_madd_uu.webp',
      ),
      MaddItem(
        displayChar: 'رِي',
        audioPath: 'audio/lessons/raa/madd/raa_madd_yaa.mp3',
        imagePath: '${_dir}raa_madd_ii.webp',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ر',
    audioIntroPath: '${_audio}raa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}raa_write_step_1.webp',
      '${_dir}raa_write_step_2.webp',
      '${_dir}raa_write_step_3.webp',
      '${_dir}raa_write_step_4.webp',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية) ────────────────────────
  words: WordsSpec(
    pages: [
      // ── صفحة 1 (ka1.swf): رَجُل، رُمَان، رِجْل، ثِيرَان ──
      WordsPage(
        listImagePath: '${_dir}raa_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'رَجُل',
            cardImagePath: '${_dir}raa_words_p1_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p1_1.mp3',
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
            word: 'رُمَان',
            cardImagePath: '${_dir}raa_words_p1_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p1_2.mp3',
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
            word: 'رِجْل',
            cardImagePath: '${_dir}raa_words_p1_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p1_3.mp3',
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
            word: 'ثِيرَان',
            cardImagePath: '${_dir}raa_words_p1_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p1_4.mp3',
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

      // ── صفحة 2 (ka2.swf): ذِرَاع، بُرْج، رِيشَة، دَرَاجَة ──
      WordsPage(
        listImagePath: '${_dir}raa_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ذِرَاع',
            cardImagePath: '${_dir}raa_words_p2_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p2_1.mp3',
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
            word: 'بُرْج',
            cardImagePath: '${_dir}raa_words_p2_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p2_2.mp3',
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
            word: 'رِيشَة',
            cardImagePath: '${_dir}raa_words_p2_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p2_3.mp3',
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
            word: 'دَرَاجَة',
            cardImagePath: '${_dir}raa_words_p2_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p2_4.mp3',
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

      // ── صفحة 3 (ka3.swf): عُصْفُور، ذُرَة، فَرَاشَة، قَارِب ──
      WordsPage(
        listImagePath: '${_dir}raa_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'عُصْفُور',
            cardImagePath: '${_dir}raa_words_p3_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p3_1.mp3',
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
            cardImagePath: '${_dir}raa_words_p3_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p3_2.mp3',
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
            word: 'فَرَاشَة',
            cardImagePath: '${_dir}raa_words_p3_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p3_3.mp3',
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
            word: 'قَارِب',
            cardImagePath: '${_dir}raa_words_p3_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p3_4.mp3',
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

      // ── صفحة 4 (ka4.swf): نَمِر، بِرْسِيم، جَرَار، فَأْر ──
      WordsPage(
        listImagePath: '${_dir}raa_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'نَمِر',
            cardImagePath: '${_dir}raa_words_p4_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p4_1.mp3',
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
            word: 'بِرْسِيم',
            cardImagePath: '${_dir}raa_words_p4_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p4_2.mp3',
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
            word: 'جَرَار',
            cardImagePath: '${_dir}raa_words_p4_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p4_3.mp3',
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
            word: 'فَأْر',
            cardImagePath: '${_dir}raa_words_p4_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}raa_word_p4_4.mp3',
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
        word: 'فَرَاشَة',
        imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_1.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'دُبّ', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'رِيشَة',
        imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_2.webp',
        audioPath: 'audio/lessons/raa/sounds/word_reesha.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'حُبُوب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'رِيشَة', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'نَمِر',
        imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_3.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'فَهْد', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'نَمِر', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قَارِب',
        imagePath: '${_gamesDir}fishing/raa/raa_fishing_round_4.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_4.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'سَفِينَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قَارِب', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'رَجُل',
        imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_1.webp',
        audioPath: '${_gamesAudio}beehive/raa/raa_beehive_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'رُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'رِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'رَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'رْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'رُمَّان',
        imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_2.webp',
        audioPath: '${_gamesAudio}beehive/raa/raa_beehive_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'رُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'رِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'رَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'رْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'رِجْل',
        imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_3.webp',
        audioPath: '${_gamesAudio}circus/raa/raa_circus_1.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'رُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'رِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'رَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'رْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'بُرْج',
        imagePath: '${_gamesDir}beehive/raa/raa_beehive_round_4.webp',
        audioPath: '${_gamesAudio}beehive/raa/raa_beehive_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'رُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'رِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'رَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'رْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'رِجْل',
        imagePath: '${_gamesDir}circus/raa/raa_circus_round_1.webp',
        audioPath: '${_gamesAudio}circus/raa/raa_circus_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'هَاتِف', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'رِجْل', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/raa/raa_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'ذُرَة',
        imagePath: '${_gamesDir}circus/raa/raa_circus_round_2.webp',
        audioPath: '${_gamesAudio}circus/raa/raa_circus_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'خَسّ', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'ذُرَة', isCorrect: true, px: 272, py: 240, wordAudio: '${_gamesAudio}circus/raa/raa_circus_2.mp3'),
          GameZoneChoice(label: 'فُلْفُل', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'فَأْر',
        imagePath: '${_gamesDir}circus/raa/raa_circus_round_3.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_2.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'فَأْر', isCorrect: true, px: 137, py: 98, wordAudio: '${_gamesAudio}match/raa/raa_match_2.mp3'),
          GameZoneChoice(label: 'دُبّ', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'نَحْلَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'فَرَاشَة',
        imagePath: '${_gamesDir}match/raa/raa_match_1.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بُرْج', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'فَأْر',
        imagePath: '${_gamesDir}match/raa/raa_match_2.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'فَأْر', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'جَمَل', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'نَمِر',
        imagePath: '${_gamesDir}match/raa/raa_match_3.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'قِرْد', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'نَمِر', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فِيل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'قَارِب',
        imagePath: '${_gamesDir}match/raa/raa_match_4.webp',
        audioPath: '${_gamesAudio}match/raa/raa_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'قَارِب', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'صَيَّاد', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'سَمَك', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'رِيم',
        bgImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/raa/raa_coloring_word_1.webp',
        introAudioPath: 'audio/lessons/raa/sounds/word_reem.mp3',
        revealAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_raah.mp3',
        wordAudioPath: 'audio/lessons/raa/sounds/word_reem.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'بُرْج', isCorrect: false),
          GameZoneChoice(label: 'رَجُل', isCorrect: false),
          GameZoneChoice(label: 'رِيم', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1_slice_1.webp', color: Color(0xFFC2185B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1_slice_2.webp', color: Color(0xFFE91E63)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_1_slice_3.webp', color: Color(0xFFF48FB1)),
        ],
      ),
      ColoringRound(
        word: 'ثِيرَان',
        bgImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/raa/raa_coloring_word_2.webp',
        introAudioPath: '${_audio}raa_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_rooh.mp3',
        wordAudioPath: '${_audio}raa_word_p1_4.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false),
          GameZoneChoice(label: 'ثِيرَان', isCorrect: true),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2_slice_1.webp', color: Color(0xFF880E4F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2_slice_2.webp', color: Color(0xFFAD1457)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_2_slice_3.webp', color: Color(0xFFF06292)),
        ],
      ),
      ColoringRound(
        word: 'مَسْرُور',
        bgImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/raa/raa_coloring_word_3.webp',
        introAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_reeh.mp3',
        revealAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_reeh.mp3',
        wordAudioPath: '${_gamesAudio}coloring/raa/raa_reveal_reeh.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'مَسْرُور', isCorrect: true),
          GameZoneChoice(label: 'فَرَح', isCorrect: false),
          GameZoneChoice(label: 'مَرَض', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3_slice_1.webp', color: Color(0xFFD81B60)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3_slice_2.webp', color: Color(0xFFEC407A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/raa/raa_coloring_round_3_slice_3.webp', color: Color(0xFFF8BBD0)),
        ],
      ),
    ],
  ),
);
