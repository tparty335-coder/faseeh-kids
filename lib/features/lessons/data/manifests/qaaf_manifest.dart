import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف القاف (ق) — الوحدة 21 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/qaaf/';
const String _audio = 'audio/lessons/qaaf/final/';
const String _soundsAudio = 'audio/lessons/qaaf/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest qaafManifest = LetterUnitManifest(
  letter: 'ق',
  unitTitle: 'الوَحْدَةُ الْحَادِيَةُ وَالْعِشْرُونَ | حَرْفُ الْقَافِ (ق)',
  topBarColor: Color(0xFF6A1B9A),
  highlightColor: Color(0xFFE1BEE7),
  mascotEmoji: '🚆',
  unitIndex: 21,
  nextLetter: 'ك',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}qaaf_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْقَافِ (ق)',
      'أَنْطِقُ حَرْفَ الْقَافِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْقَافِ مَعَ الْمُدُودِ الثَّلَاثَةِ (قَا، قُو، قِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْقَافِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْقَافِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ طَارِقٍ وَمُسَابَقَةِ الرَّسْمِ وَنَشِيدِ الْقَافِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْقَافِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}qaaf_cd_story_1.png',
        audioPath: '${_audio}qaaf_story_1.mp3',
        captionText: 'طَارِقٌ تِلْمِيذٌ يُحِبُّ الرَّسْمَ وَالتَّلْوِينَ كَثِيرًا.',
      ),
      StoryScene(
        imagePath: '${_dir}qaaf_cd_story_2.png',
        audioPath: '${_audio}qaaf_story_2.mp3',
        captionText: 'وَفِي وَقْتِ فَرَاغِهِ يَجْلِسُ طَارِقٌ وَفِي يَدِهِ الْقَلَمُ وَكُرَّاسَةُ الرَّسْمِ.',
      ),
      StoryScene(
        imagePath: '${_dir}qaaf_cd_story_3.png',
        audioPath: '${_audio}qaaf_story_3.mp3',
        captionText: 'سَمِعَ طَارِقٌ عَنْ مُسَابَقَةٍ فِي الرَّسْمِ فِي الْمَدْرَسَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}qaaf_cd_story_4.png',
        audioPath: '${_audio}qaaf_story_4.mp3',
        captionText: 'اشْتَرَكَ طَارِقٌ فِي الْمُسَابَقَةِ وَرَسَمَ لَوْحَةً جَمِيلَةً.',
      ),
      StoryScene(
        imagePath: '${_dir}qaaf_cd_story_5.png',
        audioPath: '${_audio}qaaf_story_5.mp3',
        captionText: 'وَأُعْلِنَتْ نَتِيجَةُ الْمُسَابَقَةِ فَكَانَ طَارِقٌ مِنَ الْفَائِزِينَ.',
      ),
      StoryScene(
        imagePath: '${_dir}qaaf_cd_story_nasheed.png',
        audioPath: '${_audio}qaaf_nasheed.mp3',
        isNasheed: true,
        captionText: 'قَافٌ قَلَمٌ يَرْسُمُ أَجْمَلَ .. لَوْحَاتٍ بِالْخَيْرِ تُجَمَّلْ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ق',
    items: [
      VowelItem(
        displayChar: 'قَ',
        fathaAudio: '${_vowelsAudio}qaaf_fatha.mp3',
        dammaAudio: '${_vowelsAudio}qaaf_damma.mp3',
        kasraAudio: '${_vowelsAudio}qaaf_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'قَ',
        exampleWord: 'بَقَرَة',
        exampleEmoji: '🐄',
        vowelAudio: '${_vowelsAudio}qaaf_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}qaaf_fatha_rule.mp3',
        wordAudio: '${_audio}qaaf_word_p1_3.mp3',
        slideImagePath: '${_dir}qaaf_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'قُ',
        exampleWord: 'قُطْن',
        exampleEmoji: '☁️',
        vowelAudio: '${_vowelsAudio}qaaf_damma.mp3',
        fullRuleAudio: '${_soundsAudio}qaaf_damma_rule.mp3',
        wordAudio: '${_audio}qaaf_word_p1_2.mp3',
        slideImagePath: '${_dir}qaaf_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'قِ',
        exampleWord: 'قِطَار',
        exampleEmoji: '🚆',
        vowelAudio: '${_vowelsAudio}qaaf_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}qaaf_kasra_rule.mp3',
        wordAudio: '${_audio}qaaf_word_p1_1.mp3',
        slideImagePath: '${_dir}qaaf_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'قْ',
        exampleWord: 'صَقْر',
        exampleEmoji: '🦅',
        vowelAudio: '${_vowelsAudio}qaaf_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}qaaf_sukoon_rule.mp3',
        wordAudio: '${_audio}qaaf_word_p2_4.mp3',
        slideImagePath: '${_dir}qaaf_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ق',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'قَا',
        audioPath: '${_maddAudio}qaaf_alif.mp3',
        imagePath: '${_dir}qaaf_madd_aa.png',
        exampleWord: 'قَارِب',
        explanation: 'قَافٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: قَا',
        wordAudioPath: '${_audio}qaaf_word_p3_4.mp3',
        accentColor: Color(0xFF6A1B9A),
      ),
      MaddItem(
        displayChar: 'قُو',
        audioPath: '${_maddAudio}qaaf_waw.mp3',
        imagePath: '${_dir}qaaf_madd_uu.png',
        exampleWord: 'بَرْقُوق',
        explanation: 'قَافٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: قُو',
        wordAudioPath: '${_audio}qaaf_word_p4_3.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'قِي',
        audioPath: '${_maddAudio}qaaf_yaa.mp3',
        imagePath: '${_dir}qaaf_madd_ii.png',
        exampleWord: 'حَقِيبَة',
        explanation: 'قَافٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: قِي',
        wordAudioPath: '${_audio}qaaf_word_p1_4.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ق',
    audioIntroPath: '${_audio}qaaf_write_intro.mp3',
    stepImagePaths: [
      '${_dir}qaaf_write_step_1.png',
      '${_dir}qaaf_write_step_2.png',
      '${_dir}qaaf_write_step_3.png',
      '${_dir}qaaf_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ق',
        exampleWord: 'صُنْدُوق',
        exampleEmoji: '📦',
        audioPath: '${_audio}qaaf_trace_isolated.mp3',
        imagePath: '${_dir}qaaf_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'قـ',
        exampleWord: 'قِرْد',
        exampleEmoji: '🐒',
        audioPath: '${_coreAudio}qaaf_pos_start.mp3',
        imagePath: '${_dir}qaaf_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـقـ',
        exampleWord: 'حَقِيبَة',
        exampleEmoji: '🎒',
        audioPath: '${_coreAudio}qaaf_pos_middle.mp3',
        imagePath: '${_dir}qaaf_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـق',
        exampleWord: 'طَبَق',
        exampleEmoji: '🍽️',
        audioPath: '${_coreAudio}qaaf_pos_end.mp3',
        imagePath: '${_dir}qaaf_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}qaaf_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قِطَار', cardImagePath: '${_dir}qaaf_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قُطْن', cardImagePath: '${_dir}qaaf_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَقَرَة', cardImagePath: '${_dir}qaaf_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'حَقِيبَة', cardImagePath: '${_dir}qaaf_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}qaaf_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قِطَّة', cardImagePath: '${_dir}qaaf_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قَلَم', cardImagePath: '${_dir}qaaf_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'تَقْفِزُ', cardImagePath: '${_dir}qaaf_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صَقْر', cardImagePath: '${_dir}qaaf_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}qaaf_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قَمَر', cardImagePath: '${_dir}qaaf_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قِرْد', cardImagePath: '${_dir}qaaf_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صُنْدُوق', cardImagePath: '${_dir}qaaf_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قَارِب', cardImagePath: '${_dir}qaaf_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}qaaf_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قَفَص', cardImagePath: '${_dir}qaaf_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قَلْب', cardImagePath: '${_dir}qaaf_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَرْقُوق', cardImagePath: '${_dir}qaaf_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَبَق', cardImagePath: '${_dir}qaaf_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}qaaf_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/qaaf/qaaf_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/qaaf/qaaf_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/qaaf/qaaf_circus_prompt.mp3',
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
        word: 'بَقَرَة',
        imagePath: '${_gamesDir}fishing/qaaf/qaaf_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/qaaf/qaaf_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'بَقَرَة', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'دُبّ', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قُطْن',
        imagePath: '${_gamesDir}fishing/qaaf/qaaf_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/qaaf/qaaf_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'حُبُوب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قُطْن', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قِطَار',
        imagePath: '${_gamesDir}fishing/qaaf/qaaf_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/qaaf/qaaf_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'سَيَّارَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'قِطَار', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'طَائِرَة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قَمَر',
        imagePath: '${_gamesDir}fishing/qaaf/qaaf_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/qaaf/qaaf_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'شَمْس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'نَجْم', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قَمَر', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'بَقَرَة',
        imagePath: '${_gamesDir}beehive/qaaf/qaaf_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/qaaf/qaaf_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'قُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'قِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'قَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'قْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'قُطْن',
        imagePath: '${_gamesDir}beehive/qaaf/qaaf_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/qaaf/qaaf_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'قُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'قِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'قَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'قْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'قِطَار',
        imagePath: '${_gamesDir}beehive/qaaf/qaaf_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/qaaf/qaaf_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'قُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'قِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'قَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'قْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'تَقْفِزُ',
        imagePath: '${_gamesDir}beehive/qaaf/qaaf_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/qaaf/qaaf_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'قُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'قِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'قَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'قْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'قَلَم',
        imagePath: '${_gamesDir}circus/qaaf/qaaf_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/qaaf/qaaf_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'شَمْعَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'هَاتِف', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'قَلَم', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/qaaf/qaaf_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'بَرْقُوق',
        imagePath: '${_gamesDir}circus/qaaf/qaaf_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/qaaf/qaaf_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'خَسّ', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'بَرْقُوق', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/qaaf/qaaf_circus_2.mp3'),
          GameZoneChoice(label: 'فُلْفُل', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'قِرْد',
        imagePath: '${_gamesDir}circus/qaaf/qaaf_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/qaaf/qaaf_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'قِرْد', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/qaaf/qaaf_circus_3.mp3'),
          GameZoneChoice(label: 'دُبّ', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'نَحْلَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'قِطَار',
        imagePath: '${_gamesDir}match/qaaf/qaaf_match_1.png',
        audioPath: '${_gamesAudio}match/qaaf/qaaf_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بُرْج', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'قِطَار', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'بَقَرَة',
        imagePath: '${_gamesDir}match/qaaf/qaaf_match_2.png',
        audioPath: '${_gamesAudio}match/qaaf/qaaf_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'بَقَرَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'جَمَل', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'قِرْد',
        imagePath: '${_gamesDir}match/qaaf/qaaf_match_3.png',
        audioPath: '${_gamesAudio}match/qaaf/qaaf_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'نَمِر', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'قِرْد', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فِيل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'قَارِب',
        imagePath: '${_gamesDir}match/qaaf/qaaf_match_4.png',
        audioPath: '${_gamesAudio}match/qaaf/qaaf_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'قَارِب', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'صَيَّاد', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'سَمَك', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'قَارِب',
        bgImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_word_1.png',
        introAudioPath: '${_audio}qaaf_word_p3_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/qaaf/qaaf_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/qaaf/qaaf_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}qaaf_word_p3_4.mp3',
        options: [
          GameZoneChoice(label: 'قَصْر', isCorrect: false),
          GameZoneChoice(label: 'قَمَر', isCorrect: false),
          GameZoneChoice(label: 'قَارِب', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_1_slice_1.png', color: Color(0xFF6A1B9A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_1_slice_2.png', color: Color(0xFF8E24AA)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_1_slice_3.png', color: Color(0xFFAB47BC)),
        ],
      ),
      ColoringRound(
        word: 'بَرْقُوق',
        bgImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_word_2.png',
        introAudioPath: '${_audio}qaaf_word_p4_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/qaaf/qaaf_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/qaaf/qaaf_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}qaaf_word_p4_3.mp3',
        options: [
          GameZoneChoice(label: 'قُطْن', isCorrect: false),
          GameZoneChoice(label: 'بَرْقُوق', isCorrect: true),
          GameZoneChoice(label: 'قَمْح', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'حَقِيبَة',
        bgImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_word_3.png',
        introAudioPath: '${_audio}qaaf_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/qaaf/qaaf_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/qaaf/qaaf_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}qaaf_word_p1_4.mp3',
        options: [
          GameZoneChoice(label: 'حَقِيبَة', isCorrect: true),
          GameZoneChoice(label: 'قَلَم', isCorrect: false),
          GameZoneChoice(label: 'قَلْب', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/qaaf/qaaf_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
