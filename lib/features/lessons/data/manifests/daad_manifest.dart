import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الضاد (ض) — الوحدة 15 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/daad/';
const String _audio = 'audio/lessons/daad/final/';
const String _soundsAudio = 'audio/lessons/daad/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest daadManifest = LetterUnitManifest(
  letter: 'ض',
  unitTitle: 'الوَحْدَةُ الْخَامِسَةَ عَشْرَةَ | حَرْفُ الضَّادِ (ض)',
  topBarColor: Color(0xFF33691E),
  highlightColor: Color(0xFFDCEDC8),
  mascotEmoji: '🐸',
  unitIndex: 15,
  nextLetter: 'ط',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}daad_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الضَّادِ (ض)',
      'أَنْطِقُ حَرْفَ الضَّادِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الضَّادِ مَعَ الْمُدُودِ الثَّلَاثَةِ (ضَا، ضُو، ضِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الضَّادِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الضَّادِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الضَّادِ وَنَشِيدِ الضَّابِطِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الضَّادِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}daad_cd_story_1.png',
        audioPath: '${_audio}daad_story_1.mp3',
        captionText: 'جَلَسَ فِي بَيْتِهِ مُسْتَعِدًّا لِلرِّحْلَةِ إِلَى الرِّيفِ.',
      ),
      StoryScene(
        imagePath: '${_dir}daad_cd_story_2.png',
        audioPath: '${_audio}daad_story_2.mp3',
        captionText: 'وَتَجَوَّلَ فِي الْمَزْرَعَةِ وَمَعَ غُرُوبِ الشَّمْسِ شَاهَدَ الضِّفْدَعَ.',
      ),
      StoryScene(
        imagePath: '${_dir}daad_cd_story_3.png',
        audioPath: '${_audio}daad_story_3.mp3',
        captionText: 'وَكَانَ سَعِيدًا بِهَذِهِ الرِّحْلَةِ وَعَادَ إِلَى بَيْتِهِ بَعْدَ أَنْ أَمْضَى يَوْمًا جَمِيلًا.',
      ),
      StoryScene(
        imagePath: '${_dir}daad_cd_story_nasheed.png',
        audioPath: '${_audio}daad_nasheed.mp3',
        isNasheed: true,
        captionText: 'ضَادٌ ضَابِطٌ فِي الْمَيْدَانِ .. يَبْنِي مَجْدًا لِلْأَوْطَانِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ض',
    items: [
      VowelItem(
        displayChar: 'ضَ',
        fathaAudio: '${_vowelsAudio}daad_fatha.mp3',
        dammaAudio: '${_vowelsAudio}daad_damma.mp3',
        kasraAudio: '${_vowelsAudio}daad_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'ضَ',
        exampleWord: 'ضَحِكَ',
        exampleEmoji: '😄',
        vowelAudio: '${_vowelsAudio}daad_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}daad_fatha_rule.mp3',
        wordAudio: '${_audio}daad_word_p4_2.mp3',
        slideImagePath: '${_dir}daad_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'ضُ',
        exampleWord: 'ضِفْدَع',
        exampleEmoji: '🐸',
        vowelAudio: '${_vowelsAudio}daad_damma.mp3',
        fullRuleAudio: '${_soundsAudio}daad_damma_rule.mp3',
        wordAudio: '${_audio}daad_word_p1_2.mp3',
        slideImagePath: '${_dir}daad_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'ضِ',
        exampleWord: 'ضِلْع',
        exampleEmoji: '🦴',
        vowelAudio: '${_vowelsAudio}daad_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}daad_kasra_rule.mp3',
        wordAudio: '${_audio}daad_word_p2_1.mp3',
        slideImagePath: '${_dir}daad_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'ضْ',
        exampleWord: 'خَضْرَاء',
        exampleEmoji: '🌿',
        vowelAudio: '${_vowelsAudio}daad_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}daad_sukoon_rule.mp3',
        wordAudio: '${_audio}daad_word_p1_3.mp3',
        slideImagePath: '${_dir}daad_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ض',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'ضَا',
        audioPath: '${_maddAudio}daad_alif.mp3',
        imagePath: '${_dir}daad_madd_aa.png',
        exampleWord: 'خُضَار',
        explanation: 'ضَادٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: ضَا',
        wordAudioPath: '${_audio}daad_word_p3_4.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
      MaddItem(
        displayChar: 'ضُو',
        audioPath: '${_maddAudio}daad_waw.mp3',
        imagePath: '${_dir}daad_madd_uu.png',
        exampleWord: 'وُضُوء',
        explanation: 'ضَادٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: ضُو',
        wordAudioPath: '${_audio}daad_word_p2_3.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'ضِي',
        audioPath: '${_maddAudio}daad_yaa.mp3',
        imagePath: '${_dir}daad_madd_ii.png',
        exampleWord: 'ضِيَاء',
        explanation: 'ضَادٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: ضِي',
        wordAudioPath: '${_audio}daad_word_p1_1.mp3',
        accentColor: Color(0xFFE65100),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ض',
    audioIntroPath: '${_audio}daad_write_intro.mp3',
    stepImagePaths: [
      '${_dir}daad_write_step_1.png',
      '${_dir}daad_write_step_2.png',
      '${_dir}daad_write_step_3.png',
      '${_dir}daad_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ض',
        exampleWord: 'ضِرْس',
        exampleEmoji: '🦷',
        audioPath: '${_audio}daad_trace_isolated.mp3',
        imagePath: '${_dir}daad_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'ضـ',
        exampleWord: 'ضِفْدَع',
        exampleEmoji: '🐸',
        audioPath: '${_coreAudio}daad_pos_start.mp3',
        imagePath: '${_dir}daad_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـضـ',
        exampleWord: 'خَضْرَاء',
        exampleEmoji: '🌿',
        audioPath: '${_coreAudio}daad_pos_middle.mp3',
        imagePath: '${_dir}daad_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـض',
        exampleWord: 'بَيْض',
        exampleEmoji: '🥚',
        audioPath: '${_coreAudio}daad_pos_end.mp3',
        imagePath: '${_dir}daad_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}daad_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ضِيَاء', cardImagePath: '${_dir}daad_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}daad_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضِفْدَع', cardImagePath: '${_dir}daad_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}daad_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'خَضْرَاء', cardImagePath: '${_dir}daad_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}daad_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَرِيضَة', cardImagePath: '${_dir}daad_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}daad_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}daad_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ضِلْع', cardImagePath: '${_dir}daad_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}daad_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضَابِط', cardImagePath: '${_dir}daad_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}daad_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'وُضُوء', cardImagePath: '${_dir}daad_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}daad_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضَبْع', cardImagePath: '${_dir}daad_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}daad_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}daad_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ضِرْس', cardImagePath: '${_dir}daad_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}daad_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'الضَّيْف', cardImagePath: '${_dir}daad_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}daad_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَيْض', cardImagePath: '${_dir}daad_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}daad_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'خُضَار', cardImagePath: '${_dir}daad_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}daad_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}daad_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'رَضِيع', cardImagePath: '${_dir}daad_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}daad_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضَحِكَ', cardImagePath: '${_dir}daad_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}daad_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضَوْء', cardImagePath: '${_dir}daad_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}daad_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'أَرْض', cardImagePath: '${_dir}daad_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}daad_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/daad/daad_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/daad/daad_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/daad/daad_circus_prompt.mp3',
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
        word: 'ضِفْدَع',
        imagePath: '${_gamesDir}fishing/daad/daad_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/daad/daad_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'كَلْب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ضَابِط',
        imagePath: '${_gamesDir}fishing/daad/daad_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/daad/daad_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ضَابِط', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ضِرْس',
        imagePath: '${_gamesDir}fishing/daad/daad_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/daad/daad_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'فَم', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'ضِرْس', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'أَنْف', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'حَوْض',
        imagePath: '${_gamesDir}fishing/daad/daad_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/daad/daad_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'ثَلَّاجَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مَطْبَخ', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'حَوْض', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'مَرِيضَة',
        imagePath: '${_gamesDir}beehive/daad/daad_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/daad/daad_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'ضُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ضِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ضَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'ضْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ضُفْدَع',
        imagePath: '${_gamesDir}beehive/daad/daad_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/daad/daad_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'ضُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'ضِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ضَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ضْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ضِلْع',
        imagePath: '${_gamesDir}beehive/daad/daad_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/daad/daad_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'ضُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ضِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'ضَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ضْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'خَضْرَاء',
        imagePath: '${_gamesDir}beehive/daad/daad_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/daad/daad_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'ضُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ضِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ضَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ضْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'ضِرْس',
        imagePath: '${_gamesDir}circus/daad/daad_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/daad/daad_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'هَاتِف', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'ضِرْس', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/daad/daad_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'بَيْضَة',
        imagePath: '${_gamesDir}circus/daad/daad_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/daad/daad_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'بَيْضَة', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/daad/daad_circus_2.mp3'),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'ضِفْدَع',
        imagePath: '${_gamesDir}circus/daad/daad_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/daad/daad_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/daad/daad_circus_3.mp3'),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'ضِفْدَع',
        imagePath: '${_gamesDir}match/daad/daad_match_1.png',
        audioPath: '${_gamesAudio}match/daad/daad_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'سَمَكَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مَرِيضَة',
        imagePath: '${_gamesDir}match/daad/daad_match_2.png',
        audioPath: '${_gamesAudio}match/daad/daad_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'مَرِيضَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'أُسْتَاذ', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فَلَّاح', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'بَيْض',
        imagePath: '${_gamesDir}match/daad/daad_match_3.png',
        audioPath: '${_gamesAudio}match/daad/daad_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'رَأْس', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بَيْض', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'ذِرَاع', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'رَضِيع',
        imagePath: '${_gamesDir}match/daad/daad_match_4.png',
        audioPath: '${_gamesAudio}match/daad/daad_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'رَضِيع', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'اِمْرَأَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'رَجُل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'ضَابِط',
        bgImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/daad/daad_coloring_word_1.png',
        introAudioPath: '${_audio}daad_word_p2_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/daad/daad_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/daad/daad_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}daad_word_p2_2.mp3',
        options: [
          GameZoneChoice(label: 'ضِلْع', isCorrect: false),
          GameZoneChoice(label: 'ضَبْع', isCorrect: false),
          GameZoneChoice(label: 'ضَابِط', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_1_slice_1.png', color: Color(0xFF33691E)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_1_slice_2.png', color: Color(0xFF558B2F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_1_slice_3.png', color: Color(0xFF7CB342)),
        ],
      ),
      ColoringRound(
        word: 'وُضُوء',
        bgImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/daad/daad_coloring_word_2.png',
        introAudioPath: '${_audio}daad_word_p2_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/daad/daad_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/daad/daad_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}daad_word_p2_3.mp3',
        options: [
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: false),
          GameZoneChoice(label: 'وُضُوء', isCorrect: true),
          GameZoneChoice(label: 'بَيْض', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'فَضِيلَة',
        bgImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/daad/daad_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/daad/daad_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/daad/daad_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/daad/daad_wrong_reveal_3.mp3',
        wordAudioPath: '${_maddAudio}daad_yaa.mp3',
        options: [
          GameZoneChoice(label: 'فَضِيلَة', isCorrect: true),
          GameZoneChoice(label: 'ضَحِكَ', isCorrect: false),
          GameZoneChoice(label: 'ضِرْس', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/daad/daad_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
