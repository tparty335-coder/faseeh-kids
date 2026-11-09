import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

// ─── مانيفست حرف الثاء (ث) — أصوات وصور أصلية من أسطوانة فصيح ───
// الصوت: حقيقي من الأسطوانة   |   الصور: أصلية مستخرجة ومقصوصة بدقة
// ─────────────────────────────────────────────────────────────────────────────

const String _dir = 'assets/images/lessons/thaa/';
const String _audio = 'audio/lessons/thaa/final/';
const String _soundsAudio = 'audio/lessons/thaa/sounds/';
const String _gamesDir = 'assets/images/games/';
const String _gamesAudio = 'audio/games/';

const LetterUnitManifest thaaManifest = LetterUnitManifest(
  letter: 'ث',
  unitTitle: 'الْوَحْدَةُ الرَّابِعَةُ | حَرْفُ الثَّاءِ (ث)',
  topBarColor: Color(0xFF6A1B9A), // بنفسجي غامق — لون الثاء في الأسطوانة
  highlightColor: Color(0xFFF3E5F5), // بنفسجي فاتح جداً
  mascotEmoji: '🦊', // ثعلب
  unitIndex: 4,
  nextLetter: 'ج',

  // ── الأهداف ──────────────────────────────────────────────────────────────
  objectives: ObjectivesSpec(
    audioPath: '${_audio}thaa_goal.mp3',
    objectives: [
      'أَتَعَرَّفُ عَلَى حَرْفِ الثَّاءِ (ث)',
      'أَنْطِقُ حَرْفَ الثَّاءِ بِالْحَرَكَاتِ الثَّلَاثِ',
      'أُمَيِّزُ حَرْفَ الثَّاءِ فِي الْكَلِمَاتِ',
      'أَسْتَمِعُ إِلَى قِصَّةِ حَرْفِ الثَّاءِ',
      'أَتَتَبَّعُ حَرْفَ الثَّاءِ بِالْقَلَمِ',
      'أَقْرَأُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ الثَّاءِ',
      'أَلْعَبُ أَلْعَابَ حَرْفِ الثَّاءِ',
    ],
  ),

  // ── القصة (٧ مشاهد أصلية + نشيد) ────────────────────────────────────────
  story: StorySpec(
    scenes: [
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_1.png',
        audioPath: '${_audio}thaa_story_1.mp3',
        captionText: 'ذَهَبَ ثَابِتٌ مَعَ أُسْرَتِهِ إِلَى مَزْرَعَةِ جَدِّهِ يَوْمَ الْجُمُعَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_2.png',
        audioPath: '${_audio}thaa_story_2.mp3',
        captionText: 'وَلَعِبَ بَيْنَ الْأَشْجَارِ، وَأَكَلَ بَعْضَ الثِّمَارِ وَالْفَاكِهَةِ.',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_3.png',
        audioPath: '${_audio}thaa_story_3.mp3',
        captionText: 'وَفَجْأَةً شَاهَدَ ثُعْبَانًا فَوْقَ الشَّجَرَةِ فَخَافَ وَذَهَبَ إِلَى جَدِّهِ.',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_4.png',
        audioPath: '${_audio}thaa_story_4.mp3',
        captionText: 'ثُمَّ عَادَتِ الْأُسْرَةُ وَهِيَ مَسْرُورَةٌ.',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_5.png',
        audioPath: '${_audio}thaa_story_5.mp3',
        captionText: 'اضْغَطْ عَلَى الْكَلِمَاتِ الَّتِي بِهَا حَرْفُ الثَّاءِ الْمَمْدُودِ',
        interaction: WordFindStoryInteraction(
          instructionText: 'اضْغَطْ عَلَى الْكَلِمَاتِ الَّتِي بِهَا حَرْفُ الثَّاءِ الْمَمْدُودِ:',
          instructionAudioPath: '${_audio}thaa_story_5.mp3',
          correctAudioPath: 'assets/audio/games/fishing/ahsnt.mp3',
          wrongAudioPath: 'assets/audio/games/fishing/hawel.mp3',
          targets: [
            StoryTargetItem(
              label: 'ثِيرَان',
              left: 0.34,
              top: 0.28,
              right: 0.50,
              bottom: 0.40,
              isCorrect: true,
              wordAudioPath: 'assets/audio/lessons/thaa/sounds/word_theeran.mp3',
            ),
            StoryTargetItem(
              label: 'ثِمَار',
              left: 0.20,
              top: 0.36,
              right: 0.33,
              bottom: 0.47,
              isCorrect: false,
              wordAudioPath: 'assets/audio/lessons/thaa/sounds/word_thimar.mp3',
            ),
            StoryTargetItem(
              label: 'ثُعْبَان',
              left: 0.34,
              top: 0.43,
              right: 0.50,
              bottom: 0.55,
              isCorrect: false,
              wordAudioPath: 'assets/audio/lessons/thaa/sounds/word_thoban.mp3',
            ),
            StoryTargetItem(
              label: 'ثَابِت',
              left: 0.20,
              top: 0.54,
              right: 0.33,
              bottom: 0.65,
              isCorrect: true,
              wordAudioPath: 'assets/audio/lessons/thaa/sounds/word_thabit.mp3',
            ),
            StoryTargetItem(
              label: 'ثُوم',
              left: 0.35,
              top: 0.62,
              right: 0.50,
              bottom: 0.74,
              isCorrect: true,
              wordAudioPath: 'assets/audio/lessons/thaa/sounds/word_thum.mp3',
            ),
            StoryTargetItem(
              label: 'ثَلْج',
              left: 0.20,
              top: 0.68,
              right: 0.33,
              bottom: 0.79,
              isCorrect: false,
              wordAudioPath: 'assets/audio/lessons/thaa/sounds/word_thalj.mp3',
            ),
          ],
        ),
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_6.png',
        audioPath: '${_audio}thaa_story_6.mp3',
        captionText: 'ثَاءٌ ثَعْلَبٌ ذَكِيٌّ يَجْمَعُ الثِّمَارَ وَيَلْعَبُ فِي الثَّلْجِ مَعَ الثِّيرَانِ',
      ),
      StoryScene(
        imagePath: '${_dir}thaa_cd_story_nasheed.png',
        audioPath: '${_audio}thaa_nasheed.mp3',
        captionText: 'ثَاءٌ ثَعْلَبٌ ذَكِيٌّ... ثِمَارٌ وَثَلْجٌ وَثِيرَانُ وَثُوم',
        isNasheed: true,
      ),
    ],
  ),

  // ── الأصوات ──────────────────────────────────────────────────────────────
  vowels: VowelsSpec(
    letterChar: 'ث',
    items: [
      VowelItem(
        displayChar: 'ثَ',
        fathaAudio: '${_soundsAudio}thaa_fatha.mp3',
        dammaAudio: '${_soundsAudio}thaa_damma.mp3',
        kasraAudio: '${_soundsAudio}thaa_kasra.mp3',
      ),
    ],
  ),

  // ── المدود ──────────────────────────────────────────────────────────────
  madd: MaddSpec(
    letterChar: 'ث',
    items: [
      MaddItem(
        displayChar: 'ثَا',
        audioPath: '${_soundsAudio}thaa_madd_alif.mp3',
        imagePath: '${_dir}thaa_madd_aa.png',
      ),
      MaddItem(
        displayChar: 'ثِي',
        audioPath: '${_soundsAudio}thaa_madd_yaa.mp3',
        imagePath: '${_dir}thaa_madd_ii.png',
      ),
      MaddItem(
        displayChar: 'ثُو',
        audioPath: '${_soundsAudio}thaa_madd_waw.mp3',
        imagePath: '${_dir}thaa_madd_uu.png',
      ),
    ],
  ),

  // ── الكتابة ──────────────────────────────────────────────────────────────
  tracing: TracingSpec(
    letterChar: 'ث',
    audioIntroPath: '${_audio}thaa_write_intro.mp3',
    stepImagePaths: [
      '${_dir}thaa_write_step_1.png',
      '${_dir}thaa_write_step_2.png',
      '${_dir}thaa_write_step_3.png',
      '${_dir}thaa_write_step_4.png',
    ],
  ),

  // ── كلمات الحرف — 4 صفحات أصلية من ka1..ka4.swf ──────────────────────────
  // جميع الصور والأصوات أصلية 100% من أسطوانة فصيح — لا يوجد تأليف
  // الإحداثيات نسبية (0.0..1.0) — الصور 800×474 بكسل
  words: WordsSpec(
    pages: [
      // صفحة 1 (ka1.swf): ثِمَار (أحمر)، ثَلَّاجَة (برتقالي)، ثُعْبَان (أخضر)، ثَلْج (أزرق)
      WordsPage(
        listImagePath: '${_dir}thaa_words_p1_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ثِمَار',
            cardImagePath: '${_dir}thaa_words_p1_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p1_1.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.209, right: 0.945, bottom: 0.536),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَلَّاجَة',
            cardImagePath: '${_dir}thaa_words_p1_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p1_2.mp3',
            hotspot: WordHotspot(left: 0.151, top: 0.300, right: 0.601, bottom: 0.519),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثُعْبَان',
            cardImagePath: '${_dir}thaa_words_p1_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p1_3.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.568, right: 0.782, bottom: 0.715),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَلْج',
            cardImagePath: '${_dir}thaa_words_p1_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p1_4.mp3',
            hotspot: WordHotspot(left: 0.150, top: 0.745, right: 0.422, bottom: 0.892),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 2 (ka2.swf): اِثْنَان، ثَوْب، ثَعْلَب، ثُوم
      WordsPage(
        listImagePath: '${_dir}thaa_words_p2_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'اِثْنَان',
            cardImagePath: '${_dir}thaa_words_p2_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p2_1.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.209, right: 0.945, bottom: 0.536),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَوْب',
            cardImagePath: '${_dir}thaa_words_p2_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p2_2.mp3',
            hotspot: WordHotspot(left: 0.151, top: 0.300, right: 0.601, bottom: 0.519),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَعْلَب',
            cardImagePath: '${_dir}thaa_words_p2_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p2_3.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.568, right: 0.782, bottom: 0.715),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثُوم',
            cardImagePath: '${_dir}thaa_words_p2_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p2_4.mp3',
            hotspot: WordHotspot(left: 0.150, top: 0.745, right: 0.422, bottom: 0.892),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 3 (ka3.swf): ثَابِت، ثِيرَان، مُثَلَّث، كُمَّثْرَى
      WordsPage(
        listImagePath: '${_dir}thaa_words_p3_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'ثَابِت',
            cardImagePath: '${_dir}thaa_words_p3_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p3_1.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.209, right: 0.945, bottom: 0.536),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثِيرَان',
            cardImagePath: '${_dir}thaa_words_p3_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p3_2.mp3',
            hotspot: WordHotspot(left: 0.151, top: 0.300, right: 0.601, bottom: 0.519),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مُثَلَّث',
            cardImagePath: '${_dir}thaa_words_p3_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p3_3.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.568, right: 0.782, bottom: 0.715),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'كُمَّثْرَى',
            cardImagePath: '${_dir}thaa_words_p3_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p3_4.mp3',
            hotspot: WordHotspot(left: 0.150, top: 0.745, right: 0.422, bottom: 0.892),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 4 (ka4.swf): هَيْثَم، ثَقِيل، أَثَاث، مِحْرَاث
      WordsPage(
        listImagePath: '${_dir}thaa_words_p4_list.png',
        listImageHeight: 474,
        words: [
          WordItem(
            word: 'هَيْثَم',
            cardImagePath: '${_dir}thaa_words_p4_card_1.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p4_1.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.209, right: 0.945, bottom: 0.536),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'ثَقِيل',
            cardImagePath: '${_dir}thaa_words_p4_card_2.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p4_2.mp3',
            hotspot: WordHotspot(left: 0.151, top: 0.300, right: 0.601, bottom: 0.519),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'أَثَاث',
            cardImagePath: '${_dir}thaa_words_p4_card_3.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p4_3.mp3',
            hotspot: WordHotspot(left: 0.512, top: 0.568, right: 0.782, bottom: 0.715),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
          WordItem(
            word: 'مِحْرَاث',
            cardImagePath: '${_dir}thaa_words_p4_card_4.png',
            cardHeight: 474,
            audioPath: '${_audio}thaa_word_p4_4.mp3',
            hotspot: WordHotspot(left: 0.150, top: 0.745, right: 0.422, bottom: 0.892),
            speakerOffset: Offset(0.163, 0.338),
            closeOffset: Offset(0.763, 0.338),
          ),
        ],
      ),
      // صفحة 5 محذوفة — الملفات كانت تالفة (1336 bytes فارغة)
    ],
  ),

  // ── الألعاب ──────────────────────────────────────────────────────────────
  games: GamesSpec(
    fishing: [
      FishingRound(word: 'ثَعْلَب', imagePath: '${_gamesDir}fishing/thaa_fishing_round_1.png', audioPath: '${_gamesAudio}fishing/thaa_thalab.mp3', isCorrect: true),
      FishingRound(word: 'ثَلْج', imagePath: '${_gamesDir}fishing/thaa_fishing_round_2.png', audioPath: '${_gamesAudio}fishing/thaa_thalj.mp3', isCorrect: true),
      FishingRound(word: 'ثَوْر', imagePath: '${_gamesDir}fishing/thaa_fishing_round_3.png', audioPath: '${_gamesAudio}fishing/thaa_thawr.mp3', isCorrect: true),
      FishingRound(word: 'ثُعْبَان', imagePath: '${_gamesDir}fishing/thaa_fishing_round_4.png', audioPath: '${_gamesAudio}fishing/thaa_thoban.mp3', isCorrect: true),
    ],
    beehive: [
      BeehiveRound(word: 'ثَعْلَب', imagePath: '${_gamesDir}beehive/thaa/thaa_beehive_1.png', audioPath: '${_gamesAudio}beehive/thaa/thaa_beehive_1.mp3'),
      BeehiveRound(word: 'ثَلْج', imagePath: '${_gamesDir}beehive/thaa/thaa_beehive_2.png', audioPath: '${_gamesAudio}beehive/thaa/thaa_beehive_2.mp3'),
      BeehiveRound(word: 'ثَوْر', imagePath: '${_gamesDir}beehive/thaa/thaa_beehive_3.png', audioPath: '${_gamesAudio}beehive/thaa/thaa_beehive_3.mp3'),
    ],
    circus: [
      CircusRound(word: 'ثَعْلَب', imagePath: '${_gamesDir}circus/thaa/thaa_circus_1.png', audioPath: '${_gamesAudio}circus/thaa/thaa_circus_1.mp3'),
      CircusRound(word: 'ثَلَاثَة', imagePath: '${_gamesDir}circus/thaa/thaa_circus_2.png', audioPath: '${_gamesAudio}circus/thaa/thaa_circus_2.mp3'),
      CircusRound(word: 'ثَوْر', imagePath: '${_gamesDir}circus/thaa/thaa_circus_3.png', audioPath: '${_gamesAudio}circus/thaa/thaa_circus_3.mp3'),
    ],
    wordsMatch: [
      WordsMatchPair(word: 'ثَعْلَب', imagePath: '${_gamesDir}match/thaa/thaa_match_1.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_1.mp3'),
      WordsMatchPair(word: 'ثَوْر', imagePath: '${_gamesDir}match/thaa/thaa_match_2.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_2.mp3'),
      WordsMatchPair(word: 'ثَلْج', imagePath: '${_gamesDir}match/thaa/thaa_match_3.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_3.mp3'),
      WordsMatchPair(word: 'ثَلَاثَة', imagePath: '${_gamesDir}match/thaa/thaa_match_4.png', audioPath: '${_gamesAudio}match/thaa/thaa_match_4.mp3'),
    ],
    coloring: [
      ColoringRound(
        word: 'ثَابِت',
        bgImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1.png',
        wordRevealImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_word_1.png',
        introAudioPath: '${_audio}thaa_paint_word1.mp3',
        revealAudioPath: '${_gamesAudio}coloring/thaa/thaa_reveal_1.mp3',
        slices: [
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1_s1.png', color: Color(0xFFE53935)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1_s2.png', color: Color(0xFFFF8F00)),
          ColoringSlice(maskImagePath: '${_gamesDir}coloring/thaa/thaa_coloring_1_s3.png', color: Color(0xFF795548)),
        ],
      ),
    ],
  ),
);
