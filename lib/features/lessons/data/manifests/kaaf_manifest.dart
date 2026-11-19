import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الكاف (ك) — الوحدة 22 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/kaaf/';
const String _audio = 'audio/lessons/kaaf/final/';
const String _soundsAudio = 'audio/lessons/kaaf/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest kaafManifest = LetterUnitManifest(
  letter: 'ك',
  unitTitle: 'الوَحْدَةُ الثَّانِيَةُ وَالْعِشْرُونَ | حَرْفُ الْكَافِ (ك)',
  topBarColor: Color(0xFFBF360C),
  highlightColor: Color(0xFFFFCCBC),
  mascotEmoji: '🐥',
  unitIndex: 22,
  nextLetter: 'ل',

  objectives: ObjectivesSpec(
    audioPath: 'audio/letters/core/kaaf_name.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْكَافِ (ك)',
      'أَنْطِقُ حَرْفَ الْكَافِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْكَافِ مَعَ الْمُدُودِ الثَّلَاثَةِ (كَا، كُو، كِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْكَافِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْكَافِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ كَرِيمٍ وَمَكْتَبَةِ الْكُتُبِ وَنَشِيدِ الْكَافِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْكَافِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}kaaf_cd_story_1.webp',
        audioPath: 'audio/letters/phrases/kaaf_sentence.mp3',
        captionText: 'كَرِيمٌ تِلْمِيذٌ يُحِبُّ الْقِرَاءَةَ وَدَائِمًا يَبْحَثُ فِي مَكْتَبَةِ أَبِيهِ عَنِ الْكُتُبِ وَالْقِصَصِ الْمُسَلِّيَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}kaaf_cd_story_2.webp',
        audioPath: '${_audio}kaaf_story_2.mp3',
        captionText: 'قَالَ كَرِيمٌ لِأَبِيهِ: عِنْدَمَا أَكْبَرُ أَتَمَنَّى أَنْ أَكُونَ مُؤَلِّفًا كَبِيرًا.',
      ),
      StoryScene(
        imagePath: '${_dir}kaaf_cd_story_3.webp',
        audioPath: '${_audio}kaaf_story_3.mp3',
        captionText: 'نَامَ كَرِيمٌ فِي اللَّيْلِ وَشَاهَدَ نَفْسَهُ فِي الْحُلْمِ دَاخِلَ مَكْتَبَةٍ كَبِيرَةٍ وَيُمْسِكُ كِتَابًا مَكْتُوبًا عَلَيْهِ «الْمُؤَلِّفُ الْكَبِيرُ: كَرِيم كَمَال».',
      ),
      StoryScene(
        imagePath: '${_dir}kaaf_cd_story_4.webp',
        audioPath: '${_audio}kaaf_story_4.mp3',
        captionText: 'وَعِنْدَمَا اسْتَيْقَظَ كَرِيمٌ حَكَى الْحُلْمَ لِأَبِيهِ، ابْتَسَمَ الْأَبُ وَقَالَ لَهُ: مِنَ الْيَوْمِ ابْدَأْ يَا كَرِيمُ فِي تَحْقِيقِ حُلْمِكَ.',
      ),
      StoryScene(
        imagePath: '${_dir}kaaf_cd_story_5.webp',
        audioPath: '${_audio}kaaf_story_5.mp3',
        captionText: 'وَعِنْدَمَا ذَهَبَ كَرِيمٌ إِلَى الْمَدْرَسَةِ دَخَلَ إِلَى مَكْتَبَةِ الْمَدْرَسَةِ وَأَخَذَ كِتَابًا لِيَقْرَأَهُ.',
      ),
      StoryScene(
        imagePath: '${_dir}kaaf_cd_story_nasheed.webp',
        audioPath: '${_audio}kaaf_nasheed.mp3',
        isNasheed: true,
        captionText: 'كَافٌ كِتَابٌ فِيهِ الْعِلْمُ .. يَقْرَؤُهُ كَرِيمٌ فَيَنْمُو 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ك',
    items: [
      VowelItem(
        displayChar: 'كَ',
        fathaAudio: '${_vowelsAudio}kaaf_fatha.mp3',
        dammaAudio: '${_vowelsAudio}kaaf_damma.mp3',
        kasraAudio: '${_vowelsAudio}kaaf_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'كَ',
        exampleWord: 'كَتْكُوت',
        exampleEmoji: '🐥',
        vowelAudio: '${_vowelsAudio}kaaf_fatha.mp3',
        fullRuleAudio: 'audio/letters/phrases/kaaf_fatha_demo.mp3',
        wordAudio: 'audio/letters/words/kaaf_word.mp3',
        slideImagePath: '${_dir}kaaf_vowel_fatha.webp',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'كُ',
        exampleWord: 'كُرْسِي',
        exampleEmoji: '🪑',
        vowelAudio: '${_vowelsAudio}kaaf_damma.mp3',
        fullRuleAudio: 'audio/letters/phrases/kaaf_damma_demo.mp3',
        wordAudio: 'audio/letters/words/kaaf_word2.mp3',
        slideImagePath: '${_dir}kaaf_vowel_damma.webp',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'كِ',
        exampleWord: 'كِتَاب',
        exampleEmoji: '📖',
        vowelAudio: '${_vowelsAudio}kaaf_kasra.mp3',
        fullRuleAudio: 'audio/letters/phrases/kaaf_kasra_demo.mp3',
        wordAudio: 'audio/letters/words/kaaf_word3.mp3',
        slideImagePath: '${_dir}kaaf_vowel_kasra.webp',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'كْ',
        exampleWord: 'يَكْتُبُ',
        exampleEmoji: '✍️',
        vowelAudio: '${_vowelsAudio}kaaf_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}kaaf_sukoon_rule.mp3',
        wordAudio: '${_gamesAudio}beehive/kaaf/kaaf_beehive_4.mp3',
        slideImagePath: '${_dir}kaaf_vowel_sukoon.webp',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ك',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'كَا',
        audioPath: '${_maddAudio}kaaf_alif.mp3',
        imagePath: '${_dir}kaaf_madd_aa.webp',
        exampleWord: 'كَارِم',
        explanation: 'كَافٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: كَا',
        wordAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_word_1.mp3',
        accentColor: Color(0xFFBF360C),
      ),
      MaddItem(
        displayChar: 'كُو',
        audioPath: '${_maddAudio}kaaf_waw.mp3',
        imagePath: '${_dir}kaaf_madd_uu.webp',
        exampleWord: 'كَتْكُوت',
        explanation: 'كَافٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: كُو',
        wordAudioPath: 'audio/letters/words/kaaf_word.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'كِي',
        audioPath: '${_maddAudio}kaaf_yaa.mp3',
        imagePath: '${_dir}kaaf_madd_ii.webp',
        exampleWord: 'سِكِّينَة',
        explanation: 'كَافٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: كِي',
        wordAudioPath: '${_audio}kaaf_word_p2_2.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ك',
    audioIntroPath: '${_audio}kaaf_write_intro.mp3',
    stepImagePaths: [
      '${_dir}kaaf_write_step_1.webp',
      'assets/images/lessons/kaaf/kaaf_trace_start.webp',
      'assets/images/lessons/kaaf/kaaf_trace_middle.webp',
      'assets/images/lessons/kaaf/kaaf_trace_end.webp',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ك',
        exampleWord: 'شُبَّاك',
        exampleEmoji: '🪟',
        audioPath: 'audio/lessons/faa/final/faa_trace_isolated.mp3',
        imagePath: 'assets/images/lessons/kaaf/kaaf_write_step_1.webp',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'كـ',
        exampleWord: 'كَتْكُوت',
        exampleEmoji: '🐥',
        audioPath: '${_coreAudio}kaaf_pos_start.mp3',
        imagePath: '${_dir}kaaf_trace_start.webp',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـكـ',
        exampleWord: 'سِكِّينَة',
        exampleEmoji: '🔪',
        audioPath: '${_coreAudio}kaaf_pos_middle.mp3',
        imagePath: '${_dir}kaaf_trace_middle.webp',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـك',
        exampleWord: 'مَلِك',
        exampleEmoji: '🤴',
        audioPath: '${_coreAudio}kaaf_pos_end.mp3',
        imagePath: '${_dir}kaaf_trace_end.webp',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}kaaf_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'كَتْكُوت', cardImagePath: '${_dir}kaaf_words_p1_card_1.webp', cardHeight: 474, audioPath: 'audio/letters/words/kaaf_word.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كُرْسِي', cardImagePath: '${_dir}kaaf_words_p1_card_2.webp', cardHeight: 474, audioPath: 'audio/letters/words/kaaf_word2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كِتَاب', cardImagePath: '${_dir}kaaf_words_p1_card_3.webp', cardHeight: 474, audioPath: 'audio/letters/words/kaaf_word3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كَلْب', cardImagePath: '${_dir}kaaf_words_p1_card_4.webp', cardHeight: 474, audioPath: 'audio/letters/words/kaaf_word4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}kaaf_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'مَلِك', cardImagePath: '${_dir}kaaf_words_p2_card_1.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'سِكِّينَة', cardImagePath: '${_dir}kaaf_words_p2_card_2.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'سُكَّر', cardImagePath: '${_dir}kaaf_words_p2_card_3.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فَاكِهَة', cardImagePath: '${_dir}kaaf_words_p2_card_4.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}kaaf_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'كُمَّثْرَى', cardImagePath: '${_dir}kaaf_words_p3_card_1.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَرْكَب', cardImagePath: '${_dir}kaaf_words_p3_card_2.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مِكْوَاة', cardImagePath: '${_dir}kaaf_words_p3_card_3.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شُبَّاك', cardImagePath: '${_dir}kaaf_words_p3_card_4.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}kaaf_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'كَعْكَة', cardImagePath: '${_dir}kaaf_words_p4_card_1.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كَأْس', cardImagePath: '${_dir}kaaf_words_p4_card_2.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'كُوب', cardImagePath: '${_dir}kaaf_words_p4_card_3.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَوْكَة', cardImagePath: '${_dir}kaaf_words_p4_card_4.webp', cardHeight: 474, audioPath: '${_audio}kaaf_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: 'audio/letters/short_vowels/ha_fatha.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/kaaf/kaaf_fishing_prompt.mp3',
    fishingWrongAudio: 'audio/feedback/try_again.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/kaaf/kaaf_beehive_prompt.mp3',
    beehiveWrongAudio: 'audio/feedback/try_again.mp3',
    circusPromptAudio: '${_gamesAudio}circus/kaaf/kaaf_circus_prompt.mp3',
    circusWrongAudio: 'audio/feedback/try_again.mp3',
    wordsMatchPromptAudio: 'audio/instructions/words_drag_instruction.mp3',
    wordsMatchWrongAudio: 'audio/feedback/try_again.mp3',
    coloringIntroAudio: 'audio/instructions/alif_paint_intro.mp3',
    coloringStep1Audio: 'audio/instructions/alif_paint_explain.mp3',
    coloringStep2Audio: '${_gamesAudio}coloring/2_qu3.mp3',
    coloringWrongAudio: '${_gamesAudio}coloring/5_al23.mp3',
    praiseFinishAudio: 'audio/feedback/correct.mp3',
    fishing: [
      FishingRound(
        word: 'كَتْكُوت',
        imagePath: '${_gamesDir}fishing/kaaf/kaaf_fishing_round_1.webp',
        audioPath: 'audio/games/circus/kaaf/kaaf_circus_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        zones: [
          GameZoneChoice(label: 'كَتْكُوت', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'كُرْسِي',
        imagePath: '${_gamesDir}fishing/kaaf/kaaf_fishing_round_2.webp',
        audioPath: '${_gamesAudio}fishing/kaaf/kaaf_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        zones: [
          GameZoneChoice(label: 'مَطْبَخ', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَاب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'كُرْسِي', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'سَمَك',
        imagePath: '${_gamesDir}fishing/kaaf/kaaf_fishing_round_3.webp',
        audioPath: 'audio/games/match/kaaf/kaaf_match_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/smart.mp3',
        zones: [
          GameZoneChoice(label: 'لَحْم', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'سَمَك', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'حَمَام', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'يَأْكُلُ',
        imagePath: '${_gamesDir}fishing/kaaf/kaaf_fishing_round_4.webp',
        audioPath: '${_gamesAudio}fishing/kaaf/kaaf_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        zones: [
          GameZoneChoice(label: 'يَلْعَبُ', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'يَشْرَبُ', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'يَأْكُلُ', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'كَتْكُوت',
        imagePath: '${_gamesDir}beehive/kaaf/kaaf_beehive_round_1.webp',
        audioPath: '${_gamesAudio}beehive/kaaf/kaaf_beehive_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cells: [
          GameZoneChoice(label: 'كُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'كِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'كَ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'كْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'كُرْسِي',
        imagePath: '${_gamesDir}beehive/kaaf/kaaf_beehive_round_2.webp',
        audioPath: '${_gamesAudio}beehive/kaaf/kaaf_beehive_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        cells: [
          GameZoneChoice(label: 'كُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'كِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'كَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'كْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'كِتَاب',
        imagePath: '${_gamesDir}beehive/kaaf/kaaf_beehive_round_3.webp',
        audioPath: '${_gamesAudio}beehive/kaaf/kaaf_beehive_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        cells: [
          GameZoneChoice(label: 'كُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'كِ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'كَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'كْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'يَكْتُبُ',
        imagePath: '${_gamesDir}beehive/kaaf/kaaf_beehive_round_4.webp',
        audioPath: '${_gamesAudio}beehive/kaaf/kaaf_beehive_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cells: [
          GameZoneChoice(label: 'كُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'كِ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'كَ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'كْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'كَلْب',
        imagePath: '${_gamesDir}circus/kaaf/kaaf_circus_round_1.webp',
        audioPath: 'audio/games/match/kaaf/kaaf_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        zones: [
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'بِئْر', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'كَلْب', isCorrect: true, px: 135, py: 373, wordAudio: 'audio/games/match/kaaf/kaaf_match_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'كَتْكُوت',
        imagePath: '${_gamesDir}circus/kaaf/kaaf_circus_round_2.webp',
        audioPath: '${_gamesAudio}circus/kaaf/kaaf_circus_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        zones: [
          GameZoneChoice(label: 'نَحْلَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'كَتْكُوت', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/kaaf/kaaf_circus_2.mp3'),
          GameZoneChoice(label: 'دُبّ', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'سِكِّينَة',
        imagePath: '${_gamesDir}circus/kaaf/kaaf_circus_round_3.webp',
        audioPath: 'audio/games/match/kaaf/kaaf_match_2.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        zones: [
          GameZoneChoice(label: 'سِكِّينَة', isCorrect: true, px: 137, py: 95, wordAudio: 'audio/games/match/kaaf/kaaf_match_2.mp3'),
          GameZoneChoice(label: 'تَاج', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'جَرَّار', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'كَلْب',
        imagePath: '${_gamesDir}match/kaaf/kaaf_match_1.webp',
        audioPath: '${_gamesAudio}match/kaaf/kaaf_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cards: [
          GameZoneChoice(label: 'سَمَك', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'بَقَرَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'كَلْب', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'سِكِّينَة',
        imagePath: '${_gamesDir}match/kaaf/kaaf_match_2.webp',
        audioPath: '${_gamesAudio}match/kaaf/kaaf_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        cards: [
          GameZoneChoice(label: 'سِكِّينَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'شَوْكَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'كُوب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'سَمَك',
        imagePath: '${_gamesDir}match/kaaf/kaaf_match_3.webp',
        audioPath: '${_gamesAudio}match/kaaf/kaaf_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        cards: [
          GameZoneChoice(label: 'شَبَكَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'سَمَك', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مَرْكَب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'مِكْوَاة',
        imagePath: '${_gamesDir}match/kaaf/kaaf_match_4.webp',
        audioPath: '${_gamesAudio}match/kaaf/kaaf_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cards: [
          GameZoneChoice(label: 'مِكْوَاة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'مِكْنَسَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'كُرْسِي', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'كَارِم',
        bgImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_word_1.webp',
        introAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_word_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_wrong_reveal_1.mp3',
        wordAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_word_1.mp3',
        options: [
          GameZoneChoice(label: 'سَعْد', isCorrect: false),
          GameZoneChoice(label: 'رَحْمَة', isCorrect: false),
          GameZoneChoice(label: 'كَارِم', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_round_1_slice_1.webp', color: Color(0xFFBF360C)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/kaaf/kaaf_coloring_round_1_slice_1.webp', color: Color(0xFFE64A19)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/kaaf/kaaf_coloring_round_1_slice_1.webp', color: Color(0xFFFF7043)),
        ],
      ),
      ColoringRound(
        word: 'كَتْكُوت',
        bgImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_word_2.webp',
        introAudioPath: 'audio/letters/words/kaaf_word.mp3',
        revealAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_wrong_reveal_2.mp3',
        wordAudioPath: 'audio/letters/words/kaaf_word.mp3',
        options: [
          GameZoneChoice(label: 'بَطَّة', isCorrect: false),
          GameZoneChoice(label: 'كَتْكُوت', isCorrect: true),
          GameZoneChoice(label: 'قِرْد', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_round_2_slice_1.webp', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/kaaf/kaaf_coloring_round_2_slice_1.webp', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/kaaf/kaaf_coloring_round_2_slice_1.webp', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'سِكِّينَة',
        bgImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_word_3.webp',
        introAudioPath: '${_audio}kaaf_word_p2_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/kaaf/kaaf_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}kaaf_word_p2_2.mp3',
        options: [
          GameZoneChoice(label: 'سِكِّينَة', isCorrect: true),
          GameZoneChoice(label: 'طَبَق', isCorrect: false),
          GameZoneChoice(label: 'بَصَل', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kaaf/kaaf_coloring_round_3_slice_1.webp', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/kaaf/kaaf_coloring_round_3_slice_1.webp', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/kaaf/kaaf_coloring_round_3_slice_1.webp', color: Color(0xFF66BB6A)),
        ],
      ),
    ],
  ),
);
