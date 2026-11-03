import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class LongVowelsSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;
  final bool isActive;

  const LongVowelsSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
    this.isActive = true,
  });

  @override
  State<LongVowelsSequenceWidget> createState() => _LongVowelsSequenceWidgetState();
}

class _LongVowelsSequenceWidgetState extends State<LongVowelsSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _audioPlayId = 0;

  // ─────────────────────────────────────────────────────────────────────────
  // صفحات المدود: الصفحة 0 هي شرح معنى المد وأنواعه، ثم أمثلة الأسطوانة الثلاثة
  // ─────────────────────────────────────────────────────────────────────────
  List<Map<String, dynamic>> get _pages => _getPagesForLetter(widget.letterChar);

  static List<Map<String, dynamic>> _getPagesForLetter(String letter) {
    if (letter == 'ث') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF6A1B9A),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الثَّاءِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/lessons/thaa/sounds/thaa_madd_def.mp3',
          'secondAudioFile': 'audio/lessons/thaa/sounds/thaa_madd_types.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (ثَا)',
          'maddChar': 'ثَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ يَلِيهَا أَلِفٌ، مِثْلُ: ثَابِت',
          'exampleWord': 'ثَابِت',
          'audioFile': 'audio/lessons/thaa/sounds/thaa_madd_alif.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_thabit.mp3',
          'imageFile': 'assets/images/lessons/thaa/sounds/madd_thalatha.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (ثُو)',
          'maddChar': 'ثُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ يَلِيهَا وَاوٌ، مِثْلُ: ثُوم',
          'exampleWord': 'ثُوم',
          'audioFile': 'audio/lessons/thaa/sounds/thaa_madd_waw.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_thum.mp3',
          'imageFile': 'assets/images/lessons/thaa/sounds/madd_thoban.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (ثِي)',
          'maddChar': 'ثِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ يَلِيهَا يَاءٌ، مِثْلُ: ثِيرَان',
          'exampleWord': 'ثِيرَان',
          'audioFile': 'audio/lessons/thaa/sounds/thaa_madd_yaa.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_theeran.mp3',
          'imageFile': 'assets/images/lessons/thaa/sounds/madd_thiab.png',
        },
      ];
    }

    if (letter == 'ج') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'مُقَدِّمَةُ الْمَدِّ الطَّوِيلِ',
          'color': const Color(0xFF00695C),
          'title': 'الْمُدُودُ الطَّوِيلَةُ مَعَ حَرْفِ الْجِيمِ (ج)',
          'explanation': 'حَرْفُ الْجِيمِ (ج) يَمْتَدُّ مَعَ حُرُوفِ الْمَدِّ الثَّلَاثَةِ فَيَطُولُ الصَّوْتُ.',
          'audioFile': 'audio/lessons/jeem/sounds/jeem_madd_def.mp3',
          'secondAudioFile': 'audio/lessons/jeem/sounds/jeem_madd_types.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'مَدُّ الْأَلِفِ الطَّوِيلُ (جَا)',
          'maddChar': 'جَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'مَدُّ الْأَلِفِ يَمُدُّ الْجِيمَ إِلَى ضِعْفَيْنِ مِثَالٌ: جَمَال',
          'exampleWord': 'جَمَال',
          'audioFile': 'audio/letters/long_vowels/jeem_madd_demo.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_jamal.mp3',
          'imageFile': 'assets/images/lessons/jeem/sounds/madd_jamal.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'مَدُّ الْوَاوِ الطَّوِيلُ (جُو)',
          'maddChar': 'جُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'مَدُّ الْوَاوِ يَمُدُّ الْجِيمَ إِلَى ضِعْفَيْنِ مِثَالٌ: جَوَاد',
          'exampleWord': 'جَوَاد',
          'audioFile': 'audio/letters/long_vowels/jeem_madd_demo.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_jawad.mp3',
          'imageFile': 'assets/images/lessons/jeem/sounds/madd_jawad.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'مَدُّ الْيَاءِ الطَّوِيلُ (جِي)',
          'maddChar': 'جِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'مَدُّ الْيَاءِ يَمُدُّ الْجِيمَ إِلَى ضِعْفَيْنِ مِثَالٌ: جِيل',
          'exampleWord': 'جِيل',
          'audioFile': 'audio/letters/long_vowels/jeem_madd_demo.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_jidar.mp3',
          'imageFile': 'assets/images/lessons/jeem/sounds/madd_jeel.png',
        },
      ];
    }

    if (letter == 'ت') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF6A1B9A),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ التَّاءِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/lessons/taa/madd/taa_madd_def.mp3',
          'secondAudioFile': 'audio/lessons/taa/madd/taa_madd_types.mp3',
          'imageFile': 'assets/images/lessons/taa/madd/madd_intro.png',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (تَا)',
          'maddChar': 'تَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ يَلِيهَا أَلِفٌ، مِثْلُ: تَامِر',
          'exampleWord': 'تَامِر',
          'audioFile': 'audio/lessons/taa/madd/taa_madd_alif.mp3',
          'imageFile': 'assets/images/lessons/taa/madd/madd_tamir.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (تُو)',
          'maddChar': 'تُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ يَلِيهَا وَاوٌ، مِثْلُ: تُوت',
          'exampleWord': 'تُوت',
          'audioFile': 'audio/lessons/taa/madd/taa_madd_waw.mp3',
          'imageFile': 'assets/images/lessons/taa/madd/madd_toot.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (تِي)',
          'maddChar': 'تِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ يَلِيهَا يَاءٌ، مِثْلُ: تِين',
          'exampleWord': 'تِين',
          'audioFile': 'audio/lessons/taa/madd/taa_madd_yaa.mp3',
          'imageFile': 'assets/images/lessons/taa/madd/madd_teen.png',
        },
      ];
    }

    if (letter == 'ب') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF6A1B9A),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الْبَاءِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_def.mp3',
          'secondAudioFile': 'audio/lessons/baa/sounds/baa_madd_types.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (بَا)',
          'maddChar': 'بَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: ثُعْبَان',
          'exampleWord': 'ثُعْبَان',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_alif.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_thoban.mp3',
          'imageFile': 'assets/images/lessons/baa/sounds/thoaban.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (بُو)',
          'maddChar': 'بُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: حُبُوب',
          'exampleWord': 'حُبُوب',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_waw.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_hobob.mp3',
          'imageFile': 'assets/images/lessons/baa/sounds/hobob.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (بِي)',
          'maddChar': 'بِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: طَبِيب',
          'exampleWord': 'طَبِيب',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_yaa.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_tabeeb.mp3',
          'imageFile': 'assets/images/lessons/baa/sounds/tabeeb.png',
        },
      ];
    }

    if (letter == 'ح') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF0277BD),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الْحَاءِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/lessons/ha/sounds/ha_madd_def.mp3',
          'secondAudioFile': 'audio/lessons/ha/sounds/ha_madd_types.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (حَا)',
          'maddChar': 'حَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: حَال',
          'exampleWord': 'حَال',
          'audioFile': 'audio/letters/long_vowels/ha_madd_demo.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_haal.mp3',
          'imageFile': 'assets/images/lessons/ha/sounds/madd_haal.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (حُو)',
          'maddChar': 'حُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: حُوت',
          'exampleWord': 'حُوت',
          'audioFile': 'audio/lessons/ha/sounds/ha_madd_waw.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_hoot.mp3',
          'imageFile': 'assets/images/lessons/ha/sounds/madd_hoot.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (حِي)',
          'maddChar': 'حِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: حِيلَة',
          'exampleWord': 'حِيلَة',
          'audioFile': 'audio/lessons/ha/sounds/ha_madd_yaa.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_heela.mp3',
          'imageFile': 'assets/images/lessons/ha/sounds/madd_heela.png',
        },
      ];
    }

    if (letter == 'خ') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF6A1B9A),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الْخَاءِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/lessons/ha/sounds/ha_madd_def.mp3',
          'secondAudioFile': 'audio/lessons/ha/sounds/ha_madd_types.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (خَا)',
          'maddChar': 'خَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: خَال',
          'exampleWord': 'خَال',
          'audioFile': 'audio/letters/long_vowels/khaa_madd_demo.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_haal.mp3',
          'imageFile': 'assets/images/lessons/kha/kha_madd_aa.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (خُو)',
          'maddChar': 'خُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: خُرُوج',
          'exampleWord': 'خُرُوج',
          'audioFile': 'audio/letters/long_vowels/khaa_madd_demo.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_hoot.mp3',
          'imageFile': 'assets/images/lessons/kha/kha_madd_uu.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (خِي)',
          'maddChar': 'خِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: خِيمَة',
          'exampleWord': 'خِيمَة',
          'audioFile': 'audio/letters/long_vowels/khaa_madd_demo.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_heela.mp3',
          'imageFile': 'assets/images/lessons/kha/kha_madd_ii.png',
        },
      ];
    }

    if (letter == 'د') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF00695C),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الدَّالِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/letters/long_vowels/daal_madd_demo.mp3',
          'secondAudioFile': 'audio/letters/long_vowels/daal_madd_demo.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (دَا)',
          'maddChar': 'دَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: دَار',
          'exampleWord': 'دَار',
          'audioFile': 'audio/letters/long_vowels/daal_madd_demo.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p1_4.mp3',
          'imageFile': 'assets/images/lessons/dal/dal_madd_aa.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (دُو)',
          'maddChar': 'دُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: دُود',
          'exampleWord': 'دُود',
          'audioFile': 'audio/letters/long_vowels/daal_madd_demo.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p5_3.mp3',
          'imageFile': 'assets/images/lessons/dal/dal_madd_uu.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (دِي)',
          'maddChar': 'دِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: دِيك',
          'exampleWord': 'دِيك',
          'audioFile': 'audio/letters/long_vowels/daal_madd_demo.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p2_1.mp3',
          'imageFile': 'assets/images/lessons/dal/dal_madd_ii.png',
        },
      ];
    }

    if (letter == 'ذ') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFFE65100),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الذَّالِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/letters/long_vowels/dhaal_madd_demo.mp3',
          'secondAudioFile': 'audio/letters/long_vowels/dhaal_madd_demo.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (ذَا)',
          'maddChar': 'ذَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: ذَاب',
          'exampleWord': 'ذَاب',
          'audioFile': 'audio/letters/long_vowels/dhaal_madd_demo.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p5_1.mp3',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_madd_aa.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (ذُو)',
          'maddChar': 'ذُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: ذُوق',
          'exampleWord': 'ذُوق',
          'audioFile': 'audio/letters/long_vowels/dhaal_madd_demo.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p5_2.mp3',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_madd_uu.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (ذِي)',
          'maddChar': 'ذِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: مَذِيع',
          'exampleWord': 'مَذِيع',
          'audioFile': 'audio/letters/long_vowels/dhaal_madd_demo.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p5_3.mp3',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_madd_ii.png',
        },
      ];
    }

    if (letter == 'س') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF2E7D32),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ السِّينِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/letters/long_vowels/seen_madd_demo.mp3',
          'secondAudioFile': 'audio/letters/long_vowels/seen_madd_demo.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (سَا)',
          'maddChar': 'سَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: سَارَ',
          'exampleWord': 'سَارَ',
          'audioFile': 'audio/letters/long_vowels/seen_madd_demo.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p5_1.mp3',
          'imageFile': 'assets/images/lessons/seen/seen_madd_aa.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (سُو)',
          'maddChar': 'سُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: سُوق',
          'exampleWord': 'سُوق',
          'audioFile': 'audio/letters/long_vowels/seen_madd_demo.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p5_2.mp3',
          'imageFile': 'assets/images/lessons/seen/seen_madd_uu.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (سِي)',
          'maddChar': 'سِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: سِير',
          'exampleWord': 'سِير',
          'audioFile': 'audio/letters/long_vowels/seen_madd_demo.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p5_3.mp3',
          'imageFile': 'assets/images/lessons/seen/seen_madd_ii.png',
        },
      ];
    }

    if (letter == 'ز') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFF00838F),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الزَّايِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/letters/long_vowels/zaay_madd_demo.mp3',
          'secondAudioFile': 'audio/letters/long_vowels/zaay_madd_demo.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (زَا)',
          'maddChar': 'زَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: زَاد',
          'exampleWord': 'زَاد',
          'audioFile': 'audio/letters/long_vowels/zaay_madd_demo.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p5_1.mp3',
          'imageFile': 'assets/images/lessons/zaay/zaay_madd_aa.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (زُو)',
          'maddChar': 'زُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: زُور',
          'exampleWord': 'زُور',
          'audioFile': 'audio/letters/long_vowels/zaay_madd_demo.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p5_2.mp3',
          'imageFile': 'assets/images/lessons/zaay/zaay_madd_uu.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (زِي)',
          'maddChar': 'زِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: زِين',
          'exampleWord': 'زِين',
          'audioFile': 'audio/letters/long_vowels/zaay_madd_demo.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p5_3.mp3',
          'imageFile': 'assets/images/lessons/zaay/zaay_madd_ii.png',
        },
      ];
    }

    if (letter == 'ر') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
          'color': const Color(0xFFC2185B),
          'title': 'الْحَرَكَاتُ الطَّوِيلَةُ مَعَ حَرْفِ الرَّاءِ',
          'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
          'audioFile': 'audio/letters/long_vowels/raa_madd_demo.mp3',
          'secondAudioFile': 'audio/letters/long_vowels/raa_madd_demo.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'الْمَدُّ بِالْأَلِفِ (رَا)',
          'maddChar': 'رَا',
          'color': const Color(0xFFD32F2F),
          'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: رَاح',
          'exampleWord': 'رَاح',
          'audioFile': 'audio/letters/long_vowels/raa_madd_demo.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p5_1.mp3',
          'imageFile': 'assets/images/lessons/raa/raa_madd_aa.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'الْمَدُّ بِالْوَاوِ (رُو)',
          'maddChar': 'رُو',
          'color': const Color(0xFFF57C00),
          'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: رُوح',
          'exampleWord': 'رُوح',
          'audioFile': 'audio/letters/long_vowels/raa_madd_demo.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p5_2.mp3',
          'imageFile': 'assets/images/lessons/raa/raa_madd_uu.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'الْمَدُّ بِالْيَاءِ (رِي)',
          'maddChar': 'رِي',
          'color': const Color(0xFF1976D2),
          'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: رِيح',
          'exampleWord': 'رِيح',
          'audioFile': 'audio/letters/long_vowels/raa_madd_demo.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p5_3.mp3',
          'imageFile': 'assets/images/lessons/raa/raa_madd_ii.png',
        },
      ];
    }

    // افتراضي لحرف الألف (مطابقة للأسطوانة الأصلية ahdaf_a2)
    return [
      {
        'type': 'intro',
        'id': 'madd_intro',
        'label': 'تَعْرِيفُ الْمَدِّ وَأَنْوَاعُهُ',
        'color': const Color(0xFF6A1B9A),
        'title': 'الْحَرَكَاتُ الطَّوِيلَةُ (الْمُدُودُ)',
        'explanation': 'الْمَدُّ هُوَ إِطَالَةُ زَمَنِ صَوْتِ الْحَرَكَةِ (الْفَتْحَةِ أَوِ الضَّمَّةِ أَوِ الْكَسْرَةِ) إِلَى الضِّعْفِ أَوْ أَكْثَرَ.',
        'audioFile': 'audio/stories/alif_mudud_intro.mp3',
      },
      {
        'type': 'example',
        'id': 'madd_alif',
        'label': 'الْمَدُّ بِالْأَلِفِ (آ)',
        'maddChar': 'آ',
        'color': const Color(0xFFD32F2F),
        'explanation': 'فَتْحَةٌ، يَلِيهَا أَلِفٌ، مِثْلُ: آمَال',
        'exampleWord': 'آمَال',
        'audioFile': 'audio/stories/alif_madd_amal.mp3',
        'imageFile': 'assets/images/lessons/alif/alif_word_amal.jpg',
      },
      {
        'type': 'example',
        'id': 'madd_waw',
        'label': 'الْمَدُّ بِالْوَاوِ (أُو)',
        'maddChar': 'أُو',
        'color': const Color(0xFFF57C00),
        'explanation': 'ضَمَّةٌ، يَلِيهَا وَاوٌ، مِثْلُ: الأُولَى',
        'exampleWord': 'الأُولَى',
        'audioFile': 'audio/stories/alif_madd_oula.mp3',
        'imageFile': 'assets/images/lessons/alif/alif_word_oula.jpg',
      },
      {
        'type': 'example',
        'id': 'madd_yaa',
        'label': 'الْمَدُّ بِالْيَاءِ (إِي)',
        'maddChar': 'إِي',
        'color': const Color(0xFF1976D2),
        'explanation': 'كَسْرَةٌ، يَلِيهَا يَاءٌ، مِثْلُ: إِيناس',
        'exampleWord': 'إِيناس',
        'audioFile': 'audio/stories/alif_madd_inas.mp3',
        'imageFile': 'assets/images/lessons/alif/alif_scene_inas.jpg',
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _triggerAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant LongVowelsSequenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _triggerAutoPlay();
    }
  }

  void _triggerAutoPlay() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _playPageAudio(_pages[_currentPage]);
    });
  }

  @override
  void dispose() {
    _audioPlayId++;
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playPageAudio(Map<String, dynamic> page) async {
    final playId = ++_audioPlayId;
    await AudioService.instance.stop();
    try {
      final path = page['audioFile'] as String;
      await AudioService.instance.playAsset(path);

      final followUpPath =
          (page['secondAudioFile'] as String?) ?? (page['wordAudio'] as String?);
      if (followUpPath != null) {
        await AudioService.instance
            .onPlayerComplete(AudioChannel.voice)
            ?.first
            .timeout(const Duration(seconds: 9), onTimeout: () {});
        if (!mounted || playId != _audioPlayId) return;
        await Future.delayed(const Duration(milliseconds: 250));
        if (!mounted || playId != _audioPlayId) return;
        await AudioService.instance.playAsset(followUpPath);
      }
    } catch (e) {
      debugPrint('Madd audio error: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
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
    final isTablet = MediaQuery.sizeOf(context).width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // ─── 1. شريط العنوان العلوي ───
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
                      'الْحَرَكَاتُ الطَّوِيلَةُ — ${_pages[_currentPage]['label']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playPageAudio(_pages[_currentPage]),
                ),
              ],
            ),
          ),

          // ─── 2. عرض الصفحات (المقدمة أولاً ثم أمثلة المدود) ───
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _playPageAudio(_pages[index]);
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final page = _pages[index];
                final color = page['color'] as Color;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 560 : double.infinity),
                      child: page['type'] == 'intro'
                          ? _buildIntroPage(page, color)
                          : _buildExamplePage(page, color),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── 3. أزرار التنقل السفلية ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  label: const Text('السابق',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryDay,
                    side: const BorderSide(color: AppColors.primaryDay, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),

                const SizedBox(width: 6),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(_pages.length, (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 24 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _currentPage == i ? AppColors.primaryDay : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(width: 6),

                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: _nextPage,
                    label: Text(
                      _currentPage == _pages.length - 1
                          ? 'التالي: الْكَلِمَات'
                          : _currentPage == 0
                              ? 'أَمْثِلَةُ الْمَدِّ'
                              : 'الْمَدُّ التَّالِي',
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

  // ── بناء صفحة شرح معنى المد وأنواعه الثلاثة ──
  Widget _buildIntroPage(Map<String, dynamic> page, Color color) {
    // استخرج صفحات الأمثلة للعرض داخل المقدمة
    final examplePages = _pages.where((p) => p['type'] == 'example').toList();

    return Column(
      children: [
        // بطاقة التعريف
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, color: color, size: 30),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'مَا هُوَ الْمَدُّ؟',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                page['explanation'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDay,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              // زر تشغيل الشرح الكامل
              GestureDetector(
                onTap: () => _playPageAudio(page),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_circle_rounded, color: color, size: 28),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'اضْغَطْ لِسَمَاعِ شَرْحِ الْمَدِّ كَامِلاً',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // أنواع المد الثلاثة مع صورها — تظهر مرافقةً للشرح الصوتي
        Text(
          'وَالْمَدُّ ثَلاثَةُ أَنْوَاعٍ:',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 10),

        ...examplePages.map((ex) {
          final exColor = ex['color'] as Color;
          final hasImage = ex.containsKey('imageFile');
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => _playPageAudio(ex),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: exColor.withValues(alpha: 0.4), width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    // صورة المثال
                    if (hasImage)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          width: 88,
                          height: 72,
                          child: Image.asset(
                            ex['imageFile'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: exColor.withValues(alpha: 0.1),
                              child: Icon(Icons.image, color: exColor, size: 32),
                            ),
                          ),
                        ),
                      ),
                    if (hasImage) const SizedBox(width: 12),
                    // النص
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ex['label'] as String,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: exColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ex['explanation'] as String,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              color: AppColors.textPrimaryDay,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ex['exampleWord'] as String,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: exColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.volume_up_rounded, color: exColor.withValues(alpha: 0.8), size: 22),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ── بناء صفحة المثال الفردي للمد ──
  Widget _buildExamplePage(Map<String, dynamic> m, Color color) {
    return Column(
      children: [
        // بطاقة القاعدة وشكل المد
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  m['maddChar'] as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m['explanation'] as String,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDay,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // بطاقة المثال المركزية الكبيرة
        GestureDetector(
          onTap: () => _playPageAudio(m),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'مِثَالٌ: ',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        m['exampleWord'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (m.containsKey('imageFile'))
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Image.asset(
                          m['imageFile'] as String,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade100,
                            child: const Icon(Icons.image, size: 64, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.volume_up_rounded, color: color, size: 24),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'اضْغَطْ لِسَمَاعِ نُطْقِ الْكَلِمَةِ',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
