import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الجيم (ج) — أصوات وصور أصلية 100% من أسطوانة فصيح ──────────
// جميع الأصول مستخرجة مباشرة من BoxedApp VFS:
// - الأهداف: ahdaf_a.swf
// - القصة: storybetw1..9.swf + storysongb1.swf + storyact.swf
// - الأصوات: carrot1.swf (جَزَر) + root3.swf (جُذُور) + man2.swf (رِجَال) + leg4.swf (رِجْل)
// - المدود: mad.swf + gabermad.swf (جَابِر) + facemad.swf (وُجُوه) + nagibmad.swf (نَجِيب)
// - الكتابة: write.swf (4 خطوات أصلية)
// - الكلمات: ka1..ka4.swf (4 صفحات × 4 كلمات = 16 كلمة أصلية)
// - الألعاب: fish1..4.swf + bee1..4.swf + cir1..3.swf + words1..4.swf + paint1..3.swf
// ─────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/jeem/';
const String _audio = 'audio/lessons/jeem/final/';
const String _soundsAudio = 'audio/lessons/jeem/sounds/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest jeemManifest = LetterUnitManifest(
  letter: 'ج',
  unitTitle: 'الْوَحْدَةُ الْخَامِسَةُ | حَرْفُ الْجِيمِ (ج)',
  topBarColor: Color(0xFF00695C), // أخضر زمردي عميق
  highlightColor: Color(0xFFE0F2F1), // أخضر فاتح جداً
  mascotEmoji: '🐫', // جمل
  unitIndex: 5,
  nextLetter: 'ح',

  // ── الأهداف ──────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}jeem_goal.mp3', // ✅ أصلي من ahdaf_a.swf (600 KB)
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الْجِيمِ (ج)',
      'أَنْطِقُ حَرْفَ الْجِيمِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الْجِيمِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الْجِيمِ',
      'أَتَتَبَّعُ حَرْفَ الْجِيمِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الْجِيمِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الْجِيمِ',
    ],
  ),

  // ── القصة (7 مشاهد أصلية كاملة مع النشيد والنشاط التفاعلي) ─────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_1.png',
        audioPath: '${_audio}jeem_story_1.mp3',
        captionText: 'الْعَمُّ أَحْمَدُ رَجُلٌ مَشْهُورٌ، يَعِيشُ فِي وَاحَةٍ صَحْرَاوِيَّةٍ خَضْرَاءَ، يَعْمَلُ تَاجِرًا.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_2.png',
        audioPath: '${_audio}jeem_story_2.mp3',
        captionText: 'فِي يَوْمٍ جَاءَ بِبِضَاعَةٍ كَثِيرَةٍ عَلَى الْجَمَلِ، وَكَانَ الْحِمْلُ ثَقِيلًا.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_3.png',
        audioPath: '${_audio}jeem_story_3.mp3',
        captionText: 'مَشَى الْجَمَلُ فِي الصَّحْرَاءِ مَسَافَةً طَوِيلَةً، وَهُوَ صَابِرٌ عَلَى ثِقَلِ الْحِمْلِ وَبُعْدِ الْمَسَافَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_4.png',
        audioPath: '${_audio}jeem_story_4.mp3',
        captionText: 'وَتَحَمَّلَ حَتَّى وَصَلَ إِلَى الْوَاحَةِ الْخَضْرَاءِ.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_5.png',
        audioPath: '${_audio}jeem_story_5.mp3',
        captionText: 'فَشَرِبَ مَاءً كَثِيرًا، وَشَكَرَ رَبَّهُ عَلَى نِعْمَةِ الْمَاءِ، وَنِعْمَةِ تَحَمُّلِ الْجُوعِ وَالْعَطَشِ وَالصَّبْرِ.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_6.png',
        audioPath: '${_audio}jeem_story_6.mp3',
        isNasheed: true,
        captionText: 'جِيمٌ جَمَلٌ فِي الصَّحْرَاءِ .. مِثْلُ سَفِينَةَ فَوْقَ الْمَاءِ 🎵',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_7.png',
        audioPath: '${_audio}jeem_story_7.mp3',
        captionText: 'الْجَمَلُ يَتَحَمَّلُ الْجُوعَ وَالْعَطَشَ وَارْتِفَاعَ الْحَرَارَةِ؛ لِذَلِكَ يُطْلَقُ عَلَيْهِ: (سَفِينَةُ الصَّحْرَاءِ).',
        interaction: WordFindStoryInteraction(
          instructionText: 'الْجَمَلُ يَتَحَمَّلُ الْجُوعَ وَالْعَطَشَ وَارْتِفَاعَ الْحَرَارَةِ، لِذَلِكَ يُطْلَقُ عَلَيْهِ:',
          instructionAudioPath: '${_audio}jeem_story_7.mp3',
          correctAudioPath: '${_audio}jeem_story_correct.mp3',
          wrongAudioPath: '${_audio}jeem_story_wrong.mp3',
          targets: [
            StoryTargetItem(
              label: 'صَدِيقُ الْفَلَّاحِ',
              left: 0.058,
              top: 0.400,
              right: 0.502,
              bottom: 0.546,
              isCorrect: false,
              wordAudioPath: '${_audio}jeem_choice_sadeeq.mp3',
            ),
            StoryTargetItem(
              label: 'سَفِينَةُ الصَّحْرَاءِ',
              left: 0.132,
              top: 0.548,
              right: 0.504,
              bottom: 0.728,
              isCorrect: true,
              wordAudioPath: '${_audio}jeem_choice_safeena.mp3',
            ),
            StoryTargetItem(
              label: 'مَلِكُ الْغَابَةِ',
              left: 0.130,
              top: 0.731,
              right: 0.468,
              bottom: 0.911,
              isCorrect: false,
              wordAudioPath: '${_audio}jeem_choice_malek.mp3',
            ),
          ],
        ),
      ),
    ],
  ),

  // ── الأصوات (حركات قصيرة — carrot1, root3, man2, leg4) ────────────────────
  vowels: VowelsSpec(
    letterChar: 'ج',
    items: [
      VowelItem(
        displayChar: 'جَ',
        fathaAudio: '${_soundsAudio}jeem_fatha.mp3',
        dammaAudio: '${_soundsAudio}jeem_damma.mp3',
        kasraAudio: '${_soundsAudio}jeem_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة — mad, gabermad, facemad, nagibmad) ───────────────
  madd: MaddSpec(
    letterChar: 'ج',
    items: [
      MaddItem(
        displayChar: 'جَا',
        audioPath: '${_soundsAudio}jeem_madd_alif.mp3',
        imagePath: '${_dir}jeem_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'جُو',
        audioPath: '${_soundsAudio}jeem_madd_waw.mp3',
        imagePath: '${_dir}jeem_madd_uu.png',
      ),
      MaddItem(
        displayChar: 'جِي',
        audioPath: '${_soundsAudio}jeem_madd_yaa.mp3',
        imagePath: '${_dir}jeem_madd_ii.png',
      ),
    ],
  ),

  // ── الكتابة (4 خطوات أصلية من write.swf) ──────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ج',
    audioIntroPath: '${_audio}jeem_write_intro.mp3',
    stepImagePaths: [
      '${_dir}jeem_write_step_1.png',
      '${_dir}jeem_write_step_2.png',
      '${_dir}jeem_write_step_3.png',
      '${_dir}jeem_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف — 4 صفحات أصلية من ka1..ka4.swf (16 كلمة) ─────────────────
  // الإحداثيات نسبية (0.0..1.0) — الصور 800×474 بكسل مطابقة للأسطوانة
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka1.swf): جَمَل (أحمر)، رَجُل (برتقالي)، جَزَر (أخضر)، رِجْل (أزرق)
      WordsPage(
        listImagePath: '${_dir}jeem_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'جَمَل',
            cardImagePath: '${_dir}jeem_words_p1_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'رَجُل',
            cardImagePath: '${_dir}jeem_words_p1_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جَزَر',
            cardImagePath: '${_dir}jeem_words_p1_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'رِجْل',
            cardImagePath: '${_dir}jeem_words_p1_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 2 (ka2.swf): جِذْر (أحمر)، جَابِر (برتقالي)، بُرْج (أخضر)، وُجُوه (أزرق)
      WordsPage(
        listImagePath: '${_dir}jeem_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'جِذْر',
            cardImagePath: '${_dir}jeem_words_p2_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جَابِر',
            cardImagePath: '${_dir}jeem_words_p2_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'بُرْج',
            cardImagePath: '${_dir}jeem_words_p2_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'وُجُوه',
            cardImagePath: '${_dir}jeem_words_p2_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 3 (ka3.swf): نَجِيب (أحمر)، شَجَرَة (برتقالي)، ثَلْج (أخضر)، تَاجِر (أزرق)
      WordsPage(
        listImagePath: '${_dir}jeem_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'نَجِيب',
            cardImagePath: '${_dir}jeem_words_p3_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p3_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'شَجَرَة',
            cardImagePath: '${_dir}jeem_words_p3_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p3_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَلْج',
            cardImagePath: '${_dir}jeem_words_p3_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p3_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'تَاجِر',
            cardImagePath: '${_dir}jeem_words_p3_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p3_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 4 (ka4.swf): جَبَل (أحمر)، ثَلَّاجَة (برتقالي)، جَرَس (أخضر)، دَجَاجَة (أزرق)
      WordsPage(
        listImagePath: '${_dir}jeem_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'جَبَل',
            cardImagePath: '${_dir}jeem_words_p4_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَلَّاجَة',
            cardImagePath: '${_dir}jeem_words_p4_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جَرَس',
            cardImagePath: '${_dir}jeem_words_p4_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَجَاجَة',
            cardImagePath: '${_dir}jeem_words_p4_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
    ],
  ),

  // ── الألعاب (5 ألعاب أصلية كاملة) ─────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'جَمَل', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_1.png', audioPath: '${_audio}jeem_word_p1_1.mp3', isCorrect: true),
      FishingRound(word: 'جَبَل', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_2.png', audioPath: '${_audio}jeem_word_p1_2.mp3', isCorrect: true),
      FishingRound(word: 'جَزَرَة', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_3.png', audioPath: '${_audio}jeem_word_p1_3.mp3', isCorrect: true),
      FishingRound(word: 'جَرَس', imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_4.png', audioPath: '${_audio}jeem_word_p1_4.mp3', isCorrect: true),
    ],
    beehive: [
      BeehiveRound(word: 'جَمَل', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_1.png', audioPath: '${_audio}jeem_word_p1_1.mp3'),
      BeehiveRound(word: 'جِسْر', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_2.png', audioPath: '${_audio}jeem_word_p3_3.mp3'),
      BeehiveRound(word: 'جُحْر', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_3.png', audioPath: '${_audio}jeem_word_p4_1.mp3'),
      BeehiveRound(word: 'جَبَل', imagePath: '${_gamesDir}beehive/jeem/jeem_beehive_round_4.png', audioPath: '${_audio}jeem_word_p1_2.mp3'),
    ],
    circus: [
      CircusRound(word: 'جَمَل', imagePath: '${_gamesDir}circus/jeem/jeem_circus_1.png', audioPath: '${_audio}jeem_word_p1_1.mp3'),
      CircusRound(word: 'جَبَل', imagePath: '${_gamesDir}circus/jeem/jeem_circus_2.png', audioPath: '${_audio}jeem_word_p1_2.mp3'),
      CircusRound(word: 'جَزَرَة', imagePath: '${_gamesDir}circus/jeem/jeem_circus_3.png', audioPath: '${_audio}jeem_word_p1_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'جَمَل', imagePath: '${_gamesDir}words/jeem/jeem_match_1.png', audioPath: '${_audio}jeem_word_p1_1.mp3'),
      WordsMatchPair(word: 'جَبَل', imagePath: '${_gamesDir}words/jeem/jeem_match_2.png', audioPath: '${_audio}jeem_word_p1_2.mp3'),
      WordsMatchPair(word: 'جَزَرَة', imagePath: '${_gamesDir}words/jeem/jeem_match_3.png', audioPath: '${_audio}jeem_word_p1_3.mp3'),
      WordsMatchPair(word: 'جَرَس', imagePath: '${_gamesDir}words/jeem/jeem_match_4.png', audioPath: '${_audio}jeem_word_p1_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'جَابِر',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_1.png',
        introAudioPath: '${_gamesAudio}coloring/jeem_paint1_word.mp3',
        revealAudioPath: '${_gamesAudio}coloring/jeem_paint1_ahsant.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_1.png', color: Color(0xFFC8A96E)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_1.png', color: Color(0xFF8D6E63)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_1.png', color: Color(0xFFFFD54F)),
        ],
      ),
      ColoringRound(
        word: 'وُجُوه',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/jeem_paint2_word.mp3',
        revealAudioPath: '${_gamesAudio}coloring/jeem_paint2_ahsant.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_2.png', color: Color(0xFF78909C)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_2.png', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_2.png', color: Color(0xFF90A4AE)),
        ],
      ),
      ColoringRound(
        word: 'نَجِيب',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_3.png',
        introAudioPath: '${_soundsAudio}word_najeeb.mp3',
        revealAudioPath: '${_gamesAudio}coloring/jeem_paint3_ahsant.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_3.png', color: Color(0xFFFF7043)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_3.png', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_word_3.png', color: Color(0xFFFFF176)),
        ],
      ),
    ],
  ),
);
