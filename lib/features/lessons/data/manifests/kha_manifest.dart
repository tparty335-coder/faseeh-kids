import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الخاء (خ) — المحرك الموحّد ──────────────────────────────────
// المصدر: d:\Projects\faseeh\scratch\extracted_all\khaa\audio\module_*.swf
// ──────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/kha/';
const String _audio = 'audio/lessons/kha/final/';
const String _vowelsAudio = 'audio/letters/short_vowels/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

/// مانيفست حرف الخاء — أصوات أصيلة من module_*.swf، صور placeholder
const LetterUnitManifest khaManifest = LetterUnitManifest(
  letter: 'خ',
  unitTitle: 'الْوَحْدَةُ السَّابِعَةُ | حَرْفُ الْخَاءِ (خ)',
  topBarColor: Color(0xFF6A1B9A), // بنفسجي داكن
  highlightColor: Color(0xFFE1BEE7), // بنفسجي فاتح
  mascotEmoji: '🐑', // خروف
  unitIndex: 7,
  nextLetter: 'د',

  // ── الأهداف ────────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: 'audio/lessons/kha/final/kha_letter.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الْخَاءِ (خ)',
      'أَنْطِقُ حَرْفَ الْخَاءِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الْخَاءِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الْخَاءِ',
      'أَتَتَبَّعُ حَرْفَ الْخَاءِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الْخَاءِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الْخَاءِ',
    ],
  ),

  // ── القصة (6 مشاهد + النشيد) ──────────────────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(imagePath: '${_dir}kha_cd_story_1.webp', audioPath: '${_audio}kha_story_1.mp3'),
      StoryScene(imagePath: '${_dir}kha_cd_story_2.webp', audioPath: '${_audio}kha_story_2.mp3'),
      StoryScene(imagePath: '${_dir}kha_cd_story_3.webp', audioPath: '${_audio}kha_story_3.mp3'),
      StoryScene(imagePath: '${_dir}kha_cd_story_4.webp', audioPath: '${_audio}kha_story_4.mp3'),
      StoryScene(imagePath: '${_dir}kha_cd_story_5.webp', audioPath: '${_audio}kha_story_5.mp3'),
      StoryScene(imagePath: '${_dir}kha_cd_story_6.webp', audioPath: '${_audio}kha_story_6.mp3'),
      StoryScene(imagePath: '${_dir}kha_cd_story_nasheed.webp', audioPath: '${_audio}kha_nasheed.mp3', isNasheed: true),
    ],
  ),

  // ── الأصوات (حركات قصيرة) ──────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'خ',
    items: [
      VowelItem(
        displayChar: 'خَ',
        fathaAudio: '${_vowelsAudio}khaa_fatha.mp3',
        dammaAudio: '${_vowelsAudio}khaa_damma.mp3',
        kasraAudio: '${_vowelsAudio}khaa_kasra.mp3',
      ),
    ],
  ),

  // ── المدود (حركات طويلة) ────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'خ',
    items: [
      MaddItem(displayChar: 'خَا', audioPath: 'audio/lessons/kha/madd/kha_madd_alif.mp3', imagePath: '${_dir}kha_madd_aa.webp'),
      MaddItem(displayChar: 'خِي', audioPath: 'audio/lessons/kha/madd/kha_madd_yaa.mp3', imagePath: '${_dir}kha_madd_ii.webp'),
      MaddItem(displayChar: 'خُو', audioPath: 'audio/lessons/kha/madd/kha_madd_waw.mp3', imagePath: '${_dir}kha_madd_uu.webp'),
    ],
  ),

  // ── الكتابة ────────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'خ',
    audioIntroPath: '${_audio}kha_write_intro.mp3',
    stepImagePaths: [
      '${_dir}kha_write_step_1.webp',
      '${_dir}kha_write_step_2.webp',
      '${_dir}kha_write_step_3.webp',
      '${_dir}kha_write_step_4.webp',
    ],
  ),

  // ── كلمات الحرف (4 صفحات × 4 كلمات = 16 كلمة أصلية من ka1..ka4.swf) ────
  // الإحداثيات نسبية (0.0..1.0) — الصور 800×474 بكسل مطابقة للأسطوانة
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka1.swf): خُلُود (أحمر)، خَسّ (برتقالي)، خَرُوف (أخضر)، خِيَار (أزرق)
      WordsPage(
        listImagePath: '${_dir}kha_words_p1_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'خُلُودُ',
            cardImagePath: '${_dir}kha_words_p1_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p1_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خَسٌّ',
            cardImagePath: '${_dir}kha_words_p1_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p1_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خَرُوفٌ',
            cardImagePath: '${_dir}kha_words_p1_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p1_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خِيَارٌ',
            cardImagePath: '${_dir}kha_words_p1_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p1_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 2 (ka2.swf): خَلّ (أحمر)، مَطْبَخ (برتقالي)، خُبْز (أخضر)، أُخْتِي (أزرق)
      WordsPage(
        listImagePath: '${_dir}kha_words_p2_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'خَلٌّ',
            cardImagePath: '${_dir}kha_words_p2_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p2_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مَطْبَخٌ',
            cardImagePath: '${_dir}kha_words_p2_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p2_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خُبْزٌ',
            cardImagePath: '${_dir}kha_words_p2_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p2_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'أُخْتِي',
            cardImagePath: '${_dir}kha_words_p2_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p2_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 3 (ka3.swf): خُوفُو (أحمر)، خَالِد (برتقالي)، نَخِيل (أخضر)، بِطِّيخ (أزرق)
      WordsPage(
        listImagePath: '${_dir}kha_words_p3_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'خُوفُو',
            cardImagePath: '${_dir}kha_words_p3_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p3_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خَالِد',
            cardImagePath: '${_dir}kha_words_p3_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p3_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'نَخِيل',
            cardImagePath: '${_dir}kha_words_p3_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p3_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'بِطِّيخ',
            cardImagePath: '${_dir}kha_words_p3_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p3_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 4 (ka4.swf): خَضْرَاء (أحمر)، خَمْسَة (برتقالي)، خَيْمَة (أخضر)، خَرِيطَة (أزرق)
      WordsPage(
        listImagePath: '${_dir}kha_words_p4_list.webp',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'خَضْرَاء',
            cardImagePath: '${_dir}kha_words_p4_card_1.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p4_1.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.200, right: 0.930, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خَمْسَة',
            cardImagePath: '${_dir}kha_words_p4_card_2.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p4_2.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.250, right: 0.480, bottom: 0.530),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خَيْمَة',
            cardImagePath: '${_dir}kha_words_p4_card_3.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p4_3.mp3',
            hotspot: WordHotspot(left: 0.500, top: 0.550, right: 0.850, bottom: 0.720),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'خَرِيطَة',
            cardImagePath: '${_dir}kha_words_p4_card_4.webp',
            cardHeight: 474,
            audioPath: '${_audio}kha_word_p4_4.mp3',
            hotspot: WordHotspot(left: 0.140, top: 0.720, right: 0.450, bottom: 0.900),
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
      FishingRound(word: 'خِيَار', imagePath: '${_gamesDir}fishing/kha/kha_fishing_round_1.webp', audioPath: '${_gamesAudio}fishing/kha/kha_fishing_1.mp3', isCorrect: true),
      FishingRound(word: 'بِطِّيخ', imagePath: '${_gamesDir}fishing/kha/kha_fishing_round_2.webp', audioPath: '${_gamesAudio}fishing/kha/kha_fishing_2.mp3', isCorrect: true),
      FishingRound(word: 'نَخِيل', imagePath: '${_gamesDir}fishing/kha/kha_fishing_round_3.webp', audioPath: '${_gamesAudio}fishing/kha/kha_fishing_3.mp3', isCorrect: true),
      FishingRound(word: 'خُبْز',  imagePath: '${_gamesDir}fishing/kha/kha_fishing_round_4.webp', audioPath: '${_gamesAudio}fishing/kha/kha_fishing_4.mp3', isCorrect: true),
    ],
    beehive: [
      BeehiveRound(word: 'خَرُوف', imagePath: '${_gamesDir}beehive/kha/kha_beehive_round_1.webp', audioPath: '${_gamesAudio}beehive/kha/kha_beehive_1.mp3'),
      BeehiveRound(word: 'خُبْز',  imagePath: '${_gamesDir}beehive/kha/kha_beehive_round_2.webp', audioPath: '${_gamesAudio}beehive/kha/kha_beehive_2.mp3'),
      BeehiveRound(word: 'خِيَار', imagePath: '${_gamesDir}beehive/kha/kha_beehive_round_3.webp', audioPath: '${_gamesAudio}beehive/kha/kha_beehive_3.mp3'),
      BeehiveRound(word: 'أُخْتِي', imagePath: '${_gamesDir}beehive/kha/kha_beehive_round_4.webp', audioPath: '${_gamesAudio}beehive/kha/kha_beehive_4.mp3'),
    ],
    circus: [
      CircusRound(word: 'خَسّ',   imagePath: '${_gamesDir}circus/kha/kha_circus_round_1.webp', audioPath: '${_gamesAudio}circus/kha/kha_circus_1.mp3'),
      CircusRound(word: 'خُوفُو', imagePath: '${_gamesDir}circus/kha/kha_circus_round_2.webp', audioPath: '${_gamesAudio}circus/kha/kha_circus_2.mp3'),
      CircusRound(word: 'خَرُوف', imagePath: '${_gamesDir}circus/kha/kha_circus_round_3.webp', audioPath: '${_gamesAudio}circus/kha/kha_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'خَضْرَاء', imagePath: '${_gamesDir}match/kha/kha_match_1.webp', audioPath: '${_gamesAudio}match/kha/kha_match_1.mp3'),
      WordsMatchPair(word: 'خَرُوف',  imagePath: '${_gamesDir}match/kha/kha_match_2.webp', audioPath: '${_gamesAudio}match/kha/kha_match_2.mp3'),
      WordsMatchPair(word: 'أُخْت',   imagePath: '${_gamesDir}match/kha/kha_match_3.webp', audioPath: '${_gamesAudio}match/kha/kha_match_3.mp3'),
      WordsMatchPair(word: 'خَالِد',  imagePath: '${_gamesDir}match/kha/kha_match_4.webp', audioPath: '${_gamesAudio}match/kha/kha_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'خَالِد',
        bgImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_1.webp',
        wordRevealImagePath: '${_gamesDir}coloring/kha/kha_coloring_word_1.webp',
        introAudioPath: '${_audio}kha_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/kha/kha_reveal_khaal.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_1_slice_1.webp', color: Color(0xFFAB47BC)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_1_slice_2.webp', color: Color(0xFF6A1B9A)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_1_slice_3.webp', color: Color(0xFFFFD54F)),
        ],
      ),
      ColoringRound(
        word: 'نَخِيل',
        bgImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_2.webp',
        wordRevealImagePath: '${_gamesDir}coloring/kha/kha_coloring_word_2.webp',
        introAudioPath: '${_audio}kha_paint_word2.mp3',
        revealAudioPath: '${_gamesAudio}coloring/kha/kha_reveal_kheema.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_2_slice_1.webp', color: Color(0xFF7B1FA2)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_2_slice_2.webp', color: Color(0xFFCE93D8)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_2_slice_3.webp', color: Color(0xFF90A4AE)),
        ],
      ),
      ColoringRound(
        word: 'خُوفُو',
        bgImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_3.webp',
        wordRevealImagePath: '${_gamesDir}coloring/kha/kha_coloring_word_3.webp',
        introAudioPath: '${_audio}kha_paint_word3.mp3',
        revealAudioPath: '${_gamesAudio}coloring/kha/kha_reveal_khubz.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_3_slice_1.webp', color: Color(0xFFFF7043)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_3_slice_2.webp', color: Color(0xFF4CAF50)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/kha/kha_coloring_round_3_slice_3.webp', color: Color(0xFFFFF176)),
        ],
      ),
    ],
  ),
);
