import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الهاء (ه) — الوحدة 26 ─────────────────────────────────────
const String _dir = 'assets/images/lessons/haa_end/';
const String _audio = 'audio/lessons/haa_end/final/';
const String _soundsAudio = 'audio/lessons/haa_end/sounds/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _coreAudio = 'audio/letters/core/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest haaManifest = LetterUnitManifest(
  letter: 'ه',
  unitTitle: 'الوَحْدَةُ السَّادِسَةُ وَالْعِشْرُونَ | حَرْفُ الْهَاءِ (ه)',
  topBarColor: Color(0xFF43A047),
  highlightColor: Color(0xFFC8E6C9),
  mascotEmoji: '🦅',
  unitIndex: 26,
  nextLetter: 'و',

  objectives: ObjectivesSpec(
    audioPath: '${_audio}haa_end_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى شَكْلِ وَصَوْتِ حَرْفِ الْهَاءِ (ه)',
      'أَنْطِقُ حَرْفَ الْهَاءِ بِالْحَرَكَاتِ الْقَصِيرَةِ وَالسُّكُونِ',
      'أُمَيِّزُ حَرْفَ الْهَاءِ مَعَ الْمُدُودِ الثَّلَاثَةِ (هَا، هُو، هِي)',
      'أَتَتَبَّعُ وَأَكْتُبُ حَرْفَ الْهَاءِ فِي مَوَاضِعِهِ الْمُخْتَلِفَةِ',
      'أَقْرَأُ كَلِمَاتٍ أَصْلِيَّةً تَحْتَوِي حَرْفَ الْهَاءِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ هِنْدٍ وَالشَّجَرَةِ الْكَبِيرَةِ وَنَشِيدِ الْهَاءِ',
      'أُتْقِنُ تَمْيِيزَ حَرْفِ الْهَاءِ عَبْرَ الْأَلْعَابِ التَّفَاعُلِيَّةِ',
    ],
  ),

  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}haa_end_cd_story_1.png',
        audioPath: '${_audio}haa_end_story_1.mp3',
        captionText: 'هِنْدُ تِلْمِيذَةٌ فِي الصَّفِّ الْأَوَّلِ الِابْتِدَائِيِّ. انْتَقَلَتْ هِنْدُ وَأُسْرَتُهَا إِلَى مَنْزِلٍ جَدِيدٍ.',
      ),
      StoryScene(
        imagePath: '${_dir}haa_end_cd_story_2.png',
        audioPath: '${_audio}haa_end_story_2.mp3',
        captionText: 'وَجَدَتْ هِنْدُ فِي حَدِيقَةِ الْمَنْزِلِ شَجَرَةً كَبِيرَةً.',
      ),
      StoryScene(
        imagePath: '${_dir}haa_end_cd_story_3.png',
        audioPath: '${_audio}haa_end_story_3.mp3',
        captionText: 'هِنْدُ تُحِبُّ الزَّرْعَ فَظَلَّتْ تَرْوِيهَا حَتَّى أَثْمَرَتْ.',
      ),
      StoryScene(
        imagePath: '${_dir}haa_end_cd_story_4.png',
        audioPath: '${_audio}haa_end_story_4.mp3',
        captionText: 'وَهِنْدُ مَسْرُورَةٌ لِأَنَّهَا تَأْكُلُ مِنْ ثِمَارِهَا وَتَقِفُ فِي ظِلِّهَا.',
      ),
      StoryScene(
        imagePath: '${_dir}haa_end_cd_story_nasheed.png',
        audioPath: '${_audio}haa_end_nasheed.mp3',
        isNasheed: true,
        captionText: 'هَاءٌ هِنْدٌ تَرْعَى الشَّجَرَةَ .. تَسْقِي الزَّرْعَ وَتَجْنِي الثَّمَرَةَ 🎵',
      ),
    ],
  ),

  vowels: VowelsSpec(
    letterChar: 'ه',
    items: [
      VowelItem(
        displayChar: 'هَ',
        fathaAudio: '${_vowelsAudio}haa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}haa_damma.mp3',
        kasraAudio: '${_vowelsAudio}haa_kasra.mp3',
      ),
    ],
    cards: [
      VowelCardSpec(
        vowelName: 'الْفَتْحَةُ',
        displayForm: 'هَ',
        exampleWord: 'مُهَنْدِس',
        exampleEmoji: '👷',
        vowelAudio: '${_vowelsAudio}haa_fatha.mp3',
        fullRuleAudio: '${_soundsAudio}haa_end_fatha_rule.mp3',
        wordAudio: '${_audio}haa_end_word_p3_2.mp3',
        slideImagePath: '${_dir}haa_end_vowel_fatha.png',
      ),
      VowelCardSpec(
        vowelName: 'الضَّمَّةُ',
        displayForm: 'هُ',
        exampleWord: 'هُدْهُد',
        exampleEmoji: '🐦',
        vowelAudio: '${_vowelsAudio}haa_damma.mp3',
        fullRuleAudio: '${_soundsAudio}haa_end_damma_rule.mp3',
        wordAudio: '${_audio}haa_end_word_p1_1.mp3',
        slideImagePath: '${_dir}haa_end_vowel_damma.png',
      ),
      VowelCardSpec(
        vowelName: 'الْكَسْرَةُ',
        displayForm: 'هِ',
        exampleWord: 'هِنْد',
        exampleEmoji: '👧',
        vowelAudio: '${_vowelsAudio}haa_kasra.mp3',
        fullRuleAudio: '${_soundsAudio}haa_end_kasra_rule.mp3',
        wordAudio: '${_audio}haa_end_word_p1_4.mp3',
        slideImagePath: '${_dir}haa_end_vowel_kasra.png',
      ),
      VowelCardSpec(
        vowelName: 'السُّكُونُ',
        displayForm: 'هْ',
        exampleWord: 'نَهْر',
        exampleEmoji: '🏞️',
        vowelAudio: '${_vowelsAudio}haa_sukoon.mp3',
        fullRuleAudio: '${_soundsAudio}haa_end_sukoon_rule.mp3',
        wordAudio: '${_audio}haa_end_word_p2_4.mp3',
        slideImagePath: '${_dir}haa_end_vowel_sukoon.png',
      ),
    ],
  ),

  madd: MaddSpec(
    letterChar: 'ه',
    useManifestMadd: true,
    items: [
      MaddItem(
        displayChar: 'هَا',
        audioPath: '${_maddAudio}haa_alif.mp3',
        imagePath: '${_dir}haa_end_madd_aa.png',
        exampleWord: 'هَانِي',
        explanation: 'هَاءٌ مَفْتُوحَةٌ مَعَ مَدٍّ بِالْأَلِفِ: هَا',
        wordAudioPath: '${_audio}haa_end_word_p4_4.mp3',
        accentColor: Color(0xFF43A047),
      ),
      MaddItem(
        displayChar: 'هُو',
        audioPath: '${_maddAudio}haa_waw.mp3',
        imagePath: '${_dir}haa_end_madd_uu.png',
        exampleWord: 'فُهُود',
        explanation: 'هَاءٌ مَضْمُومَةٌ مَعَ مَدٍّ بِالْوَاوِ: هُو',
        wordAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_coloring_reveal_2.mp3',
        accentColor: Color(0xFF1565C0),
      ),
      MaddItem(
        displayChar: 'هِي',
        audioPath: '${_maddAudio}haa_yaa.mp3',
        imagePath: '${_dir}haa_end_madd_ii.png',
        exampleWord: 'سُهَيْر',
        explanation: 'هَاءٌ مَكْسُورَةٌ مَعَ مَدٍّ بِالْيَاءِ: هِي',
        wordAudioPath: '${_soundsAudio}haa_end_madd_ii.mp3',
        accentColor: Color(0xFFD84315),
      ),
    ],
  ),

  tracing: TracingSpec(
    letterChar: 'ه',
    audioIntroPath: '${_audio}haa_end_write_intro.mp3',
    stepImagePaths: [
      '${_dir}haa_end_write_step_1.png',
      '${_dir}haa_end_write_step_2.png',
      '${_dir}haa_end_write_step_3.png',
      '${_dir}haa_end_write_step_4.png',
    ],
    positions: [
      TracingPositionSpec(
        position: 'isolated',
        title: 'مُنْفَصِل',
        displayForm: 'ه',
        exampleWord: 'مِيَاه',
        exampleEmoji: '💧',
        audioPath: '${_audio}haa_end_trace_isolated.mp3',
        imagePath: '${_dir}haa_end_trace_isolated.png',
      ),
      TracingPositionSpec(
        position: 'start',
        title: 'فِي أَوَّلِ الْكَلِمَة',
        displayForm: 'هـ',
        exampleWord: 'هِلَال',
        exampleEmoji: '🌙',
        audioPath: '${_coreAudio}haa_pos_start.mp3',
        imagePath: '${_dir}haa_end_trace_start.png',
      ),
      TracingPositionSpec(
        position: 'middle',
        title: 'فِي وَسَطِ الْكَلِمَة',
        displayForm: 'ـهـ',
        exampleWord: 'فَهْد',
        exampleEmoji: '🐆',
        audioPath: '${_coreAudio}haa_pos_middle.mp3',
        imagePath: '${_dir}haa_end_trace_middle.png',
      ),
      TracingPositionSpec(
        position: 'end',
        title: 'فِي آخِرِ الْكَلِمَة',
        displayForm: 'ـه',
        exampleWord: 'وَجْه',
        exampleEmoji: '😊',
        audioPath: '${_coreAudio}haa_pos_end.mp3',
        imagePath: '${_dir}haa_end_trace_end.png',
      ),
    ],
  ),

  words: WordsSpec(
    pages: [
      WordsPage(
        listImagePath: '${_dir}haa_end_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'هُدْهُد', cardImagePath: '${_dir}haa_end_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p1_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'فَهْد', cardImagePath: '${_dir}haa_end_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p1_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُهْر', cardImagePath: '${_dir}haa_end_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p1_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'هِنْد', cardImagePath: '${_dir}haa_end_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p1_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}haa_end_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'هَرَم', cardImagePath: '${_dir}haa_end_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p2_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'سُهَيْر', cardImagePath: '${_dir}haa_end_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p2_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'هَاتِف', cardImagePath: '${_dir}haa_end_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p2_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'نَهْر', cardImagePath: '${_dir}haa_end_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p2_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}haa_end_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'هِلَال', cardImagePath: '${_dir}haa_end_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p3_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'مُهَنْدِس', cardImagePath: '${_dir}haa_end_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p3_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'هُوَيْدَا', cardImagePath: '${_dir}haa_end_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p3_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'سَهْم', cardImagePath: '${_dir}haa_end_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p3_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
      WordsPage(
        listImagePath: '${_dir}haa_end_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'هِرَّة', cardImagePath: '${_dir}haa_end_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p4_1.mp3', hotspot: WordHotspot(left: 0.44, top: 0.16, right: 0.86, bottom: 0.38), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'هَدِيَّة', cardImagePath: '${_dir}haa_end_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p4_2.mp3', hotspot: WordHotspot(left: 0.11, top: 0.36, right: 0.48, bottom: 0.56), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'زَهْرَة', cardImagePath: '${_dir}haa_end_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p4_3.mp3', hotspot: WordHotspot(left: 0.44, top: 0.54, right: 0.87, bottom: 0.74), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
          WordItem(word: 'هَانِي', cardImagePath: '${_dir}haa_end_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}haa_end_word_p4_4.mp3', hotspot: WordHotspot(left: 0.11, top: 0.72, right: 0.48, bottom: 0.90), speakerOffset: Offset(0.175, 0.315), closeOffset: Offset(0.812, 0.330)),
        ],
      ),
    ],
  ),

  games: GamesSpec(
    fishingIntroAudio: '${_gamesAudio}fishing/sayd.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/haa_end/haa_end_fishing_prompt.mp3',
    fishingWrongAudio: '${_gamesAudio}fishing/hawe.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/haa_end/haa_end_beehive_prompt.mp3',
    beehiveWrongAudio: '${_gamesAudio}beehive/6_haw.mp3',
    circusPromptAudio: '${_gamesAudio}circus/haa_end/haa_end_circus_prompt.mp3',
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
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}fishing/haa_end/haa_end_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/haa_end/haa_end_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba62.mp3',
        zones: [
          GameZoneChoice(label: 'مُهَنْدِس', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'فَلَّاح', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'طَبِيب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'وَجْه',
        imagePath: '${_gamesDir}fishing/haa_end/haa_end_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/haa_end/haa_end_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba58.mp3',
        zones: [
          GameZoneChoice(label: 'رَأْس', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'يَد', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'وَجْه', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'هُدْهُد',
        imagePath: '${_gamesDir}fishing/haa_end/haa_end_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/haa_end/haa_end_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba56.mp3',
        zones: [
          GameZoneChoice(label: 'قِطّ', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'هُدْهُد', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'كَلْب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'مُهْر',
        imagePath: '${_gamesDir}fishing/haa_end/haa_end_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/haa_end/haa_end_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: '${_gamesAudio}fishing/ahsnt.mp3',
        roundEndPraiseAudio: '${_gamesAudio}fishing/ba52.mp3',
        zones: [
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'مُهْر', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'مُهَنْدِس',
        imagePath: '${_gamesDir}beehive/haa_end/haa_end_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/haa_end/haa_end_beehive_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'هُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'هَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'هِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'هْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'هِنْد',
        imagePath: '${_gamesDir}beehive/haa_end/haa_end_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/haa_end/haa_end_beehive_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'هُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'هَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'هِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'هْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'هُدْهُد',
        imagePath: '${_gamesDir}beehive/haa_end/haa_end_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/haa_end/haa_end_beehive_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cells: [
          GameZoneChoice(label: 'هُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'هَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'هِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'هْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'نَهْر',
        imagePath: '${_gamesDir}beehive/haa_end/haa_end_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/haa_end/haa_end_beehive_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cells: [
          GameZoneChoice(label: 'هُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'هَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'هِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'هْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'هُدْهُد',
        imagePath: '${_gamesDir}circus/haa_end/haa_end_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/haa_end/haa_end_circus_1.mp3',
        praiseAudio: '${_gamesAudio}circus/7_ba62.mp3',
        zones: [
          GameZoneChoice(label: 'حَمَامَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'دَجَاجَة', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'هُدْهُد', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/haa_end/haa_end_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'هَرَم',
        imagePath: '${_gamesDir}circus/haa_end/haa_end_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/haa_end/haa_end_circus_2.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba59.mp3',
        zones: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'هَرَم', isCorrect: true, px: 269, py: 232, wordAudio: '${_gamesAudio}circus/haa_end/haa_end_circus_2.mp3'),
          GameZoneChoice(label: 'مِفْتَاح', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'فَهْد',
        imagePath: '${_gamesDir}circus/haa_end/haa_end_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/haa_end/haa_end_circus_3.mp3',
        praiseAudio: '${_gamesAudio}circus/6_ba53.mp3',
        zones: [
          GameZoneChoice(label: 'زَرَافَة', isCorrect: false, px: 137, py: 95),
          GameZoneChoice(label: 'أَسَد', isCorrect: false, px: 269, py: 232),
          GameZoneChoice(label: 'فَهْد', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/haa_end/haa_end_circus_3.mp3'),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'هَرَم',
        imagePath: '${_gamesDir}match/haa_end/haa_end_match_1.png',
        audioPath: '${_gamesAudio}match/haa_end/haa_end_match_1.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'هَوَاء', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'هَرَم', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'خُبْز', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'نَهْر',
        imagePath: '${_gamesDir}match/haa_end/haa_end_match_2.png',
        audioPath: '${_gamesAudio}match/haa_end/haa_end_match_2.mp3',
        praiseAudio: '${_gamesAudio}beehive/3_raa.mp3',
        cards: [
          GameZoneChoice(label: 'نَهْر', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'ثَلْج', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'هِلَال', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'هَاتِف',
        imagePath: '${_gamesDir}match/haa_end/haa_end_match_3.png',
        audioPath: '${_gamesAudio}match/haa_end/haa_end_match_3.mp3',
        praiseAudio: '${_gamesAudio}beehive/2_sah.mp3',
        cards: [
          GameZoneChoice(label: 'كَلْب', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'فَهْد', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'هَاتِف', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'هِلَال',
        imagePath: '${_gamesDir}match/haa_end/haa_end_match_4.png',
        audioPath: '${_gamesAudio}match/haa_end/haa_end_match_4.mp3',
        praiseAudio: '${_gamesAudio}beehive/4_momt.mp3',
        cards: [
          GameZoneChoice(label: 'هِلَال', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'هُدْهُد', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'سَهْم', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'هَانِي',
        bgImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_word_1.png',
        introAudioPath: '${_audio}haa_end_word_p4_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_coloring_reveal_1.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}haa_end_word_p4_4.mp3',
        options: [
          GameZoneChoice(label: 'رَجَب', isCorrect: false),
          GameZoneChoice(label: 'سَمَر', isCorrect: false),
          GameZoneChoice(label: 'هَانِي', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_1_slice_1.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_1_slice_2.png', color: Color(0xFF66BB6A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_1_slice_3.png', color: Color(0xFF81C784)),
        ],
      ),
      ColoringRound(
        word: 'فُهُود',
        bgImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_coloring_reveal_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_coloring_reveal_2.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_wrong_reveal_2.mp3',
        wordAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_coloring_reveal_2.mp3',
        options: [
          GameZoneChoice(label: 'فُهُود', isCorrect: true),
          GameZoneChoice(label: 'هِرَّة', isCorrect: false),
          GameZoneChoice(label: 'فَهْد', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_2_slice_1.png', color: Color(0xFF1565C0)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_2_slice_2.png', color: Color(0xFF1E88E5)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_2_slice_3.png', color: Color(0xFF42A5F5)),
        ],
      ),
      ColoringRound(
        word: 'سُهَيْر',
        bgImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_word_3.png',
        introAudioPath: '${_audio}haa_end_word_p2_2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_coloring_reveal_3.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/haa_end/haa_end_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}haa_end_word_p2_2.mp3',
        options: [
          GameZoneChoice(label: 'كَوْثَر', isCorrect: false),
          GameZoneChoice(label: 'أَمَل', isCorrect: false),
          GameZoneChoice(label: 'سُهَيْر', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_3_slice_1.png', color: Color(0xFFD84315)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_3_slice_2.png', color: Color(0xFFEF6C00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/haa_end/haa_end_coloring_round_3_slice_3.png', color: Color(0xFFFFA726)),
        ],
      ),
    ],
  ),
);
