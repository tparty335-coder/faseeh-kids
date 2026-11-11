import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الظاء (ظ) — الوحدة 17 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/dhaa/';
const String _audio = 'audio/lessons/dhaa/final/';
const String _soundsAudio = 'audio/lessons/dhaa/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest dhaaManifest = LetterUnitManifest(
  letter: 'ظ',
  unitTitle: 'الوَحْدَةُ السَّابِعَةَ عَشْرَةَ | حَرْفُ الظَّاءِ (ظ)',
  topBarColor: Color(0xFF4527A0),
  highlightColor: Color(0xFFD1C4E9),
  mascotEmoji: '✉️',
  unitIndex: 17,
  nextLetter: 'ع',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}dhaa_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الظَّاءِ (ظ)',
      'أَنْطِقُ حَرْفَ الظَّاءِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الظَّاءِ مَعَ الْمُدُودِ الثَّلَاثَةِ (ظَا، ظُو، ظِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الظَّاءِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الظَّاءِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ الْكَلْبِ وَالشَّجَرَةِ وَنَشِيدِ الظَّاءِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الظَّاءِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}dhaa_cd_story_1.png',
        audioPath: '${_audio}dhaa_story_1.mp3',
        captionText: 'كَانَ الْكَلْبُ يَلْهَثُ مِنْ شِدَّةِ الْحَرِّ وَالْعَطَشِ.',
      ),
      StoryScene(
        imagePath: '${_dir}dhaa_cd_story_2.png',
        audioPath: '${_audio}dhaa_story_2.mp3',
        captionText: 'أَخَذَ الْكَلْبُ يَبْحَثُ عَنِ الْمَاءِ هُنَا وَهُنَاكَ حَتَّى وَجَدَ الْمَاءَ، فَشَرِبَ حَتَّى ارْتَوَى.',
      ),
      StoryScene(
        imagePath: '${_dir}dhaa_cd_story_3.png',
        audioPath: '${_audio}dhaa_story_3.mp3',
        captionText: 'ذَهَبَ الْكَلْبُ إِلَى الشَّجَرَةِ لِيَسْتَظِلَّ بِظِلِّهَا، فَوَجَدَ عَظْمَةً تَحْتَ الشَّجَرَةِ فَأَكَلَهَا.',
      ),
      StoryScene(
        imagePath: '${_dir}dhaa_cd_story_4.png',
        audioPath: '${_audio}dhaa_story_4.mp3',
        captionText: 'نَامَ الْكَلْبُ تَحْتَ الشَّجَرَةِ حَتَّى حَلَّ الظَّلَامُ.',
      ),
      StoryScene(
        imagePath: '${_dir}dhaa_cd_story_nasheed.png',
        audioPath: '${_audio}dhaa_nasheed.mp3',
        isNasheed: true,
        captionText: 'ظَاءٌ ظَرْفٌ لِلرِّسَالَةِ .. يَحْمِلُ أَجْمَلَ الْعِبَارَاتِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ظ',
    items: [
      VowelItem(
        displayChar: 'ظَ',
        fathaAudio: '${_vowelsAudio}dhaa_dh_fatha.mp3',
        dammaAudio: '${_vowelsAudio}dhaa_dh_damma.mp3',
        kasraAudio: '${_vowelsAudio}dhaa_dh_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'ظَ',
        exampleWord: 'ظَرْف',
        exampleEmoji: '✉️',
        vowelAudio: '${_vowelsAudio}dhaa_dh_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}dhaa_fatha_rule.mp3',
        wordAudio: '${_audio}dhaa_word_p1_1.mp3',
        slideImagePath: '${_dir}dhaa_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'ظُ',
        exampleWord: 'يَنْظُرُ',
        exampleEmoji: '🔭',
        vowelAudio: '${_vowelsAudio}dhaa_dh_damma.mp3',
        fullRuleAudio: '${_soundsAudio}dhaa_damma_rule.mp3',
        wordAudio: '${_audio}dhaa_word_p3_3.mp3',
        slideImagePath: '${_dir}dhaa_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'ظِ',
        exampleWord: 'ظِلّ',
        exampleEmoji: '👤',
        vowelAudio: '${_vowelsAudio}dhaa_dh_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}dhaa_kasra_rule.mp3',
        wordAudio: '${_audio}dhaa_word_p1_4.mp3',
        slideImagePath: '${_dir}dhaa_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'ظْ',
        exampleWord: 'عَظْمَة',
        exampleEmoji: '🦴',
        vowelAudio: '${_vowelsAudio}dhaa_dh_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}dhaa_sukoon_rule.mp3',
        wordAudio: '${_audio}dhaa_word_p1_2.mp3',
        slideImagePath: '${_dir}dhaa_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ظ',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'ظَا',
        audioPath: '${_maddAudio}dhaa_dh_alif.mp3',
        imagePath: '${_dir}dhaa_madd_aa.png',
        exampleWord: 'ظَافِر',
        explanation: 'ظَاءٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: ظَا',
        wordAudioPath: '${_audio}dhaa_word_p4_1.mp3',
        accentColor: Color(0xFFD84315),
      ),
      MaddItem(
        displayChar: 'ظُو',
        audioPath: '${_maddAudio}dhaa_dh_waw.mp3',
        imagePath: '${_dir}dhaa_madd_uu.png',
        exampleWord: 'مَنْظُور',
        explanation: 'ظَاءٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: ظُو',
        wordAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_coloring_reveal_2.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'ظِي',
        audioPath: '${_maddAudio}dhaa_dh_yaa.mp3',
        imagePath: '${_dir}dhaa_madd_ii.png',
        exampleWord: 'نَظِيم',
        explanation: 'ظَاءٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: ظِي',
        wordAudioPath: '${_audio}dhaa_word_p4_4.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ظ',
    audioIntroPath: '${_audio}dhaa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}dhaa_write_step_1.png',
      '${_dir}dhaa_write_step_2.png',
      '${_dir}dhaa_write_step_3.png',
      '${_dir}dhaa_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ظ',
        exampleWord: 'ظَرْف',
        exampleEmoji: '✉️',
        audioPath: '${_audio}dhaa_trace_isolated.mp3',
        imagePath: '${_dir}dhaa_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'ظـ',
        exampleWord: 'ظَرْف',
        exampleEmoji: '✉️',
        audioPath: '${_coreAudio}dhaa_dh_pos_start.mp3',
        imagePath: '${_dir}dhaa_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـظـ',
        exampleWord: 'عَظْمَة',
        exampleEmoji: '🦴',
        audioPath: '${_coreAudio}dhaa_dh_pos_middle.mp3',
        imagePath: '${_dir}dhaa_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـظ',
        exampleWord: 'حَافِظ',
        exampleEmoji: '🧒',
        audioPath: '${_coreAudio}dhaa_dh_pos_end.mp3',
        imagePath: '${_dir}dhaa_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}dhaa_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ظَرْف', cardImagePath: '${_dir}dhaa_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'عَظْمَة', cardImagePath: '${_dir}dhaa_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'حَافِظ', cardImagePath: '${_dir}dhaa_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ظِلّ', cardImagePath: '${_dir}dhaa_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}dhaa_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ظَبْي', cardImagePath: '${_dir}dhaa_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ظَهْر', cardImagePath: '${_dir}dhaa_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُظَاهَرَة', cardImagePath: '${_dir}dhaa_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ظُفْر', cardImagePath: '${_dir}dhaa_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}dhaa_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ظَرِيف', cardImagePath: '${_dir}dhaa_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ظَلَام', cardImagePath: '${_dir}dhaa_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'يَنْظُرُ', cardImagePath: '${_dir}dhaa_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَظَّارَة', cardImagePath: '${_dir}dhaa_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}dhaa_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'ظَافِر', cardImagePath: '${_dir}dhaa_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَظِيف', cardImagePath: '${_dir}dhaa_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'يَسْتَيْقِظُ', cardImagePath: '${_dir}dhaa_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَظِيم', cardImagePath: '${_dir}dhaa_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}dhaa_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/dhaa/dhaa_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/dhaa/dhaa_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/dhaa/dhaa_circus_prompt.mp3',
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
        word: 'ظَبْي',
        imagePath: '${_gamesDir}fishing/dhaa/dhaa_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/dhaa/dhaa_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'ظَبْي', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'غَزَال', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ظَرْف',
        imagePath: '${_gamesDir}fishing/dhaa/dhaa_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/dhaa/dhaa_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'كِتَاب', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'كُرَّاسَة', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ظَرْف', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'عَظْمَة',
        imagePath: '${_gamesDir}fishing/dhaa/dhaa_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/dhaa/dhaa_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'رَأْس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'عَظْمَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'رِجْل', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'ظَهْر',
        imagePath: '${_gamesDir}fishing/dhaa/dhaa_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/dhaa/dhaa_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'ذِرَاع', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'بَطْن', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'ظَهْر', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'ظَرْف',
        imagePath: '${_gamesDir}beehive/dhaa/dhaa_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/dhaa/dhaa_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'ظُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ظَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'ظِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ظْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'ظِلّ',
        imagePath: '${_gamesDir}beehive/dhaa/dhaa_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/dhaa/dhaa_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'ظُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ظَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ظِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'ظْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'يَنْظُرُ',
        imagePath: '${_gamesDir}beehive/dhaa/dhaa_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/dhaa/dhaa_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'ظُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'ظَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ظِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ظْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'عَظْمَة',
        imagePath: '${_gamesDir}beehive/dhaa/dhaa_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/dhaa/dhaa_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'ظُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'ظَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'ظِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'ظْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'ظِلّ',
        imagePath: '${_gamesDir}circus/dhaa/dhaa_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/dhaa/dhaa_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'تُفَّاحَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'مَانْجُو', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'ظِلّ', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/dhaa/dhaa_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'ظَرْف',
        imagePath: '${_gamesDir}circus/dhaa/dhaa_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/dhaa/dhaa_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'كِتَاب', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'ظَرْف', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/dhaa/dhaa_circus_2.mp3'),
          GameZoneChoice(label: 'قَلَم', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'عَظْمَة',
        imagePath: '${_gamesDir}circus/dhaa/dhaa_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/dhaa/dhaa_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'نَمِر', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'عَظْمَة', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/dhaa/dhaa_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'عَظْمَة',
        imagePath: '${_gamesDir}match/dhaa/dhaa_match_1.png',
        audioPath: '${_gamesAudio}match/dhaa/dhaa_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'كَلْب', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'عَظْمَة', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'نَظَّارَة',
        imagePath: '${_gamesDir}match/dhaa/dhaa_match_2.png',
        audioPath: '${_gamesAudio}match/dhaa/dhaa_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'نَظَّارَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'سَيَّارَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مَرْكَب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ظَرْف',
        imagePath: '${_gamesDir}match/dhaa/dhaa_match_3.png',
        audioPath: '${_gamesAudio}match/dhaa/dhaa_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'طِفْل', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'قُطْن', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'ظَرْف', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ظَبْي',
        imagePath: '${_gamesDir}match/dhaa/dhaa_match_4.png',
        audioPath: '${_gamesAudio}match/dhaa/dhaa_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'ظَبْي', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'طَبَق', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'ظَافِر',
        bgImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_word_1.png',
        introAudioPath: '${_audio}dhaa_word_p4_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}dhaa_word_p4_1.mp3',
        options: [
          GameZoneChoice(label: 'رَجَب', isCorrect: false),
          GameZoneChoice(label: 'أَحْمَد', isCorrect: false),
          GameZoneChoice(label: 'ظَافِر', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_1_slice_1.png', color: Color(0xFF4527A0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_1_slice_2.png', color: Color(0xFF5E35B1)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_1_slice_3.png', color: Color(0xFF7E57C2)),
        ],
      ),
      ColoringRound(
        word: 'مَنْظُور',
        bgImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_coloring_reveal_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_wrong_reveal_2.mp3',
        wordAudioPath: '${_maddAudio}dhaa_dh_waw.mp3',
        options: [
          GameZoneChoice(label: 'مَنْظُور', isCorrect: true),
          GameZoneChoice(label: 'سَعْد', isCorrect: false),
          GameZoneChoice(label: 'مُحَمَّد', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'نَظِيم',
        bgImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_word_3.png',
        introAudioPath: '${_audio}dhaa_word_p4_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/dhaa/dhaa_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}dhaa_word_p4_4.mp3',
        options: [
          GameZoneChoice(label: 'فَهْد', isCorrect: false),
          GameZoneChoice(label: 'هِبَة', isCorrect: false),
          GameZoneChoice(label: 'نَظِيم', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_3_slice_1.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_3_slice_2.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/dhaa/dhaa_coloring_round_3_slice_3.png', color: Color(0xFF66BB6A)),
        ],
      ),
    ],
  ),
);
