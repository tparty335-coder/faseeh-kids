import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الشين (ش) — الوحدة 13 ──────────────────────────────────────
// أصول أصلية 100% مستخرجة من أسطوانة فصيح: start, sto1..5, stosong, mov1..8, write1..5, ka1..4, fish1..4, bee1..4, cir1..3, words1..4, paint1..3
const String _dir = 'assets/images/lessons/sheen/';
const String _audio = 'audio/lessons/sheen/final/';
const String _soundsAudio = 'audio/lessons/sheen/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest sheenManifest = LetterUnitManifest(
  letter: 'ش',
  unitTitle: 'الوَحْدَةُ الثَّالِثَةَ عَشْرَةَ | حَرْفُ الشِّينِ (ش)',
  topBarColor: Color(0xFF00796B),
  highlightColor: Color(0xFFB2DFDB),
  mascotEmoji: '🌳',
  unitIndex: 13,
  nextLetter: 'ص',

  objectives: ObjectivesSpec(
    audioPath: 'audio/letters/core/sheen_name.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الشِّينِ (ش)',
      'أَنْطِقُ حَرْفَ الشِّينِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الشِّينِ مَعَ الْمُدُودِ الثَّلَاثَةِ (شَا، شُو، شِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الشِّينِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الشِّينِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ شَذَا وَالشَّجَرَةِ وَنَشِيدِ الشِّينِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الشِّينِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}sheen_cd_story_1.webp',
        audioPath: 'audio/letters/phrases/sheen_sentence.mp3',
        captionText: 'كَانَتْ لِشَذَا شَجَرَةٌ صَغِيرَةٌ تَرْعَاهَا بِالسُّقْيَا.',
      ),
      StoryScene(
        imagePath: '${_dir}sheen_cd_story_2.webp',
        audioPath: '${_audio}sheen_story_2.mp3',
        captionText: 'ثُمَّ انْقَطَعَتْ عَنْهَا فَتْرَةً طَوِيلَةً لِسَفَرِهَا مَعَ وَالِدِهَا.',
      ),
      StoryScene(
        imagePath: '${_dir}sheen_cd_story_3.webp',
        audioPath: '${_audio}sheen_story_3.mp3',
        captionText: 'ظَلَّتِ الشَّجَرَةُ تَبْكِي حَتَّى ذَبُلَتْ وَشَعَرَتْ أَنَّهَا أَوْشَكَتْ عَلَى الْهَلَاكِ.',
      ),
      StoryScene(
        imagePath: '${_dir}sheen_cd_story_4.webp',
        audioPath: '${_audio}sheen_story_4.mp3',
        captionText: 'وَوَجَدَتِ الشَّجَرَةُ قَدْ تَغَيَّرَ شَكْلُهَا مِنَ الْخُضْرَةِ إِلَى الصُّفْرَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}sheen_cd_story_5.webp',
        audioPath: '${_audio}sheen_story_5.mp3',
        captionText: 'وَأَسْرَعَتْ تَسْقِي الشَّجَرَةَ، شَكَرَتِ الشَّجَرَةُ شَذَا عَلَى مَا فَعَلَتْ.',
      ),
      StoryScene(
        imagePath: '${_dir}sheen_cd_story_nasheed.webp',
        audioPath: '${_audio}sheen_nasheed.mp3',
        isNasheed: true,
        captionText: 'شِينٌ شَجَرَةٌ خَضْرَاءُ .. فِيهَا ثَمَرٌ فِيهَا ضِيَاءُ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ش',
    items: [
      VowelItem(
        displayChar: 'شَ',
        fathaAudio: '${_vowelsAudio}sheen_fatha.mp3',
        dammaAudio: '${_vowelsAudio}sheen_damma.mp3',
        kasraAudio: '${_vowelsAudio}sheen_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'شَ',
        exampleWord: 'شَمْس',
        exampleEmoji: '☀️',
        vowelAudio: '${_vowelsAudio}sheen_fatha.mp3',
        fullRuleAudio: 'audio/letters/phrases/sheen_fatha_demo.mp3',
        wordAudio: 'audio/letters/words/sheen_word2.mp3',
        slideImagePath: '${_dir}sheen_vowel_fatha.webp',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'شُ',
        exampleWord: 'شُعْلَة',
        exampleEmoji: '🔥',
        vowelAudio: '${_vowelsAudio}sheen_damma.mp3',
        fullRuleAudio: 'audio/letters/phrases/sheen_damma_demo.mp3',
        wordAudio: 'audio/letters/words/sheen_word.mp3',
        slideImagePath: '${_dir}sheen_vowel_damma.webp',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'شِ',
        exampleWord: 'شِرَاع',
        exampleEmoji: '⛵',
        vowelAudio: '${_vowelsAudio}sheen_kasra.mp3',
        fullRuleAudio: 'audio/letters/phrases/sheen_kasra_demo.mp3',
        wordAudio: '${_audio}sheen_word_p2_3.mp3',
        slideImagePath: '${_dir}sheen_vowel_kasra.webp',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'شْ',
        exampleWord: 'عُشْب',
        exampleEmoji: '🌿',
        vowelAudio: '${_vowelsAudio}sheen_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}sheen_sukoon_rule.mp3',
        wordAudio: 'audio/lessons/ayn/final/ayn_word_p3_1.mp3',
        slideImagePath: '${_dir}sheen_vowel_sukoon.webp',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ش',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'شَا',
        audioPath: '${_maddAudio}sheen_alif.mp3',
        imagePath: '${_dir}sheen_madd_aa.webp',
        exampleWord: 'شَاكِر',
        explanation: 'شِينٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: شَا',
        wordAudioPath: '${_audio}sheen_word_p2_2.mp3',
        accentColor: Color(0xFFD84315),
      ),
      MaddItem(
        displayChar: 'شُو',
        audioPath: '${_maddAudio}sheen_waw.mp3',
        imagePath: '${_dir}sheen_madd_uu.webp',
        exampleWord: 'عَاشُور',
        explanation: 'شِينٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: شُو',
        wordAudioPath: '${_gamesAudio}coloring/sheen/sheen_word_2.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'شِي',
        audioPath: '${_maddAudio}sheen_yaa.mp3',
        imagePath: '${_dir}sheen_madd_ii.webp',
        exampleWord: 'مُشِيرَة',
        explanation: 'شِينٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: شِي',
        wordAudioPath: '${_audio}sheen_word_p3_2.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ش',
    audioIntroPath: 'audio/lessons/faa/final/faa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}sheen_write_step_1.webp',
      'assets/images/lessons/sheen/sheen_trace_start.webp',
      'assets/images/lessons/sheen/sheen_trace_middle.webp',
      'assets/images/lessons/sheen/sheen_trace_end.webp',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ش',
        exampleWord: 'دُشّ',
        exampleEmoji: '🚿',
        audioPath: 'audio/lessons/faa/final/faa_trace_isolated.mp3',
        imagePath: 'assets/images/lessons/sheen/sheen_write_step_1.webp',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'شـ',
        exampleWord: 'شَمْسِيَّة',
        exampleEmoji: '☂️',
        audioPath: '${_coreAudio}sheen_pos_start.mp3',
        imagePath: '${_dir}sheen_trace_start.webp',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـشـ',
        exampleWord: 'مِشْبَك',
        exampleEmoji: '📎',
        audioPath: '${_coreAudio}sheen_pos_middle.mp3',
        imagePath: '${_dir}sheen_trace_middle.webp',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـش',
        exampleWord: 'عُشّ',
        exampleEmoji: '🪺',
        audioPath: '${_coreAudio}sheen_pos_end.mp3',
        imagePath: '${_dir}sheen_trace_end.webp',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}sheen_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'شُعْلَة', cardImagePath: '${_dir}sheen_words_p1_card_1.webp', cardHeight: 474, audioPath: 'audio/letters/words/sheen_word.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَمْس', cardImagePath: '${_dir}sheen_words_p1_card_2.webp', cardHeight: 474, audioPath: 'audio/letters/words/sheen_word2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَجَرَة', cardImagePath: '${_dir}sheen_words_p1_card_3.webp', cardHeight: 474, audioPath: 'audio/letters/words/sheen_word3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'دُشّ', cardImagePath: '${_dir}sheen_words_p1_card_4.webp', cardHeight: 474, audioPath: 'audio/letters/words/sheen_word4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}sheen_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'شَمْسِيَّة', cardImagePath: '${_dir}sheen_words_p2_card_1.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَاكِر', cardImagePath: '${_dir}sheen_words_p2_card_2.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شِرَاع', cardImagePath: '${_dir}sheen_words_p2_card_3.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَاطِئ', cardImagePath: '${_dir}sheen_words_p2_card_4.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}sheen_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'شَمْعَة', cardImagePath: '${_dir}sheen_words_p3_card_1.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُشِيرَة', cardImagePath: '${_dir}sheen_words_p3_card_2.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَاة', cardImagePath: '${_dir}sheen_words_p3_card_3.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مِشْبَك', cardImagePath: '${_dir}sheen_words_p3_card_4.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}sheen_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'شُبَّاك', cardImagePath: '${_dir}sheen_words_p4_card_1.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عُشْب', cardImagePath: '${_dir}sheen_words_p4_card_2.webp', cardHeight: 474, audioPath: 'audio/lessons/ayn/final/ayn_word_p3_1.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'شَوْكَة', cardImagePath: '${_dir}sheen_words_p4_card_3.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عُشّ', cardImagePath: '${_dir}sheen_words_p4_card_4.webp', cardHeight: 474, audioPath: '${_audio}sheen_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: 'audio/letters/short_vowels/ha_fatha.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/sheen/sheen_fishing_prompt.mp3',
    fishingWrongAudio: 'audio/feedback/try_again.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/sheen/sheen_beehive_prompt.mp3',
    beehiveWrongAudio: 'audio/feedback/try_again.mp3',
    circusPromptAudio: '${_gamesAudio}circus/sheen/sheen_circus_prompt.mp3',
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
        word: 'شَجَرَة',
        imagePath: '${_gamesDir}fishing/sheen/sheen_fishing_round_1.webp',
        audioPath: 'audio/games/match/sheen/sheen_match_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        zones: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'وَرْدَة', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'عُشّ',
        imagePath: '${_gamesDir}fishing/sheen/sheen_fishing_round_2.webp',
        audioPath: 'audio/games/match/sheen/sheen_match_4.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        zones: [
          GameZoneChoice(label: 'كُوخ', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَيْت', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'عُشّ', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'مِشْمِش',
        imagePath: '${_gamesDir}fishing/sheen/sheen_fishing_round_3.webp',
        audioPath: '${_gamesAudio}fishing/sheen/sheen_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/smart.mp3',
        zones: [
          GameZoneChoice(label: 'عِنَب', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'مِشْمِش', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'تُفَّاح', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'شُبَّاك',
        imagePath: '${_gamesDir}fishing/sheen/sheen_fishing_round_4.webp',
        audioPath: 'audio/games/match/sheen/sheen_match_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        zones: [
          GameZoneChoice(label: 'سُلَّم', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَاب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'شُبَّاك', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'شَمْسِيَّة',
        imagePath: '${_gamesDir}beehive/sheen/sheen_beehive_round_1.webp',
        audioPath: 'audio/games/circus/sheen/sheen_circus_3.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cells: [
          GameZoneChoice(label: 'شُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'شَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'شِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'شْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'شِرَاع',
        imagePath: '${_gamesDir}beehive/sheen/sheen_beehive_round_2.webp',
        audioPath: 'audio/games/match/sheen/sheen_match_3.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        cells: [
          GameZoneChoice(label: 'شُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'شَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'شِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'شْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'شُعْلَة',
        imagePath: '${_gamesDir}beehive/sheen/sheen_beehive_round_3.webp',
        audioPath: '${_gamesAudio}beehive/sheen/sheen_beehive_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        cells: [
          GameZoneChoice(label: 'شُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'شَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'شِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'شْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'عُشْب',
        imagePath: '${_gamesDir}beehive/sheen/sheen_beehive_round_4.webp',
        audioPath: '${_gamesAudio}beehive/sheen/sheen_beehive_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cells: [
          GameZoneChoice(label: 'شُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'شَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'شِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'شْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'شَجَرَة',
        imagePath: '${_gamesDir}circus/sheen/sheen_circus_round_1.webp',
        audioPath: 'audio/games/match/sheen/sheen_match_2.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        zones: [
          GameZoneChoice(label: 'وَرْدَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'زَهْرَة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: true, px: 135, py: 373, wordAudio: 'audio/games/match/sheen/sheen_match_2.mp3'),
        ],
      ),
      CircusRound(
        word: 'شَمْعَة',
        imagePath: '${_gamesDir}circus/sheen/sheen_circus_round_2.webp',
        audioPath: '${_gamesAudio}circus/sheen/sheen_circus_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        zones: [
          GameZoneChoice(label: 'مِصْبَاح', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'شَمْعَة', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/sheen/sheen_circus_2.mp3'),
          GameZoneChoice(label: 'فَانُوس', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'شَمْسِيَّة',
        imagePath: '${_gamesDir}circus/sheen/sheen_circus_round_3.webp',
        audioPath: '${_gamesAudio}circus/sheen/sheen_circus_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        zones: [
          GameZoneChoice(label: 'كُرْسِي', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'طَاوِلَة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'شَمْسِيَّة', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/sheen/sheen_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'شُبَّاك',
        imagePath: '${_gamesDir}match/sheen/sheen_match_1.webp',
        audioPath: '${_gamesAudio}match/sheen/sheen_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cards: [
          GameZoneChoice(label: 'سُلَّم', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'شُبَّاك', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'بَاب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'شَجَرَة',
        imagePath: '${_gamesDir}match/sheen/sheen_match_2.webp',
        audioPath: '${_gamesAudio}match/sheen/sheen_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        cards: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'عُشْب', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'شَمْعَة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'شِرَاع',
        imagePath: '${_gamesDir}match/sheen/sheen_match_3.webp',
        audioPath: '${_gamesAudio}match/sheen/sheen_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        cards: [
          GameZoneChoice(label: 'سَفِينَة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'شَاطِئ', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'شِرَاع', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'عُشّ',
        imagePath: '${_gamesDir}match/sheen/sheen_match_4.webp',
        audioPath: '${_gamesAudio}match/sheen/sheen_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        cards: [
          GameZoneChoice(label: 'عُشّ', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'غُصْن', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'عِنَب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'شَاكِر',
        bgImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_word_1.webp',
        introAudioPath: '${_audio}sheen_word_p2_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/sheen/sheen_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/sheen/sheen_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}sheen_word_p2_2.mp3',
        options: [
          GameZoneChoice(label: 'عُشْب', isCorrect: false),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false),
          GameZoneChoice(label: 'شَاكِر', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_round_1_slice_1.webp', color: Color(0xFF00695C)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/sheen/sheen_coloring_round_1_slice_1.webp', color: Color(0xFF00897B)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/sheen/sheen_coloring_round_1_slice_1.webp', color: Color(0xFF26A69A)),
        ],
      ),
      ColoringRound(
        word: 'عَاشُور',
        bgImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_word_2.webp',
        introAudioPath: '${_gamesAudio}coloring/sheen/sheen_word_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/sheen/sheen_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/sheen/sheen_wrong_reveal_2.mp3',
        wordAudioPath: '${_gamesAudio}coloring/sheen/sheen_word_2.mp3',
        options: [
          GameZoneChoice(label: 'عَاشُور', isCorrect: true),
          GameZoneChoice(label: 'شَمْس', isCorrect: false),
          GameZoneChoice(label: 'شَمْعَة', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_round_2_slice_1.webp', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/sheen/sheen_coloring_round_2_slice_1.webp', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/sheen/sheen_coloring_round_2_slice_1.webp', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'مُشِيرَة',
        bgImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_word_3.webp',
        introAudioPath: '${_audio}sheen_word_p3_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/sheen/sheen_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/sheen/sheen_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}sheen_word_p3_2.mp3',
        options: [
          GameZoneChoice(label: 'مِشْمِش', isCorrect: false),
          GameZoneChoice(label: 'عُشّ', isCorrect: false),
          GameZoneChoice(label: 'مُشِيرَة', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/sheen/sheen_coloring_round_3_slice_1.webp', color: Color(0xFF6A1B9A)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/sheen/sheen_coloring_round_3_slice_1.webp', color: Color(0xFF8E24AA)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/sheen/sheen_coloring_round_3_slice_1.webp', color: Color(0xFFAB47BC)),
        ],
      ),
    ],
  ),
);
