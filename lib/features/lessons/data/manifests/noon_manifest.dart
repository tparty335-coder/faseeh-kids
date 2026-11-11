import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف النون (ن) — الوحدة 25 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/noon/';
const String _audio = 'audio/lessons/noon/final/';
const String _soundsAudio = 'audio/lessons/noon/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest noonManifest = LetterUnitManifest(
  letter: 'ن',
  unitTitle: 'الوَحْدَةُ الْخَامِسَةُ وَالْعِشْرُونَ | حَرْفُ النُّونِ (ن)',
  topBarColor: Color(0xFF0277BD),
  highlightColor: Color(0xFFB3E5FC),
  mascotEmoji: '⛵',
  unitIndex: 25,
  nextLetter: 'ه',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}noon_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ النُّونِ (ن)',
      'أَنْطِقُ حَرْفَ النُّونِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ النُّونِ مَعَ الْمُدُودِ الثَّلَاثَةِ (نَا، نُو، نِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ النُّونِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ النُّونِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ الْعَمِّ حَسَنٍ وَنَهْرِ النِّيلِ وَنَشِيدِ النُّونِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ النُّونِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}noon_cd_story_1.png',
        audioPath: '${_audio}noon_story_1.mp3',
        captionText: 'عَمُّ حَسَنٍ يَعْمَلُ صَيَّادًا. خَرَجَ يَوْمًا يَصْطَادُ مِنْ مِيَاهِ النِّيلِ.',
      ),
      StoryScene(
        imagePath: '${_dir}noon_cd_story_2.png',
        audioPath: '${_audio}noon_story_2.mp3',
        captionText: 'رَمَى الْعَمُّ حَسَنٌ الشَّبَكَةَ فِي الْمَاءِ، وَجَلَسَ يَنْتَظِرُ رِزْقَهُ وَيَتَأَمَّلُ فِيمَا حَوْلَهُ.',
      ),
      StoryScene(
        imagePath: '${_dir}noon_cd_story_3.png',
        audioPath: '${_audio}noon_story_3.mp3',
        captionText: 'وَعَلَى الْبُعْدِ نَخْلَةٌ مُثْمِرَةٌ عَلَى الشَّاطِئِ .. وَالشَّمْسُ تُضِيءُ الْكَوْنَ بِنُورِهَا.',
      ),
      StoryScene(
        imagePath: '${_dir}noon_cd_story_4.png',
        audioPath: '${_audio}noon_story_4.mp3',
        captionText: 'وَشَدَّ الْعَمُّ حَسَنٌ الشَّبَكَةَ فَإِذَا بِهَا سَمَكٌ وَفِيرٌ.',
      ),
      StoryScene(
        imagePath: '${_dir}noon_cd_story_5.png',
        audioPath: '${_audio}noon_story_5.mp3',
        captionText: 'فَشَكَرَ اللَّهَ الَّذِي رَزَقَهُ بِالْخَيْرِ الْوَفِيرِ.',
      ),
      StoryScene(
        imagePath: '${_dir}noon_cd_story_nasheed.png',
        audioPath: '${_audio}noon_nasheed.mp3',
        isNasheed: true,
        captionText: 'نُونٌ نِيلٌ نَهْرُ الْخَيْرِ .. بَيْنَ الْوَادِي ذَهَبٌ يَجْرِي 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ن',
    items: [
      VowelItem(
        displayChar: 'نَ',
        fathaAudio: '${_vowelsAudio}noon_fatha.mp3',
        dammaAudio: '${_vowelsAudio}noon_damma.mp3',
        kasraAudio: '${_vowelsAudio}noon_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'نَ',
        exampleWord: 'عِنَب',
        exampleEmoji: '🍇',
        vowelAudio: '${_vowelsAudio}noon_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}noon_fatha_rule.mp3',
        wordAudio: '${_audio}noon_word_p1_3.mp3',
        slideImagePath: '${_dir}noon_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'نُ',
        exampleWord: 'نُسُور',
        exampleEmoji: '🦅',
        vowelAudio: '${_vowelsAudio}noon_damma.mp3',
        fullRuleAudio: '${_soundsAudio}noon_damma_rule.mp3',
        wordAudio: '${_audio}noon_word_p2_3.mp3',
        slideImagePath: '${_dir}noon_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'نِ',
        exampleWord: 'أَرَانِب',
        exampleEmoji: '🐇',
        vowelAudio: '${_vowelsAudio}noon_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}noon_kasra_rule.mp3',
        wordAudio: '${_audio}noon_word_p2_4.mp3',
        slideImagePath: '${_dir}noon_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'نْ',
        exampleWord: 'مُهَنْدِس',
        exampleEmoji: '👷',
        vowelAudio: '${_vowelsAudio}noon_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}noon_sukoon_rule.mp3',
        wordAudio: '${_audio}noon_word_p3_3.mp3',
        slideImagePath: '${_dir}noon_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ن',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'نَا',
        audioPath: '${_maddAudio}noon_alif.mp3',
        imagePath: '${_dir}noon_madd_aa.png',
        exampleWord: 'نَادِر',
        explanation: 'نُونٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: نَا',
        wordAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_2.mp3',
        accentColor: Color(0xFF0277BD),
      ),
      MaddItem(
        displayChar: 'نُو',
        audioPath: '${_maddAudio}noon_waw.mp3',
        imagePath: '${_dir}noon_madd_uu.png',
        exampleWord: 'نُور',
        explanation: 'نُونٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: نُو',
        wordAudioPath: '${_audio}noon_word_p4_3.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'نِي',
        audioPath: '${_maddAudio}noon_yaa.mp3',
        imagePath: '${_dir}noon_madd_ii.png',
        exampleWord: 'مُنِير',
        explanation: 'نُونٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: نِي',
        wordAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_3.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ن',
    audioIntroPath: '${_audio}noon_write_intro.mp3',
    stepImagePaths: [
      '${_dir}noon_write_step_1.png',
      '${_dir}noon_write_step_2.png',
      '${_dir}noon_write_step_3.png',
      '${_dir}noon_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ن',
        exampleWord: 'حِصَان',
        exampleEmoji: '🐎',
        audioPath: '${_audio}noon_trace_isolated.mp3',
        imagePath: '${_dir}noon_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'نـ',
        exampleWord: 'نَحْلَة',
        exampleEmoji: '🐝',
        audioPath: '${_coreAudio}noon_pos_start.mp3',
        imagePath: '${_dir}noon_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـنـ',
        exampleWord: 'صُنْدُوق',
        exampleEmoji: '📦',
        audioPath: '${_coreAudio}noon_pos_middle.mp3',
        imagePath: '${_dir}noon_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـن',
        exampleWord: 'لَبَن',
        exampleEmoji: '🥛',
        audioPath: '${_coreAudio}noon_pos_end.mp3',
        imagePath: '${_dir}noon_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}noon_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'غُصْن', cardImagePath: '${_dir}noon_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}noon_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'لَبَن', cardImagePath: '${_dir}noon_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}noon_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عِنَب', cardImagePath: '${_dir}noon_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}noon_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'رُمَّان', cardImagePath: '${_dir}noon_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}noon_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}noon_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'حِصَان', cardImagePath: '${_dir}noon_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}noon_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ثُعْبَان', cardImagePath: '${_dir}noon_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}noon_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نُسُور', cardImagePath: '${_dir}noon_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}noon_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'أَرَانِب', cardImagePath: '${_dir}noon_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}noon_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}noon_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'سَفِينَة', cardImagePath: '${_dir}noon_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}noon_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صُنْدُوق', cardImagePath: '${_dir}noon_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}noon_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُهَنْدِس', cardImagePath: '${_dir}noon_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}noon_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فُسْتَان', cardImagePath: '${_dir}noon_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}noon_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}noon_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'عَيْن', cardImagePath: '${_dir}noon_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}noon_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'أُذُن', cardImagePath: '${_dir}noon_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}noon_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نُور', cardImagePath: '${_dir}noon_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}noon_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'لَيْمُون', cardImagePath: '${_dir}noon_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}noon_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/noon/noon_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/noon/noon_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/noon/noon_circus_prompt.mp3',
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
        word: 'حِصَان',
        imagePath: '${_gamesDir}fishing/noon/noon_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/noon/noon_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'حِصَان', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قُطْن',
        imagePath: '${_gamesDir}fishing/noon/noon_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/noon/noon_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'فُول', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَرْسِيم', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قُطْن', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'نَخْلَة',
        imagePath: '${_gamesDir}fishing/noon/noon_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/noon/noon_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'خِيَار', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'بِطِّيخ', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'عِنَب',
        imagePath: '${_gamesDir}fishing/noon/noon_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/noon/noon_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'مَوْز', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'خَوْخ', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'عِنَب', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'عِنَب',
        imagePath: '${_gamesDir}beehive/noon/noon_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/noon/noon_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'نُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'نَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'نِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'نْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'أَرَانِب',
        imagePath: '${_gamesDir}beehive/noon/noon_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/noon/noon_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'نُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'نَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'نِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'نْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'نُسُور',
        imagePath: '${_gamesDir}beehive/noon/noon_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/noon/noon_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'نُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'نَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'نِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'نْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}beehive/noon/noon_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/noon/noon_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'نُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'نَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'نِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'نْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'رُمَّان',
        imagePath: '${_gamesDir}circus/noon/noon_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/noon/noon_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'بُرْتُقَال', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'رُمَّان', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/noon/noon_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'ثُعْبَان',
        imagePath: '${_gamesDir}circus/noon/noon_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/noon/noon_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'خَرُوف', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'ثُعْبَان', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/noon/noon_circus_2.mp3'),
          GameZoneChoice(label: 'فَأْر', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'سَفِينَة',
        imagePath: '${_gamesDir}circus/noon/noon_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/noon/noon_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'خُبْز', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'سَفِينَة', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/noon/noon_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'حِصَان',
        imagePath: '${_gamesDir}match/noon/noon_match_1.png',
        audioPath: '${_gamesAudio}match/noon/noon_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'حِمَار', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'حِصَان', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'زَرَافَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'أَرَانِب',
        imagePath: '${_gamesDir}match/noon/noon_match_2.png',
        audioPath: '${_gamesAudio}match/noon/noon_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'أَرَانِب', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'شَاة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}match/noon/noon_match_3.png',
        audioPath: '${_gamesAudio}match/noon/noon_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'مُعَلِّم', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'عَيْن',
        imagePath: '${_gamesDir}match/noon/noon_match_4.png',
        audioPath: '${_gamesAudio}match/noon/noon_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'عَيْن', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'أَنْف', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'أُذُن', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'نُور',
        bgImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/noon/noon_coloring_word_1.png',
        introAudioPath: '${_audio}noon_word_p4_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/noon/noon_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}noon_word_p4_3.mp3',
        options: [
          GameZoneChoice(label: 'قَلَم', isCorrect: false),
          GameZoneChoice(label: 'عَلَم', isCorrect: false),
          GameZoneChoice(label: 'نُور', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_1_slice_1.png', color: Color(0xFF0277BD)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_1_slice_2.png', color: Color(0xFF0288D1)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_1_slice_3.png', color: Color(0xFF29B6F6)),
        ],
      ),
      ColoringRound(
        word: 'نَادِر',
        bgImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/noon/noon_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/noon/noon_wrong_reveal_2.mp3',
        wordAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_2.mp3',
        options: [
          GameZoneChoice(label: 'نَادِر', isCorrect: true),
          GameZoneChoice(label: 'هِنْد', isCorrect: false),
          GameZoneChoice(label: 'سَعْد', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_2_slice_1.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_2_slice_2.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_2_slice_3.png', color: Color(0xFF66BB6A)),
        ],
      ),
      ColoringRound(
        word: 'مُنِير',
        bgImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/noon/noon_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/noon/noon_wrong_reveal_3.mp3',
        wordAudioPath: '${_gamesAudio}coloring/noon/noon_coloring_reveal_3.mp3',
        options: [
          GameZoneChoice(label: 'زَهْرَة', isCorrect: false),
          GameZoneChoice(label: 'فَهْد', isCorrect: false),
          GameZoneChoice(label: 'مُنِير', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/noon/noon_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
