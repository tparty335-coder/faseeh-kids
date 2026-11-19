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
    audioPath: 'audio/lessons/jeem/final/jeem_letter.mp3', // ✅ أصلي من ahdaf_a.swf (600 KB)
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
        imagePath: '${_dir}jeem_cd_story_1.webp',
        audioPath: '${_audio}jeem_story_1.mp3',
        captionText: 'الْعَمُّ أَحْمَدُ رَجُلٌ مَشْهُورٌ، يَعِيشُ فِي وَاحَةٍ صَحْرَاوِيَّةٍ خَضْرَاءَ، يَعْمَلُ تَاجِرًا.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_2.webp',
        audioPath: '${_audio}jeem_story_2.mp3',
        captionText: 'فِي يَوْمٍ جَاءَ بِبِضَاعَةٍ كَثِيرَةٍ عَلَى الْجَمَلِ، وَكَانَ الْحِمْلُ ثَقِيلًا.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_3.webp',
        audioPath: '${_audio}jeem_story_3.mp3',
        captionText: 'مَشَى الْجَمَلُ فِي الصَّحْرَاءِ مَسَافَةً طَوِيلَةً، وَهُوَ صَابِرٌ عَلَى ثِقَلِ الْحِمْلِ وَبُعْدِ الْمَسَافَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_4.webp',
        audioPath: '${_audio}jeem_story_4.mp3',
        captionText: 'وَتَحَمَّلَ حَتَّى وَصَلَ إِلَى الْوَاحَةِ الْخَضْرَاءِ.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_5.webp',
        audioPath: '${_audio}jeem_story_5.mp3',
        captionText: 'فَشَرِبَ مَاءً كَثِيرًا، وَشَكَرَ رَبَّهُ عَلَى نِعْمَةِ الْمَاءِ، وَنِعْمَةِ تَحَمُّلِ الْجُوعِ وَالْعَطَشِ وَالصَّبْرِ.',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_6.webp',
        audioPath: 'audio/lessons/jeem/final/jeem_nasheed.mp3',
        isNasheed: true,
        captionText: 'جِيمٌ جَمَلٌ فِي الصَّحْرَاءِ .. مِثْلُ سَفِينَةَ فَوْقَ الْمَاءِ 🎵',
      ),
      StoryScene(
        imagePath: '${_dir}jeem_cd_story_7.webp',
        audioPath: '${_audio}jeem_story_7.mp3',
        captionText: 'الْجَمَلُ يَتَحَمَّلُ الْجُوعَ وَالْعَطَشَ وَارْتِفَاعَ الْحَرَارَةِ؛ لِذَلِكَ يُطْلَقُ عَلَيْهِ: (سَفِينَةُ الصَّحْرَاءِ).',
        interaction: WordFindStoryInteraction(
          instructionText: 'الْجَمَلُ يَتَحَمَّلُ الْجُوعَ وَالْعَطَشَ وَارْتِفَاعَ الْحَرَارَةِ، لِذَلِكَ يُطْلَقُ عَلَيْهِ:',
          instructionAudioPath: '${_audio}jeem_story_7.mp3',
          correctAudioPath: 'audio/feedback/smart.mp3',
          wrongAudioPath: 'audio/feedback/try_again.mp3',
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
        dammaAudio: 'audio/letters/short_vowels/jeem_damma.mp3',
        kasraAudio: 'audio/letters/short_vowels/jeem_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة — mad, gabermad, facemad, nagibmad) ───────────────
  madd: MaddSpec(
    letterChar: 'ج',
    items: [
      MaddItem(
        displayChar: 'جَا',
        audioPath: 'audio/letters/long_vowels/jeem_madd_demo.mp3',
        imagePath: '${_dir}jeem_madd_aa.webp',
      ),
      MaddItem(
        displayChar: 'جُو',
        audioPath: '${_soundsAudio}jeem_madd_waw.mp3',
        imagePath: '${_dir}jeem_madd_uu.webp',
      ),
      MaddItem(
        displayChar: 'جِي',
        audioPath: '${_soundsAudio}jeem_madd_yaa.mp3',
        imagePath: '${_dir}jeem_madd_ii.webp',
      ),
    ],
  ),

  // ── الكتابة (4 خطوات أصلية من write.swf) ──────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ج',
    audioIntroPath: '${_audio}jeem_write_intro.mp3',
    stepImagePaths: [
      '${_dir}jeem_write_step_1.webp',
      '${_dir}jeem_write_step_2.webp',
      '${_dir}jeem_write_step_3.webp',
      '${_dir}jeem_write_step_4.webp',
    ],
  ),

  // ── كلمات الحرف — 4 صفحات أصلية من ka1..ka4.swf (16 كلمة) ─────────────────
  // الإحداثيات نسبية (0.0..1.0) — الصور 800×474 بكسل مطابقة للأسطوانة
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka1.swf): جَمَل (أحمر)، رَجُل (برتقالي)، جَزَر (أخضر)، رِجْل (أزرق)
      WordsPage(
        listImagePath: '${_dir}jeem_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'جَمَل',
            cardImagePath: '${_dir}jeem_words_p1_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'رَجُل',
            cardImagePath: '${_dir}jeem_words_p1_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جَزَر',
            cardImagePath: '${_dir}jeem_words_p1_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p1_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'رِجْل',
            cardImagePath: '${_dir}jeem_words_p1_card_4.webp',
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
        listImagePath: '${_dir}jeem_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'جِذْر',
            cardImagePath: '${_dir}jeem_words_p2_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جَابِر',
            cardImagePath: '${_dir}jeem_words_p2_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'بُرْج',
            cardImagePath: '${_dir}jeem_words_p2_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p2_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'وُجُوه',
            cardImagePath: '${_dir}jeem_words_p2_card_4.webp',
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
        listImagePath: '${_dir}jeem_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'نَجِيب',
            cardImagePath: '${_dir}jeem_words_p3_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p3_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'شَجَرَة',
            cardImagePath: 'assets/images/lessons/jeem/sounds/najm.webp',
            cardHeight: 474,
            audioPath: 'audio/lessons/taa/final/taa_word_p5_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَلْج',
            cardImagePath: '${_dir}jeem_words_p3_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p3_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'تَاجِر',
            cardImagePath: '${_dir}jeem_words_p3_card_4.webp',
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
        listImagePath: '${_dir}jeem_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'جَبَل',
            cardImagePath: 'assets/images/lessons/jeem/sounds/jabal.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَلَّاجَة',
            cardImagePath: '${_dir}jeem_words_p4_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جَرَس',
            cardImagePath: '${_dir}jeem_words_p4_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}jeem_word_p4_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'دَجَاجَة',
            cardImagePath: '${_dir}jeem_words_p4_card_4.webp',
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
    fishingIntroAudio: '${_gamesAudio}fishing/fish1_5_al12.mp3',
    fishingPromptAudio: '${_gamesAudio}fishing/fish1_7_131.mp3',
    fishingWrongAudio: 'audio/feedback/try_again.mp3',
    beehivePromptAudio: '${_gamesAudio}beehive/bee1_6_130.mp3',
    beehiveWrongAudio: 'audio/feedback/try_again.mp3',
    circusPromptAudio: '${_gamesAudio}circus/jeem/jeem_circus_prompt.mp3',
    circusWrongAudio: 'audio/feedback/try_again.mp3',
    wordsMatchPromptAudio: 'audio/instructions/words_drag_instruction.mp3',
    wordsMatchWrongAudio: 'audio/feedback/try_again.mp3',
    coloringIntroAudio: 'audio/instructions/alif_paint_intro.mp3',
    coloringStep1Audio: 'audio/instructions/alif_paint_explain.mp3',
    coloringStep2Audio: '${_gamesAudio}coloring/2_qu3.mp3',
    coloringWrongAudio: '${_gamesAudio}coloring/5_al23.mp3',
    fishing: [
      FishingRound(
        word: 'بُرْج',
        imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_1.webp',
        audioPath: '${_gamesAudio}fishing/jeem/jeem_fishing_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/common/encourage_1.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 1024,
        imgH: 465,
        zones: [
          GameZoneChoice(label: 'بُرْج', isCorrect: true, px: 185, py: 375, w: 290, h: 120),
          GameZoneChoice(label: 'رَأْس', isCorrect: false, px: 500, py: 345, w: 300, h: 120),
          GameZoneChoice(label: 'مِفْتَاح', isCorrect: false, px: 805, py: 398, w: 290, h: 120),
        ],
      ),
      FishingRound(
        word: 'شَجَرَة',
        imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_2.webp',
        audioPath: 'audio/games/match/jeem/jeem_match_2.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 1024,
        imgH: 465,
        zones: [
          GameZoneChoice(label: 'وَرْدَة', isCorrect: false, px: 185, py: 375, w: 290, h: 120),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, px: 500, py: 345, w: 300, h: 120),
          GameZoneChoice(label: 'شَجَرَة', isCorrect: true, px: 805, py: 398, w: 290, h: 120),
        ],
      ),
      FishingRound(
        word: 'جَمَل',
        imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_3.webp',
        audioPath: 'audio/games/match/jeem/jeem_match_1.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/correct.mp3',
        roundEndPraiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 1024,
        imgH: 465,
        zones: [
          GameZoneChoice(label: 'قَلَم', isCorrect: false, px: 185, py: 375, w: 290, h: 120),
          GameZoneChoice(label: 'جَمَل', isCorrect: true, px: 500, py: 345, w: 300, h: 120),
          GameZoneChoice(label: 'أَرْنَب', isCorrect: false, px: 805, py: 398, w: 290, h: 120),
        ],
      ),
      FishingRound(
        word: 'ثَلَّاجَة',
        imagePath: '${_gamesDir}fishing/jeem/jeem_fishing_4.webp',
        audioPath: 'audio/games/match/jeem/jeem_match_4.mp3',
        isCorrect: true,
        correctPraiseAudio: 'audio/feedback/smart.mp3',
        roundEndPraiseAudio: 'audio/feedback/correct.mp3',
        imgW: 1024,
        imgH: 465,
        zones: [
          GameZoneChoice(label: 'مِرْوَحَة', isCorrect: false, px: 185, py: 375, w: 290, h: 120),
          GameZoneChoice(label: 'غَسَّالَة', isCorrect: false, px: 500, py: 345, w: 300, h: 120),
          GameZoneChoice(label: 'ثَلَّاجَة', isCorrect: true, px: 805, py: 398, w: 290, h: 120),
        ],
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'جَزَر',
        imagePath: 'assets/images/games/beehive/jeem_beehive_round_1.webp',
        audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 146,
        cells: [
          GameZoneChoice(label: 'جُ', isCorrect: false, px: 689, py: 175),
          GameZoneChoice(label: 'جِ', isCorrect: false, px: 543, py: 255),
          GameZoneChoice(label: 'جَ', isCorrect: true, px: 741, py: 257),
          GameZoneChoice(label: 'جْ', isCorrect: false, px: 593, py: 344),
        ],
      ),
      BeehiveRound(
        word: 'وُجُوه',
        imagePath: 'assets/images/games/beehive/jeem_beehive_round_2.webp',
        audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 146,
        cells: [
          GameZoneChoice(label: 'جُ', isCorrect: true, px: 689, py: 175),
          GameZoneChoice(label: 'جِ', isCorrect: false, px: 543, py: 255),
          GameZoneChoice(label: 'جَ', isCorrect: false, px: 741, py: 257),
          GameZoneChoice(label: 'جْ', isCorrect: false, px: 593, py: 344),
        ],
      ),
      BeehiveRound(
        word: 'جِذْر',
        imagePath: 'assets/images/games/beehive/jeem_beehive_round_3.webp',
        audioPath: '${_gamesAudio}beehive/jeem/jeem_beehive_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 146,
        cells: [
          GameZoneChoice(label: 'جُ', isCorrect: false, px: 689, py: 175),
          GameZoneChoice(label: 'جِ', isCorrect: true, px: 543, py: 255),
          GameZoneChoice(label: 'جَ', isCorrect: false, px: 741, py: 257),
          GameZoneChoice(label: 'جْ', isCorrect: false, px: 593, py: 344),
        ],
      ),
      BeehiveRound(
        word: 'رِجْل',
        imagePath: 'assets/images/games/beehive/jeem_beehive_round_4.webp',
        audioPath: 'audio/games/circus/raa/raa_circus_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 440,
        speakerPx: 502,
        speakerPy: 146,
        cells: [
          GameZoneChoice(label: 'جُ', isCorrect: false, px: 689, py: 175),
          GameZoneChoice(label: 'جِ', isCorrect: false, px: 543, py: 255),
          GameZoneChoice(label: 'جَ', isCorrect: false, px: 741, py: 257),
          GameZoneChoice(label: 'جْ', isCorrect: true, px: 593, py: 344),
        ],
      ),
    ],
    circus: [
      CircusRound(
        word: 'جَمَل',
        imagePath: '${_gamesDir}circus/jeem/jeem_circus_1.webp',
        audioPath: 'audio/games/match/jeem/jeem_match_1.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'فَرَاشَة', isCorrect: false, px: 145, py: 97),
          GameZoneChoice(label: 'دُبّ', isCorrect: false, px: 274, py: 236),
          GameZoneChoice(label: 'جَمَل', isCorrect: true, px: 140, py: 386),
        ],
      ),
      CircusRound(
        word: 'ثَلَّاجَة',
        imagePath: '${_gamesDir}circus/jeem/jeem_circus_2.webp',
        audioPath: 'audio/games/match/jeem/jeem_match_4.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'مِرْوَحَة', isCorrect: false, px: 145, py: 97),
          GameZoneChoice(label: 'ثَلَّاجَة', isCorrect: true, px: 274, py: 236),
          GameZoneChoice(label: 'فُرْشَاة', isCorrect: false, px: 140, py: 386),
        ],
      ),
      CircusRound(
        word: 'دَجَاجَة',
        imagePath: '${_gamesDir}circus/jeem/jeem_circus_3.webp',
        audioPath: '${_gamesAudio}circus/jeem/jeem_circus_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        zones: [
          GameZoneChoice(label: 'دَجَاجَة', isCorrect: true, px: 145, py: 97),
          GameZoneChoice(label: 'كَلْب', isCorrect: false, px: 274, py: 236),
          GameZoneChoice(label: 'نَحْلَة', isCorrect: false, px: 140, py: 386),
        ],
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'جَمَل',
        imagePath: 'assets/images/games/match/jeem/jeem_match_1.webp',
        audioPath: '${_gamesAudio}match/jeem/jeem_match_1.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 456,
        cardPx: 178,
        cardPyList: [124, 236, 352],
        dropPx: 505,
        dropPy: 423,
        cards: [
          GameZoneChoice(label: 'بَطَّة', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'جَمَل', isCorrect: true, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'مِفْتَاح', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'شَجَرَة',
        imagePath: 'assets/images/games/match/jeem/jeem_match_2.webp',
        audioPath: '${_gamesAudio}match/jeem/jeem_match_2.mp3',
        praiseAudio: 'audio/feedback/great.mp3',
        imgW: 800,
        imgH: 456,
        cardPx: 178,
        cardPyList: [124, 236, 352],
        dropPx: 505,
        dropPy: 423,
        cards: [
          GameZoneChoice(label: 'شَجَرَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'نَخْلَة', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'رَأْس', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'دَجَاجَة',
        imagePath: 'assets/images/games/match/jeem/jeem_match_3.webp',
        audioPath: '${_gamesAudio}match/jeem/jeem_match_3.mp3',
        praiseAudio: 'audio/feedback/smart.mp3',
        imgW: 800,
        imgH: 456,
        cardPx: 178,
        cardPyList: [124, 236, 352],
        dropPx: 505,
        dropPy: 423,
        cards: [
          GameZoneChoice(label: 'وُجُوه', isCorrect: false, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'شُبَّاك', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'دَجَاجَة', isCorrect: true, colorValue: 0xFFFFD17A),
        ],
      ),
      WordsMatchPair(
        word: 'ثَلَّاجَة',
        imagePath: 'assets/images/games/match/jeem/jeem_match_4.webp',
        audioPath: '${_gamesAudio}match/jeem/jeem_match_4.mp3',
        praiseAudio: 'audio/common/encourage_1.mp3',
        imgW: 800,
        imgH: 456,
        cardPx: 178,
        cardPyList: [124, 236, 352],
        dropPx: 505,
        dropPy: 432,
        cards: [
          GameZoneChoice(label: 'ثَلَّاجَة', isCorrect: true, colorValue: 0xFF5AC8FA),
          GameZoneChoice(label: 'ثُعْبَان', isCorrect: false, colorValue: 0xFFFF9EB5),
          GameZoneChoice(label: 'جَبَل', isCorrect: false, colorValue: 0xFFFFD17A),
        ],
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'جَابِر',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_1.webp',
        wordRevealImagePath: 'assets/images/games/coloring/jeem_coloring_word_1.webp',
        introAudioPath: '${_gamesAudio}coloring/jeem_paint1_word.mp3',
        revealAudioPath: '${_gamesAudio}coloring/jeem_paint1_ahsant.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/jeem/jeem_paint1_wrong.mp3',
        wordAudioPath: '${_audio}jeem_word_p2_2.mp3',
        imgW: 1024,
        imgH: 490,
        wordX: 208,
        wordY: 190,
        wordW: 490,
        wordH: 160,
        cardCx: 82,
        cardCyList: [91, 248, 410],
        cardW: 142,
        cardH: 124,
        options: [
          GameZoneChoice(label: 'جَزَر', isCorrect: false),
          GameZoneChoice(label: 'رَجُل', isCorrect: false),
          GameZoneChoice(label: 'جَابِر', isCorrect: true),
        ],
        slices: [
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_1.webp', color: Color(0xFFC8A96E)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_1.webp', color: Color(0xFF8D6E63)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_1.webp', color: Color(0xFFFFD54F)),
        ],
      ),
      ColoringRound(
        word: 'وُجُوه',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_2.webp',
        wordRevealImagePath: 'assets/images/games/coloring/jeem_coloring_word_2.webp',
        introAudioPath: 'audio/games/coloring/alif_good_inas.mp3',
        revealAudioPath: '${_gamesAudio}coloring/jeem_paint2_ahsant.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/jeem/jeem_paint2_wrong.mp3',
        wordAudioPath: '${_audio}jeem_word_p2_4.mp3',
        imgW: 1024,
        imgH: 490,
        wordX: 208,
        wordY: 190,
        wordW: 490,
        wordH: 160,
        cardCx: 82,
        cardCyList: [91, 248, 410],
        cardW: 142,
        cardH: 124,
        options: [
          GameZoneChoice(label: 'جَبَل', isCorrect: false),
          GameZoneChoice(label: 'وُجُوه', isCorrect: true),
          GameZoneChoice(label: 'جِذْر', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_2.webp', color: Color(0xFF78909C)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_2.webp', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_2.webp', color: Color(0xFF90A4AE)),
        ],
      ),
      ColoringRound(
        word: 'نَجِيب',
        bgImagePath: '${_gamesDir}coloring/jeem/jeem_coloring_3.webp',
        wordRevealImagePath: 'assets/images/games/coloring/jeem_coloring_word_3.webp',
        introAudioPath: '${_audio}jeem_word_p3_1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/jeem_paint3_ahsant.mp3',
        wrongRevealAudioPath: '${_gamesAudio}coloring/jeem/jeem_paint3_wrong.mp3',
        wordAudioPath: '${_audio}jeem_word_p3_1.mp3',
        imgW: 1024,
        imgH: 490,
        wordX: 208,
        wordY: 190,
        wordW: 490,
        wordH: 160,
        cardCx: 82,
        cardCyList: [91, 248, 410],
        cardW: 142,
        cardH: 124,
        options: [
          GameZoneChoice(label: 'نَجِيب', isCorrect: true),
          GameZoneChoice(label: 'جَمَل', isCorrect: false),
          GameZoneChoice(label: 'بُرْج', isCorrect: false),
        ],
        slices: [
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_3.webp', color: Color(0xFFFF7043)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_3.webp', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: 'assets/images/games/coloring/jeem_coloring_word_3.webp', color: Color(0xFFFFF176)),
        ],
      ),
    ],
  ),
);
