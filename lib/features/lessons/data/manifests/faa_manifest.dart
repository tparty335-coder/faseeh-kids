import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الفاء (ف) — الوحدة 20 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/faa/';
const String _audio = 'audio/lessons/faa/final/';
const String _soundsAudio = 'audio/lessons/faa/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest faaManifest = LetterUnitManifest(
  letter: 'ف',
  unitTitle: 'الوَحْدَةُ الْعِشْرُونَ | حَرْفُ الْفَاءِ (ف)',
  topBarColor: Color(0xFF00695C),
  highlightColor: Color(0xFFB2DFDB),
  mascotEmoji: '🦋',
  unitIndex: 20,
  nextLetter: 'ق',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}faa_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْفَاءِ (ف)',
      'أَنْطِقُ حَرْفَ الْفَاءِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْفَاءِ مَعَ الْمُدُودِ الثَّلَاثَةِ (فَا، فُو، فِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْفَاءِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْفَاءِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ الْفَأْرِ وَالْقِطِّ وَنَشِيدِ الْفَاءِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْفَاءِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}faa_cd_story_1.png',
        audioPath: '${_audio}faa_story_1.mp3',
        captionText: 'كَانَ الْفَأْرُ جَائِعًا، وَأَخَذَ يَلُفُّ وَيُفَتِّشُ حَتَّى وَجَدَ قِطْعَةً مِنَ الْجُبْنِ فَأَخَذَهَا لِيَأْكُلَهَا.',
      ),
      StoryScene(
        imagePath: '${_dir}faa_cd_story_2.png',
        audioPath: '${_audio}faa_story_2.mp3',
        captionText: 'فَرَآهُ الْقِطُّ، خَافَ الْفَأْرُ وَجَرَى وَفِي فَمِهِ قِطْعَةُ الْجُبْنِ.',
      ),
      StoryScene(
        imagePath: '${_dir}faa_cd_story_3.png',
        audioPath: '${_audio}faa_story_3.mp3',
        captionText: 'وَالْقِطُّ يَجْرِي خَلْفَهُ حَتَّى اخْتَفَى الْفَأْرُ خَلْفَ السِّتَارَةِ وَأَكَلَ قِطْعَةَ الْجُبْنِ.',
      ),
      StoryScene(
        imagePath: '${_dir}faa_cd_story_nasheed.png',
        audioPath: '${_audio}faa_nasheed.mp3',
        isNasheed: true,
        captionText: 'فَاءٌ فَأْرٌ يَجْرِي مَسْرُورْ .. خَلْفَ السِّتَارَةِ حِينَ يَدُورْ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ف',
    items: [
      VowelItem(
        displayChar: 'فَ',
        fathaAudio: '${_vowelsAudio}faa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}faa_damma.mp3',
        kasraAudio: '${_vowelsAudio}faa_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'فَ',
        exampleWord: 'فَوَاكِه',
        exampleEmoji: '🍓',
        vowelAudio: '${_vowelsAudio}faa_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}faa_fatha_rule.mp3',
        wordAudio: '${_audio}faa_word_p4_1.mp3',
        slideImagePath: '${_dir}faa_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'فُ',
        exampleWord: 'فُسْتَان',
        exampleEmoji: '👗',
        vowelAudio: '${_vowelsAudio}faa_damma.mp3',
        fullRuleAudio: '${_soundsAudio}faa_damma_rule.mp3',
        wordAudio: '${_audio}faa_word_p2_1.mp3',
        slideImagePath: '${_dir}faa_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'فِ',
        exampleWord: 'تَقْفِزُ',
        exampleEmoji: '🤸',
        vowelAudio: '${_vowelsAudio}faa_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}faa_kasra_rule.mp3',
        wordAudio: '${_audio}faa_word_p2_2.mp3',
        slideImagePath: '${_dir}faa_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'فْ',
        exampleWord: 'ضِفْدَع',
        exampleEmoji: '🐸',
        vowelAudio: '${_vowelsAudio}faa_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}faa_sukoon_rule.mp3',
        wordAudio: '${_audio}faa_word_p1_2.mp3',
        slideImagePath: '${_dir}faa_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ف',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'فَا',
        audioPath: '${_maddAudio}faa_alif.mp3',
        imagePath: '${_dir}faa_madd_aa.png',
        exampleWord: 'فَارِس',
        explanation: 'فَاءٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: فَا',
        wordAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_1.mp3',
        accentColor: Color(0xFF00695C),
      ),
      MaddItem(
        displayChar: 'فُو',
        audioPath: '${_maddAudio}faa_waw.mp3',
        imagePath: '${_dir}faa_madd_uu.png',
        exampleWord: 'عُصْفُور',
        explanation: 'فَاءٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: فُو',
        wordAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_2.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'فِي',
        audioPath: '${_maddAudio}faa_yaa.mp3',
        imagePath: '${_dir}faa_madd_ii.png',
        exampleWord: 'فِيل',
        explanation: 'فَاءٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: فِي',
        wordAudioPath: '${_audio}faa_word_p1_4.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ف',
    audioIntroPath: '${_audio}faa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}faa_write_step_1.png',
      '${_dir}faa_write_step_2.png',
      '${_dir}faa_write_step_3.png',
      '${_dir}faa_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ف',
        exampleWord: 'خَرُوف',
        exampleEmoji: '🐑',
        audioPath: '${_audio}faa_trace_isolated.mp3',
        imagePath: '${_dir}faa_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'فـ',
        exampleWord: 'فَرَاشَة',
        exampleEmoji: '🦋',
        audioPath: '${_coreAudio}faa_pos_start.mp3',
        imagePath: '${_dir}faa_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـفـ',
        exampleWord: 'تُفَّاح',
        exampleEmoji: '🍎',
        audioPath: '${_coreAudio}faa_pos_middle.mp3',
        imagePath: '${_dir}faa_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـف',
        exampleWord: 'الضَّيْف',
        exampleEmoji: '🏠',
        audioPath: '${_coreAudio}faa_pos_end.mp3',
        imagePath: '${_dir}faa_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}faa_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'فَرَاشَة', cardImagePath: '${_dir}faa_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}faa_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضِفْدَع', cardImagePath: '${_dir}faa_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}faa_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فَأْر', cardImagePath: '${_dir}faa_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}faa_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فِيل', cardImagePath: '${_dir}faa_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}faa_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}faa_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'فُسْتَان', cardImagePath: '${_dir}faa_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}faa_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'تَقْفِزُ', cardImagePath: '${_dir}faa_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}faa_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طِفْل', cardImagePath: '${_dir}faa_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}faa_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فَلَّاح', cardImagePath: '${_dir}faa_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}faa_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}faa_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ظَرْف', cardImagePath: '${_dir}faa_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}faa_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مِفْتَاح', cardImagePath: '${_dir}faa_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}faa_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'خَرُوف', cardImagePath: '${_dir}faa_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}faa_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قَفَص', cardImagePath: '${_dir}faa_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}faa_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}faa_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'فَوَاكِه', cardImagePath: '${_dir}faa_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}faa_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فَرَاوِلَة', cardImagePath: '${_dir}faa_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}faa_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'تُفَّاح', cardImagePath: '${_dir}faa_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}faa_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَفَاف', cardImagePath: '${_dir}faa_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}faa_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/faa/faa_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/faa/faa_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/faa/faa_circus_prompt.mp3',
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
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}fishing/faa/faa_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/faa/faa_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'حَمَامَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'صَقْر', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'فَرَاشَة',
        imagePath: '${_gamesDir}fishing/faa/faa_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/faa/faa_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'نَمْلَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'نَحْلَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'فَرَاوِلَة',
        imagePath: '${_gamesDir}fishing/faa/faa_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/faa/faa_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'بِطِّيخ', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'فَرَاوِلَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'عِنَب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'فُسْتَان',
        imagePath: '${_gamesDir}fishing/faa/faa_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/faa/faa_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'بَدْلَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'قَمِيص', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'فُسْتَان', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'فَوَاكِه',
        imagePath: '${_gamesDir}beehive/faa/faa_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/faa/faa_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'فُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'فَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'فِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'فْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'تَقْفِزُ',
        imagePath: '${_gamesDir}beehive/faa/faa_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/faa/faa_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'فُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'فَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'فِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'فْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'فُسْتَان',
        imagePath: '${_gamesDir}beehive/faa/faa_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/faa/faa_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'فُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'فَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'فِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'فْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ضِفْدَع',
        imagePath: '${_gamesDir}beehive/faa/faa_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/faa/faa_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'فُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'فَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'فِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'فْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'فُسْتَان',
        imagePath: '${_gamesDir}circus/faa/faa_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/faa/faa_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'قَمِيص', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'كُرْسِي', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'فُسْتَان', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/faa/faa_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}circus/faa/faa_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/faa/faa_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'تِمْسَاح', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/faa/faa_circus_2.mp3'),
          GameZoneChoice(label: 'كَلْب', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'فَرَاوِلَة',
        imagePath: '${_gamesDir}circus/faa/faa_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/faa/faa_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'رَغِيف', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'مَوْز', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'فَرَاوِلَة', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/faa/faa_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'فَلَّاح',
        imagePath: '${_gamesDir}match/faa/faa_match_1.png',
        audioPath: '${_gamesAudio}match/faa/faa_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فَلَّاح', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'تَاجِر', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ضِفْدَع',
        imagePath: '${_gamesDir}match/faa/faa_match_2.png',
        audioPath: '${_gamesAudio}match/faa/faa_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فَأْر', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'فِيل',
        imagePath: '${_gamesDir}match/faa/faa_match_3.png',
        audioPath: '${_gamesAudio}match/faa/faa_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فِيل', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'فَوَاكِه',
        imagePath: '${_gamesDir}match/faa/faa_match_4.png',
        audioPath: '${_gamesAudio}match/faa/faa_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'فَوَاكِه', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مِفْتَاح', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فُسْتَان', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'فَارِس',
        bgImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/faa/faa_coloring_word_1.png',
        introAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/faa/faa_wrong_reveal_1.mp3',
        wordAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_1.mp3',
        options: [
          GameZoneChoice(label: 'أَحْمَد', isCorrect: false),
          GameZoneChoice(label: 'أَمَل', isCorrect: false),
          GameZoneChoice(label: 'فَارِس', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_1_slice_1.png', color: Color(0xFF00695C)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_1_slice_2.png', color: Color(0xFF00897B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_1_slice_3.png', color: Color(0xFF26A69A)),
        ],
      ),
      ColoringRound(
        word: 'عُصْفُور',
        bgImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/faa/faa_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/faa/faa_wrong_reveal_2.mp3',
        wordAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_2.mp3',
        options: [
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true),
          GameZoneChoice(label: 'نَحْلَة', isCorrect: false),
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'فِيل',
        bgImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/faa/faa_coloring_word_3.png',
        introAudioPath: '${_audio}faa_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/faa/faa_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/faa/faa_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}faa_word_p1_4.mp3',
        options: [
          GameZoneChoice(label: 'أَسَد', isCorrect: false),
          GameZoneChoice(label: 'فَأْر', isCorrect: false),
          GameZoneChoice(label: 'فِيل', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/faa/faa_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
