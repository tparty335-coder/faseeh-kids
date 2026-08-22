class ArabicLetter {
  final String letter;
  final String name;
  final String nameEn;
  final String sound;
  final List<String> exampleWords;
  final int unitIndex;

  const ArabicLetter({
    required this.letter,
    required this.name,
    required this.nameEn,
    required this.sound,
    required this.exampleWords,
    required this.unitIndex,
  });
}

const List<ArabicLetter> arabicLetters = [
  ArabicLetter(letter: 'أ', name: 'أَلِف', nameEn: 'Alif', sound: 'أَ', exampleWords: ['أَسَد', 'أُذُن', 'إِبْرَة'], unitIndex: 1),
  ArabicLetter(letter: 'ب', name: 'بَاء', nameEn: 'Baa', sound: 'بَ', exampleWords: ['بَطَّة', 'بَاب', 'بَقَرَة'], unitIndex: 1),
  ArabicLetter(letter: 'ت', name: 'تَاء', nameEn: 'Taa', sound: 'تَ', exampleWords: ['تُفَّاحَة', 'تِمْسَاح', 'تَاج'], unitIndex: 1),
  ArabicLetter(letter: 'ث', name: 'ثَاء', nameEn: 'Thaa', sound: 'ثَ', exampleWords: ['ثَعْلَب', 'ثُعْبَان', 'ثَلْج'], unitIndex: 1),
  ArabicLetter(letter: 'ج', name: 'جِيم', nameEn: 'Jeem', sound: 'جَ', exampleWords: ['جَمَل', 'جُبْن', 'جَزَر'], unitIndex: 1),
  ArabicLetter(letter: 'ح', name: 'حَاء', nameEn: 'Haa', sound: 'حَ', exampleWords: ['حِصَان', 'حَلِيب', 'حَمَامَة'], unitIndex: 1),
  ArabicLetter(letter: 'خ', name: 'خَاء', nameEn: 'Khaa', sound: 'خَ', exampleWords: ['خَرُوف', 'خُبْز', 'خَوْخ'], unitIndex: 1),
  ArabicLetter(letter: 'د', name: 'دَال', nameEn: 'Daal', sound: 'دَ', exampleWords: ['دَجَاجَة', 'دُب', 'دَرَّاجَة'], unitIndex: 2),
  ArabicLetter(letter: 'ذ', name: 'ذَال', nameEn: 'Thaal', sound: 'ذَ', exampleWords: ['ذِئْب', 'ذُرَة', 'ذَهَب'], unitIndex: 2),
  ArabicLetter(letter: 'ر', name: 'رَاء', nameEn: 'Raa', sound: 'رَ', exampleWords: ['رُمَّان', 'رِيشَة', 'رَجُل'], unitIndex: 2),
  ArabicLetter(letter: 'ز', name: 'زَاي', nameEn: 'Zaay', sound: 'زَ', exampleWords: ['زَرَافَة', 'زَهْرَة', 'زَيْتُون'], unitIndex: 2),
  ArabicLetter(letter: 'س', name: 'سِين', nameEn: 'Seen', sound: 'سَ', exampleWords: ['سَمَكَة', 'سَيَّارَة', 'سَاعَة'], unitIndex: 2),
  ArabicLetter(letter: 'ش', name: 'شِين', nameEn: 'Sheen', sound: 'شَ', exampleWords: ['شَمْس', 'شَجَرَة', 'شَمْعَة'], unitIndex: 2),
  ArabicLetter(letter: 'ص', name: 'صَاد', nameEn: 'Saad', sound: 'صَ', exampleWords: ['صَقْر', 'صُنْدُوق', 'صَارُوخ'], unitIndex: 2),
  ArabicLetter(letter: 'ض', name: 'ضَاد', nameEn: 'Daad', sound: 'ضَ', exampleWords: ['ضِفْدَع', 'ضِرْس', 'ضَابِط'], unitIndex: 3),
  ArabicLetter(letter: 'ط', name: 'طَاء', nameEn: 'Taa', sound: 'طَ', exampleWords: ['طَائِرَة', 'طَمَاطِم', 'طِفْل'], unitIndex: 3),
  ArabicLetter(letter: 'ظ', name: 'ظَاء', nameEn: 'Dhaa', sound: 'ظَ', exampleWords: ['ظَرْف', 'ظِل', 'ظَبْي'], unitIndex: 3),
  ArabicLetter(letter: 'ع', name: 'عَيْن', nameEn: 'Ayn', sound: 'عَ', exampleWords: ['عُصْفُور', 'عِنَب', 'عَيْن'], unitIndex: 3),
  ArabicLetter(letter: 'غ', name: 'غَيْن', nameEn: 'Ghayn', sound: 'غَ', exampleWords: ['غَزَال', 'غَسَّالَة', 'غُرَاب'], unitIndex: 3),
  ArabicLetter(letter: 'ف', name: 'فَاء', nameEn: 'Faa', sound: 'فَ', exampleWords: ['فِيل', 'فَرَاشَة', 'فَأْر'], unitIndex: 3),
  ArabicLetter(letter: 'ق', name: 'قَاف', nameEn: 'Qaaf', sound: 'قَ', exampleWords: ['قِرْد', 'قَمَر', 'قِطَار'], unitIndex: 3),
  ArabicLetter(letter: 'ك', name: 'كَاف', nameEn: 'Kaaf', sound: 'كَ', exampleWords: ['كَلْب', 'كِتَاب', 'كُرَة'], unitIndex: 4),
  ArabicLetter(letter: 'ل', name: 'لاَم', nameEn: 'Laam', sound: 'لَ', exampleWords: ['لَيْمُون', 'لَحْم', 'لُعْبَة'], unitIndex: 4),
  ArabicLetter(letter: 'م', name: 'مِيم', nameEn: 'Meem', sound: 'مَ', exampleWords: ['مَوْز', 'مِفْتَاح', 'مَكْتَب'], unitIndex: 4),
  ArabicLetter(letter: 'ن', name: 'نُون', nameEn: 'Noon', sound: 'نَ', exampleWords: ['نَمْلَة', 'نَمِر', 'نَظَّارَة'], unitIndex: 4),
  ArabicLetter(letter: 'ه', name: 'هَاء', nameEn: 'Haa', sound: 'هَ', exampleWords: ['هِلال', 'هَدِيَّة', 'هُدْهُد'], unitIndex: 4),
  ArabicLetter(letter: 'و', name: 'وَاو', nameEn: 'Waaw', sound: 'وَ', exampleWords: ['وَرْدَة', 'وَجْه', 'وَلَد'], unitIndex: 4),
  ArabicLetter(letter: 'ي', name: 'يَاء', nameEn: 'Yaa', sound: 'يَ', exampleWords: ['يَد', 'يَمَامَة', 'يَاسْمِين'], unitIndex: 4),
];
