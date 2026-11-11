import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الميم (م) — الوحدة 24 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/meem/';
const String _audio = 'audio/lessons/meem/final/';
const String _soundsAudio = 'audio/lessons/meem/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest meemManifest = LetterUnitManifest(
  letter: 'م',
  unitTitle: 'الوَحْدَةُ الرَّابِعَةُ وَالْعِشْرُونَ | حَرْفُ الْمِيمِ (م)',
  topBarColor: Color(0xFFF9A825),
  highlightColor: Color(0xFFFFF9C4),
  mascotEmoji: '🍌',
  unitIndex: 24,
  nextLetter: 'ن',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}meem_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْمِيمِ (م)',
      'أَنْطِقُ حَرْفَ الْمِيمِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْمِيمِ مَعَ الْمُدُودِ الثَّلَاثَةِ (مَا، مُو، مِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْمِيمِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْمِيمِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ مَرْوَانَ وَالْمَوْزِ وَنَشِيدِ الْمِيمِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْمِيمِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}meem_cd_story_1.png',
        audioPath: '${_audio}meem_story_1.mp3',
        captionText: 'مَرْوَانُ طِفْلٌ يُحِبُّ الْمَوْزَ.',
      ),
      StoryScene(
        imagePath: '${_dir}meem_cd_story_2.png',
        audioPath: '${_audio}meem_story_2.mp3',
        captionText: 'وَفِي يَوْمٍ مِنَ الْأَيَّامِ اشْتَرَتْ أُمُّهُ مَوْزًا لَهُ وَلِإِخْوَتِهِ.',
      ),
      StoryScene(
        imagePath: '${_dir}meem_cd_story_3.png',
        audioPath: '${_audio}meem_story_3.mp3',
        captionText: 'أَكَلَ مَرْوَانُ الْكَثِيرَ مِنَ الْمَوْزِ.',
      ),
      StoryScene(
        imagePath: '${_dir}meem_cd_story_4.png',
        audioPath: '${_audio}meem_story_4.mp3',
        captionText: 'أَكَلْتُ الْكَثِيرَ مِنَ الْمَوْزِ .. فَأَنَا أُحِبُّ الْمَوْزَ، فَشَعَرَ بِأَلَمٍ فِي بَطْنِهِ.',
      ),
      StoryScene(
        imagePath: '${_dir}meem_cd_story_5.png',
        audioPath: '${_audio}meem_story_5.mp3',
        captionText: 'أَسْرَعَتِ الْأُمُّ وَأَحْضَرَتِ الطَّبِيبَ وَأَعْطَاهُ الدَّوَاءَ.',
      ),
      StoryScene(
        imagePath: '${_dir}meem_cd_story_6.png',
        audioPath: '${_audio}meem_story_6.mp3',
        captionText: 'يَجِبُ عَلَيْنَا الِاعْتِدَالُ فِي الطَّعَامِ وَلَا نُسْرِفَ فِي أَكْلِ مَا نُحِبُّ.',
      ),
      StoryScene(
        imagePath: '${_dir}meem_cd_story_nasheed.png',
        audioPath: '${_audio}meem_nasheed.mp3',
        isNasheed: true,
        captionText: 'مِيمٌ مَوْزٌ طَعْمٌ حُلْوٌ .. نَأْكُلُ مِنْهُ وَنَحْنُ نَنْمُو 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'م',
    items: [
      VowelItem(
        displayChar: 'مَ',
        fathaAudio: '${_vowelsAudio}meem_fatha.mp3',
        dammaAudio: '${_vowelsAudio}meem_damma.mp3',
        kasraAudio: '${_vowelsAudio}meem_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'مَ',
        exampleWord: 'مَلِك',
        exampleEmoji: '🤴',
        vowelAudio: '${_vowelsAudio}meem_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}meem_fatha_rule.mp3',
        wordAudio: '${_audio}meem_word_p2_4.mp3',
        slideImagePath: '${_dir}meem_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'مُ',
        exampleWord: 'مُذِيع',
        exampleEmoji: '🎙️',
        vowelAudio: '${_vowelsAudio}meem_damma.mp3',
        fullRuleAudio: '${_soundsAudio}meem_damma_rule.mp3',
        wordAudio: '${_audio}meem_word_p2_2.mp3',
        slideImagePath: '${_dir}meem_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'مِ',
        exampleWord: 'مِصْر',
        exampleEmoji: '🇪🇬',
        vowelAudio: '${_vowelsAudio}meem_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}meem_kasra_rule.mp3',
        wordAudio: '${_audio}meem_word_p3_1.mp3',
        slideImagePath: '${_dir}meem_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'مْ',
        exampleWord: 'شَمْس',
        exampleEmoji: '☀️',
        vowelAudio: '${_vowelsAudio}meem_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}meem_sukoon_rule.mp3',
        wordAudio: '${_audio}meem_word_p3_2.mp3',
        slideImagePath: '${_dir}meem_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'م',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'مَا',
        audioPath: '${_maddAudio}meem_alif.mp3',
        imagePath: '${_dir}meem_madd_aa.png',
        exampleWord: 'آمَال',
        explanation: 'مِيمٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: مَا',
        wordAudioPath: '${_soundsAudio}meem_madd_aa.mp3',
        accentColor: Color(0xFFF9A825),
      ),
      MaddItem(
        displayChar: 'مُو',
        audioPath: '${_maddAudio}meem_waw.mp3',
        imagePath: '${_dir}meem_madd_uu.png',
        exampleWord: 'مَحْمُود',
        explanation: 'مِيمٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: مُو',
        wordAudioPath: '${_soundsAudio}meem_madd_uu.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'مِي',
        audioPath: '${_maddAudio}meem_yaa.mp3',
        imagePath: '${_dir}meem_madd_ii.png',
        exampleWord: 'سَمِير',
        explanation: 'مِيمٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: مِي',
        wordAudioPath: '${_gamesAudio}coloring/meem/meem_coloring_reveal_3.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'م',
    audioIntroPath: '${_audio}meem_write_intro.mp3',
    stepImagePaths: [
      '${_dir}meem_write_step_1.png',
      '${_dir}meem_write_step_2.png',
      '${_dir}meem_write_step_3.png',
      '${_dir}meem_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'م',
        exampleWord: 'ثُوم',
        exampleEmoji: '🧄',
        audioPath: '${_audio}meem_trace_isolated.mp3',
        imagePath: '${_dir}meem_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'مـ',
        exampleWord: 'مَوْز',
        exampleEmoji: '🍌',
        audioPath: '${_coreAudio}meem_pos_start.mp3',
        imagePath: '${_dir}meem_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـمـ',
        exampleWord: 'عَظْمَة',
        exampleEmoji: '🦴',
        audioPath: '${_coreAudio}meem_pos_middle.mp3',
        imagePath: '${_dir}meem_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـم',
        exampleWord: 'قَلَم',
        exampleEmoji: '✏️',
        audioPath: '${_coreAudio}meem_pos_end.mp3',
        imagePath: '${_dir}meem_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}meem_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'لَيْمُون', cardImagePath: '${_dir}meem_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}meem_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'رُمَّان', cardImagePath: '${_dir}meem_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}meem_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَوْز', cardImagePath: '${_dir}meem_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}meem_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ثُوم', cardImagePath: '${_dir}meem_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}meem_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}meem_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'مُهَنْدِس', cardImagePath: '${_dir}meem_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}meem_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُذِيع', cardImagePath: '${_dir}meem_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}meem_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُعَلِّم', cardImagePath: '${_dir}meem_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}meem_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَلِك', cardImagePath: '${_dir}meem_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}meem_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}meem_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'مِصْر', cardImagePath: '${_dir}meem_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}meem_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَمْس', cardImagePath: '${_dir}meem_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}meem_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَلَم', cardImagePath: '${_dir}meem_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}meem_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قَمَر', cardImagePath: '${_dir}meem_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}meem_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}meem_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'مَزْرَعَة', cardImagePath: '${_dir}meem_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}meem_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'لُحُوم', cardImagePath: '${_dir}meem_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}meem_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قَلَم', cardImagePath: '${_dir}meem_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}meem_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَظْمَة', cardImagePath: '${_dir}meem_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}meem_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/meem/meem_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/meem/meem_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/meem/meem_circus_prompt.mp3',
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
        word: 'عَظْمَة',
        imagePath: '${_gamesDir}fishing/meem/meem_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/meem/meem_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'عَظْمَة', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'وَلَد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'يَد', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ثُوم',
        imagePath: '${_gamesDir}fishing/meem/meem_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/meem/meem_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'جَزَر', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَصَل', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ثُوم', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'مَرْيَم',
        imagePath: '${_gamesDir}fishing/meem/meem_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/meem/meem_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'سَارَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مَرْيَم', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'إِسْرَاء', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'لَيْمُون',
        imagePath: '${_gamesDir}fishing/meem/meem_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/meem/meem_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'فَرَاوِلَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'لَيْمُون', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'مَزْرَعَة',
        imagePath: '${_gamesDir}beehive/meem/meem_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/meem/meem_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'مُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'مَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'مِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'مْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مِصْر',
        imagePath: '${_gamesDir}beehive/meem/meem_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/meem/meem_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'مُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'مَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'مِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'مْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'مُذِيع',
        imagePath: '${_gamesDir}beehive/meem/meem_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/meem/meem_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'مُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'مَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'مِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'مْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'شَمْس',
        imagePath: '${_gamesDir}beehive/meem/meem_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/meem/meem_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'مُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'مَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'مِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'مْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}circus/meem/meem_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/meem/meem_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'فَلَّاح', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/meem/meem_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'شَمْس',
        imagePath: '${_gamesDir}circus/meem/meem_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/meem/meem_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'شَمْس', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/meem/meem_circus_2.mp3'),
          GameZoneChoice(label: 'عُصْفُور', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'لَيْمُون',
        imagePath: '${_gamesDir}circus/meem/meem_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/meem/meem_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'فَرَاوِلَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'لَيْمُون', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/meem/meem_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'قَلَم',
        imagePath: '${_gamesDir}match/meem/meem_match_1.png',
        audioPath: '${_gamesAudio}match/meem/meem_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'مِصْر', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'قَلَم', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'عَلَم', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'عَظْمَة',
        imagePath: '${_gamesDir}match/meem/meem_match_2.png',
        audioPath: '${_gamesAudio}match/meem/meem_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'عَظْمَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'وَرْدَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مُعَلِّم',
        imagePath: '${_gamesDir}match/meem/meem_match_3.png',
        audioPath: '${_gamesAudio}match/meem/meem_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'مُحَامِي', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مُذِيع', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مُعَلِّم', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'لَيْمُون',
        imagePath: '${_gamesDir}match/meem/meem_match_4.png',
        audioPath: '${_gamesAudio}match/meem/meem_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'لَيْمُون', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'خَوْخ', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'رُمَّان',
        bgImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/meem/meem_coloring_word_1.png',
        introAudioPath: '${_audio}meem_word_p1_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/meem/meem_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/meem/meem_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}meem_word_p1_2.mp3',
        options: [
          GameZoneChoice(label: 'تَمْر', isCorrect: false),
          GameZoneChoice(label: 'نَمْلَة', isCorrect: false),
          GameZoneChoice(label: 'رُمَّان', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_1_slice_1.png', color: Color(0xFFC62828)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_1_slice_2.png', color: Color(0xFFE53935)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_1_slice_3.png', color: Color(0xFFEF5350)),
        ],
      ),
      ColoringRound(
        word: 'لَيْمُون',
        bgImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/meem/meem_coloring_word_2.png',
        introAudioPath: '${_audio}meem_word_p1_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/meem/meem_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/meem/meem_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}meem_word_p1_1.mp3',
        options: [
          GameZoneChoice(label: 'لَيْمُون', isCorrect: true),
          GameZoneChoice(label: 'مِشْمِش', isCorrect: false),
          GameZoneChoice(label: 'تَمْر', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_2_slice_1.png', color: Color(0xFFF9A825)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_2_slice_2.png', color: Color(0xFFFBC02D)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_2_slice_3.png', color: Color(0xFFFDD835)),
        ],
      ),
      ColoringRound(
        word: 'سَمِير',
        bgImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/meem/meem_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/meem/meem_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/meem/meem_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/meem/meem_wrong_reveal_3.mp3',
        wordAudioPath: '${_gamesAudio}coloring/meem/meem_coloring_reveal_3.mp3',
        options: [
          GameZoneChoice(label: 'عَلَم', isCorrect: false),
          GameZoneChoice(label: 'مِصْر', isCorrect: false),
          GameZoneChoice(label: 'سَمِير', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_3_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_3_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/meem/meem_coloring_round_3_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
    ],
  ),
);
