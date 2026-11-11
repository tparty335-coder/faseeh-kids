import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف العين (ع) — الوحدة 18 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/ayn/';
const String _audio = 'audio/lessons/ayn/final/';
const String _soundsAudio = 'audio/lessons/ayn/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest aynManifest = LetterUnitManifest(
  letter: 'ع',
  unitTitle: 'الوَحْدَةُ الثَّامِنَةَ عَشْرَةَ | حَرْفُ الْعَيْنِ (ع)',
  topBarColor: Color(0xFF00838F),
  highlightColor: Color(0xFFB2EBF2),
  mascotEmoji: '🍇',
  unitIndex: 18,
  nextLetter: 'غ',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}ayn_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْعَيْنِ (ع)',
      'أَنْطِقُ حَرْفَ الْعَيْنِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْعَيْنِ مَعَ الْمُدُودِ الثَّلَاثَةِ (عَا، عُو، عِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْعَيْنِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْعَيْنِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ وَنَشِيدِ حَرْفِ الْعَيْنِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْعَيْنِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}ayn_cd_story_1.png',
        audioPath: '${_audio}ayn_story_1.mp3',
        captionText: 'الْجَدُّ يَحْكِي لِلْأَحْفَادِ قِصَّةَ حَرْفِ الْعَيْنِ.',
      ),
      StoryScene(
        imagePath: '${_dir}ayn_cd_story_nasheed.png',
        audioPath: '${_audio}ayn_nasheed.mp3',
        isNasheed: true,
        captionText: 'عَيْنٌ عَلَمٌ لَوَّنَّاهُ .. فَوْقَ الشَّمْسِ وَرَفَعْنَاهُ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ع',
    items: [
      VowelItem(
        displayChar: 'عَ',
        fathaAudio: '${_vowelsAudio}ain_fatha.mp3',
        dammaAudio: '${_vowelsAudio}ain_damma.mp3',
        kasraAudio: '${_vowelsAudio}ain_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'عَ',
        exampleWord: 'مَزْرَعَة',
        exampleEmoji: '🌾',
        vowelAudio: '${_vowelsAudio}ain_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}ayn_fatha_rule.mp3',
        wordAudio: '${_audio}ayn_word_p2_2.mp3',
        slideImagePath: '${_dir}ayn_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'عُ',
        exampleWord: 'عُصْفُور',
        exampleEmoji: '🐦',
        vowelAudio: '${_vowelsAudio}ain_damma.mp3',
        fullRuleAudio: '${_soundsAudio}ayn_damma_rule.mp3',
        wordAudio: '${_audio}ayn_word_p2_1.mp3',
        slideImagePath: '${_dir}ayn_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'عِ',
        exampleWord: 'عِنَب',
        exampleEmoji: '🍇',
        vowelAudio: '${_vowelsAudio}ain_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}ayn_kasra_rule.mp3',
        wordAudio: '${_audio}ayn_word_p2_3.mp3',
        slideImagePath: '${_dir}ayn_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'عْ',
        exampleWord: 'ثُعْبَان',
        exampleEmoji: '🐍',
        vowelAudio: '${_vowelsAudio}ain_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}ayn_sukoon_rule.mp3',
        wordAudio: '${_audio}ayn_word_p1_2.mp3',
        slideImagePath: '${_dir}ayn_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ع',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'عَا',
        audioPath: '${_maddAudio}ain_alif.mp3',
        imagePath: '${_dir}ayn_madd_aa.png',
        exampleWord: 'عَادِل',
        explanation: 'عَيْنٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: عَا',
        wordAudioPath: '${_audio}ayn_word_p2_4.mp3',
        accentColor: Color(0xFFD84315),
      ),
      MaddItem(
        displayChar: 'عُو',
        audioPath: '${_maddAudio}ain_waw.mp3',
        imagePath: '${_dir}ayn_madd_uu.png',
        exampleWord: 'مَسْعُود',
        explanation: 'عَيْنٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: عُو',
        wordAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_2.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'عِي',
        audioPath: '${_maddAudio}ain_yaa.mp3',
        imagePath: '${_dir}ayn_madd_ii.png',
        exampleWord: 'سَعِيد',
        explanation: 'عَيْنٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: عِي',
        wordAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_3.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ع',
    audioIntroPath: '${_audio}ayn_write_intro.mp3',
    stepImagePaths: [
      '${_dir}ayn_write_step_1.png',
      '${_dir}ayn_write_step_2.png',
      '${_dir}ayn_write_step_3.png',
      '${_dir}ayn_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ع',
        exampleWord: 'ذِرَاع',
        exampleEmoji: '💪',
        audioPath: '${_audio}ayn_trace_isolated.mp3',
        imagePath: '${_dir}ayn_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'عـ',
        exampleWord: 'عُصْفُور',
        exampleEmoji: '🐦',
        audioPath: '${_coreAudio}ain_pos_start.mp3',
        imagePath: '${_dir}ayn_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـعـ',
        exampleWord: 'مَسْعُود',
        exampleEmoji: '👦',
        audioPath: '${_coreAudio}ain_pos_middle.mp3',
        imagePath: '${_dir}ayn_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـع',
        exampleWord: 'ضِلْع',
        exampleEmoji: '🦴',
        audioPath: '${_coreAudio}ain_pos_end.mp3',
        imagePath: '${_dir}ayn_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}ayn_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'عَظْمَة', cardImagePath: '${_dir}ayn_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ثُعْبَان', cardImagePath: '${_dir}ayn_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضِلْع', cardImagePath: '${_dir}ayn_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ذِرَاع', cardImagePath: '${_dir}ayn_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}ayn_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'عُصْفُور', cardImagePath: '${_dir}ayn_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَزْرَعَة', cardImagePath: '${_dir}ayn_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عِنَب', cardImagePath: '${_dir}ayn_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَادِل', cardImagePath: '${_dir}ayn_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}ayn_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'عُشْب', cardImagePath: '${_dir}ayn_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُذِيع', cardImagePath: '${_dir}ayn_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضِفْدَع', cardImagePath: '${_dir}ayn_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شِرَاع', cardImagePath: '${_dir}ayn_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}ayn_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'سَاعَة', cardImagePath: '${_dir}ayn_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عُطُور', cardImagePath: '${_dir}ayn_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شُعْلَة', cardImagePath: '${_dir}ayn_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَمْعَة', cardImagePath: '${_dir}ayn_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}ayn_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/ayn/ayn_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/ayn/ayn_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/ayn/ayn_circus_prompt.mp3',
    circusWrongAudio: '${_gamesAudio}circus/4_hawe.mp3',
    wordsMatchPromptAudio: 'audio/instructions/words_drag_instruction.mp3',
    wordsMatchWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    coloringIntroAudio: '${_gamesAudio}coloring/6_al15.mp3',
    coloringStep1Audio: '${_gamesAudio}coloring/3_qu2.mp3',
    coloringStep2Audio: '${_gamesAudio}coloring/2_qu3.mp3',
    coloringWrongAudio: '${_gamesAudio}coloring/5_al23.mp3',
    praiseFinishAudio: '${_gamesAudio}fishing/ahsnt.mp3',
    fishing: [
      FishingRound(
        word: 'مَزْرَعَة',
        imagePath: '${_gamesDir}fishing/ayn/ayn_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/ayn/ayn_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'مَزْرَعَة', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'حَدِيقَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'عِنَب',
        imagePath: '${_gamesDir}fishing/ayn/ayn_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/ayn/ayn_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'بُرْتُقَال', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مَوْز', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'عِنَب', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ثُعْبَان',
        imagePath: '${_gamesDir}fishing/ayn/ayn_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/ayn/ayn_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'ثُعْبَان', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'فَأْر', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'عَادِل',
        imagePath: '${_gamesDir}fishing/ayn/ayn_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/ayn/ayn_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'ضِيَاء', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'سَيِّد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'عَادِل', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'مَزْرَعَة',
        imagePath: '${_gamesDir}beehive/ayn/ayn_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/ayn/ayn_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'عُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'عِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'عَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'عْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}beehive/ayn/ayn_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/ayn/ayn_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'عُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'عِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'عَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'عْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'عِنَب',
        imagePath: '${_gamesDir}beehive/ayn/ayn_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/ayn/ayn_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'عُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'عِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'عَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'عْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ثُعْبَان',
        imagePath: '${_gamesDir}beehive/ayn/ayn_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/ayn/ayn_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'عُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'عِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'عَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'عْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}circus/ayn/ayn_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/ayn/ayn_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'هَاتِف', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/ayn/ayn_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'ثُعْبَان',
        imagePath: '${_gamesDir}circus/ayn/ayn_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/ayn/ayn_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'ثُعْبَان', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/ayn/ayn_circus_2.mp3'),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'عِنَب',
        imagePath: '${_gamesDir}circus/ayn/ayn_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/ayn/ayn_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'عِنَب', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/ayn/ayn_circus_3.mp3'),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}match/ayn/ayn_match_1.png',
        audioPath: '${_gamesAudio}match/ayn/ayn_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'عِنَب',
        imagePath: '${_gamesDir}match/ayn/ayn_match_2.png',
        audioPath: '${_gamesAudio}match/ayn/ayn_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'عِنَب', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'زَهْرَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ذِرَاع',
        imagePath: '${_gamesDir}match/ayn/ayn_match_3.png',
        audioPath: '${_gamesAudio}match/ayn/ayn_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'قِرْد', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'ذِرَاع', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فِيل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مَزْرَعَة',
        imagePath: '${_gamesDir}match/ayn/ayn_match_4.png',
        audioPath: '${_gamesAudio}match/ayn/ayn_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'مَزْرَعَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مَاعِز', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'غُرَاب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'عَادِل',
        bgImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_word_1.png',
        introAudioPath: '${_audio}ayn_word_p2_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/ayn/ayn_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}ayn_word_p2_4.mp3',
        options: [
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false),
          GameZoneChoice(label: 'عَادِل', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_1_slice_1.png', color: Color(0xFF00838F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_1_slice_2.png', color: Color(0xFF00ACC1)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_1_slice_3.png', color: Color(0xFF26C6DA)),
        ],
      ),
      ColoringRound(
        word: 'مَسْعُود',
        bgImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/ayn/ayn_wrong_reveal_2.mp3',
        wordAudioPath: '${_maddAudio}ain_waw.mp3',
        options: [
          GameZoneChoice(label: 'يَبِيعُ', isCorrect: false),
          GameZoneChoice(label: 'مَسْعُود', isCorrect: true),
          GameZoneChoice(label: 'مِسْمَار', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'سَعِيد',
        bgImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ayn/ayn_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/ayn/ayn_wrong_reveal_3.mp3',
        wordAudioPath: '${_maddAudio}ain_yaa.mp3',
        options: [
          GameZoneChoice(label: 'سَعِيد', isCorrect: true),
          GameZoneChoice(label: 'طِفْل', isCorrect: false),
          GameZoneChoice(label: 'بِنْت', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_3_slice_1.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_3_slice_2.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ayn/ayn_coloring_round_3_slice_3.png', color: Color(0xFF66BB6A)),
        ],
      ),
    ],
  ),
);
