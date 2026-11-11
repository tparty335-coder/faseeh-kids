import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف السين (س) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1_س.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ahdaf_a.swf, write.swf, ka1..ka4.swf, sto1..sto4.swf, stosong.swf, mov1..mov10.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/seen/';
const String _audio = 'audio/lessons/seen/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
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
    audioPath: '${_audio}seen_goal.mp3',
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
        imagePath: '${_dir}seen_cd_story_1.png',
        audioPath: '${_audio}seen_story_1.mp3',
      ), // أراد الأرنب أن يتخلص من الأسد ملك الغابة، فخدعه وقال له إن أسدًا آخر يسبه.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_2.png',
        audioPath: '${_audio}seen_story_2.mp3',
      ), // فذهبا سويًا إلى بئر عميقة. وقال الأرنب: إنه هنا يا مولاي.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_3.png',
        audioPath: '${_audio}seen_story_3.mp3',
      ), // فنظر الأسد فرأى ظله في البئر ظنًّا أنه خصمه.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_4.png',
        audioPath: '${_audio}seen_story_4.mp3',
      ), // فوثب ليقاتله، فسقط في البئر غرقًا.
      StoryScene(
        imagePath: '${_dir}seen_cd_story_nasheed.png',
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
      MaddItem(displayChar: 'سَا', audioPath: '${_maddAudio}seen_madd_demo.mp3', imagePath: '${_dir}seen_madd_aa.png'),
      MaddItem(displayChar: 'سُو', audioPath: '${_maddAudio}seen_madd_demo.mp3', imagePath: '${_dir}seen_madd_uu.png'),
      MaddItem(displayChar: 'سِي', audioPath: '${_maddAudio}seen_madd_demo.mp3', imagePath: '${_dir}seen_madd_ii.png'),
    ],
  ),

  // ── التخطيط والكتابة ──
  tracing: TracingSpec(
    letterChar: 'س',
    audioIntroPath: '${_audio}seen_write_intro.mp3',
    stepImagePaths: [
      '${_dir}seen_write_step_1.png',
      '${_dir}seen_write_step_2.png',
      '${_dir}seen_write_step_3.png',
      '${_dir}seen_write_step_4.png',
    ],
  ),

  // ── بنك الكلمات (4 صفحات × 4 كلمات = 16 كلمة أصلية من أسطوانة الوزارة) ──
  words: WordsSpec(
    pages: [
      // ── صفحة 1 (ka1.swf): كُرْسِي، فُسْتَان، تِمْسَاح، شَمْسَ ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'كُرْسِي', cardImagePath: '${_dir}seen_words_p1_card_1.png', cardHeight: 474, audioPath: '${_audio}seen_word_p1_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'فُسْتَان', cardImagePath: '${_dir}seen_words_p1_card_2.png', cardHeight: 474, audioPath: '${_audio}seen_word_p1_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'تِمْسَاح', cardImagePath: '${_dir}seen_words_p1_card_3.png', cardHeight: 474, audioPath: '${_audio}seen_word_p1_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'شَمْسَ', cardImagePath: '${_dir}seen_words_p1_card_4.png', cardHeight: 474, audioPath: '${_audio}seen_word_p1_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
      // ── صفحة 2 (ka2.swf): سَمَكَة، يَرْسُمُ، تَغْسَل، نُسُور ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'سَمَكَة', cardImagePath: '${_dir}seen_words_p2_card_1.png', cardHeight: 474, audioPath: '${_audio}seen_word_p2_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'يَرْسُمُ', cardImagePath: '${_dir}seen_words_p2_card_2.png', cardHeight: 474, audioPath: '${_audio}seen_word_p2_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'تَغْسَل', cardImagePath: '${_dir}seen_words_p2_card_3.png', cardHeight: 474, audioPath: '${_audio}seen_word_p2_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'نُسُور', cardImagePath: '${_dir}seen_words_p2_card_4.png', cardHeight: 474, audioPath: '${_audio}seen_word_p2_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
      // ── صفحة 3 (ka3.swf): بِرْسِيم، سَاعَة، سُلَحْفَاة، سَيَّارَة ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'بِرْسِيم', cardImagePath: '${_dir}seen_words_p3_card_1.png', cardHeight: 474, audioPath: '${_audio}seen_word_p3_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سَاعَة', cardImagePath: '${_dir}seen_words_p3_card_2.png', cardHeight: 474, audioPath: '${_audio}seen_word_p3_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سُلَحْفَاة', cardImagePath: '${_dir}seen_words_p3_card_3.png', cardHeight: 474, audioPath: '${_audio}seen_word_p3_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سَيَّارَة', cardImagePath: '${_dir}seen_words_p3_card_4.png', cardHeight: 474, audioPath: '${_audio}seen_word_p3_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
      // ── صفحة 4 (ka4.swf): سُبُورَة، سُوق، سُلَّم، سَرِير ──
      WordsPage(
        listImagePath: '${_dir}seen_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(word: 'سُبُورَة', cardImagePath: '${_dir}seen_words_p4_card_1.png', cardHeight: 474, audioPath: '${_audio}seen_word_p4_1.mp3', hotspot: WordHotspot(left: 0.480, top: 0.190, right: 0.800, bottom: 0.370), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سُوق', cardImagePath: '${_dir}seen_words_p4_card_2.png', cardHeight: 474, audioPath: '${_audio}seen_word_p4_2.mp3', hotspot: WordHotspot(left: 0.140, top: 0.360, right: 0.450, bottom: 0.540), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سُلَّم', cardImagePath: '${_dir}seen_words_p4_card_3.png', cardHeight: 474, audioPath: '${_audio}seen_word_p4_3.mp3', hotspot: WordHotspot(left: 0.480, top: 0.550, right: 0.800, bottom: 0.730), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
          WordItem(word: 'سَرِير', cardImagePath: '${_dir}seen_words_p4_card_4.png', cardHeight: 474, audioPath: '${_audio}seen_word_p4_4.mp3', hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900), speakerOffset: Offset(0.174, 0.318), closeOffset: Offset(0.760, 0.316)),
        ],
      ),
    ],
  ),

  // ── الألعاب ──
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'سَمَكَة', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بِرْسِيم', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_2.mp3', isCorrect: true),
      FishingRound(word: 'سَيَّارَة', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'شَمْس', imagePath: '${_gamesDir}fishing/seen/seen_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/seen/seen_fishing_4.mp3', isCorrect: true),
    ],
    beehive: [
      BeehiveRound(word: 'أَسَد', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_1.mp3'),
      BeehiveRound(word: 'تَغْسِل', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_2.mp3'),
      BeehiveRound(word: 'يَرْسُم', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_3.mp3'),
      BeehiveRound(word: 'فُسْتَان', imagePath: '${_gamesDir}beehive/seen/seen_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/seen/seen_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'شَمْس', imagePath: '${_gamesDir}circus/seen/seen_circus_round_1.png', audioPath: '${_gamesAudio}circus/seen/seen_circus_1.mp3'),
      CircusRound(word: 'سُلَحْفَاة', imagePath: '${_gamesDir}circus/seen/seen_circus_round_2.png', audioPath: '${_gamesAudio}circus/seen/seen_circus_2.mp3'),
      CircusRound(word: 'سَاعَة', imagePath: '${_gamesDir}circus/seen/seen_circus_round_3.png', audioPath: '${_gamesAudio}circus/seen/seen_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'فُسْتَان', imagePath: '${_gamesDir}match/seen/seen_match_1.png', audioPath: '${_gamesAudio}match/seen/seen_match_1.mp3'),
      WordsMatchPair(word: 'يَرْسُم', imagePath: '${_gamesDir}match/seen/seen_match_2.png', audioPath: '${_gamesAudio}match/seen/seen_match_2.mp3'),
      WordsMatchPair(word: 'سَبُّورَة', imagePath: '${_gamesDir}match/seen/seen_match_3.png', audioPath: '${_gamesAudio}match/seen/seen_match_3.mp3'),
      WordsMatchPair(word: 'تِمْسَاح', imagePath: '${_gamesDir}match/seen/seen_match_4.png', audioPath: '${_gamesAudio}match/seen/seen_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'تِمْسَاح',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_1.png',
        introAudioPath: '${_audio}seen_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_saah.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_1.png', color: Color(0xFF1B5E20)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_2.png', color: Color(0xFF2E7D32)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_1_slice_3.png', color: Color(0xFF4CAF50)),
        ],
      ),
      ColoringRound(
        word: 'نُسُور',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_2.png',
        introAudioPath: '${_audio}seen_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_sooh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_1.png', color: Color(0xFF33691E)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_2.png', color: Color(0xFF558B2F)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_2_slice_3.png', color: Color(0xFF7CB342)),
        ],
      ),
      ColoringRound(
        word: 'بِرْسِيم',
        bgImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/seen/seen_coloring_word_3.png',
        introAudioPath: '${_audio}seen_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/seen/seen_reveal_seeh.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_1.png', color: Color(0xFF004D40)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_2.png', color: Color(0xFF00796B)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/seen/seen_coloring_round_3_slice_3.png', color: Color(0xFF4DB6AC)),
        ],
      ),
    ],
  ),
);
