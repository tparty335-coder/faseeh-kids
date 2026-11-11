import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الياء (ي) — الوحدة 28 (الأخيرة) ───────────────────────────
const String _dir = 'assets/images/lessons/yaa/';
const String _audio = 'audio/lessons/yaa/final/';
const String _soundsAudio = 'audio/lessons/yaa/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest yaaManifest = LetterUnitManifest(
  letter: 'ي',
  unitTitle: 'الوَحْدَةُ الثَّامِنَةُ وَالْعِشْرُونَ | حَرْفُ الْيَاءِ (ي)',
  topBarColor: Color(0xFF283593),
  highlightColor: Color(0xFFC5CAE9),
  mascotEmoji: '🖐️',
  unitIndex: 28,
  nextLetter: null,

  objectives: ObjectivesSpec(
    audioPath: '${_audio}yaa_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْيَاءِ (ي)',
      'أَنْطِقُ حَرْفَ الْيَاءِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْيَاءِ مَعَ الْمُدُودِ الثَّلَاثَةِ (يَا، يُو، يِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْيَاءِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْيَاءِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ يُسْرَى وَالْمَكْتَبَةِ وَنَشِيدِ الْيَاءِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْيَاءِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}yaa_cd_story_1.png',
        audioPath: '${_audio}yaa_story_1.mp3',
        captionText: 'يُسْرَى يُحِبُّ قِرَاءَةَ الْقِصَصِ، ذَهَبَ يُسْرَى إِلَى مَكْتَبَةِ الْمَدْرَسَةِ وَاخْتَارَ قِصَّةً.',
      ),
      StoryScene(
        imagePath: '${_dir}yaa_cd_story_2.png',
        audioPath: '${_audio}yaa_story_2.mp3',
        captionText: 'وَفِي حِصَّةِ النَّشَاطِ بَدَأَ يُسْرَى يَحْكِي لِزُمَلَائِهِ قِصَّةً عَنِ الصَّدَاقَةِ، فَأُعْجِبَ التَّلَامِيذُ بِالْقِصَّةِ وَشَكَرُوا يُسْرَى.',
      ),
      StoryScene(
        imagePath: '${_dir}yaa_cd_story_nasheed.png',
        audioPath: '${_audio}yaa_nasheed.mp3',
        isNasheed: true,
        captionText: 'يَاءٌ يُسْرَى يَقْرَأُ قِصَّةً .. يُبْهِجُ فِيهَا كُلَّ الرُّفْقَةِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ي',
    items: [
      VowelItem(
        displayChar: 'يَ',
        fathaAudio: '${_vowelsAudio}yaa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}yaa_damma.mp3',
        kasraAudio: '${_vowelsAudio}yaa_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'يَ',
        exampleWord: 'يَد',
        exampleEmoji: '🖐️',
        vowelAudio: '${_vowelsAudio}yaa_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}yaa_fatha_rule.mp3',
        wordAudio: '${_audio}yaa_word_p1_1.mp3',
        slideImagePath: '${_dir}yaa_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'يُ',
        exampleWord: 'يُسْرَى',
        exampleEmoji: '👦',
        vowelAudio: '${_vowelsAudio}yaa_damma.mp3',
        fullRuleAudio: '${_soundsAudio}yaa_damma_rule.mp3',
        wordAudio: '${_audio}yaa_word_p1_3.mp3',
        slideImagePath: '${_dir}yaa_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'يْ',
        exampleWord: 'ذَيْل',
        exampleEmoji: '🦊',
        vowelAudio: '${_vowelsAudio}yaa_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}yaa_kasra_rule.mp3',
        wordAudio: '${_audio}yaa_word_p1_2.mp3',
        slideImagePath: '${_dir}yaa_vowel_kasra.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ي',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'يَا',
        audioPath: '${_maddAudio}yaa_alif.mp3',
        imagePath: '${_dir}yaa_madd_ii.png',
        exampleWord: 'خِيَار',
        explanation: 'يَاءٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: يَا',
        wordAudioPath: '${_audio}yaa_word_p1_4.mp3',
        accentColor: Color(0xFF283593),
      ),
      MaddItem(
        displayChar: 'يُو',
        audioPath: '${_maddAudio}yaa_waw.mp3',
        imagePath: '${_dir}yaa_madd_uu.png',
        exampleWord: 'طُيُور',
        explanation: 'يَاءٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: يُو',
        wordAudioPath: '${_audio}yaa_word_p2_1.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'يِي',
        audioPath: '${_maddAudio}yaa_yaa.mp3',
        imagePath: '${_dir}yaa_madd_aa.png',
        exampleWord: 'مِصْرِيِّين',
        explanation: 'يَاءٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: يِي',
        wordAudioPath: '${_gamesAudio}coloring/yaa/yaa_coloring_reveal_2.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ي',
    audioIntroPath: '${_audio}yaa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}yaa_write_step_1.png',
      '${_dir}yaa_write_step_2.png',
      '${_dir}yaa_write_step_3.png',
      '${_dir}yaa_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ي',
        exampleWord: 'شَاي',
        exampleEmoji: '🍵',
        audioPath: '${_audio}yaa_trace_isolated.mp3',
        imagePath: '${_dir}yaa_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'يـ',
        exampleWord: 'يَد',
        exampleEmoji: '🖐️',
        audioPath: '${_coreAudio}yaa_pos_start.mp3',
        imagePath: '${_dir}yaa_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـيـ',
        exampleWord: 'خِيَار',
        exampleEmoji: '🥒',
        audioPath: '${_coreAudio}yaa_pos_middle.mp3',
        imagePath: '${_dir}yaa_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـي',
        exampleWord: 'كُرْسِي',
        exampleEmoji: '🪑',
        audioPath: '${_coreAudio}yaa_pos_end.mp3',
        imagePath: '${_dir}yaa_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}yaa_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'يَد', cardImagePath: '${_dir}yaa_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ذَيْل', cardImagePath: '${_dir}yaa_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'يُسْرَى', cardImagePath: '${_dir}yaa_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'خِيَار', cardImagePath: '${_dir}yaa_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}yaa_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'طُيُور', cardImagePath: '${_dir}yaa_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَخِيل', cardImagePath: '${_dir}yaa_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'تِين', cardImagePath: '${_dir}yaa_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُذِيع', cardImagePath: '${_dir}yaa_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}yaa_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'طَبِيب', cardImagePath: '${_dir}yaa_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فِيل', cardImagePath: '${_dir}yaa_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَصِير', cardImagePath: '${_dir}yaa_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بِطِّيخ', cardImagePath: '${_dir}yaa_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}yaa_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ثِيرَان', cardImagePath: '${_dir}yaa_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَيْن', cardImagePath: '${_dir}yaa_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'حَقِيبَة', cardImagePath: '${_dir}yaa_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كُرْسِي', cardImagePath: '${_dir}yaa_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}yaa_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/yaa/yaa_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/yaa/yaa_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/yaa/yaa_circus_prompt.mp3',
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
        word: 'تِين',
        imagePath: '${_gamesDir}fishing/yaa/yaa_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/yaa/yaa_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'تِين', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'عِنَب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'مَوْز', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ذَيْل',
        imagePath: '${_gamesDir}fishing/yaa/yaa_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/yaa/yaa_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'رَأْس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أُذُن', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ذَيْل', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'بِطِّيخ',
        imagePath: '${_gamesDir}fishing/yaa/yaa_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/yaa/yaa_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'جَوَافَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بِطِّيخ', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'خَوْخ', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'طُيُور',
        imagePath: '${_gamesDir}fishing/yaa/yaa_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/yaa/yaa_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'قِرْد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'طُيُور', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'يَد',
        imagePath: '${_gamesDir}beehive/yaa/yaa_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/yaa/yaa_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'يُ', isCorrect: false, px: 642, py: 148),
          GameZoneChoice(label: 'يَ', isCorrect: true, px: 743, py: 262),
          GameZoneChoice(label: 'يْ', isCorrect: false, px: 595, py: 346),
        ],
      ),
      BeehiveRound(
        word: 'يُسْرَى',
        imagePath: '${_gamesDir}beehive/yaa/yaa_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/yaa/yaa_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'يُ', isCorrect: true, px: 642, py: 148),
          GameZoneChoice(label: 'يَ', isCorrect: false, px: 743, py: 262),
          GameZoneChoice(label: 'يْ', isCorrect: false, px: 595, py: 346),
        ],
      ),
      BeehiveRound(
        word: 'ذَيْل',
        imagePath: '${_gamesDir}beehive/yaa/yaa_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/yaa/yaa_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'يُ', isCorrect: false, px: 642, py: 148),
          GameZoneChoice(label: 'يَ', isCorrect: false, px: 743, py: 262),
          GameZoneChoice(label: 'يْ', isCorrect: true, px: 595, py: 346),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'خِيَار',
        imagePath: '${_gamesDir}circus/yaa/yaa_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/yaa/yaa_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'غُرَاب', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'خِيَار', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/yaa/yaa_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'تِين',
        imagePath: '${_gamesDir}circus/yaa/yaa_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/yaa/yaa_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'تِين', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/yaa/yaa_circus_2.mp3'),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'فِيل',
        imagePath: '${_gamesDir}circus/yaa/yaa_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/yaa/yaa_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'فِيل', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/yaa/yaa_circus_3.mp3'),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'فِيل',
        imagePath: '${_gamesDir}match/yaa/yaa_match_1.png',
        audioPath: '${_gamesAudio}match/yaa/yaa_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'كَلْب', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فِيل', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'بِطِّيخ',
        imagePath: '${_gamesDir}match/yaa/yaa_match_2.png',
        audioPath: '${_gamesAudio}match/yaa/yaa_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'بِطِّيخ', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مَوْز', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'عِنَب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'يَد',
        imagePath: '${_gamesDir}match/yaa/yaa_match_3.png',
        audioPath: '${_gamesAudio}match/yaa/yaa_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'ذِرَاع', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'يَد', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'قَدَم', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'نَخِيل',
        imagePath: '${_gamesDir}match/yaa/yaa_match_4.png',
        audioPath: '${_gamesAudio}match/yaa/yaa_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'نَخِيل', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'غُصْن', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'خِيَار',
        bgImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_word_1.png',
        introAudioPath: '${_audio}yaa_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/yaa/yaa_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/yaa/yaa_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}yaa_word_p1_4.mp3',
        options: [
          GameZoneChoice(label: 'تَمْر', isCorrect: false),
          GameZoneChoice(label: 'عِنَب', isCorrect: false),
          GameZoneChoice(label: 'خِيَار', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_1_slice_1.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_1_slice_2.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_1_slice_3.png', color: Color(0xFF66BB6A)),
        ],
      ),
      ColoringRound(
        word: 'مِصْرِيِّين',
        bgImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/yaa/yaa_coloring_reveal_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/yaa/yaa_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/yaa/yaa_wrong_reveal_2.mp3',
        wordAudioPath: '${_gamesAudio}coloring/yaa/yaa_coloring_reveal_2.mp3',
        options: [
          GameZoneChoice(label: 'عَرَبِي', isCorrect: false),
          GameZoneChoice(label: 'مِصْرِيِّين', isCorrect: true),
          GameZoneChoice(label: 'أَجْنَبِي', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_2_slice_1.png', color: Color(0xFFC62828)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_2_slice_2.png', color: Color(0xFFE53935)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_2_slice_3.png', color: Color(0xFFEF5350)),
        ],
      ),
      ColoringRound(
        word: 'طُيُور',
        bgImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_word_3.png',
        introAudioPath: '${_audio}yaa_word_p2_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/yaa/yaa_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/yaa/yaa_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}yaa_word_p2_1.mp3',
        options: [
          GameZoneChoice(label: 'نِسْر', isCorrect: false),
          GameZoneChoice(label: 'هُدْهُد', isCorrect: false),
          GameZoneChoice(label: 'طُيُور', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_3_slice_1.png', color: Color(0xFF283593)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_3_slice_2.png', color: Color(0xFF3949AB)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/yaa/yaa_coloring_round_3_slice_3.png', color: Color(0xFF5C6BC0)),
        ],
      ),
    ],
  ),
);
