import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف اللام (ل) — الوحدة 23 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/laam/';
const String _audio = 'audio/lessons/laam/final/';
const String _soundsAudio = 'audio/lessons/laam/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest laamManifest = LetterUnitManifest(
  letter: 'ل',
  unitTitle: 'الوَحْدَةُ الثَّالِثَةُ وَالْعِشْرُونَ | حَرْفُ اللَّامِ (ل)',
  topBarColor: Color(0xFF00838F),
  highlightColor: Color(0xFFB2EBF2),
  mascotEmoji: '🍋',
  unitIndex: 23,
  nextLetter: 'م',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}laam_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ اللَّامِ (ل)',
      'أَنْطِقُ حَرْفَ اللَّامِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ اللَّامِ مَعَ الْمُدُودِ الثَّلَاثَةِ (لَا، لُو، لِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ اللَّامِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ اللَّامِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ اللَّبَنِ الْمُفِيدِ وَنَشِيدِ اللَّامِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ اللَّامِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}laam_cd_story_1.png',
        audioPath: '${_audio}laam_story_1.mp3',
        captionText: 'تَجْلِسُ الْأُسْرَةُ حَوْلَ مَائِدَةِ الْفَطُورِ وَتَتَنَاوَلُ اللَّبَنَ وَالْجُبْنَ.',
      ),
      StoryScene(
        imagePath: '${_dir}laam_cd_story_2.png',
        audioPath: '${_audio}laam_story_2.mp3',
        captionText: 'تَصْحُو مُبَكِّرًا وَتَضَعُ اللَّبَنَ عَلَى النَّارِ يَغْلِي.',
      ),
      StoryScene(
        imagePath: '${_dir}laam_cd_story_nasheed.png',
        audioPath: '${_audio}laam_nasheed.mp3',
        isNasheed: true,
        captionText: 'لَامٌ لَبَنٌ يُقَوِّي الْجِسْمَ .. نَشْرَبُ مِنْهُ نَحْيَا بِسَلَامْ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ل',
    items: [
      VowelItem(
        displayChar: 'لَ',
        fathaAudio: '${_vowelsAudio}laam_fatha.mp3',
        dammaAudio: '${_vowelsAudio}laam_damma.mp3',
        kasraAudio: '${_vowelsAudio}laam_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'لَ',
        exampleWord: 'شُعْلَة',
        exampleEmoji: '🔥',
        vowelAudio: '${_vowelsAudio}laam_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}laam_fatha_rule.mp3',
        wordAudio: '${_audio}laam_word_p1_2.mp3',
        slideImagePath: '${_dir}laam_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'لُ',
        exampleWord: 'لُحُوم',
        exampleEmoji: '🥩',
        vowelAudio: '${_vowelsAudio}laam_damma.mp3',
        fullRuleAudio: '${_soundsAudio}laam_damma_rule.mp3',
        wordAudio: '${_audio}laam_word_p1_1.mp3',
        slideImagePath: '${_dir}laam_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'لِ',
        exampleWord: 'مَلِك',
        exampleEmoji: '🤴',
        vowelAudio: '${_vowelsAudio}laam_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}laam_kasra_rule.mp3',
        wordAudio: '${_audio}laam_word_p1_4.mp3',
        slideImagePath: '${_dir}laam_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'لْ',
        exampleWord: 'ضِلْع',
        exampleEmoji: '🦴',
        vowelAudio: '${_vowelsAudio}laam_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}laam_sukoon_rule.mp3',
        wordAudio: '${_gamesAudio}beehive/laam/laam_beehive_4.mp3',
        slideImagePath: '${_dir}laam_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ل',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'لَا',
        audioPath: '${_maddAudio}laam_alif.mp3',
        imagePath: '${_dir}laam_madd_aa.png',
        exampleWord: 'صَلَاح',
        explanation: 'لَامٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: لَا',
        wordAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_1.mp3',
        accentColor: Color(0xFF00838F),
      ),
      MaddItem(
        displayChar: 'لُو',
        audioPath: '${_maddAudio}laam_waw.mp3',
        imagePath: '${_dir}laam_madd_uu.png',
        exampleWord: 'مُلُوك',
        explanation: 'لَامٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: لُو',
        wordAudioPath: '${_audio}laam_word_p2_1.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'لِي',
        audioPath: '${_maddAudio}laam_yaa.mp3',
        imagePath: '${_dir}laam_madd_ii.png',
        exampleWord: 'بَلِيغ',
        explanation: 'لَامٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: لِي',
        wordAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_3.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ل',
    audioIntroPath: '${_audio}laam_write_intro.mp3',
    stepImagePaths: [
      '${_dir}laam_write_step_1.png',
      '${_dir}laam_write_step_2.png',
      '${_dir}laam_write_step_3.png',
      '${_dir}laam_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ل',
        exampleWord: 'غَزَال',
        exampleEmoji: '🦌',
        audioPath: '${_audio}laam_trace_isolated.mp3',
        imagePath: '${_dir}laam_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'لـ',
        exampleWord: 'لَبَن',
        exampleEmoji: '🥛',
        audioPath: '${_coreAudio}laam_pos_start.mp3',
        imagePath: '${_dir}laam_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـلـ',
        exampleWord: 'شُعْلَة',
        exampleEmoji: '🔥',
        audioPath: '${_coreAudio}laam_pos_middle.mp3',
        imagePath: '${_dir}laam_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـل',
        exampleWord: 'فِيل',
        exampleEmoji: '🐘',
        audioPath: '${_coreAudio}laam_pos_end.mp3',
        imagePath: '${_dir}laam_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}laam_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'لُحُوم', cardImagePath: '${_dir}laam_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}laam_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شُعْلَة', cardImagePath: '${_dir}laam_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}laam_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'غَزَال', cardImagePath: '${_dir}laam_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}laam_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَلِك', cardImagePath: '${_dir}laam_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}laam_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}laam_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'مُلُوك', cardImagePath: '${_dir}laam_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}laam_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ظِلّ', cardImagePath: '${_dir}laam_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}laam_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'لَيْمُون', cardImagePath: '${_dir}laam_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}laam_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَحْلَة', cardImagePath: '${_dir}laam_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}laam_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}laam_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'نَخْلَة', cardImagePath: '${_dir}laam_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}laam_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَمْلَة', cardImagePath: '${_dir}laam_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}laam_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'لَبَن', cardImagePath: '${_dir}laam_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}laam_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَلَح', cardImagePath: '${_dir}laam_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}laam_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}laam_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قَلَم', cardImagePath: '${_dir}laam_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}laam_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فِيل', cardImagePath: '${_dir}laam_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}laam_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مِلْح', cardImagePath: '${_dir}laam_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}laam_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فُلْفُل', cardImagePath: '${_dir}laam_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}laam_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/laam/laam_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/laam/laam_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/laam/laam_circus_prompt.mp3',
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
        word: 'لُحُوم',
        imagePath: '${_gamesDir}fishing/laam/laam_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/laam/laam_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'لُحُوم', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'سَمَك', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'أَرُزّ', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'لَبَن',
        imagePath: '${_gamesDir}fishing/laam/laam_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/laam/laam_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'فَوَاكِه', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'عَصِير', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'لَبَن', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'بَلَح',
        imagePath: '${_gamesDir}fishing/laam/laam_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/laam/laam_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'تِين', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَلَح', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'غَزَال',
        imagePath: '${_gamesDir}fishing/laam/laam_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/laam/laam_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'غَزَال', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'شُعْلَة',
        imagePath: '${_gamesDir}beehive/laam/laam_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/laam/laam_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'لُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'لِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'لَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'لْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'لُحُوم',
        imagePath: '${_gamesDir}beehive/laam/laam_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/laam/laam_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'لُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'لِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'لَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'لْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مَلِك',
        imagePath: '${_gamesDir}beehive/laam/laam_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/laam/laam_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'لُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'لِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'لَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'لْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ضِلْع',
        imagePath: '${_gamesDir}beehive/laam/laam_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/laam/laam_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'لُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'لِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'لَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'لْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'شُعْلَة',
        imagePath: '${_gamesDir}circus/laam/laam_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/laam/laam_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'صُنْدُوق', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'فُسْتَان', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'شُعْلَة', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/laam/laam_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'نَحْلَة',
        imagePath: '${_gamesDir}circus/laam/laam_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/laam/laam_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'دَجَاجَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'نَحْلَة', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/laam/laam_circus_2.mp3'),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'فِيل',
        imagePath: '${_gamesDir}circus/laam/laam_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/laam/laam_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'فِيل', isCorrect: true, px: 137, py: 95, wordAudio: '${_gamesAudio}circus/laam/laam_circus_3.mp3'),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'قَلَم',
        imagePath: '${_gamesDir}match/laam/laam_match_1.png',
        audioPath: '${_gamesAudio}match/laam/laam_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'عَلَم', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'ظِلّ', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'قَلَم', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'غَزَال',
        imagePath: '${_gamesDir}match/laam/laam_match_2.png',
        audioPath: '${_gamesAudio}match/laam/laam_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'غَزَال', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فِيل', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'لَيْمُون',
        imagePath: '${_gamesDir}match/laam/laam_match_3.png',
        audioPath: '${_gamesAudio}match/laam/laam_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'لُحُوم', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'لَيْمُون', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'لَبَن', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مِلْح',
        imagePath: '${_gamesDir}match/laam/laam_match_4.png',
        audioPath: '${_gamesAudio}match/laam/laam_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'مِلْح', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فُول', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فُلْفُل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'صَلَاح',
        bgImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/laam/laam_coloring_word_1.png',
        introAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/laam/laam_wrong_reveal_1.mp3',
        wordAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_1.mp3',
        options: [
          GameZoneChoice(label: 'رَجُل', isCorrect: false),
          GameZoneChoice(label: 'أَمَل', isCorrect: false),
          GameZoneChoice(label: 'صَلَاح', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_1_slice_1.png', color: Color(0xFF00838F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_1_slice_2.png', color: Color(0xFF00ACC1)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_1_slice_3.png', color: Color(0xFF26C6DA)),
        ],
      ),
      ColoringRound(
        word: 'مُلُوك',
        bgImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/laam/laam_coloring_word_2.png',
        introAudioPath: '${_audio}laam_word_p2_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/laam/laam_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}laam_word_p2_1.mp3',
        options: [
          GameZoneChoice(label: 'مَلِك', isCorrect: false),
          GameZoneChoice(label: 'مُلُوك', isCorrect: true),
          GameZoneChoice(label: 'عَلَم', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'بَلِيغ',
        bgImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/laam/laam_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/laam/laam_wrong_reveal_3.mp3',
        wordAudioPath: '${_gamesAudio}coloring/laam/laam_coloring_reveal_3.mp3',
        options: [
          GameZoneChoice(label: 'بَلِيغ', isCorrect: true),
          GameZoneChoice(label: 'يَأْكُلُ', isCorrect: false),
          GameZoneChoice(label: 'يَغْسِلُ', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/laam/laam_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
