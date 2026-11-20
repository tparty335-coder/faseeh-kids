import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف السين (س) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1_س.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ahdaf_a.swf, write.swf, ka1..ka4.swf, sto1..sto4.swf, stosong.swf, mov1..mov10.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/seen/';
const String _audio = 'audio/lessons/seen/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف السين كامل
const LetterUnitManifest seenManifest = LetterUnitManifest(
  letter: 'س',
  unitTitle: 'الوحدة الثانية عشرة | حرف السين (س)',
  topBarColor: Color(0xFF2E7D32), // أخضر زمردي داكن
  highlightColor: Color(0xFFA5D6A7), // أخضر فاتح
  mascotEmoji: '🐢', // سلحفاة
  unitIndex: 12,
  nextLetter: 'ش',

  // ── الأهداف ──
  objectives: ObjectivesSpec(
    audioPath: 'audio/letters/core/seen_name.mp3',
    objectives: [
      'التعرف على شكل وصوت حرف السين (س)',
      'التمييز بين الحركات القصيرة والطويلة',
      'كتابة حرف السين في مواضعه المختلفة',
      'قراءة كلمات تبدأ أو تحتوي على حرف السين',
      'التفاعل مع قصة ونشيد حرف السين',
      'تطبيق المهارات المكتسبة عبر ألعاب تفاعلية',
      'إتقان نطق حرف السين بمخارجه الصحيحة',
    ],
  ),

  // ── القصة (4 مشاهد + النشيد = 5 مشاهد أصلية) ──
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}seen_cd_story_1.webp',
        audioPath: '${_audio}seen_story_1.mp3',
      ), // أراد الأرنب أن يتخلص من الأسد ملك الغابة، فخدعه وقال له إن أسدًا آخر يسبه.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_2.webp',
        audioPath: '${_audio}seen_story_2.mp3',
      ), // فذهبا سويًا إلى بئر عميقة. وقال الأرنب: إنه هنا يا مولاي.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_3.webp',
        audioPath: '${_audio}seen_story_3.mp3',
      ), // فنظر الأسد فرأى ظله في البئر ظنًّا أنه خصمه.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_4.webp',
        audioPath: '${_audio}seen_story_4.mp3',
      ), // فوثب ليقاتله، فسقط في البئر غرقًا.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_nasheed.webp',
        audioPath: '${_audio}seen_nasheed.mp3',
        isNasheed: true,
      ), // سين سمكة تحت الماء • تذكر رباً سخى عطاء / سبحان الله
    ],
  ),

  // ── الحركات ──
  vowels: VowelsSpec(
    letterChar: 'س',
    items: [
      VowelItem(
        displayChar: 'سَ',
        fathaAudio: '${_vowelsAudio}seen_fatha.mp3',
        dammaAudio: '${_vowelsAudio}seen_damma.mp3',
        kasraAudio: '${_vowelsAudio}seen_kasra.mp3',
      ),
    ],
  ),

  // ── المدود ──
  madd: MaddSpec(
    letterChar: 'س',
    items: [
      MaddItem(displayChar: 'سَا', audioPath: 'audio/lessons/seen/madd/seen_madd_alif.mp3', imagePath: '${_dir}seen_madd_aa.webp'),
      MaddItem(displayChar: 'سُو', audioPath: 'audio/lessons/seen/madd/seen_madd_waw.mp3', imagePath: '${_dir}seen_madd_uu.webp'),
      MaddItem(displayChar: 'سِي', audioPath: 'audio/lessons/seen/madd/seen_madd_yaa.mp3', imagePath: '${_dir}seen_madd_ii.webp'),
    ],
  ),

  // ── التخطيط والكتابة ──
  tracing: TracingSpec(
    letterChar: 'س',
    audioIntroPath: 'audio/lessons/laam/final/laam_write_intro.mp3',
    stepImagePaths: [
      '${_dir}seen_write_step_1.webp',
      'assets/images/lessons/seen/seen_trace_start.webp',
      'assets/images/lessons/seen/seen_trace_middle.webp',
      'assets/images/lessons/seen/seen_trace_end.webp',
    ],
  ),

  // ── بنك الكلمات (4 صفحات × 4 كلمات = 16 كلمة أصلية من أسطوانة الوزارة) ──
  words: WordsSpec(
    pages: [
      // ── صفحة 1 (ka1.swf): كُرْسِي، فُسْتَان، تِمْسَاح، شَمْسَ ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'كُرْسِي', cardImagePath: '${_dir}seen_words_p1_card_1.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p1_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'فُسْتَان', cardImagePath: '${_dir}seen_words_p1_card_2.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p1_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'تِمْسَاح', cardImagePath: '${_dir}seen_words_p1_card_3.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p1_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'شَمْسَ', cardImagePath: 'assets/images/lessons/seen/seen_sukoon_example.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p1_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
      // ── صفحة 2 (ka2.swf): سَمَكَة، يَرْسُمُ، تَغْسَل، نُسُور ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'سَمَكَة', cardImagePath: '${_dir}seen_words_p2_card_1.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p2_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'يَرْسُمُ', cardImagePath: '${_dir}seen_words_p2_card_2.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p2_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'تَغْسَل', cardImagePath: '${_dir}seen_words_p2_card_3.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p2_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'نُسُور', cardImagePath: '${_dir}seen_words_p2_card_4.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p2_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
      // ── صفحة 3 (ka3.swf): بِرْسِيم، سَاعَة، سُلَحْفَاة، سَيَّارَة ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'بِرْسِيم', cardImagePath: '${_dir}seen_words_p3_card_1.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p3_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سَاعَة', cardImagePath: '${_dir}seen_words_p3_card_2.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p3_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سُلَحْفَاة', cardImagePath: '${_dir}seen_words_p3_card_3.webp', cardHeight: 474, audioPath: 'audio/games/circus/seen/seen_circus_2.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سَيَّارَة', cardImagePath: '${_dir}seen_words_p3_card_4.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p3_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
      // ── صفحة 4 (ka4.swf): سُبُورَة، سُوق، سُلَّم، سَرِير ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(word: 'سُبُورَة', cardImagePath: '${_dir}seen_words_p4_card_1.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p4_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سُوق', cardImagePath: '${_dir}seen_words_p4_card_2.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p4_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سُلَّم', cardImagePath: '${_dir}seen_words_p4_card_3.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p4_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سَرِير', cardImagePath: '${_dir}seen_words_p4_card_4.webp', cardHeight: 474, audioPath: '${_audio}seen_word_p4_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
    ],
  ),

  // ── الألعاب ──
  games: GamesSpec(
    fishingIntroAudio: 'audio/letters/short_vowels/ha_fatha.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/seen/seen_fishing_prompt.mp3',
    fishingWrongAudio: 'audio/feedback/try_again.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/seen/seen_beehive_prompt.mp3',
    beehiveWrongAudio: 'audio/feedback/try_again.mp3',
    circusPromptAudio: '${_gamesAudio}circus/seen/seen_circus_prompt.mp3',
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
        word: 'سَمَكَة',
        imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_1.webp',
        audioPath: '${_gamesAudio}fishing/seen/seen_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'سَمَكَة', isCorrect: true, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'جَمَل', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'بِرْسِيم',
        imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_2.webp',
        audioPath: '${_gamesAudio}fishing/seen/seen_fishing_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'قُطْن', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'فُول', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'بِرْسِيم', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'سَيَّارَة',
        imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_3.webp',
        audioPath: '${_gamesAudio}fishing/seen/seen_fishing_3.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'طَائِرَة', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'سَيَّارَة', isCorrect: true, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'قِطَار', isCorrect: false, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
      FishingRound(
        word: 'شَمْس',
        imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_4.webp',
        audioPath: '${_gamesAudio}fishing/seen/seen_fishing_4.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 800,
        imgH: 490,
        zones: [
          GameZoneChoice(label: 'قَمَر', isCorrect: false, px: 120, py: 425, w: 215, h: 90),
          GameZoneChoice(label: 'نَجْم', isCorrect: false, px: 382, py: 382, w: 220, h: 90),
          GameZoneChoice(label: 'شَمْس', isCorrect: true, px: 625, py: 425, w: 215, h: 90),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'أَسَد',
        imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_1.webp',
        audioPath: '${_gamesAudio}beehive/seen/seen_beehive_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'سُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'سَ', isCorrect: true, px: 546, py: 269),
          GameZoneChoice(label: 'سِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'سْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'تَغْسِل',
        imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_2.webp',
        audioPath: '${_gamesAudio}beehive/seen/seen_beehive_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'سُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'سَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'سِ', isCorrect: true, px: 739, py: 255),
          GameZoneChoice(label: 'سْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'يَرْسُم',
        imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_3.webp',
        audioPath: '${_gamesAudio}match/seen/seen_match_2.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'سُ', isCorrect: true, px: 692, py: 181),
          GameZoneChoice(label: 'سَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'سِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'سْ', isCorrect: false, px: 595, py: 350),
        ],
      ),
      BeehiveRound(
        word: 'فُسْتَان',
        imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_4.webp',
        audioPath: '${_gamesAudio}match/seen/seen_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        cells: [
          GameZoneChoice(label: 'سُ', isCorrect: false, px: 692, py: 181),
          GameZoneChoice(label: 'سَ', isCorrect: false, px: 546, py: 269),
          GameZoneChoice(label: 'سِ', isCorrect: false, px: 739, py: 255),
          GameZoneChoice(label: 'سْ', isCorrect: true, px: 595, py: 350),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'شَمْس',
        imagePath: '${_gamesDir}circus/seen/seen_circus_round_1.webp',
        audioPath: '${_gamesAudio}circus/seen/seen_circus_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'شَمْعَة', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'قَمَر', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'شَمْس', isCorrect: true, px: 135, py: 373, wordAudio: '${_gamesAudio}circus/seen/seen_circus_1.mp3'),
        ],
      ),
      CircusRound(
        word: 'سُلَحْفَاة',
        imagePath: '${_gamesDir}circus/seen/seen_circus_round_2.webp',
        audioPath: '${_gamesAudio}circus/seen/seen_circus_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'قِطَّة', isCorrect: false, px: 137, py: 98),
          GameZoneChoice(label: 'سُلَحْفَاة', isCorrect: true, px: 272, py: 240, wordAudio: '${_gamesAudio}circus/seen/seen_circus_2.mp3'),
          GameZoneChoice(label: 'حِصَان', isCorrect: false, px: 135, py: 373),
        ],
      ),
      CircusRound(
        word: 'سَاعَة',
        imagePath: '${_gamesDir}circus/seen/seen_circus_round_3.webp',
        audioPath: '${_gamesAudio}circus/seen/seen_circus_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'سَاعَة', isCorrect: true, px: 137, py: 98, wordAudio: '${_gamesAudio}circus/seen/seen_circus_3.mp3'),
          GameZoneChoice(label: 'فُرْشَاة', isCorrect: false, px: 272, py: 240),
          GameZoneChoice(label: 'هَاتِف', isCorrect: false, px: 135, py: 373),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'فُسْتَان',
        imagePath: '${_gamesDir}match/seen/seen_match_1.webp',
        audioPath: '${_gamesAudio}match/seen/seen_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'قَمِيص', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'قُبَّعَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'فُسْتَان', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'يَرْسُم',
        imagePath: '${_gamesDir}match/seen/seen_match_2.webp',
        audioPath: '${_gamesAudio}match/seen/seen_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'يَرْسُم', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'يَأْكُل', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'يَلْعَب', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'سَبُّورَة',
        imagePath: '${_gamesDir}match/seen/seen_match_3.webp',
        audioPath: '${_gamesAudio}match/seen/seen_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'مُعَلِّم', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'سَبُّورَة', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'تِلْمِيذ', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'تِمْسَاح',
        imagePath: '${_gamesDir}match/seen/seen_match_4.webp',
        audioPath: '${_gamesAudio}match/seen/seen_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 446,
        cards: [
          GameZoneChoice(label: 'تِمْسَاح', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'حُوت', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'نَهْر', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'تِمْسَاح',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_1.webp',
        introAudioPath: '${_audio}seen_word_p1_3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_saah.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/seen/seen_wrong_reveal_1.mp3',
        wordAudioPath: '${_audio}seen_word_p1_3.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'سَمَك', isCorrect: false),
          GameZoneChoice(label: 'أَسَد', isCorrect: false),
          GameZoneChoice(label: 'تِمْسَاح', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_1.webp', color: Color(0xFF1B5E20)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_2.webp', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_3.webp', color: Color(0xFF4CAF50)),
        ],
      ),
      ColoringRound(
        word: 'نُسُور',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_2.webp',
        introAudioPath: '${_audio}seen_word_p2_4.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_sooh.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/seen/seen_wrong_reveal_2.mp3',
        wordAudioPath: '${_audio}seen_word_p2_4.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'سُلَّم', isCorrect: false),
          GameZoneChoice(label: 'نُسُور', isCorrect: true),
          GameZoneChoice(label: 'سَمَك', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_1.webp', color: Color(0xFF33691E)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_2.webp', color: Color(0xFF558B2F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_3.webp', color: Color(0xFF7CB342)),
        ],
      ),
      ColoringRound(
        word: 'بِرْسِيم',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_3.webp',
        introAudioPath: '${_audio}seen_word_p3_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_seeh.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/seen/seen_wrong_reveal_3.mp3',
        wordAudioPath: '${_audio}seen_word_p3_1.mp3',
        imgW: 800,
        imgH: 450,
        options: [
          GameZoneChoice(label: 'بِرْسِيم', isCorrect: true),
          GameZoneChoice(label: 'عَدَس', isCorrect: false),
          GameZoneChoice(label: 'خَسّ', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_1.webp', color: Color(0xFF004D40)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_2.webp', color: Color(0xFF00796B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_3.webp', color: Color(0xFF4DB6AC)),
        ],
      ),
    ],
  ),
);
