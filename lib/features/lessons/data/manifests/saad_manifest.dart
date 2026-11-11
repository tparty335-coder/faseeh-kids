import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الصاد (ص) — الوحدة 14 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/saad/';
const String _audio = 'audio/lessons/saad/final/';
const String _soundsAudio = 'audio/lessons/saad/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest saadManifest = LetterUnitManifest(
  letter: 'ص',
  unitTitle: 'الوَحْدَةُ الرَّابِعَةَ عَشْرَةَ | حَرْفُ الصَّادِ (ص)',
  topBarColor: Color(0xFF5D4037),
  highlightColor: Color(0xFFD7CCC8),
  mascotEmoji: '🦅',
  unitIndex: 14,
  nextLetter: 'ض',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}saad_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الصَّادِ (ص)',
      'أَنْطِقُ حَرْفَ الصَّادِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الصَّادِ مَعَ الْمُدُودِ الثَّلَاثَةِ (صَا، صُو، صِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الصَّادِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الصَّادِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ الصَّقْرِ وَالصَّيَّادِ وَنَشِيدِ الصَّادِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الصَّادِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}saad_cd_story_1.png',
        audioPath: '${_audio}saad_story_1.mp3',
        captionText: 'كَانَ الصَّقْرُ يَطِيرُ عَالِيًا فِي الْهَوَاءِ.',
      ),
      StoryScene(
        imagePath: '${_dir}saad_cd_story_2.png',
        audioPath: '${_audio}saad_story_2.mp3',
        captionText: 'ثُمَّ اسْتَقَرَّ فَوْقَ غُصْنِ شَجَرَةٍ.',
      ),
      StoryScene(
        imagePath: '${_dir}saad_cd_story_3.png',
        audioPath: '${_audio}saad_story_3.mp3',
        captionText: 'وَإِذَا بِصَيَّادٍ مَاهِرٍ فِي الصَّبَاحِ الْبَاكِرِ يَصْطَادُ هَذَا الصَّقْرَ وَيَقَعُ فَرِيسَةً فِي شِبَاكِهِ.',
      ),
      StoryScene(
        imagePath: '${_dir}saad_cd_story_nasheed.png',
        audioPath: '${_audio}saad_nasheed.mp3',
        isNasheed: true,
        captionText: 'صَادٌ صَقْرٌ عَالِي الْهِمَّةِ .. يَحْلِقُ دَوْمًا فَوْقَ الْقِمَّةِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ص',
    items: [
      VowelItem(
        displayChar: 'صَ',
        fathaAudio: '${_vowelsAudio}saad_fatha.mp3',
        dammaAudio: '${_vowelsAudio}saad_damma.mp3',
        kasraAudio: '${_vowelsAudio}saad_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'صَ',
        exampleWord: 'صَقْر',
        exampleEmoji: '🦅',
        vowelAudio: '${_vowelsAudio}saad_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}saad_fatha_rule.mp3',
        wordAudio: '${_audio}saad_word_p1_1.mp3',
        slideImagePath: '${_dir}saad_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'صُ',
        exampleWord: 'صُنْدُوق',
        exampleEmoji: '📦',
        vowelAudio: '${_vowelsAudio}saad_damma.mp3',
        fullRuleAudio: '${_soundsAudio}saad_damma_rule.mp3',
        wordAudio: '${_audio}saad_word_p2_4.mp3',
        slideImagePath: '${_dir}saad_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'صِ',
        exampleWord: 'صِغَار',
        exampleEmoji: '🧒',
        vowelAudio: '${_vowelsAudio}saad_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}saad_kasra_rule.mp3',
        wordAudio: '${_audio}saad_word_p2_3.mp3',
        slideImagePath: '${_dir}saad_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'صْ',
        exampleWord: 'مِصْر',
        exampleEmoji: '🇪🇬',
        vowelAudio: '${_vowelsAudio}saad_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}saad_sukoon_rule.mp3',
        wordAudio: '${_audio}saad_word_p3_3.mp3',
        slideImagePath: '${_dir}saad_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ص',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'صَا',
        audioPath: '${_maddAudio}saad_alif.mp3',
        imagePath: '${_dir}saad_madd_aa.png',
        exampleWord: 'صَالِح',
        explanation: 'صَادٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: صَا',
        wordAudioPath: '${_audio}saad_word_p1_4.mp3',
        accentColor: Color(0xFFBF360C),
      ),
      MaddItem(
        displayChar: 'صُو',
        audioPath: '${_maddAudio}saad_waw.mp3',
        imagePath: '${_dir}saad_madd_uu.png',
        exampleWord: 'صُورَة',
        explanation: 'صَادٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: صُو',
        wordAudioPath: '${_audio}saad_word_p2_2.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'صِي',
        audioPath: '${_maddAudio}saad_yaa.mp3',
        imagePath: '${_dir}saad_madd_ii.png',
        exampleWord: 'عَصِير',
        explanation: 'صَادٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: صِي',
        wordAudioPath: '${_audio}saad_word_p2_1.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ص',
    audioIntroPath: '${_audio}saad_write_intro.mp3',
    stepImagePaths: [
      '${_dir}saad_write_step_1.png',
      '${_dir}saad_write_step_2.png',
      '${_dir}saad_write_step_3.png',
      '${_dir}saad_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ص',
        exampleWord: 'صَقْر',
        exampleEmoji: '🦅',
        audioPath: '${_audio}saad_trace_isolated.mp3',
        imagePath: '${_dir}saad_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'صـ',
        exampleWord: 'صُنْدُوق',
        exampleEmoji: '📦',
        audioPath: '${_coreAudio}saad_pos_start.mp3',
        imagePath: '${_dir}saad_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـصـ',
        exampleWord: 'عَصِير',
        exampleEmoji: '🧃',
        audioPath: '${_coreAudio}saad_pos_middle.mp3',
        imagePath: '${_dir}saad_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـص',
        exampleWord: 'قَفَص',
        exampleEmoji: '🐦',
        audioPath: '${_coreAudio}saad_pos_end.mp3',
        imagePath: '${_dir}saad_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}saad_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'صَقْر', cardImagePath: '${_dir}saad_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}saad_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صَيَّاد', cardImagePath: '${_dir}saad_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}saad_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَصَل', cardImagePath: '${_dir}saad_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}saad_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صَالِح', cardImagePath: '${_dir}saad_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}saad_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}saad_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'عَصِير', cardImagePath: '${_dir}saad_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}saad_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صُورَة', cardImagePath: '${_dir}saad_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}saad_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صِغَار', cardImagePath: '${_dir}saad_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}saad_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صُنْدُوق', cardImagePath: '${_dir}saad_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}saad_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}saad_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'عُصْفُور', cardImagePath: '${_dir}saad_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}saad_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'صَارُوخ', cardImagePath: '${_dir}saad_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}saad_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مِصْر', cardImagePath: '${_dir}saad_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}saad_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'حِصَان', cardImagePath: '${_dir}saad_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}saad_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}saad_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قَفَص', cardImagePath: '${_dir}saad_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}saad_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فَصْل', cardImagePath: '${_dir}saad_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}saad_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مِصْبَاح', cardImagePath: '${_dir}saad_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}saad_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غُصْن', cardImagePath: '${_dir}saad_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}saad_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/saad/saad_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/saad/saad_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/saad/saad_circus_prompt.mp3',
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
        word: 'صَقْر',
        imagePath: '${_gamesDir}fishing/saad/saad_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/saad/saad_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'صَقْر', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'قِطّ', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'فَأْر', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'غُصْن',
        imagePath: '${_gamesDir}fishing/saad/saad_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/saad/saad_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'غُصْن', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'مِصْر',
        imagePath: '${_gamesDir}fishing/saad/saad_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/saad/saad_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'الْإِمَارَات', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مِصْر', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'السُّعُودِيَّة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'صُنْدُوق',
        imagePath: '${_gamesDir}fishing/saad/saad_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/saad/saad_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'مِنْضَدَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'كُرْسِي', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'صَقْر',
        imagePath: '${_gamesDir}beehive/saad/saad_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/saad/saad_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'صُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'صَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'صِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'صْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'صِغَار',
        imagePath: '${_gamesDir}beehive/saad/saad_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/saad/saad_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'صُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'صَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'صِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'صْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'صُنْدُوق',
        imagePath: '${_gamesDir}beehive/saad/saad_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/saad/saad_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'صُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'صَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'صِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'صْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مِصْر',
        imagePath: '${_gamesDir}beehive/saad/saad_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/saad/saad_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'صُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'صَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'صِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'صْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'صَقْر',
        imagePath: '${_gamesDir}circus/saad/saad_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/saad/saad_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'سَمَكَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'ضِفْدَع', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'صَقْر', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/saad/saad_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'حِصَان',
        imagePath: '${_gamesDir}circus/saad/saad_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/saad/saad_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'حِصَان', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/saad/saad_circus_2.mp3'),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}circus/saad/saad_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/saad/saad_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/saad/saad_circus_3.mp3'),
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'قِرْد', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'عُصْفُور',
        imagePath: '${_gamesDir}match/saad/saad_match_1.png',
        audioPath: '${_gamesAudio}match/saad/saad_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'حَمَامَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'نَسْر', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'عُصْفُور', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مِصْر',
        imagePath: '${_gamesDir}match/saad/saad_match_2.png',
        audioPath: '${_gamesAudio}match/saad/saad_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'مِصْر', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'تُونُس', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'لِيبْيَا', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'فَصْل',
        imagePath: '${_gamesDir}match/saad/saad_match_3.png',
        audioPath: '${_gamesAudio}match/saad/saad_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'مَسْجِد', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فَصْل', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'حَدِيقَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'صَيَّاد',
        imagePath: '${_gamesDir}match/saad/saad_match_4.png',
        audioPath: '${_gamesAudio}match/saad/saad_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'صَيَّاد', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مُذِيع', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'صَالِح',
        bgImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/saad/saad_coloring_word_1.png',
        introAudioPath: '${_audio}saad_word_p1_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/saad/saad_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/saad/saad_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}saad_word_p1_4.mp3',
        options: [
          GameZoneChoice(label: 'صَقْر', isCorrect: false),
          GameZoneChoice(label: 'أَسَد', isCorrect: false),
          GameZoneChoice(label: 'صَالِح', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_1_slice_1.png', color: Color(0xFF5D4037)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_1_slice_2.png', color: Color(0xFF795548)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_1_slice_3.png', color: Color(0xFFA1887F)),
        ],
      ),
      ColoringRound(
        word: 'صُورَة',
        bgImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/saad/saad_coloring_word_2.png',
        introAudioPath: '${_audio}saad_word_p2_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/saad/saad_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/saad/saad_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}saad_word_p2_2.mp3',
        options: [
          GameZoneChoice(label: 'قَلَم', isCorrect: false),
          GameZoneChoice(label: 'صُورَة', isCorrect: true),
          GameZoneChoice(label: 'عَلَم', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'عَصِير',
        bgImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/saad/saad_coloring_word_3.png',
        introAudioPath: '${_audio}saad_word_p2_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/saad/saad_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/saad/saad_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}saad_word_p2_1.mp3',
        options: [
          GameZoneChoice(label: 'عَصِير', isCorrect: true),
          GameZoneChoice(label: 'قَصَب', isCorrect: false),
          GameZoneChoice(label: 'غُصْن', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_3_slice_1.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_3_slice_2.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/saad/saad_coloring_round_3_slice_3.png', color: Color(0xFF66BB6A)),
        ],
      ),
    ],
  ),
);
