import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الغين (غ) — الوحدة 19 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/ghayn/';
const String _audio = 'audio/lessons/ghayn/final/';
const String _soundsAudio = 'audio/lessons/ghayn/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest ghaynManifest = LetterUnitManifest(
  letter: 'غ',
  unitTitle: 'الوَحْدَةُ التَّاسِعَةَ عَشْرَةَ | حَرْفُ الْغَيْنِ (غ)',
  topBarColor: Color(0xFF1B5E20),
  highlightColor: Color(0xFFC8E6C9),
  mascotEmoji: '🦌',
  unitIndex: 19,
  nextLetter: 'ف',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}ghayn_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْغَيْنِ (غ)',
      'أَنْطِقُ حَرْفَ الْغَيْنِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْغَيْنِ مَعَ الْمُدُودِ الثَّلَاثَةِ (غَا، غُو، غِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْغَيْنِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْغَيْنِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ الْغُرَابِ وَالْغَزَالِ وَنَشِيدِ الْغَيْنِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْغَيْنِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}ghayn_cd_story_1.png',
        audioPath: '${_audio}ghayn_story_1.mp3',
        captionText: 'فِي يَوْمٍ مِنَ الْأَيَّامِ كَانَ الْغُرَابُ يَقِفُ عَلَى غُصْنِ شَجَرَةٍ.',
      ),
      StoryScene(
        imagePath: '${_dir}ghayn_cd_story_2.png',
        audioPath: '${_audio}ghayn_story_2.mp3',
        captionText: 'حَاوَلَ الْأَسَدُ الْجَرْيَ وَرَاءَ الْغَزَالِ لِيَأْكُلَهُ.',
      ),
      StoryScene(
        imagePath: '${_dir}ghayn_cd_story_3.png',
        audioPath: '${_audio}ghayn_story_3.mp3',
        captionText: 'قَالَ الْغُرَابُ لِلْأَسَدِ وَالْغَزَالِ: يَا أَصْدِقَائِي، دَعُونَا نَعِيشُ مَعًا فِي الْغَابَةِ فِي سَلَامٍ.',
      ),
      StoryScene(
        imagePath: '${_dir}ghayn_cd_story_nasheed.png',
        audioPath: '${_audio}ghayn_nasheed.mp3',
        isNasheed: true,
        captionText: 'غَيْنٌ غَابَةٌ بَيْتُ الْأَسَدِ .. يَجْرِي يَزْأَرُ خَلْفَ الصَّيْدِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'غ',
    items: [
      VowelItem(
        displayChar: 'غَ',
        fathaAudio: '${_vowelsAudio}ghain_fatha.mp3',
        dammaAudio: '${_vowelsAudio}ghain_damma.mp3',
        kasraAudio: '${_vowelsAudio}ghain_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'غَ',
        exampleWord: 'غَزَال',
        exampleEmoji: '🦌',
        vowelAudio: '${_vowelsAudio}ghain_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}ghayn_fatha_rule.mp3',
        wordAudio: '${_audio}ghayn_word_p1_1.mp3',
        slideImagePath: '${_dir}ghayn_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'غُ',
        exampleWord: 'غُصْن',
        exampleEmoji: '🌿',
        vowelAudio: '${_vowelsAudio}ghain_damma.mp3',
        fullRuleAudio: '${_soundsAudio}ghayn_damma_rule.mp3',
        wordAudio: '${_audio}ghayn_word_p1_3.mp3',
        slideImagePath: '${_dir}ghayn_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'غِ',
        exampleWord: 'غِذَاء',
        exampleEmoji: '🍽️',
        vowelAudio: '${_vowelsAudio}ghain_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}ghayn_kasra_rule.mp3',
        wordAudio: '${_audio}ghayn_word_p1_2.mp3',
        slideImagePath: '${_dir}ghayn_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'غْ',
        exampleWord: 'تَغْسِلُ',
        exampleEmoji: '🧼',
        vowelAudio: '${_vowelsAudio}ghain_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}ghayn_sukoon_rule.mp3',
        wordAudio: '${_audio}ghayn_word_p4_2.mp3',
        slideImagePath: '${_dir}ghayn_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'غ',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'غَا',
        audioPath: '${_maddAudio}ghain_alif.mp3',
        imagePath: '${_dir}ghayn_madd_aa.png',
        exampleWord: 'غَابَة',
        explanation: 'غَيْنٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: غَا',
        wordAudioPath: '${_audio}ghayn_word_p1_4.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
      MaddItem(
        displayChar: 'غُو',
        audioPath: '${_maddAudio}ghain_waw.mp3',
        imagePath: '${_dir}ghayn_madd_uu.png',
        exampleWord: 'يَغُوصُ',
        explanation: 'غَيْنٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: غُو',
        wordAudioPath: '${_audio}ghayn_word_p2_1.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'غِي',
        audioPath: '${_maddAudio}ghain_yaa.mp3',
        imagePath: '${_dir}ghayn_madd_ii.png',
        exampleWord: 'صَغِير',
        explanation: 'غَيْنٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: غِي',
        wordAudioPath: '${_audio}ghayn_word_p2_2.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'غ',
    audioIntroPath: '${_audio}ghayn_write_intro.mp3',
    stepImagePaths: [
      '${_dir}ghayn_write_step_1.png',
      '${_dir}ghayn_write_step_2.png',
      '${_dir}ghayn_write_step_3.png',
      '${_dir}ghayn_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'غ',
        exampleWord: 'دِمَاغ',
        exampleEmoji: '🧠',
        audioPath: '${_audio}ghayn_trace_isolated.mp3',
        imagePath: '${_dir}ghayn_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'غـ',
        exampleWord: 'غَزَال',
        exampleEmoji: '🦌',
        audioPath: '${_coreAudio}ghain_pos_start.mp3',
        imagePath: '${_dir}ghayn_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـغـ',
        exampleWord: 'يَغُوصُ',
        exampleEmoji: '🤿',
        audioPath: '${_coreAudio}ghain_pos_middle.mp3',
        imagePath: '${_dir}ghayn_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـغ',
        exampleWord: 'بَلِيغ',
        exampleEmoji: '🧒',
        audioPath: '${_coreAudio}ghain_pos_end.mp3',
        imagePath: '${_dir}ghayn_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}ghayn_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'غَزَال', cardImagePath: '${_dir}ghayn_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غِذَاء', cardImagePath: '${_dir}ghayn_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غُصْن', cardImagePath: '${_dir}ghayn_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غَابَة', cardImagePath: '${_dir}ghayn_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}ghayn_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'يَغُوصُ', cardImagePath: '${_dir}ghayn_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صَغِير', cardImagePath: '${_dir}ghayn_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'دِمَاغ', cardImagePath: '${_dir}ghayn_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'رَغِيف', cardImagePath: '${_dir}ghayn_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}ghayn_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'غَسَّالَة', cardImagePath: '${_dir}ghayn_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صَمْغ', cardImagePath: '${_dir}ghayn_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غَلَّايَة', cardImagePath: '${_dir}ghayn_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غُرَاب', cardImagePath: '${_dir}ghayn_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}ghayn_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'غَار', cardImagePath: '${_dir}ghayn_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'تَغْسِلُ', cardImagePath: '${_dir}ghayn_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غُلَام', cardImagePath: '${_dir}ghayn_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَلِيغ', cardImagePath: '${_dir}ghayn_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}ghayn_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/ghayn/ghayn_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/ghayn/ghayn_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/ghayn/ghayn_circus_prompt.mp3',
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
        word: 'غَزَال',
        imagePath: '${_gamesDir}fishing/ghayn/ghayn_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/ghayn/ghayn_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'غَزَال', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'نَمِر', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'غُرَاب',
        imagePath: '${_gamesDir}fishing/ghayn/ghayn_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/ghayn/ghayn_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'حَمَام', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'عُصْفُور', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'غُرَاب', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'غَسَّالَة',
        imagePath: '${_gamesDir}fishing/ghayn/ghayn_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/ghayn/ghayn_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'مِكْوَاة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'غَسَّالَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ثَلَّاجَة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'رَغِيف',
        imagePath: '${_gamesDir}fishing/ghayn/ghayn_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/ghayn/ghayn_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'جُبْن', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أَرُزّ', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'رَغِيف', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'غَزَال',
        imagePath: '${_gamesDir}beehive/ghayn/ghayn_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/ghayn/ghayn_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'غُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'غِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'غَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'غْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'غُصْن',
        imagePath: '${_gamesDir}beehive/ghayn/ghayn_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/ghayn/ghayn_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'غُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'غِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'غَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'غْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'غِذَاء',
        imagePath: '${_gamesDir}beehive/ghayn/ghayn_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/ghayn/ghayn_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'غُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'غِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'غَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'غْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'تَغْسِلُ',
        imagePath: '${_gamesDir}beehive/ghayn/ghayn_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/ghayn/ghayn_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'غُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'غِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'غَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'غْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'غَزَال',
        imagePath: '${_gamesDir}circus/ghayn/ghayn_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/ghayn/ghayn_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'هَاتِف', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'غَزَال', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/ghayn/ghayn_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'رَغِيف',
        imagePath: '${_gamesDir}circus/ghayn/ghayn_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/ghayn/ghayn_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'رَغِيف', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/ghayn/ghayn_circus_2.mp3'),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'غُرَاب',
        imagePath: '${_gamesDir}circus/ghayn/ghayn_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/ghayn/ghayn_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'غُرَاب', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/ghayn/ghayn_circus_3.mp3'),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'غُصْن',
        imagePath: '${_gamesDir}match/ghayn/ghayn_match_1.png',
        audioPath: '${_gamesAudio}match/ghayn/ghayn_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'غُصْن', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'غَابَة',
        imagePath: '${_gamesDir}match/ghayn/ghayn_match_2.png',
        audioPath: '${_gamesAudio}match/ghayn/ghayn_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'غَابَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'زَهْرَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'غُرَاب',
        imagePath: '${_gamesDir}match/ghayn/ghayn_match_3.png',
        audioPath: '${_gamesAudio}match/ghayn/ghayn_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'قِرْد', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'غُرَاب', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فِيل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'غَزَال',
        imagePath: '${_gamesDir}match/ghayn/ghayn_match_4.png',
        audioPath: '${_gamesAudio}match/ghayn/ghayn_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'غَزَال', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مَاعِز', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'غُرَاب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'غَابَة',
        bgImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_word_1.png',
        introAudioPath: '${_audio}ghayn_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ghayn/ghayn_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/ghayn/ghayn_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}ghayn_word_p1_4.mp3',
        options: [
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false),
          GameZoneChoice(label: 'غَابَة', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_1_slice_1.png', color: Color(0xFF1B5E20)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_1_slice_2.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_1_slice_3.png', color: Color(0xFF4CAF50)),
        ],
      ),
      ColoringRound(
        word: 'يَغُوصُ',
        bgImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_word_2.png',
        introAudioPath: '${_audio}ghayn_word_p2_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ghayn/ghayn_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/ghayn/ghayn_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}ghayn_word_p2_1.mp3',
        options: [
          GameZoneChoice(label: 'يَبِيعُ', isCorrect: false),
          GameZoneChoice(label: 'يَغُوصُ', isCorrect: true),
          GameZoneChoice(label: 'يَلْعَبُ', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'صَغِير',
        bgImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_word_3.png',
        introAudioPath: '${_audio}ghayn_word_p2_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/ghayn/ghayn_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/ghayn/ghayn_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}ghayn_word_p2_2.mp3',
        options: [
          GameZoneChoice(label: 'صَغِير', isCorrect: true),
          GameZoneChoice(label: 'طِفْل', isCorrect: false),
          GameZoneChoice(label: 'بِنْت', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/ghayn/ghayn_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
