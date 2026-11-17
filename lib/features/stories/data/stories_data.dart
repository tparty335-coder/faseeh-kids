class Story {
  final String id;
  final String title;
  final List<String> pages;
  final int difficultyLevel;
  final List<String> pageImages;
  final List<String> pageAudios;
  final String? letterTag;

  const Story({
    required this.id,
    required this.title,
    required this.pages,
    required this.difficultyLevel,
    this.pageImages = const [],
    this.pageAudios = const [],
    this.letterTag,
  });
}

/// مكتبة قصص فصيح المصورة والمنطوقة بصوت بشري أصيل من الأسطوانات التعليمية (صفر TTS)
final List<Story> storiesData = [
  const Story(
    id: 'story_1',
    title: 'قصة حرف الألف — أَحْمَدُ وَالْأَرْنَبُ',
    letterTag: 'أ',
    difficultyLevel: 1,
    pages: [
      'فِي يَوْمٍ جَمِيلٍ خَرَجَ أَحْمَدُ وَأَمَلُ إِلَى الْحَدِيقَةِ الْوَاسِعَةِ.',
      'شَاهَدَ أَحْمَدُ أَرْنَبًا أَبْيَضَ يَأْكُلُ الْجَزَرَ وَيَقْفِزُ بِسَعَادَةٍ.',
      'وَفِي حَدِيقَةِ الْحَيَوَانِ رَأَى أَسَدًا قَوِيًّا فِي عَرِينِهِ.',
      'عَادَ أَحْمَدُ إِلَى أُمِّهِ مَسْرُورًا وَهُوَ يُرَدِّدُ نَشِيدَ حَرْفِ الْأَلِفِ.',
    ],
    pageImages: [
      'assets/images/lessons/alif/alif_cd_story_1.webp',
      'assets/images/lessons/alif/alif_cd_story_2.webp',
      'assets/images/lessons/alif/alif_cd_story_4.webp',
      'assets/images/lessons/alif/alif_cd_story_nasheed.webp',
    ],
    pageAudios: [
      'audio/stories/alif_story_1.mp3',
      'audio/stories/alif_story_2.mp3',
      'audio/stories/alif_story_4.mp3',
      'audio/stories/alif_nasheed.mp3',
    ],
  ),
  const Story(
    id: 'story_2',
    title: 'قصة حرف الباء — بَاسِمٌ وَالْبُحَيْرَةُ',
    letterTag: 'ب',
    difficultyLevel: 1,
    pages: [
      'ذَهَبَ بَاسِمٌ وَبَسْمَةُ فِي نُزْهَةٍ جَمِيلَةٍ إِلَى الْمَزْرَعَةِ.',
      'رَأَى بَاسِمٌ بَطَّةً تَسْبَحُ فِي الْبُحَيْرَةِ الصَّافِيَةِ.',
      'وَبِجَانِبِ الْبَيْتِ شَاهَدَا بَقَرَةً تَأْكُلُ الْعُشْبَ الْأَخْضَرَ.',
      'غَنَّى الْأَطْفَالُ نَشِيدَ حَرْفِ الْبَاءِ بِفَرَحٍ وَسُرُورٍ.',
    ],
    pageImages: [
      'assets/images/lessons/baa/baa_cd_story_1.webp',
      'assets/images/lessons/baa/baa_cd_story_2.webp',
      'assets/images/lessons/baa/baa_cd_story_4.webp',
      'assets/images/lessons/baa/baa_cd_story_6.webp',
    ],
    pageAudios: [
      'audio/stories/baa_story_1.mp3',
      'audio/stories/baa_story_2.mp3',
      'audio/stories/baa_story_4.mp3',
      'audio/stories/baa_story_6.mp3',
    ],
  ),
  const Story(
    id: 'story_3',
    title: 'قصة حرف الجيم — جَمَالٌ وَالْجَمَلُ',
    letterTag: 'ج',
    difficultyLevel: 1,
    pages: [
      'زَارَ جَمَالٌ مَزْرَعَةَ جَدِّهِ الْكَبِيرَةَ فِي الصَّبَاحِ.',
      'شَاهَدَ جَمَالٌ جَمَلًا صَبُورًا يَمْشِي فَوْقَ الرِّمَالِ.',
      'وَعَبَرَ الْجِسْرَ الْخَشَبِيَّ لِيَجْمَعَ الْجَزَرَ الطَّازَجَ.',
      'أَنْشَدَ جَمَالٌ مَعَ أَصْدِقَائِهِ نَشِيدَ حَرْفِ الْجِيمِ.',
    ],
    pageImages: [
      'assets/images/lessons/jeem/jeem_cd_story_1.webp',
      'assets/images/lessons/jeem/jeem_cd_story_2.webp',
      'assets/images/lessons/jeem/jeem_cd_story_3.webp',
      'assets/images/lessons/jeem/jeem_cd_story_nasheed.webp',
    ],
    pageAudios: [
      'audio/lessons/jeem/final/jeem_story_1.mp3',
      'audio/lessons/jeem/final/jeem_story_2.mp3',
      'audio/lessons/jeem/final/jeem_story_3.mp3',
      'audio/lessons/jeem/final/jeem_nasheed.mp3',
    ],
  ),
  const Story(
    id: 'story_taa',
    title: 'قصة حرف التاء — تَامِرٌ وَالتُّفَّاحُ',
    letterTag: 'ت',
    difficultyLevel: 1,
    pages: [
      'خَرَجَ تَامِرٌ وَتَهَانِي لِقَطْفِ التُّفَّاحِ وَالتُّوتِ مِنَ الْبُسْتَانِ.',
      'وَضَعَ تَامِرٌ التَّمْرَ اللَّذِيذَ فِي الطَّبَقِ.',
      'وَاسْتَمَعَ الْأَطْفَالُ إِلَى نَشِيدِ حَرْفِ التَّاءِ الْمُمْتِعِ.',
    ],
    pageImages: [
      'assets/images/lessons/taa/taa_cd_story_1.webp',
      'assets/images/lessons/taa/taa_cd_story_3.webp',
      'assets/images/lessons/taa/taa_cd_story_nasheed.webp',
    ],
    pageAudios: [
      'audio/lessons/taa/final/taa_story_1.mp3',
      'audio/lessons/taa/final/taa_story_3.mp3',
      'audio/lessons/taa/final/taa_nasheed.mp3',
    ],
  ),
  const Story(
    id: 'story_ha',
    title: 'قصة حرف الحاء — حُسَامٌ وَالْحِصَانُ',
    letterTag: 'ح',
    difficultyLevel: 2,
    pages: [
      'فِي الصَّبَاحِ الْبَاكِرِ ذَهَبَ حُسَامٌ إِلَى الْحَقْلِ الْأَخْضَرِ.',
      'شَاهَدَ حَمَامَةً بَيْضَاءَ وَحِصَانًا سَرِيعًا يَجْرِي فِي الْمَزْرَعَةِ.',
      'رَدَّدَ حُسَامٌ نَشِيدَ حَرْفِ الْحَاءِ بِصَوْتٍ جَمِيلٍ.',
    ],
    pageImages: [
      'assets/images/lessons/ha/ha_cd_story_1.webp',
      'assets/images/lessons/ha/ha_cd_story_3.webp',
      'assets/images/lessons/ha/ha_cd_story_nasheed.webp',
    ],
    pageAudios: [
      'audio/lessons/ha/final/ha_story_1.mp3',
      'audio/lessons/ha/final/ha_story_3.mp3',
      'audio/lessons/ha/final/ha_nasheed.mp3',
    ],
  ),
  const Story(
    id: 'story_seen',
    title: 'قصة حرف السين — سَمِيرٌ وَالسَّمَكَةُ',
    letterTag: 'س',
    difficultyLevel: 2,
    pages: [
      'ذَهَبَ سَمِيرٌ وَسُعَادُ إِلَى شَاطِئِ الْبَحْرِ الْجَمِيلِ.',
      'شَاهَدَا سَفِينَةً كَبِيرَةً وَسَمَكَةً تَسْبَحُ فِي الْمَاءِ.',
      'أَنْشَدَ الْأَطْفَالُ نَشِيدَ حَرْفِ السِّينِ.',
    ],
    pageImages: [
      'assets/images/lessons/seen/seen_cd_story_1.webp',
      'assets/images/lessons/seen/seen_cd_story_2.webp',
      'assets/images/lessons/seen/seen_cd_story_nasheed.webp',
    ],
    pageAudios: [
      'audio/lessons/seen/final/seen_story_1.mp3',
      'audio/lessons/seen/final/seen_story_2.mp3',
      'audio/lessons/seen/final/seen_nasheed.mp3',
    ],
  ),
];
