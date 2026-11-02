import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف التاء (ت) — الـ Pilot على المحرك الموحّد ─────────────────
// TODO: استبدل إحداثيات الـ hotspot والأصوات والصور بالقيم المستخرجة من SWF
// المصدر المرجعي: d:\Projects\faseeh_kids\scratch\extracted_taa\
// ────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/taa/';
const String _audio = 'audio/lessons/taa/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف التاء — مرتبط بالأصول المستخرجة من أسطوانة الوزارة الأصلية
const LetterUnitManifest taaManifest = LetterUnitManifest(
  letter: 'ت',
  unitTitle: 'الْوَحْدَةُ الثَّالِثَةُ | حَرْفُ التَّاءِ (ت)',
  topBarColor: Color(0xFF1565C0),
  highlightColor: Color(0xFFFFF176),
  mascotEmoji: '🍎', // تفاحة التاء الأصلية في الأسطوانة
  unitIndex: 3,
  nextLetter: 'ث',

  // ── الأهداف ──────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}taa_goal.mp3', // ✅ أصلي من الأسطوانة
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ التَّاءِ (ت)',
      'أَنْطِقُ حَرْفَ التَّاءِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ التَّاءِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ التَّاءِ',
      'أَتَتَبَّعُ حَرْفَ التَّاءِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ التَّاءِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ التَّاءِ',
      'أُنْشِئُ كَلِمَاتٍ جَدِيدَةً بِحَرْفِ التَّاءِ',
    ],
  ),

  // ── القصة (٦ مشاهد أصلية مطابقة للأسطوانة) ────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}taa_cd_story_1.png',
        audioPath: '${_audio}taa_story_1.mp3', // تامر يحب الحقل ويذهب إليه كل أسبوع مع أبيه
      ),
      StoryScene(
        imagePath: '${_dir}taa_cd_story_2.png',
        audioPath: '${_audio}taa_story_2.mp3', // الحقل فيه أشجار تفاح وأشجار تين
      ),
      StoryScene(
        imagePath: '${_dir}taa_cd_story_3.png',
        audioPath: '${_audio}taa_story_3.mp3', // يساعد تامر والده في جمع التين والتفاح
      ),
      StoryScene(
        imagePath: '${_dir}taa_cd_story_4.png',
        audioPath: '${_audio}taa_story_4.mp3', // ويعود إلى البيت مسروراً
      ),
      StoryScene(
        imagePath: '${_dir}taa_cd_story_5.png',
        audioPath: '${_audio}taa_story_5.mp3', // تامر حوله عناصر كثيرة بها حرف التاء ابحث عنها واضغط عليها
        interaction: WordFindStoryInteraction(
          instructionText: 'تَامِرُ حَوْلَهُ عَنَاصِرُ كَثِيرَةٌ بِهَا حَرْفُ التَّاءِ.. ابْحَثْ عَنْهَا وَاضْغَطْ عَلَيْهَا',
          instructionAudioPath: '${_audio}taa_story_5.mp3',
          correctAudioPath: 'assets/audio/feedback/correct.mp3',
          wrongAudioPath: 'assets/audio/feedback/try_again.mp3',
          targets: [
            StoryTargetItem(
              label: 'بَيْت',
              left: 0.35,
              top: 0.14,
              right: 0.50,
              bottom: 0.36,
              isCorrect: true,
              wordAudioPath: 'assets/audio/lessons/taa/sounds/word_bayt.mp3',
            ),
            StoryTargetItem(
              label: 'تَامِر',
              left: 0.26,
              top: 0.43,
              right: 0.42,
              bottom: 0.65,
              isCorrect: true,
              wordAudioPath: 'assets/audio/lessons/taa/final/taa_kw_tamer.mp3',
            ),
            StoryTargetItem(
              label: 'تُفَّاح',
              left: 0.13,
              top: 0.63,
              right: 0.30,
              bottom: 0.85,
              isCorrect: true,
              wordAudioPath: 'assets/audio/lessons/taa/final/taa_word_tufah.mp3',
            ),
            StoryTargetItem(
              label: 'دَجَاجَة',
              left: 0.65,
              top: 0.57,
              right: 0.82,
              bottom: 0.80,
              isCorrect: false,
            ),
          ],
        ),
      ),
      StoryScene(
        imagePath: '${_dir}taa_cd_story_6.png',
        audioPath: '${_audio}taa_story_6.mp3',
      ),
      StoryScene(
        imagePath: '${_dir}taa_cd_story_nasheed.png',
        audioPath: '${_audio}taa_nasheed.mp3', // نشيد الحرف (تاء تاج فوق الرأس يزين ملكاً قوي البأس)
        isNasheed: true,
      ),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ت',
    items: [
      VowelItem(
        displayChar: 'تَ',
        fathaAudio: '${_vowelsAudio}taa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}taa_damma.mp3',
        kasraAudio: '${_vowelsAudio}taa_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ─────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ت',
    items: [
      MaddItem(
        displayChar: 'تَا',
        audioPath: 'audio/lessons/taa/madd/taa_madd_alif.mp3',
        imagePath: '${_dir}taa_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'تِي',
        audioPath: 'audio/lessons/taa/madd/taa_madd_yaa.mp3',
        imagePath: '${_dir}taa_madd_ii.png',
      ),
      MaddItem(
        displayChar: 'تُو',
        audioPath: 'audio/lessons/taa/madd/taa_madd_waw.mp3',
        imagePath: '${_dir}taa_madd_uu.png',
      ),
    ],
  ),

  // ── الكتابة ───────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ت',
    audioIntroPath: '${_audio}taa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}taa_write_step_1.png',
      '${_dir}taa_write_step_2.png',
      '${_dir}taa_write_step_3.png',
      '${_dir}taa_write_step_4.png',
      '${_dir}taa_write_step_5.png',
    ],
  ),

  // ── كلمات الحرف (٥ صفحات × ٤ كلمات = ٢٠ كلمة أصلية من ka_t1..ka_t5.swf) ──
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka_t1.swf): تَامِر، تُوت، تِين، تَمْر
      WordsPage(
        listImagePath: '${_dir}taa_words_p1_list.png',
        listImageHeight: 606,
        words: [
          WordItem(
            word: 'تَامِر',
            cardImagePath: '${_dir}taa_words_p1_card_1.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p1_1.mp3',
            hotspot: WordHotspot(left: 500, top: 150, right: 805, bottom: 260),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تُوت',
            cardImagePath: '${_dir}taa_words_p1_card_2.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p1_3.mp3',
            hotspot: WordHotspot(left: 140, top: 255, right: 445, bottom: 365),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تِين',
            cardImagePath: '${_dir}taa_words_p1_card_3.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p1_2.mp3',
            hotspot: WordHotspot(left: 500, top: 360, right: 805, bottom: 470),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تَمْر',
            cardImagePath: '${_dir}taa_words_p1_card_4.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p1_4.mp3',
            hotspot: WordHotspot(left: 140, top: 470, right: 445, bottom: 580),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
        ],
      ),
      // صفحة 2 (ka_t2.swf): تَأْكُلُ، كَتْكُوت، بِنْتٌ، تِمْسَاح
      WordsPage(
        listImagePath: '${_dir}taa_words_p2_list.png',
        listImageHeight: 606,
        words: [
          WordItem(
            word: 'تَأْكُلُ',
            cardImagePath: '${_dir}taa_words_p2_card_1.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p2_1.mp3',
            hotspot: WordHotspot(left: 500, top: 150, right: 805, bottom: 260),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'كَتْكُوت',
            cardImagePath: '${_dir}taa_words_p2_card_2.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p2_3.mp3',
            hotspot: WordHotspot(left: 140, top: 255, right: 445, bottom: 365),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'بِنْتٌ',
            cardImagePath: '${_dir}taa_words_p2_card_3.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p2_2.mp3',
            hotspot: WordHotspot(left: 500, top: 360, right: 805, bottom: 470),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تِمْسَاح',
            cardImagePath: '${_dir}taa_words_p2_card_4.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p2_4.mp3',
            hotspot: WordHotspot(left: 140, top: 470, right: 445, bottom: 580),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
        ],
      ),
      // صفحة 3 (ka_t3.swf): يَكْتُبُ، تِلْمِيذَة، تِلْمِيذ، تَاج
      WordsPage(
        listImagePath: '${_dir}taa_words_p3_list.png',
        listImageHeight: 606,
        words: [
          WordItem(
            word: 'يَكْتُبُ',
            cardImagePath: '${_dir}taa_words_p3_card_1.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p3_1.mp3',
            hotspot: WordHotspot(left: 500, top: 150, right: 805, bottom: 260),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تِلْمِيذَة',
            cardImagePath: '${_dir}taa_words_p3_card_2.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p3_2.mp3',
            hotspot: WordHotspot(left: 140, top: 255, right: 445, bottom: 365),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تِلْمِيذ',
            cardImagePath: '${_dir}taa_words_p3_card_3.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p3_3.mp3',
            hotspot: WordHotspot(left: 500, top: 360, right: 805, bottom: 470),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تَاج',
            cardImagePath: '${_dir}taa_words_p3_card_4.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p3_4.mp3',
            hotspot: WordHotspot(left: 140, top: 470, right: 445, bottom: 580),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
        ],
      ),
      // صفحة 4 (ka_t4.swf): تُفَّاحَة، تَلْعَب، حُوت، مِفْتَاح
      WordsPage(
        listImagePath: '${_dir}taa_words_p4_list.png',
        listImageHeight: 606,
        words: [
          WordItem(
            word: 'تُفَّاحَة',
            cardImagePath: '${_dir}taa_words_p4_card_1.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p4_1.mp3',
            hotspot: WordHotspot(left: 500, top: 150, right: 805, bottom: 260),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'تَلْعَب',
            cardImagePath: '${_dir}taa_words_p4_card_2.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p4_2.mp3',
            hotspot: WordHotspot(left: 140, top: 255, right: 445, bottom: 365),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'حُوت',
            cardImagePath: '${_dir}taa_words_p4_card_3.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p4_3.mp3',
            hotspot: WordHotspot(left: 500, top: 360, right: 805, bottom: 470),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'مِفْتَاح',
            cardImagePath: '${_dir}taa_words_p4_card_4.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p4_4.mp3',
            hotspot: WordHotspot(left: 140, top: 470, right: 445, bottom: 580),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
        ],
      ),
      // صفحة 5 (ka_t5.swf): زَرَافَة، شَجَرَة، بَطَّة، كِتَاب
      WordsPage(
        listImagePath: '${_dir}taa_words_p5_list.png',
        listImageHeight: 606,
        words: [
          WordItem(
            word: 'زَرَافَة',
            cardImagePath: '${_dir}taa_words_p5_card_1.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p5_1.mp3',
            hotspot: WordHotspot(left: 500, top: 150, right: 805, bottom: 260),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'شَجَرَة',
            cardImagePath: '${_dir}taa_words_p5_card_2.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p5_2.mp3',
            hotspot: WordHotspot(left: 140, top: 255, right: 445, bottom: 365),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'بَطَّة',
            cardImagePath: '${_dir}taa_words_p5_card_3.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p5_3.mp3',
            hotspot: WordHotspot(left: 500, top: 360, right: 805, bottom: 470),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
          WordItem(
            word: 'كِتَاب',
            cardImagePath: '${_dir}taa_words_p5_card_4.png',
            cardHeight: 606,
            audioPath: '${_audio}taa_word_p5_4.mp3',
            hotspot: WordHotspot(left: 140, top: 470, right: 445, bottom: 580),
            speakerOffset: Offset(220, 200),
            closeOffset: Offset(765, 200),
          ),
        ],
      ),
    ],
  ),

  // ── الألعاب ───────────────────────────────────────────────────────────────
  // TODO: استبدل جميع مسارات الصور والأصوات بالأصول المستخرجة من SWF
  games: GamesSpec(
    // لعبة صيد الكلمات
    fishing: [
      FishingRound(word: 'تُفَّاحَة', imagePath: '${_gamesDir}fishing/taa/taa_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/taa/taa_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بَاب', imagePath: '${_gamesDir}fishing/taa/taa_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/taa/taa_fishing_2.mp3', isCorrect: false),
      FishingRound(word: 'تِمْسَاح', imagePath: '${_gamesDir}fishing/taa/taa_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/taa/taa_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'أَسَد', imagePath: '${_gamesDir}fishing/taa/taa_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/taa/taa_fishing_4.mp3', isCorrect: false),
    ],
    // لعبة خلية النحل
    beehive: [
      BeehiveRound(word: 'تَاج', imagePath: '${_gamesDir}beehive/taa/taa_beehive_round_1.png', audioPath: '${_gamesAudio}beehive/taa/taa_beehive_1.mp3'),
      BeehiveRound(word: 'تِين', imagePath: '${_gamesDir}beehive/taa/taa_beehive_round_2.png', audioPath: '${_gamesAudio}beehive/taa/taa_beehive_2.mp3'),
      BeehiveRound(word: 'تَمْر', imagePath: '${_gamesDir}beehive/taa/taa_beehive_round_3.png', audioPath: '${_gamesAudio}beehive/taa/taa_beehive_3.mp3'),
      BeehiveRound(word: 'تُرْبَة', imagePath: '${_gamesDir}beehive/taa/taa_beehive_round_4.png', audioPath: '${_gamesAudio}beehive/taa/taa_beehive_4.mp3'),
    ],
    // لعبة السيرك
    circus: [
      CircusRound(word: 'تُفَّاحَة', imagePath: '${_gamesDir}circus/taa/taa_circus_round_1.png', audioPath: '${_gamesAudio}circus/taa/taa_circus_1.mp3'),
      CircusRound(word: 'تِمْسَاح', imagePath: '${_gamesDir}circus/taa/taa_circus_round_2.png', audioPath: '${_gamesAudio}circus/taa/taa_circus_2.mp3'),
      CircusRound(word: 'تَاج', imagePath: '${_gamesDir}circus/taa/taa_circus_round_3.png', audioPath: '${_gamesAudio}circus/taa/taa_circus_3.mp3'),
    ],
    // لعبة مطابقة الكلمات
    wordsMatch: [
      WordsMatchPair(word: 'تُفَّاحَة', imagePath: '${_gamesDir}match/taa/taa_match_1.png', audioPath: '${_gamesAudio}match/taa/taa_match_1.mp3'),
      WordsMatchPair(word: 'تِمْسَاح', imagePath: '${_gamesDir}match/taa/taa_match_2.png', audioPath: '${_gamesAudio}match/taa/taa_match_2.mp3'),
      WordsMatchPair(word: 'تَاج', imagePath: '${_gamesDir}match/taa/taa_match_3.png', audioPath: '${_gamesAudio}match/taa/taa_match_3.mp3'),
      WordsMatchPair(word: 'تِين', imagePath: '${_gamesDir}match/taa/taa_match_4.png', audioPath: '${_gamesAudio}match/taa/taa_match_4.mp3'),
    ],
    // لعبة التلوين
    coloring: [
      ColoringRound(
        word: 'تُفَّاحَة',
        bgImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/taa/taa_coloring_word_1.png',
        introAudioPath: '${_gamesAudio}coloring/taa/taa_intro_tuffaha.mp3',
        revealAudioPath: '${_gamesAudio}coloring/taa/taa_reveal_tuffaha.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_1_slice_1.png', color: Color(0xFFE53935)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_1_slice_2.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_1_slice_3.png', color: Color(0xFF795548)),
        ],
      ),
      ColoringRound(
        word: 'تِمْسَاح',
        bgImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_2.png',
        wordRevealImagePath: '${_gamesDir}coloring/taa/taa_coloring_word_2.png',
        introAudioPath: '${_gamesAudio}coloring/taa/taa_intro_timsah.mp3',
        revealAudioPath: '${_gamesAudio}coloring/taa/taa_reveal_timsah.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_2_slice_1.png', color: Color(0xFF43A047)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_2_slice_2.png', color: Color(0xFF8BC34A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_2_slice_3.png', color: Color(0xFFFFF176)),
        ],
      ),
      ColoringRound(
        word: 'تَاج',
        bgImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_3.png',
        wordRevealImagePath: '${_gamesDir}coloring/taa/taa_coloring_word_3.png',
        introAudioPath: '${_gamesAudio}coloring/taa/taa_intro_taaj.mp3',
        revealAudioPath: '${_gamesAudio}coloring/taa/taa_reveal_taaj.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_3_slice_1.png', color: Color(0xFFFDD835)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_3_slice_2.png', color: Color(0xFFE53935)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/taa/taa_coloring_round_3_slice_3.png', color: Color(0xFF1E88E5)),
        ],
      ),
    ],
  ),
);
