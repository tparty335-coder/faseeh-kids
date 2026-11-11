import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الواو (و) — الوحدة 27 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/waaw/';
const String _audio = 'audio/lessons/waaw/final/';
const String _soundsAudio = 'audio/lessons/waaw/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest waawManifest = LetterUnitManifest(
  letter: 'و',
  unitTitle: 'الوَحْدَةُ السَّابِعَةُ وَالْعِشْرُونَ | حَرْفُ الْوَاوِ (و)',
  topBarColor: Color(0xFF00796B),
  highlightColor: Color(0xFFB2DFDB),
  mascotEmoji: '🦚',
  unitIndex: 27,
  nextLetter: 'ي',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}waaw_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْوَاوِ (و)',
      'أَنْطِقُ حَرْفَ الْوَاوِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْوَاوِ مَعَ الْمُدُودِ الثَّلَاثَةِ (وَا، وُو، وِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْوَاوِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْوَاوِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ وِسَامَ وَالْوَرْدِ الْعَطِرِ وَنَشِيدِ الْوَاوِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْوَاوِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}waaw_cd_story_1.png',
        audioPath: '${_audio}waaw_story_1.mp3',
        captionText: 'خَرَجَتْ وِسَامُ إِلَى حَدِيقَةِ الْمَنْزِلِ لِتَتَنَزَّهَ فِي الْحَدِيقَةِ وَتَشُمَّ رَائِحَةَ الْوَرْدِ الْعَطِرَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}waaw_cd_story_2.png',
        audioPath: '${_audio}waaw_story_2.mp3',
        captionText: 'وَنَظَرَتْ إِلَى الْوَرْدِ بِأَلْوَانِهِ الْجَمِيلَةِ وَقَالَتْ: سُبْحَانَ اللَّهِ الَّذِي خَلَقَ وَأَبْدَعَ هَذِهِ الْأَلْوَانَ الْجَمِيلَةَ.',
      ),
      StoryScene(
        imagePath: '${_dir}waaw_cd_story_nasheed.png',
        audioPath: '${_audio}waaw_nasheed.mp3',
        isNasheed: true,
        captionText: 'وَاوٌ وَرْدَةٌ فِي الْبُسْتَانِ .. تُعْطِي عِطْرًا لِلْإِنْسَانِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'و',
    items: [
      VowelItem(
        displayChar: 'وَ',
        fathaAudio: '${_vowelsAudio}waaw_fatha.mp3',
        dammaAudio: '${_vowelsAudio}waaw_damma.mp3',
        kasraAudio: '${_vowelsAudio}waaw_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'وَ',
        exampleWord: 'وَجْه',
        exampleEmoji: '😊',
        vowelAudio: '${_vowelsAudio}waaw_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}waaw_fatha_rule.mp3',
        wordAudio: '${_audio}waaw_word_p2_1.mp3',
        slideImagePath: '${_dir}waaw_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'وُ',
        exampleWord: 'وُجُوه',
        exampleEmoji: '👨‍👩‍👧‍👦',
        vowelAudio: '${_vowelsAudio}waaw_damma.mp3',
        fullRuleAudio: '${_soundsAudio}waaw_damma_rule.mp3',
        wordAudio: '${_gamesAudio}fishing/waaw/waaw_fishing_3.mp3',
        slideImagePath: '${_dir}waaw_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'وِ',
        exampleWord: 'وِسَام',
        exampleEmoji: '👧',
        vowelAudio: '${_vowelsAudio}waaw_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}waaw_kasra_rule.mp3',
        wordAudio: '${_gamesAudio}beehive/waaw/waaw_beehive_2.mp3',
        slideImagePath: '${_dir}waaw_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'وْ',
        exampleWord: 'حَوْض',
        exampleEmoji: '🚰',
        vowelAudio: '${_vowelsAudio}waaw_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}waaw_sukoon_rule.mp3',
        wordAudio: '${_gamesAudio}fishing/waaw/waaw_fishing_4.mp3',
        slideImagePath: '${_dir}waaw_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'و',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'وَا',
        audioPath: '${_maddAudio}waaw_alif.mp3',
        imagePath: '${_dir}waaw_madd_aa.png',
        exampleWord: 'دَوَاء',
        explanation: 'وَاوٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: وَا',
        wordAudioPath: '${_audio}waaw_word_p3_4.mp3',
        accentColor: Color(0xFF00796B),
      ),
      MaddItem(
        displayChar: 'وُو',
        audioPath: '${_maddAudio}waaw_waw.mp3',
        imagePath: '${_dir}waaw_madd_uu.png',
        exampleWord: 'طَاوُوس',
        explanation: 'وَاوٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: وُو',
        wordAudioPath: '${_audio}waaw_word_p4_3.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'وِي',
        audioPath: '${_maddAudio}waaw_yaa.mp3',
        imagePath: '${_dir}waaw_madd_ii.png',
        exampleWord: 'طَوِيل',
        explanation: 'وَاوٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: وِي',
        wordAudioPath: '${_gamesAudio}coloring/waaw/waaw_coloring_reveal_3.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'و',
    audioIntroPath: '${_audio}waaw_write_intro.mp3',
    stepImagePaths: [
      '${_dir}waaw_write_step_1.png',
      '${_dir}waaw_write_step_2.png',
      '${_dir}waaw_write_step_3.png',
      '${_dir}waaw_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'و',
        exampleWord: 'عَمْرُو',
        exampleEmoji: '🧑',
        audioPath: '${_audio}waaw_trace_isolated.mp3',
        imagePath: '${_dir}waaw_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'و',
        exampleWord: 'وَجْه',
        exampleEmoji: '😊',
        audioPath: '${_coreAudio}waaw_pos_start.mp3',
        imagePath: '${_dir}waaw_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـو',
        exampleWord: 'صُنْدُوق',
        exampleEmoji: '📦',
        audioPath: '${_coreAudio}waaw_pos_middle.mp3',
        imagePath: '${_dir}waaw_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـو',
        exampleWord: 'طُيُور',
        exampleEmoji: '🐦',
        audioPath: '${_coreAudio}waaw_pos_end.mp3',
        imagePath: '${_dir}waaw_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}waaw_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'طُيُور', cardImagePath: '${_dir}waaw_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نُسُور', cardImagePath: '${_dir}waaw_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عُصْفُور', cardImagePath: '${_dir}waaw_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كَتْكُوت', cardImagePath: '${_dir}waaw_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}waaw_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'وَجْه', cardImagePath: '${_dir}waaw_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'وَلَد', cardImagePath: '${_dir}waaw_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُلُوك', cardImagePath: '${_dir}waaw_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'وَرْدَة', cardImagePath: '${_dir}waaw_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}waaw_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'لُحُوم', cardImagePath: '${_dir}waaw_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ثُوم', cardImagePath: '${_dir}waaw_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بُذُور', cardImagePath: '${_dir}waaw_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'دَوَاء', cardImagePath: '${_dir}waaw_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}waaw_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ضَوْء', cardImagePath: '${_dir}waaw_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عُطُور', cardImagePath: '${_dir}waaw_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَاوُوس', cardImagePath: '${_dir}waaw_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صُنْدُوق', cardImagePath: '${_dir}waaw_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}waaw_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/waaw/waaw_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/waaw/waaw_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/waaw/waaw_circus_prompt.mp3',
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
        word: 'وَجْه',
        imagePath: '${_gamesDir}fishing/waaw/waaw_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/waaw/waaw_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'وَجْه', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'رَجُل', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'يَد', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'وِسَام',
        imagePath: '${_gamesDir}fishing/waaw/waaw_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/waaw/waaw_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'مُهَنَّد', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'حَمْزَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'وِسَام', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'وُجُوه',
        imagePath: '${_gamesDir}fishing/waaw/waaw_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/waaw/waaw_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'رَأْس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'وُجُوه', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ظَهْر', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'حَوْض',
        imagePath: '${_gamesDir}fishing/waaw/waaw_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/waaw/waaw_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'طَبَق', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مَاء', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'حَوْض', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'وَجْه',
        imagePath: '${_gamesDir}beehive/waaw/waaw_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/waaw/waaw_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'وُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'وَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'وِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'وْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'وِسَام',
        imagePath: '${_gamesDir}beehive/waaw/waaw_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/waaw/waaw_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'وُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'وَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'وِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'وْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'طَاوُوس',
        imagePath: '${_gamesDir}beehive/waaw/waaw_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/waaw/waaw_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'وُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'وَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'وِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'وْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ضَوْء',
        imagePath: '${_gamesDir}beehive/waaw/waaw_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/waaw/waaw_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'وُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'وَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'وِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'وْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'حُوت',
        imagePath: '${_gamesDir}circus/waaw/waaw_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/waaw/waaw_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'تِمْسَاح', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'حُوت', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/waaw/waaw_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'طَاوُوس',
        imagePath: '${_gamesDir}circus/waaw/waaw_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/waaw/waaw_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'طَاوُوس', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/waaw/waaw_circus_2.mp3'),
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'كَتْكُوت',
        imagePath: '${_gamesDir}circus/waaw/waaw_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/waaw/waaw_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'كَتْكُوت', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/waaw/waaw_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'ثُوم',
        imagePath: '${_gamesDir}match/waaw/waaw_match_1.png',
        audioPath: '${_gamesAudio}match/waaw/waaw_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'خُبْز', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'ثُوم', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فُول', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'دَوَاء',
        imagePath: '${_gamesDir}match/waaw/waaw_match_2.png',
        audioPath: '${_gamesAudio}match/waaw/waaw_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'دَوَاء', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'غِذَاء', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'حَوْض', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'تُوت',
        imagePath: '${_gamesDir}match/waaw/waaw_match_3.png',
        audioPath: '${_gamesAudio}match/waaw/waaw_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'عِنَب', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'تُوت', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'طُيُور',
        imagePath: '${_gamesDir}match/waaw/waaw_match_4.png',
        audioPath: '${_gamesAudio}match/waaw/waaw_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'طُيُور', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'حُوت', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مُلُوك', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'دَوَاء',
        bgImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_word_1.png',
        introAudioPath: '${_audio}waaw_word_p3_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/waaw/waaw_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/waaw/waaw_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}waaw_word_p3_4.mp3',
        options: [
          GameZoneChoice(label: 'طِفْل', isCorrect: false),
          GameZoneChoice(label: 'بِنْت', isCorrect: false),
          GameZoneChoice(label: 'دَوَاء', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_1_slice_1.png', color: Color(0xFF00796B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_1_slice_2.png', color: Color(0xFF009688)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_1_slice_3.png', color: Color(0xFF4DB6AC)),
        ],
      ),
      ColoringRound(
        word: 'طَاوُوس',
        bgImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_word_2.png',
        introAudioPath: '${_audio}waaw_word_p4_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/waaw/waaw_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/waaw/waaw_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}waaw_word_p4_3.mp3',
        options: [
          GameZoneChoice(label: 'طَاوُوس', isCorrect: true),
          GameZoneChoice(label: 'أَسَد', isCorrect: false),
          GameZoneChoice(label: 'فَأْر', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'طَوِيل',
        bgImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/waaw/waaw_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/waaw/waaw_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/waaw/waaw_wrong_reveal_3.mp3',
        wordAudioPath: '${_gamesAudio}coloring/waaw/waaw_coloring_reveal_3.mp3',
        options: [
          GameZoneChoice(label: 'قَمْح', isCorrect: false),
          GameZoneChoice(label: 'خُبْز', isCorrect: false),
          GameZoneChoice(label: 'طَوِيل', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/waaw/waaw_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
