import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الذال (ذ) — المحرك الموحّد ──────────────────────────────────
// المصدر: arabic_1prim_t1U2_ذ.exe (أسطوانة الوزارة الأصلية)
// تفريغ نصي وصوتي 100%: ka1..ka4.swf, sto1..sto4.swf, stosong.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/dhaal/';
const String _audio = 'audio/lessons/dhaal/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _maddAudio = 'audio/letters/long_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الذال — أصول وأصوات أصلية 100% من أسطوانة الوزارة
const LetterUnitManifest dhaalManifest = LetterUnitManifest(
  letter: 'ذ',
  unitTitle: 'الْوَحْدَةُ التَّاسِعَةُ | حَرْفُ الذَّالِ (ذ)',
  topBarColor: Color(0xFFE65100), // عنبري ذهبي داكن
  highlightColor: Color(0xFFFFB74D), // عنبري فاتح
  mascotEmoji: '🐺', // ذئب
  unitIndex: 9,
  nextLetter: 'ر',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}dhaal_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الذَّالِ (ذ)',
      'أَنْطِقُ حَرْفَ الذَّالِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الذَّالِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الذَّالِ',
      'أَتَتَبَّعُ حَرْفَ الذَّالِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الذَّالِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الذَّالِ',
    ],
  ),

  // ── القصة (5 مشاهد + النشيد = 6 مشاهد أصلية) ──────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_1.png',
        audioPath: '${_audio}dhaal_story_1.mp3',
      ), // ذهب معاذ بغنمه إلى المرعى وكان الذئب يراقبه من بعيد.
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_2.png',
        audioPath: '${_audio}dhaal_story_2.mp3',
      ), // جلس معاذ تحت الشجرة يستظل بها
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_3.png',
        audioPath: '${_audio}dhaal_story_3.mp3',
      ), // حاول الذئب الهجوم على الغنم .
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_4.png',
        audioPath: '${_audio}dhaal_story_4.mp3',
      ), // ولكن معاذ رآه فأسرع نحوه بالعصا.
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_5.png',
        audioPath: '${_audio}dhaal_story_5.mp3',
      ), // ففر الذئب هاربًا.
      StoryScene(
        imagePath: '${_dir}dhaal_cd_story_nasheed.png',
        audioPath: '${_audio}dhaal_nasheed.mp3',
        isNasheed: true,
      ),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ذ',
    items: [
      VowelItem(
        displayChar: 'ذَ',
        fathaAudio: '${_vowelsAudio}dhaal_fatha.mp3',
        dammaAudio: '${_vowelsAudio}dhaal_damma.mp3',
        kasraAudio: '${_vowelsAudio}dhaal_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ذ',
    items: [
      MaddItem(
        displayChar: 'ذَا',
        audioPath: '${_maddAudio}dhaal_madd_demo.mp3',
        imagePath: '${_dir}dhaal_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'ذُو',
        audioPath: '${_maddAudio}dhaal_madd_demo.mp3',
        imagePath: '${_dir}dhaal_madd_uu.png',
      ),
      MaddItem(
        displayChar: 'ذِي',
        audioPath: '${_maddAudio}dhaal_madd_demo.mp3',
        imagePath: '${_dir}dhaal_madd_ii.png',
      ),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ذ',
    audioIntroPath: '${_audio}dhaal_write_intro.mp3',
    stepImagePaths: [
      '${_dir}dhaal_write_step_1.png',
      '${_dir}dhaal_write_step_2.png',
      '${_dir}dhaal_write_step_3.png',
      '${_dir}dhaal_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية) ────────────────────────
  words: WordsSpec(
    pages: [
      // ── صفحة 1: ذِئْب، مُعَاذ، ذَيْل، أُذُن ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ذِئْب',
            cardImagePath: '${_dir}dhaal_words_p1_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مُعَاذ',
            cardImagePath: '${_dir}dhaal_words_p1_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ذَيْل',
            cardImagePath: '${_dir}dhaal_words_p1_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'أُذُن',
            cardImagePath: '${_dir}dhaal_words_p1_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p1_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),

      // ── صفحة 2: بُذُور، ذُرَة، ذَهَب، تُذَاكِر ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'بُذُور',
            cardImagePath: '${_dir}dhaal_words_p2_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p2_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ذُرَة',
            cardImagePath: '${_dir}dhaal_words_p2_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p2_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ذَهَب',
            cardImagePath: '${_dir}dhaal_words_p2_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p2_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'تُذَاكِر',
            cardImagePath: '${_dir}dhaal_words_p2_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p2_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),

      // ── صفحة 3: مِئْذَنَة، تِلْمِيذ، أُسْتَاذ، تَأْخُذ ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'مِئْذَنَة',
            cardImagePath: '${_dir}dhaal_words_p3_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'تِلْمِيذ',
            cardImagePath: '${_dir}dhaal_words_p3_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'أُسْتَاذ',
            cardImagePath: '${_dir}dhaal_words_p3_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'تَأْخُذ',
            cardImagePath: '${_dir}dhaal_words_p3_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p3_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),

      // ── صفحة 4: ذِرَاع، جِذْر، غِذَاء، مُذِيع ──
      WordsPage(
        listImagePath: '${_dir}dhaal_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ذِرَاع',
            cardImagePath: '${_dir}dhaal_words_p4_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_1.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.200,
              right: 0.930,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'جِذْر',
            cardImagePath: '${_dir}dhaal_words_p4_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_2.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.250,
              right: 0.480,
              bottom: 0.530,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'غِذَاء',
            cardImagePath: '${_dir}dhaal_words_p4_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_3.mp3',
            hotspot: WordHotspot(
              left: 0.500,
              top: 0.550,
              right: 0.850,
              bottom: 0.720,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مُذِيع',
            cardImagePath: '${_dir}dhaal_words_p4_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}dhaal_word_p4_4.mp3',
            hotspot: WordHotspot(
              left: 0.140,
              top: 0.720,
              right: 0.450,
              bottom: 0.900,
            ),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
    ],
  ),

  // ── الألعاب ────────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(
        word: 'ذِئْب',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_1.png',
        audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_1.mp3',
        isCorrect: true,
      ),
      FishingRound(
        word: 'كِتَاب',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_2.png',
        audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_2.mp3',
        isCorrect: false,
      ),
      FishingRound(
        word: 'ذَهَب',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_3.png',
        audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_3.mp3',
        isCorrect: true,
      ),
      FishingRound(
        word: 'قَلَم',
        imagePath: '${_gamesDir}fishing/dhaal/dhaal_fishing_round_4.png',
        audioPath: '${_gamesAudio}fishing/dhaal/dhaal_fishing_4.mp3',
        isCorrect: false,
      ),
    ],
    beehive: [
      BeehiveRound(
        word: 'ذَهَب',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_1.png',
        audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_1.mp3',
      ),
      BeehiveRound(
        word: 'ذِئْب',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_2.png',
        audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_2.mp3',
      ),
      BeehiveRound(
        word: 'ذُرَة',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_3.png',
        audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_3.mp3',
      ),
      BeehiveRound(
        word: 'جِذْر',
        imagePath: '${_gamesDir}beehive/dhaal/dhaal_beehive_round_4.png',
        audioPath: '${_gamesAudio}beehive/dhaal/dhaal_beehive_4.mp3',
      ),
    ],
    circus: [
      CircusRound(
        word: 'ذِئْب',
        imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_1.png',
        audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_1.mp3',
      ),
      CircusRound(
        word: 'ذُرَة',
        imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_2.png',
        audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_2.mp3',
      ),
      CircusRound(
        word: 'ذَهَب',
        imagePath: '${_gamesDir}circus/dhaal/dhaal_circus_round_3.png',
        audioPath: '${_gamesAudio}circus/dhaal/dhaal_circus_3.mp3',
      ),
    ],
    wordsMatch: [
      WordsMatchPair(
        word: 'ذِئْب',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_1.png',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_1.mp3',
      ),
      WordsMatchPair(
        word: 'ذُرَة',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_2.png',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_2.mp3',
      ),
      WordsMatchPair(
        word: 'ذَهَب',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_3.png',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_3.mp3',
      ),
      WordsMatchPair(
        word: 'قُنْفُذ',
        imagePath: '${_gamesDir}match/dhaal/dhaal_match_4.png',
        audioPath: '${_gamesAudio}match/dhaal/dhaal_match_4.mp3',
      ),
    ],
    coloring: [
      ColoringRound(
        word: 'ذَاب',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1.png',
        wordRevealImagePath:
            '${_gamesDir}coloring/dhaal/dhaal_coloring_word_1.png',
        introAudioPath: '${_audio}dhaal_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaal/dhaal_reveal_thaab.mp3',
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_1.png',
            color: Color(0xFFE65100),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_2.png',
            color: Color(0xFFFF8F00),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_1_slice_3.png',
            color: Color(0xFFFFD54F),
          ),
        ],
      ),
      ColoringRound(
        word: 'ذُوق',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2.png',
        wordRevealImagePath:
            '${_gamesDir}coloring/dhaal/dhaal_coloring_word_2.png',
        introAudioPath: '${_audio}dhaal_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/dhaal/dhaal_reveal_thooq.mp3',
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_1.png',
            color: Color(0xFFF57C00),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_2.png',
            color: Color(0xFFFFB74D),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_2_slice_3.png',
            color: Color(0xFF90A4AE),
          ),
        ],
      ),
      ColoringRound(
        word: 'مَذِيع',
        bgImagePath: '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3.png',
        wordRevealImagePath:
            '${_gamesDir}coloring/dhaal/dhaal_coloring_word_3.png',
        introAudioPath: '${_audio}dhaal_paint_word3.mp3',
        revealAudioPath:
            '${_gamesAudio}coloring/dhaal/dhaal_reveal_matheea.mp3',
        slices: [
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_1.png',
            color: Color(0xFFFF7043),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_2.png',
            color: Color(0xFF4CAF50),
          ),
          ColoringSlice(
            maskImagePath:
                '${_gamesDir}coloring/dhaal/dhaal_coloring_round_3_slice_3.png',
            color: Color(0xFFFFF176),
          ),
        ],
      ),
    ],
  ),
);
