import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class ShortVowelsSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;
  final bool isActive;

  const ShortVowelsSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
    this.isActive = true,
  });

  @override
  State<ShortVowelsSequenceWidget> createState() =>
      _ShortVowelsSequenceWidgetState();
}

class _ShortVowelsSequenceWidgetState extends State<ShortVowelsSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ─── Data: mirrors original CD ahdaf_a2 / ahdaf_b2 exactly ───────────────
  // الفتحة، الضمة، الكسرة، السكون: أمثلة شاملة لكل حركة
  List<Map<String, dynamic>> get _harakat => _getHarakatForLetter(widget.letterChar);

  // الصوت التمهيدي — يُشغَّل مرة واحدة عند فتح المحطة قبل أي شرح
  static String? _getIntroAudioForLetter(String letter) {
    switch (letter) {
      case 'ح':
        return 'audio/letters/short_vowels/ha_fatha.mp3';
      case 'خ':
        return 'audio/letters/short_vowels/khaa_fatha.mp3';
      case 'د':
        return 'audio/letters/short_vowels/daal_fatha.mp3';
      case 'ذ':
        return 'audio/letters/short_vowels/dhaal_fatha.mp3';
      case 'ر':
        return 'audio/letters/short_vowels/raa_fatha.mp3';
      case 'ز':
        return 'audio/letters/short_vowels/zaay_fatha.mp3';
      case 'س':
        return 'audio/letters/short_vowels/seen_fatha.mp3';
      case 'ج':
        return 'audio/letters/short_vowels/jeem_fatha.mp3';
      case 'ث':
        return 'audio/letters/short_vowels/thaa_fatha.mp3';
      case 'ت':
        return 'audio/lessons/taa/sounds/taa_fatha.mp3';
      case 'ب':
        return 'audio/lessons/baa/sounds/baa_fatha.mp3';
      default:
        return null;
    }
  }

  bool _introPlayed = false;

  static List<Map<String, dynamic>> _getHarakatForLetter(String letter) {
    if (letter == 'ث') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (ثَ)',
          'vowelMark': 'ثَ',
          'color': const Color(0xFFE53935),
          'vowelAudio': 'audio/lessons/thaa/sounds/thaa_fatha.mp3',
          'explanation': 'الْفَتْحَةُ عِبَارَةٌ عَنْ شَرْطَةٍ تُوضَعُ فَوْقَ الْحَرْفِ فَتُحَوِّلُ صَوْتَ الْحَرْفِ دَاخِلَ الْكَلِمَةِ إِلَى (ثَ)',
          'ruleAudio': 'audio/lessons/thaa/sounds/thaa_fatha_rule.mp3',
          'examples': [
            {
              'word': 'ثَلْج',
              'position': 'ثَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/thaa/sounds/word_thalj.mp3',
              'image': 'assets/images/lessons/thaa/sounds/thalj.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (ثُ)',
          'vowelMark': 'ثُ',
          'color': const Color(0xFFFF6F00),
          'vowelAudio': 'audio/lessons/thaa/sounds/thaa_damma.mp3',
          'explanation': 'الضَّمَّةُ تُوضَعُ فَوْقَ الْحَرْفِ وَتُغَيِّرُ صَوْتَ الْحَرْفِ دَاخِلَ الْكَلِمَةِ إِلَى (ثُ)',
          'ruleAudio': 'audio/lessons/thaa/sounds/thaa_damma_rule.mp3',
          'examples': [
            {
              'word': 'ثُعْبَان',
              'position': 'ثَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/thaa/sounds/word_thoban.mp3',
              'image': 'assets/images/lessons/thaa/sounds/thoban.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (ثِ)',
          'vowelMark': 'ثِ',
          'color': const Color(0xFF1E88E5),
          'vowelAudio': 'audio/lessons/thaa/sounds/thaa_kasra.mp3',
          'explanation': 'الشَّرْطَةُ الَّتِي تُوضَعُ أَسْفَلَ الْحَرْفِ تُسَمَّى كَسْرَةً وَتُغَيِّرُ صَوْتَ الْحَرْفِ دَاخِلَ الْكَلِمَةِ إِلَى (ثِ)',
          'ruleAudio': 'audio/lessons/thaa/sounds/thaa_kasra_rule.mp3',
          'examples': [
            {
              'word': 'ثِمَار',
              'position': 'ثَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/thaa/sounds/word_thimar.mp3',
              'image': 'assets/images/lessons/thaa/sounds/thimar.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (ثْ)',
          'vowelMark': 'ثْ',
          'color': const Color(0xFF5D4037),
          'vowelAudio': 'audio/lessons/thaa/sounds/thaa_sukoon.mp3',
          'explanation': 'يُوضَعُ السُّكُونُ فَوْقَ الْحَرْفِ فَيَكُونُ بِدُونِ حَرَكَةٍ (ثْ)',
          'ruleAudio': 'audio/lessons/thaa/sounds/thaa_sukoon_rule.mp3',
          'examples': [
            {
              'word': 'اِثْنَان',
              'position': 'ثَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/thaa/sounds/word_athnan.mp3',
              'image': 'assets/images/lessons/thaa/sounds/athnan.png',
            },
          ],
        },
      ];
    }

    if (letter == 'ج') {
        return [
          {
            'id': 'fatha',
            'label': 'الْفَتْحَةُ (جَ)',
            'vowelMark': 'جَ',
            'color': const Color(0xFFE53935),
            'vowelAudio': 'audio/lessons/jeem/sounds/jeem_fatha.mp3',
            'explanation': 'الْفَتْحَةُ عِبَارَةٌ عَنْ شَرْطَةٍ تُوضَعُ فَوْقَ الْحَرْفِ فَتُحَوِّلُ صَوْتَ الْحَرْفِ دَاخِلَ الْكَلِمَةِ إِلَى (جَ)',
            'ruleAudio': 'audio/lessons/jeem/sounds/jeem_fatha_rule.mp3',
            'examples': [
              {
                'word': 'جَزَر',
                'position': 'جِيمٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
                'audio': 'audio/lessons/jeem/sounds/word_jazar.mp3',
                'image': 'assets/images/lessons/jeem/sounds/jazar.png',
              },
            ],
          },
          {
            'id': 'damma',
            'label': 'الضَّمَّةُ (جُ)',
            'vowelMark': 'جُ',
            'color': const Color(0xFFFF6F00),
            'vowelAudio': 'audio/lessons/jeem/sounds/jeem_damma.mp3',
            'explanation': 'الضَّمَّةُ تُوضَعُ فَوْقَ الْحَرْفِ وَتُغَيِّرُ صَوْتَ الْحَرْفِ دَاخِلَ الْكَلِمَةِ إِلَى (جُ)',
            'ruleAudio': 'audio/lessons/jeem/sounds/jeem_kasra_rule.mp3',
            'examples': [
              {
                'word': 'رَجُل',
                'position': 'جِيمٌ مَضْمُومَةٌ فِي وَسَطِ الْكَلِمَةِ',
                'audio': 'audio/lessons/jeem/sounds/word_rejal.mp3',
                'image': 'assets/images/lessons/jeem/sounds/rejal.png',
              },
            ],
          },
          {
            'id': 'kasra',
            'label': 'الْكَسْرَةُ (جِ)',
            'vowelMark': 'جِ',
            'color': const Color(0xFF1E88E5),
            'vowelAudio': 'audio/lessons/jeem/sounds/jeem_kasra.mp3',
            'explanation': 'الشَّرْطَةُ الَّتِي تُوضَعُ أَسْفَلَ الْحَرْفِ تُسَمَّى كَسْرَةً وَتُغَيِّرُ صَوْتَ الْحَرْفِ دَاخِلَ الْكَلِمَةِ إِلَى (جِ)',
            'ruleAudio': 'audio/lessons/jeem/sounds/jeem_damma_rule.mp3',
            'examples': [
              {
                'word': 'جِذْر',
                'position': 'جِيمٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
                'audio': 'audio/lessons/jeem/sounds/word_juthoor.mp3',
                'image': 'assets/images/lessons/jeem/sounds/juthoor.png',
              },
            ],
          },
          {
            'id': 'sukoon',
            'label': 'عَلَامَةُ السُّكُونِ (جْ)',
            'vowelMark': 'جْ',
            'color': const Color(0xFF5D4037),
            'vowelAudio': 'audio/lessons/jeem/sounds/jeem_sukoon.mp3',
            'explanation': 'يُوضَعُ السُّكُونُ فَوْقَ الْحَرْفِ جِيم فَيَكُونُ بِدُونِ حَرَكَةٍ (جْ)',
            'ruleAudio': 'audio/lessons/jeem/sounds/jeem_sukoon_rule.mp3',
            'examples': [
              {
                'word': 'رِجْل',
                'position': 'جِيمٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
                'audio': 'audio/lessons/jeem/sounds/word_rejl.mp3',
                'image': 'assets/images/lessons/jeem/sounds/rejl.png',
              },
            ],
          },
        ];
      }

      if (letter == 'ت') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (تَ)',
          'vowelMark': 'تَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ مَائِلَةٌ تُوضَعُ فَوْقَ الْحَرْفِ فَيُصْبِحُ صَوْتُهُ (تَ)',
          'ruleAudio': 'audio/lessons/taa/sounds/taa_fatha_rule.mp3',
          'examples': [
            {
              'word': 'تَأْكُلُ',
              'position': 'تَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/taa/sounds/word_taakul.mp3',
              'image': 'assets/images/lessons/taa/sounds/taakul.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (تُ)',
          'vowelMark': 'تُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ وَاوٌ صَغِيرَةٌ تُوضَعُ فَوْقَ الْحَرْفِ فَيُصْبِحُ صَوْتُهُ (تُ)',
          'ruleAudio': 'audio/lessons/taa/sounds/taa_damma_rule.mp3',
          'examples': [
            {
              'word': 'تُوتُ',
              'position': 'تَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/taa/sounds/word_toot.mp3',
              'image': 'assets/images/lessons/taa/sounds/toot.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (تِ)',
          'vowelMark': 'تِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ شَرْطَةٌ مَائِلَةٌ تُوضَعُ تَحْتَ الْحَرْفِ فَيُصْبِحُ صَوْتُهُ (تِ)',
          'ruleAudio': 'audio/lessons/taa/sounds/taa_kasra_rule.mp3',
          'examples': [
            {
              'word': 'تِمْسَاحُ',
              'position': 'تَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/taa/sounds/word_timsah.mp3',
              'image': 'assets/images/lessons/taa/sounds/timsah.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (تْ)',
          'vowelMark': 'تْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ دَائِرَةٌ صَغِيرَةٌ تُوضَعُ فَوْقَ الْحَرْفِ فَيَسْكُنُ صَوْتُهُ (تْ)',
          'ruleAudio': 'audio/lessons/taa/sounds/taa_sukoon_rule.mp3',
          'examples': [
            {
              'word': 'كَتْكُوتُ',
              'position': 'تَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/taa/sounds/word_katkoot.mp3',
              'image': 'assets/images/lessons/taa/sounds/katkoot.png',
            },
          ],
        },
      ];
    }

    if (letter == 'ب') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (بَ)',
          'vowelMark': 'بَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْبَاءِ إِلَى (بَ)',
          'ruleAudio': 'audio/lessons/baa/sounds/baa_fatha_rule.mp3',
          'examples': [
            {
              'word': 'بَقَرَة',
              'position': 'بَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/baa/sounds/word_baqara.mp3',
              'image': 'assets/images/lessons/baa/sounds/baqara.png',
            },
            {
              'word': 'بَاب',
              'position': 'بَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/baa/sounds/word_bab.mp3',
              'image': 'assets/images/lessons/baa/sounds/bab.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (بُ)',
          'vowelMark': 'بُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْبَاءِ إِلَى (بُ)',
          'ruleAudio': 'audio/lessons/baa/sounds/baa_damma_rule.mp3',
          'examples': [
            {
              'word': 'بُرْج',
              'position': 'بَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/baa/sounds/word_borg.mp3',
              'image': 'assets/images/lessons/baa/sounds/borg.png',
            },
            {
              'word': 'يَكْتُبُ',
              'position': 'بَاءٌ مَضْمُومَةٌ فِي آخِرِ الْكَلِمَةِ (مَرْفُوع)',
              'audio': 'audio/lessons/baa/sounds/word_yaktb.mp3',
              'image': 'assets/images/lessons/baa/sounds/yaktb.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (بِ)',
          'vowelMark': 'بِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ شَرْطَةٌ أَسْفَلَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْبَاءِ إِلَى (بِ)',
          'ruleAudio': 'audio/lessons/baa/sounds/baa_kasra_rule.mp3',
          'examples': [
            {
              'word': 'بِطِّيخ',
              'position': 'بَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/baa/sounds/word_betteekh.mp3',
              'image': 'assets/images/lessons/baa/sounds/betteekh.png',
            },
            {
              'word': 'بِنْت',
              'position': 'بَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/baa/sounds/word_bint.mp3',
              'image': 'assets/images/lessons/baa/sounds/bint.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (بْ)',
          'vowelMark': 'بْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ فَوْقَ الْبَاءِ يَجْعَلُهَا بِدُونِ حَرَكَةٍ فَتَسْكُنُ (بْ)',
          'ruleAudio': 'audio/lessons/baa/sounds/baa_sukoon_rule.mp3',
          'examples': [
            {
              'word': 'إِبْرَة',
              'position': 'بَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/baa/sounds/word_ibra.mp3',
              'image': 'assets/images/lessons/baa/sounds/ibra.png',
            },
            {
              'word': 'يَكْتُبْ',
              'position': 'بَاءٌ سَاكِنَةٌ فِي آخِرِ الْكَلِمَةِ (عِنْدَ الْوَقْفِ)',
              'audio': 'audio/lessons/baa/sounds/word_yaktb.mp3',
              'image': 'assets/images/lessons/baa/sounds/yaktb.png',
            },
          ],
        },
      ];
    }

    if (letter == 'ح') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (حَ)',
          'vowelMark': 'حَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْحَاءِ إِلَى (حَ)',
          'ruleAudio': 'audio/lessons/ha/sounds/ha_fatha_rule.mp3',
          'examples': [
            {
              'word': 'حَمَل',
              'position': 'حَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_himal.mp3',
              'image': 'assets/images/lessons/ha/sounds/hamal.png',
            },
            {
              'word': 'حَصَان',
              'position': 'حَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hisaan.mp3',
              'image': 'assets/images/lessons/ha/sounds/hisaan.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (حُ)',
          'vowelMark': 'حُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْحَاءِ إِلَى (حُ)',
          'ruleAudio': 'audio/lessons/ha/sounds/ha_damma_rule.mp3',
          'examples': [
            {
              'word': 'حُوت',
              'position': 'حَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hoot.mp3',
              'image': 'assets/images/lessons/ha/sounds/hoot.png',
            },
            {
              'word': 'حُجْرَة',
              'position': 'حَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hujra.mp3',
              'image': 'assets/images/lessons/ha/sounds/hujra.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (حِ)',
          'vowelMark': 'حِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ أَسْفَلَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْحَاءِ إِلَى (حِ)',
          'ruleAudio': 'audio/lessons/ha/sounds/ha_kasra_rule.mp3',
          'examples': [
            {
              'word': 'حِمَار',
              'position': 'حَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_himaar.mp3',
              'image': 'assets/images/lessons/ha/sounds/himaar.png',
            },
            {
              'word': 'حِصَان',
              'position': 'حَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hisaan.mp3',
              'image': 'assets/images/lessons/ha/sounds/hisaan.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (حْ)',
          'vowelMark': 'حْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ فَوْقَ الْحَاءِ يَجْعَلُهَا بِدُونِ حَرَكَةٍ فَتَسْكُنُ (حْ)',
          'ruleAudio': 'audio/lessons/ha/sounds/ha_sukoon_rule.mp3',
          'examples': [
            {
              'word': 'نَحْل',
              'position': 'حَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_nahl.mp3',
              'image': 'assets/images/lessons/ha/sounds/nahl.png',
            },
            {
              'word': 'بَحْر',
              'position': 'حَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_bahr.mp3',
              'image': 'assets/images/lessons/ha/sounds/bahr.png',
            },
          ],
        },
      ];
    }

    if (letter == 'خ') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (خَ)',
          'vowelMark': 'خَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْخَاءِ إِلَى (خَ)',
          'ruleAudio': 'audio/letters/short_vowels/khaa_fatha.mp3',
          'examples': [
            {
              'word': 'خَرُوف',
              'position': 'خَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_himal.mp3',
              'image': 'assets/images/lessons/kha/kha_fatha_kharuf.png',
            },
            {
              'word': 'خَاتَم',
              'position': 'خَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hisaan.mp3',
              'image': 'assets/images/lessons/kha/kha_fatha_khatam.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (خُ)',
          'vowelMark': 'خُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْخَاءِ إِلَى (خُ)',
          'ruleAudio': 'audio/letters/short_vowels/khaa_damma.mp3',
          'examples': [
            {
              'word': 'خُبْز',
              'position': 'خَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hoot.mp3',
              'image': 'assets/images/lessons/kha/kha_damma_khubz.png',
            },
            {
              'word': 'خُرُوج',
              'position': 'خَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hujra.mp3',
              'image': 'assets/images/lessons/kha/kha_damma_khuruj.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (خِ)',
          'vowelMark': 'خِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ أَسْفَلَ الْحَرْفِ تُحَوِّلُ صَوْتَ الْخَاءِ إِلَى (خِ)',
          'ruleAudio': 'audio/letters/short_vowels/khaa_kasra.mp3',
          'examples': [
            {
              'word': 'خِيمَة',
              'position': 'خَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_himaar.mp3',
              'image': 'assets/images/lessons/kha/kha_kasra_kheema.png',
            },
            {
              'word': 'خِيَار',
              'position': 'خَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_hisaan.mp3',
              'image': 'assets/images/lessons/kha/kha_kasra_khiyar.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (خْ)',
          'vowelMark': 'خْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ فَوْقَ الْخَاءِ يَجْعَلُهَا بِدُونِ حَرَكَةٍ فَتَسْكُنُ (خْ)',
          'ruleAudio': 'audio/letters/short_vowels/khaa_sukoon.mp3',
          'examples': [
            {
              'word': 'نَخْل',
              'position': 'خَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_nahl.mp3',
              'image': 'assets/images/lessons/kha/kha_sukoon_nakhl.png',
            },
            {
              'word': 'مَخْبَز',
              'position': 'خَاءٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/ha/sounds/word_bahr.mp3',
              'image': 'assets/images/lessons/kha/kha_sukoon_makhbaz.png',
            },
          ],
        },
      ];
    }

    if (letter == 'د') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (دَ)',
          'vowelMark': 'دَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الدَّالِ إِلَى (دَ)',
          'ruleAudio': 'audio/letters/short_vowels/daal_fatha.mp3',
          'examples': [
            {
              'word': 'دَار',
              'position': 'دَالٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p1_4.mp3',
              'image': 'assets/images/lessons/dal/dal_fatha_dub.png',
            },
            {
              'word': 'دَرَاجَة',
              'position': 'دَالٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p1_3.mp3',
              'image': 'assets/images/lessons/dal/dal_fatha_daraja.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (دُ)',
          'vowelMark': 'دُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الدَّالِ إِلَى (دُ)',
          'ruleAudio': 'audio/letters/short_vowels/daal_damma.mp3',
          'examples': [
            {
              'word': 'دُبّ',
              'position': 'دَالٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p1_1.mp3',
              'image': 'assets/images/lessons/dal/dal_damma_dukan.png',
            },
            {
              'word': 'دُخَان',
              'position': 'دَالٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p3_2.mp3',
              'image': 'assets/images/lessons/dal/dal_damma_durba.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (دِ)',
          'vowelMark': 'دِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ أَسْفَلَ الْحَرْفِ تُحَوِّلُ صَوْتَ الدَّالِ إِلَى (دِ)',
          'ruleAudio': 'audio/letters/short_vowels/daal_kasra.mp3',
          'examples': [
            {
              'word': 'دِيك',
              'position': 'دَالٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p2_1.mp3',
              'image': 'assets/images/lessons/dal/dal_kasra_deek.png',
            },
            {
              'word': 'دِرْهَم',
              'position': 'دَالٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p2_2.mp3',
              'image': 'assets/images/lessons/dal/dal_kasra_dirham.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (دْ)',
          'vowelMark': 'دْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ فَوْقَ الدَّالِ يَجْعَلُهَا بِدُونِ حَرَكَةٍ فَتَسْكُنُ (دْ)',
          'ruleAudio': 'audio/letters/short_vowels/daal_sukoon.mp3',
          'examples': [
            {
              'word': 'وَرْد',
              'position': 'دَالٌ سَاكِنَةٌ فِي آخِرِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p4_1.mp3',
              'image': 'assets/images/lessons/dal/dal_sukoon_ward.png',
            },
            {
              'word': 'أَسَد',
              'position': 'دَالٌ سَاكِنَةٌ فِي آخِرِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dal/final/dal_word_p4_2.mp3',
              'image': 'assets/images/lessons/dal/dal_sukoon_asad.png',
            },
          ],
        },
      ];
    }

    if (letter == 'ذ') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (ذَ)',
          'vowelMark': 'ذَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الذَّالِ إِلَى (ذَ)',
          'ruleAudio': 'audio/letters/short_vowels/dhaal_fatha.mp3',
          'examples': [
            {
              'word': 'ذَهَب',
              'position': 'ذَالٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p1_3.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_fatha_thahab.png',
            },
            {
              'word': 'ذَيْل',
              'position': 'ذَالٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p1_4.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_fatha_theeb.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (ذُ)',
          'vowelMark': 'ذُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الذَّالِ إِلَى (ذُ)',
          'ruleAudio': 'audio/letters/short_vowels/dhaal_damma.mp3',
          'examples': [
            {
              'word': 'ذُرَة',
              'position': 'ذَالٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p1_2.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_damma_thurah.png',
            },
            {
              'word': 'ذُبَابَة',
              'position': 'ذَالٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p2_2.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_damma_thubab.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (ذِ)',
          'vowelMark': 'ذِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ أَسْفَلَ الْحَرْفِ تُحَوِّلُ صَوْتَ الذَّالِ إِلَى (ذِ)',
          'ruleAudio': 'audio/letters/short_vowels/dhaal_kasra.mp3',
          'examples': [
            {
              'word': 'ذِئْب',
              'position': 'ذَالٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p1_1.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_kasra_theeb.png',
            },
            {
              'word': 'ذِرَاع',
              'position': 'ذَالٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p2_1.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_kasra_thikra.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (ذْ)',
          'vowelMark': 'ذْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ فَوْقَ الذَّالِ يَجْعَلُهَا بِدُونِ حَرَكَةٍ فَتَسْكُنُ (ذْ)',
          'ruleAudio': 'audio/letters/short_vowels/dhaal_sukoon.mp3',
          'examples': [
            {
              'word': 'قُنْفُذ',
              'position': 'ذَالٌ سَاكِنَةٌ فِي آخِرِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p4_1.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_sukoon_qunfuth.png',
            },
            {
              'word': 'جَذْر',
              'position': 'ذَالٌ سَاكِنَةٌ فِي وَسَطِ الْكَلِمَةِ',
              'audio': 'audio/lessons/dhaal/final/dhaal_word_p4_2.mp3',
              'image': 'assets/images/lessons/dhaal/dhaal_sukoon_jathr.png',
            },
          ],
        },
      ];
    }

    if (letter == 'س') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (سَ)',
          'vowelMark': 'سَ',
          'color': const Color(0xFFE53935),
          'explanation': 'نَفْتَحُ الْفَمَ عِنْدَ نُطْقِ حَرْفِ السِّينِ (سَ)',
          'ruleAudio': 'audio/letters/short_vowels/seen_fatha.mp3',
          'examples': [
            {
              'word': 'سَمَكَة',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p1_1.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p1_card_1.png',
            },
            {
              'word': 'سَفِينَة',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p1_2.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p1_card_2.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (سُ)',
          'vowelMark': 'سُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'نَضُمُّ الشَّفَتَيْنِ عِنْدَ نُطْقِ حَرْفِ السِّينِ (سُ)',
          'ruleAudio': 'audio/letters/short_vowels/seen_damma.mp3',
          'examples': [
            {
              'word': 'سُكَّر',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p2_1.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p2_card_1.png',
            },
            {
              'word': 'سُلَحْفَاة',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p2_2.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p2_card_2.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (سِ)',
          'vowelMark': 'سِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'نَخْفِضُ الْفَكَّ عِنْدَ نُطْقِ حَرْفِ السِّينِ (سِ)',
          'ruleAudio': 'audio/letters/short_vowels/seen_kasra.mp3',
          'examples': [
            {
              'word': 'سِرْوَال',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p3_1.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p3_card_1.png',
            },
            {
              'word': 'سِتَار',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p3_2.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p3_card_2.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (سْ)',
          'vowelMark': 'سْ',
          'color': const Color(0xFF43A047),
          'explanation': 'نَقِفُ عَلَى حَرْفِ السِّينِ بِسُكُونٍ هَادِئٍ (سْ)',
          'ruleAudio': 'audio/lessons/seen/sounds/seen_sukoon_rule.mp3',
          'examples': [
            {
              'word': 'مَسْجِد',
              'position': 'وَسَطُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p4_1.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p4_card_1.png',
            },
            {
              'word': 'شَمْس',
              'position': 'آخِرُ الْكَلِمَةِ',
              'audio': 'audio/lessons/seen/final/seen_word_p4_3.mp3',
              'image': 'assets/images/lessons/seen/seen_words_p4_card_3.png',
            },
          ],
        },
      ];
    }

    if (letter == 'ز') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (زَ)',
          'vowelMark': 'زَ',
          'color': const Color(0xFFE53935),
          'explanation': 'نَفْتَحُ الْفَمَ عِنْدَ نُطْقِ حَرْفِ الزَّايِ (زَ)',
          'ruleAudio': 'audio/letters/short_vowels/zaay_fatha.mp3',
          'examples': [
            {
              'word': 'زَهْرَة',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p1_1.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p1_card_1.png',
            },
            {
              'word': 'زَيْتُون',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p1_2.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p1_card_2.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (زُ)',
          'vowelMark': 'زُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'نَضُمُّ الشَّفَتَيْنِ عِنْدَ نُطْقِ حَرْفِ الزَّايِ (زُ)',
          'ruleAudio': 'audio/letters/short_vowels/zaay_damma.mp3',
          'examples': [
            {
              'word': 'زُمُرُّد',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p2_2.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p2_card_2.png',
            },
            {
              'word': 'زُقَاق',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p3_2.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p3_card_2.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (زِ)',
          'vowelMark': 'زِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'نَخْفِضُ الْفَكَّ عِنْدَ نُطْقِ حَرْفِ الزَّايِ (زِ)',
          'ruleAudio': 'audio/letters/short_vowels/zaay_kasra.mp3',
          'examples': [
            {
              'word': 'زِيَارَة',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p2_4.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p2_card_4.png',
            },
            {
              'word': 'زِنْبَق',
              'position': 'أَوَّلُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p1_4.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p1_card_4.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (زْ)',
          'vowelMark': 'زْ',
          'color': const Color(0xFF43A047),
          'explanation': 'نَقِفُ عَلَى حَرْفِ الزَّايِ بِسُكُونٍ هَادِئٍ (زْ)',
          'ruleAudio': 'audio/lessons/zaay/sounds/zaay_sukoon_rule.mp3',
          'examples': [
            {
              'word': 'مِيزَان',
              'position': 'وَسَطُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p4_2.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p4_card_2.png',
            },
            {
              'word': 'لَوْز',
              'position': 'آخِرُ الْكَلِمَةِ',
              'audio': 'audio/lessons/zaay/final/zaay_word_p4_4.mp3',
              'image': 'assets/images/lessons/zaay/zaay_words_p4_card_4.png',
            },
          ],
        },
      ];
    }

    if (letter == 'ر') {
      return [
        {
          'id': 'fatha',
          'label': 'الْفَتْحَةُ (رَ)',
          'vowelMark': 'رَ',
          'color': const Color(0xFFE53935),
          'explanation': 'الْفَتْحَةُ شَرْطَةٌ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الرَّاءِ إِلَى (رَ)',
          'ruleAudio': 'audio/letters/short_vowels/raa_fatha.mp3',
          'examples': [
            {
              'word': 'رَجُل',
              'position': 'رَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p1_1.mp3',
              'image': 'assets/images/lessons/raa/raa_fatha_rajul.png',
            },
            {
              'word': 'رَمْل',
              'position': 'رَاءٌ مَفْتُوحَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p1_4.mp3',
              'image': 'assets/images/lessons/raa/raa_fatha_raml.png',
            },
          ],
        },
        {
          'id': 'damma',
          'label': 'الضَّمَّةُ (رُ)',
          'vowelMark': 'رُ',
          'color': const Color(0xFFFF6F00),
          'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُحَوِّلُ صَوْتَ الرَّاءِ إِلَى (رُ)',
          'ruleAudio': 'audio/letters/short_vowels/raa_damma.mp3',
          'examples': [
            {
              'word': 'رُمَّان',
              'position': 'رَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p1_2.mp3',
              'image': 'assets/images/lessons/raa/raa_damma_rumman.png',
            },
            {
              'word': 'رُكَب',
              'position': 'رَاءٌ مَضْمُومَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p3_3.mp3',
              'image': 'assets/images/lessons/raa/raa_damma_rukab.png',
            },
          ],
        },
        {
          'id': 'kasra',
          'label': 'الْكَسْرَةُ (رِ)',
          'vowelMark': 'رِ',
          'color': const Color(0xFF1E88E5),
          'explanation': 'الْكَسْرَةُ أَسْفَلَ الْحَرْفِ تُحَوِّلُ صَوْتَ الرَّاءِ إِلَى (رِ)',
          'ruleAudio': 'audio/letters/short_vowels/raa_kasra.mp3',
          'examples': [
            {
              'word': 'رِيشَة',
              'position': 'رَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p1_3.mp3',
              'image': 'assets/images/lessons/raa/raa_kasra_reesha.png',
            },
            {
              'word': 'رِيم',
              'position': 'رَاءٌ مَكْسُورَةٌ فِي أَوَّلِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p2_4.mp3',
              'image': 'assets/images/lessons/raa/raa_kasra_reem.png',
            },
          ],
        },
        {
          'id': 'sukoon',
          'label': 'عَلَامَةُ السُّكُونِ (رْ)',
          'vowelMark': 'رْ',
          'color': const Color(0xFF5D4037),
          'explanation': 'السُّكُونُ فَوْقَ الرَّاءِ يَجْعَلُهَا بِدُونِ حَرَكَةٍ فَتَسْكُنُ (رْ)',
          'ruleAudio': 'audio/letters/short_vowels/raa_sukoon.mp3',
          'examples': [
            {
              'word': 'بَحْر',
              'position': 'رَاءٌ سَاكِنَةٌ فِي آخِرِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p4_1.mp3',
              'image': 'assets/images/lessons/raa/raa_sukoon_bahr.png',
            },
            {
              'word': 'صَقْر',
              'position': 'رَاءٌ سَاكِنَةٌ فِي آخِرِ الْكَلِمَةِ',
              'audio': 'audio/lessons/raa/final/raa_word_p4_2.mp3',
              'image': 'assets/images/lessons/raa/raa_sukoon_saqr.png',
            },
          ],
        },
      ];
    }

    // افتراضي لحرف الألف (مطابقة للأسطوانة الأصلية ahdaf_a2)
    return [
      {
        'id': 'fatha',
        'label': 'الْفَتْحَةُ (أَ)',
        'vowelMark': 'أَ',
        'color': const Color(0xFFE53935),
        'explanation': 'الْفَتْحَةُ عِبَارَةٌ عَنْ شَرْطَةٍ تُوضَعُ فَوْقَ الْحَرْفِ فَيُصْبِحُ (أَ)',
        'ruleAudio': 'audio/stories/alif_fatha_rule.mp3',
        'examples': [
          {
            'word': 'أَكَلَ',
            'position': 'أَلِفٌ فِي أَوَّلِ الْكَلِمَةِ',
            'audio': 'audio/stories/alif_word_akala.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_akala.jpg',
          },
          {
            'word': 'سَأَلَ',
            'position': 'أَلِفٌ فِي وَسَطِ الْكَلِمَةِ',
            'audio': 'audio/stories/alif_word_saala.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_saala.jpg',
          },
          {
            'word': 'قَرَأَ',
            'position': 'أَلِفٌ فِي آخِرِ الْكَلِمَةِ',
            'audio': 'audio/stories/alif_word_qaraa.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_qaraa.jpg',
          },
        ],
      },
      {
        'id': 'damma',
        'label': 'الضَّمَّةُ (أُ)',
        'vowelMark': 'أُ',
        'color': const Color(0xFFFF6F00),
        'explanation': 'الضَّمَّةُ فَوْقَ الْحَرْفِ تُغَيِّرُ صَوْتَهُ إِلَى (أُ)',
        'ruleAudio': 'audio/stories/alif_damma_rule.mp3',
        'examples': [
          {
            'word': 'أُذُن',
            'position': '',
            'audio': 'audio/stories/alif_word_udhun.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_udhun.jpg',
          },
          {
            'word': 'أُمِّي',
            'position': '',
            'audio': 'audio/stories/alif_word_ummi.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_ummi.jpg',
          },
        ],
      },
      {
        'id': 'kasra',
        'label': 'الْكَسْرَةُ (إِ)',
        'vowelMark': 'إِ',
        'color': const Color(0xFF1E88E5),
        'explanation': 'الشَّرْطَةُ الَّتِي تُوضَعُ أَسْفَلَ الْحَرْفِ تُسَمَّى كَسْرَةً (إِ)',
        'ruleAudio': 'audio/stories/alif_kasra_rule.mp3',
        'examples': [
          {
            'word': 'إِبْرَة',
            'position': '',
            'audio': 'audio/stories/alif_word_ibra.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_ibra.jpg',
          },
          {
            'word': 'إِينَاس',
            'position': '',
            'audio': 'audio/stories/alif_word_inas.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_inas.jpg',
          },
        ],
      },
      {
        'id': 'sukoon',
        'label': 'عَلَامَةُ السُّكُونِ (أْ)',
        'vowelMark': 'أْ',
        'color': const Color(0xFF5D4037),
        'explanation': 'السُّكُونُ فَوْقَ الْحَرْفِ يَجْعَلُ الْحَرْفَ بِدُونِ حَرَكَةٍ',
        'ruleAudio': 'audio/stories/alif_sukoon_rule.mp3',
        'examples': [
          {
            'word': 'فَأْس',
            'position': '',
            'audio': 'audio/stories/alif_word_faas.mp3',
            'image': 'assets/images/lessons/alif/alif_word_faas.jpg',
          },
          {
            'word': 'رَأْس',
            'position': '',
            'audio': 'audio/stories/alif_word_ras_explain.mp3',
            'image': 'assets/images/lessons/alif/alif_scene_ras.jpg',
          },
        ],
      },
    ];
  }

  // Sub-example index per haraka page
  final Map<int, int> _exampleIndex = {0: 0, 1: 0, 2: 0, 3: 0};

  /// رمز إلغاء التشغيل التلقائي — يُزاد عند كل تفاعل يدوي لوقف أي تسلسل صوتي تلقائي معلّق
  int _autoPlayToken = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _triggerAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant ShortVowelsSequenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _triggerAutoPlay();
    }
  }

  void _triggerAutoPlay() {
    final myToken = ++_autoPlayToken;
    Future.delayed(const Duration(milliseconds: 400), () async {
      if (!mounted || myToken != _autoPlayToken) return;
      final intro = _getIntroAudioForLetter(widget.letterChar);
      if (intro != null && !_introPlayed) {
        // يُشغِّل صوت المقدمة ("أصوات حرف الثاء: ثَـ") مرة واحدة فقط
        _introPlayed = true;
        await AudioService.instance.stop();
        if (!mounted || myToken != _autoPlayToken) return;
        try {
          // ينتظر انتهاء المقدمة بناءً على المدة الفعلية بدلاً من onPlayerComplete
          // حتى لا يُفعَّل الشرح التلقائي بسبب صوت آخر ينتهي لاحقاً
          final dur = AudioService.instance.getAssetDuration(intro);
          await AudioService.instance.playAsset(intro);
          await Future.delayed(dur + const Duration(milliseconds: 200));
        } catch (_) {}
      }
      if (mounted && myToken == _autoPlayToken) {
        _playRuleAudio(_harakat[_currentPage]);
      }
    });
  }

  @override
  void dispose() {
    _autoPlayToken++; // إلغاء أي تشغيل تلقائي معلّق
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playRuleAudio(Map<String, dynamic> haraka) async {
    _autoPlayToken++; // إلغاء التشغيل التلقائي المعلّق عند الضغط اليدوي
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(haraka['ruleAudio'] as String);
    } catch (e) {
      debugPrint('Rule audio error: $e');
    }
  }

  void _playExampleAudio(String audioPath) async {
    _autoPlayToken++; // إلغاء التشغيل التلقائي المعلّق عند الضغط اليدوي
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(audioPath);
    } catch (e) {
      debugPrint('Example audio error: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < _harakat.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onPrevious();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // ─── 1. Header ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDay,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'الْحَرَكَاتُ الْقَصِيرَةُ — ${_harakat[_currentPage]['label']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playRuleAudio(_harakat[_currentPage]),
                ),
              ],
            ),
          ),

          // ─── 2. PageView of harakat ───────────────────────────────────────
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _exampleIndex[index] = 0;
                });
                _playRuleAudio(_harakat[index]);
              },
              itemCount: _harakat.length,
              itemBuilder: (context, pageIdx) {
                final h = _harakat[pageIdx];
                final color = h['color'] as Color;
                final examples = h['examples'] as List<Map<String, dynamic>>;
                final currentEx = _exampleIndex[pageIdx] ?? 0;
                final ex = examples[currentEx];

                final isTablet = MediaQuery.sizeOf(context).width > 600;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 540 : double.infinity),
                      child: Column(
                        children: [
                          // ── 1. بطاقة الحركة والقاعدة ──────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    final va = h['vowelAudio'] as String?;
                                    if (va != null) {
                                      _playExampleAudio(va);
                                    } else {
                                      _playRuleAudio(h);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      h['vowelMark'] as String,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 42,
                                        fontWeight: FontWeight.w900,
                                        color: color,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      _playRuleAudio(h);
                                    },
                                    child: Text(
                                      h['explanation'] as String,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimaryDay,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ── 2. أزرار اختيار الأمثلة التفاعلية الكبيرة ────────
                          if (examples.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < examples.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() => _exampleIndex[pageIdx] = i);
                                            _playExampleAudio(examples[i]['audio'] as String);
                                          },
                                          borderRadius: BorderRadius.circular(20),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: currentEx == i ? color : Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: color.withValues(alpha: currentEx == i ? 1.0 : 0.4),
                                                width: 2,
                                              ),
                                              boxShadow: currentEx == i
                                                  ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))]
                                                  : const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  examples[i]['word'] as String,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: currentEx == i ? Colors.white : color,
                                                  ),
                                                ),
                                                if ((examples[i]['position'] as String).isNotEmpty) ...[
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    '(${examples[i]['position']})',
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: currentEx == i ? Colors.white.withValues(alpha: 0.9) : Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),

                          // ── 3. بطاقة المثال مع المشهد الأصلي بالكامل ──────────
                          GestureDetector(
                            onTap: () => _playExampleAudio(ex['audio'] as String),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 3))
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // عنوان الكلمة وموضع الحرف
                                  Row(
                                    children: [
                                      Text(
                                        ex['word'] as String,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 34,
                                          fontWeight: FontWeight.w900,
                                          color: color,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      if ((ex['position'] as String).isNotEmpty)
                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: color.withValues(alpha: 0.12),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              ex['position'] as String,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.volume_up_rounded, color: color, size: 28),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // المشهد الأصلي الكامل بدون أي قص (نسبة 4:3 واضحة وكاملة)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Container(
                                        color: Colors.grey.shade100,
                                        child: Image.asset(
                                          ex['image'] as String,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => Container(
                                            color: Colors.grey.shade100,
                                            child: const Icon(Icons.image, size: 48, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.touch_app_rounded, size: 16, color: Colors.grey),
                                      SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'اضْغَطْ لِسَمَاعِ نُطْقِ الْكَلِمَةِ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ── 4. أزرار التنقل بين الأمثلة بأزرار كبيرة مريحة ────
                          if (examples.length > 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      final newIdx = currentEx > 0 ? currentEx - 1 : examples.length - 1;
                                      setState(() => _exampleIndex[pageIdx] = newIdx);
                                      _playExampleAudio(examples[newIdx]['audio'] as String);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                                    label: const Text(
                                      'المثال السابق',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: color,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int i = 0; i < examples.length; i++)
                                          AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            margin: const EdgeInsets.symmetric(horizontal: 4),
                                            width: currentEx == i ? 24 : 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: currentEx == i ? color : Colors.grey.shade300,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      final newIdx = currentEx < examples.length - 1 ? currentEx + 1 : 0;
                                      setState(() => _exampleIndex[pageIdx] = newIdx);
                                      _playExampleAudio(examples[newIdx]['audio'] as String);
                                    },
                                    label: const Text(
                                      'المثال التالي',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: color,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── 3. Haraka navigation ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  label: const Text('السابق',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDay,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _harakat.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == i ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == i ? AppColors.primaryDay : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: _nextPage,
                    label: Text(
                      _currentPage == _harakat.length - 1 ? 'التالي: الْمُدُود' : 'التالي',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDay,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
