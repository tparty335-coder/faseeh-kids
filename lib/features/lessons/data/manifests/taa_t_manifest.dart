import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الطاء (ط) — الوحدة 16 ──────────────────────────────────────
const String _dir = 'assets/images/lessons/taa_t/';
const String _audio = 'audio/lessons/taa_t/final/';
const String _soundsAudio = 'audio/lessons/taa_t/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest taaTManifest = LetterUnitManifest(
  letter: 'ط',
  unitTitle: 'الوَحْدَةُ السَّادِسَةَ عَشْرَةَ | حَرْفُ الطَّاءِ (ط)',
  topBarColor: Color(0xFF0277BD),
  highlightColor: Color(0xFFB3E5FC),
  mascotEmoji: '✈️',
  unitIndex: 16,
  nextLetter: 'ظ',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}taa_t_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الطَّاءِ (ط)',
      'أَنْطِقُ حَرْفَ الطَّاءِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الطَّاءِ مَعَ الْمُدُودِ الثَّلَاثَةِ (طَا، طُو، طِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الطَّاءِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الطَّاءِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ طَارِقٍ فِي حَقْلِ الْقُطْنِ وَنَشِيدِ الطَّاءِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الطَّاءِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}taa_t_cd_story_1.png',
        audioPath: '${_audio}taa_t_story_1.mp3',
        captionText: 'حَقْلُ الْقُطْنِ الْأَبْيَضُ الْجَمِيلُ فِي الرِّيفِ.',
      ),
      StoryScene(
        imagePath: '${_dir}taa_t_cd_story_2.png',
        audioPath: '${_audio}taa_t_story_2.mp3',
        captionText: 'كَانَ طَارِقٌ فِي زِيَارَةٍ إِلَى حَقْلِ عَمِّهِ فَشَاهَدَ هَذَا الْمَنْظَرَ.',
      ),
      StoryScene(
        imagePath: '${_dir}taa_t_cd_story_3.png',
        audioPath: '${_audio}taa_t_story_3.mp3',
        captionText: 'فَأُعْجِبَ عِنْدَمَا شَاهَدَ "أَبُو قِرْدَانَ" يَنْزِلُ حَقْلَ الْقُطْنِ وَيَلْتَقِطُ الدِّيدَانَ.',
      ),
      StoryScene(
        imagePath: '${_dir}taa_t_cd_story_nasheed.png',
        audioPath: '${_audio}taa_t_nasheed.mp3',
        isNasheed: true,
        captionText: 'طَاءٌ طَيْرٌ فَوْقَ الشَّجَرِ .. يُغَرِّدُ لَحْنًا عِنْدَ السَّحَرِ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ط',
    items: [
      VowelItem(
        displayChar: 'طَ',
        fathaAudio: '${_vowelsAudio}taa_t_fatha.mp3',
        dammaAudio: '${_vowelsAudio}taa_t_damma.mp3',
        kasraAudio: '${_vowelsAudio}taa_t_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'طَ',
        exampleWord: 'طَبِيب',
        exampleEmoji: '👨‍⚕️',
        vowelAudio: '${_vowelsAudio}taa_t_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}taa_t_fatha_rule.mp3',
        wordAudio: '${_audio}taa_t_word_p1_2.mp3',
        slideImagePath: '${_dir}taa_t_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'طُ',
        exampleWord: 'طُيُور',
        exampleEmoji: '🐦',
        vowelAudio: '${_vowelsAudio}taa_t_damma.mp3',
        fullRuleAudio: '${_soundsAudio}taa_t_damma_rule.mp3',
        wordAudio: '${_audio}taa_t_word_p3_3.mp3',
        slideImagePath: '${_dir}taa_t_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'طِ',
        exampleWord: 'طِفْل',
        exampleEmoji: '👶',
        vowelAudio: '${_vowelsAudio}taa_t_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}taa_t_kasra_rule.mp3',
        wordAudio: '${_audio}taa_t_word_p1_1.mp3',
        slideImagePath: '${_dir}taa_t_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'طْ',
        exampleWord: 'قُطْن',
        exampleEmoji: '☁️',
        vowelAudio: '${_vowelsAudio}taa_t_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}taa_t_sukoon_rule.mp3',
        wordAudio: '${_audio}taa_t_word_p4_3.mp3',
        slideImagePath: '${_dir}taa_t_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ط',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'طَا',
        audioPath: '${_maddAudio}taa_t_alif.mp3',
        imagePath: '${_dir}taa_t_madd_aa.png',
        exampleWord: 'قِطَار',
        explanation: 'طَاءٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: طَا',
        wordAudioPath: '${_audio}taa_t_word_p4_4.mp3',
        accentColor: Color(0xFFD84315),
      ),
      MaddItem(
        displayChar: 'طُو',
        audioPath: '${_maddAudio}taa_t_waw.mp3',
        imagePath: '${_dir}taa_t_madd_uu.png',
        exampleWord: 'عُطُور',
        explanation: 'طَاءٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: طُو',
        wordAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_coloring_reveal_3.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'طِي',
        audioPath: '${_maddAudio}taa_t_yaa.mp3',
        imagePath: '${_dir}taa_t_madd_ii.png',
        exampleWord: 'طَيَرَان',
        explanation: 'طَاءٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: طِي',
        wordAudioPath: '${_maddAudio}taa_t_yaa.mp3',
        accentColor: Color(0xFF2E7D32),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ط',
    audioIntroPath: '${_audio}taa_t_write_intro.mp3',
    stepImagePaths: [
      '${_dir}taa_t_write_step_1.png',
      '${_dir}taa_t_write_step_2.png',
      '${_dir}taa_t_write_step_3.png',
      '${_dir}taa_t_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ط',
        exampleWord: 'طَبِيب',
        exampleEmoji: '👨‍⚕️',
        audioPath: '${_audio}taa_t_trace_isolated.mp3',
        imagePath: '${_dir}taa_t_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'طـ',
        exampleWord: 'طُيُور',
        exampleEmoji: '🐦',
        audioPath: '${_coreAudio}taa_t_pos_start.mp3',
        imagePath: '${_dir}taa_t_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـطـ',
        exampleWord: 'قِطَار',
        exampleEmoji: '🚂',
        audioPath: '${_coreAudio}taa_t_pos_middle.mp3',
        imagePath: '${_dir}taa_t_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـط',
        exampleWord: 'ضَابِط',
        exampleEmoji: '👮',
        audioPath: '${_coreAudio}taa_t_pos_end.mp3',
        imagePath: '${_dir}taa_t_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}taa_t_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'طِفْل', cardImagePath: '${_dir}taa_t_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَبِيب', cardImagePath: '${_dir}taa_t_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'ضَابِط', cardImagePath: '${_dir}taa_t_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَارِق', cardImagePath: '${_dir}taa_t_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}taa_t_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'طَبَّاخ', cardImagePath: '${_dir}taa_t_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مَطْبَخ', cardImagePath: '${_dir}taa_t_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَبَق', cardImagePath: '${_dir}taa_t_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَمَاطِم', cardImagePath: '${_dir}taa_t_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}taa_t_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'قِطَّة', cardImagePath: '${_dir}taa_t_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'بَطَّة', cardImagePath: '${_dir}taa_t_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طُيُور', cardImagePath: '${_dir}taa_t_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَائِرَة', cardImagePath: '${_dir}taa_t_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}taa_t_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'طَرْبُوش', cardImagePath: '${_dir}taa_t_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'طَبْلَة', cardImagePath: '${_dir}taa_t_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قُطْن', cardImagePath: '${_dir}taa_t_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'قِطَار', cardImagePath: '${_dir}taa_t_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}taa_t_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/taa_t/taa_t_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/taa_t/taa_t_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/taa_t/taa_t_circus_prompt.mp3',
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
        word: 'طَبِيب',
        imagePath: '${_gamesDir}fishing/taa_t/taa_t_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/taa_t/taa_t_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/momt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'طَبِيب', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'صَيَّاد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'فَلَّاح', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قُطْن',
        imagePath: '${_gamesDir}fishing/taa_t/taa_t_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/taa_t/taa_t_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/sah.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'عَدَس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'فُول', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قُطْن', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'طَائِرَة',
        imagePath: '${_gamesDir}fishing/taa_t/taa_t_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/taa_t/taa_t_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'سَفِينَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'طَائِرَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'مَرْكَب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'قِطَّة',
        imagePath: '${_gamesDir}fishing/taa_t/taa_t_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/taa_t/taa_t_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/momtt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قِطَّة', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'طَبِيب',
        imagePath: '${_gamesDir}beehive/taa_t/taa_t_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/taa_t/taa_t_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'طُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'طَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'طِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'طْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'طِفْل',
        imagePath: '${_gamesDir}beehive/taa_t/taa_t_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/taa_t/taa_t_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cells: [
          GameZoneChoice(label: 'طُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'طَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'طِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'طْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'طُيُور',
        imagePath: '${_gamesDir}beehive/taa_t/taa_t_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/taa_t/taa_t_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'طُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'طَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'طِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'طْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'قُطْن',
        imagePath: '${_gamesDir}beehive/taa_t/taa_t_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/taa_t/taa_t_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'طُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'طَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'طِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'طْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'طَبِيب',
        imagePath: '${_gamesDir}circus/taa_t/taa_t_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/taa_t/taa_t_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'نَجَّار', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'طَبِيب', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/taa_t/taa_t_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'طَائِرَة',
        imagePath: '${_gamesDir}circus/taa_t/taa_t_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/taa_t/taa_t_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'سَيَّارَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'طَائِرَة', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/taa_t/taa_t_circus_2.mp3'),
          GameZoneChoice(label: 'مَرْكَب', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'طَبْلَة',
        imagePath: '${_gamesDir}circus/taa_t/taa_t_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/taa_t/taa_t_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'بِيَانُو', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'عُود', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'طَبْلَة', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/taa_t/taa_t_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'قِطَّة',
        imagePath: '${_gamesDir}match/taa_t/taa_t_match_1.png',
        audioPath: '${_gamesAudio}match/taa_t/taa_t_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'كَلْب', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'قِطَّة', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'قِطَار',
        imagePath: '${_gamesDir}match/taa_t/taa_t_match_2.png',
        audioPath: '${_gamesAudio}match/taa_t/taa_t_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'قِطَار', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'سَيَّارَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مَرْكَب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'طُيُور',
        imagePath: '${_gamesDir}match/taa_t/taa_t_match_3.png',
        audioPath: '${_gamesAudio}match/taa_t/taa_t_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'طِفْل', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'قُطْن', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'طُيُور', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'طَائِرَة',
        imagePath: '${_gamesDir}match/taa_t/taa_t_match_4.png',
        audioPath: '${_gamesAudio}match/taa_t/taa_t_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'طَائِرَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'طَبَق', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'طَبِيب',
        bgImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_word_1.png',
        introAudioPath: '${_audio}taa_t_word_p1_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}taa_t_word_p1_2.mp3',
        options: [
          GameZoneChoice(label: 'قِطَّة', isCorrect: false),
          GameZoneChoice(label: 'مَطْبَخ', isCorrect: false),
          GameZoneChoice(label: 'طَبِيب', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_1_slice_1.png', color: Color(0xFF0277BD)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_1_slice_2.png', color: Color(0xFF039BE5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_1_slice_3.png', color: Color(0xFF29B6F6)),
        ],
      ),
      ColoringRound(
        word: 'قِطَار',
        bgImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_word_2.png',
        introAudioPath: '${_audio}taa_t_word_p4_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}taa_t_word_p4_4.mp3',
        options: [
          GameZoneChoice(label: 'قِطَار', isCorrect: true),
          GameZoneChoice(label: 'بَطَّة', isCorrect: false),
          GameZoneChoice(label: 'طَبَق', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_2_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_2_slice_2.png', color: Color(0xFFE65100)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_2_slice_3.png', color: Color(0xFFFB8C00)),
        ],
      ),
      ColoringRound(
        word: 'عُطُور',
        bgImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_coloring_reveal_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/taa_t/taa_t_wrong_reveal_3.mp3',
        wordAudioPath: '${_maddAudio}taa_t_waw.mp3',
        options: [
          GameZoneChoice(label: 'مَطَر', isCorrect: false),
          GameZoneChoice(label: 'طِفْل', isCorrect: false),
          GameZoneChoice(label: 'عُطُور', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_3_slice_1.png', color: Color(0xFF6A1B9A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_3_slice_2.png', color: Color(0xFF8E24AA)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa_t/taa_t_coloring_round_3_slice_3.png', color: Color(0xFFAB47BC)),
        ],
      ),
    ],
  ),
);
