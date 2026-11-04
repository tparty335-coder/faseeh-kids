import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';

class TraceSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;

  const TraceSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
  });

  @override
  State<TraceSequenceWidget> createState() => _TraceSequenceWidgetState();
}

class _TraceSequenceWidgetState extends State<TraceSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  List<Map<String, dynamic>> get _steps => _getStepsForLetter(widget.letterChar);

  static List<Map<String, dynamic>> _getStepsForLetter(String letter) {
    if (letter == 'ث') {
      return [
        {
          'title': 'الثَّاءُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'قَوْسٌ أَعْلَاهُ ثَلَاثُ نِقَاطٍ',
          'positionCode': 'isolated',
          'letterShape': 'ث',
          'allForms': ['ث'],
          'formsNote': 'شَكْلٌ وَاحِدٌ فَقَطْ لِلثَّاءِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'ثُعْبَان',
          'exampleEmoji': '🐍',
          'imageFile': 'assets/images/lessons/thaa/sounds/thoban.png',
          'audio': 'audio/lessons/thaa/writing/thaa_write_intro.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_thoban.mp3',
          'color': const Color(0xFF6A1B9A),
        },
        {
          'title': 'الثَّاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ',
          'positionCode': 'start',
          'letterShape': 'ثـ',
          'allForms': ['ثـ'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي يَلِيهَا',
          'position': 'أَوَّلُ الْكَلِمَةِ',
          'exampleWord': 'ثَعْلَب',
          'exampleEmoji': '🦊',
          'imageFile': 'assets/images/lessons/thaa/sounds/thalab.png',
          'audio': 'audio/letters/short_vowels/thaa_fatha.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_thalab.mp3',
          'color': const Color(0xFF7B1FA2),
        },
        {
          'title': 'الثَّاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَمَا بَعْدَهَا',
          'positionCode': 'middle',
          'letterShape': 'ـثـ',
          'allForms': ['ـثـ'],
          'formsNote': 'مُتَّصِلَةٌ مِنَ الْجِهَتَيْنِ',
          'position': 'وَسَطُ الْكَلِمَةِ',
          'exampleWord': 'مِثْقَاب',
          'exampleEmoji': '🔧',
          'imageFile': 'assets/images/lessons/thaa/sounds/mithqab.png',
          'audio': 'audio/letters/short_vowels/thaa_fatha.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_thalj.mp3',
          'color': const Color(0xFF8E24AA),
        },
        {
          'title': 'الثَّاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'end',
          'letterShape': 'ـث',
          'allForms': ['ـث'],
          'formsNote': 'الثَّاءُ فِي آخِرِ الْكَلِمَةِ',
          'position': 'آخِرُ الْكَلِمَةِ',
          'exampleWord': 'لَيْث',
          'exampleEmoji': '🦁',
          'imageFile': 'assets/images/lessons/thaa/sounds/layth.png',
          'audio': 'audio/letters/short_vowels/thaa_sukoon.mp3',
          'wordAudio': 'audio/lessons/thaa/sounds/word_thalatha.mp3',
          'color': const Color(0xFF4A148C),
        },
      ];
    }

    if (letter == 'ج') {
      return [
        {
          'title': 'الْجِيمُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'رَأْسٌ مُنْحَنٍ وَبَطْنٌ بِدَاخِلِهِ نُقْطَةٌ',
          'positionCode': 'isolated',
          'letterShape': 'ج',
          'allForms': ['ج'],
          'formsNote': 'شَكْلٌ وَاحِدٌ فَقَطْ لِلْجِيمِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'جَمَل',
          'exampleEmoji': '🐫',
          'imageFile': 'assets/images/lessons/jeem/sounds/jamal.png',
          'audio': 'audio/lessons/jeem/writing/jeem_write_intro.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_jamal.mp3',
          'color': const Color(0xFF00695C),
        },
        {
          'title': 'الْجِيمُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ',
          'positionCode': 'start',
          'letterShape': 'جـ',
          'allForms': ['جـ'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي يَلِيهَا',
          'position': 'أَوَّلُ الْكَلِمَةِ',
          'exampleWord': 'جَبَل',
          'exampleEmoji': '⛰️',
          'imageFile': 'assets/images/lessons/jeem/sounds/jabal.png',
          'audio': 'audio/letters/short_vowels/jeem_fatha.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_jabal.mp3',
          'color': const Color(0xFF00796B),
        },
        {
          'title': 'الْجِيمُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَمَا بَعْدَهَا',
          'positionCode': 'middle',
          'letterShape': 'ـجـ',
          'allForms': ['ـجـ'],
          'formsNote': 'مُتَّصِلَةٌ مِنَ الْجِهَتَيْنِ',
          'position': 'وَسَطُ الْكَلِمَةِ',
          'exampleWord': 'نَجْم',
          'exampleEmoji': '⭐',
          'imageFile': 'assets/images/lessons/jeem/sounds/najm.png',
          'audio': 'audio/letters/short_vowels/jeem_sukoon.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_najm.mp3',
          'color': const Color(0xFF2E7D32),
        },
        {
          'title': 'الْجِيمُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'end',
          'letterShape': 'ـج',
          'allForms': ['ـج'],
          'formsNote': 'الْجِيمُ فِي آخِرِ الْكَلِمَةِ',
          'position': 'آخِرُ الْكَلِمَةِ',
          'exampleWord': 'ثَلْج',
          'exampleEmoji': '❄️',
          'imageFile': 'assets/images/lessons/jeem/sounds/fajr.png',
          'audio': 'audio/letters/short_vowels/jeem_sukoon.mp3',
          'wordAudio': 'audio/lessons/jeem/sounds/word_fajr.mp3',
          'color': const Color(0xFF004D40),
        },
      ];
    }

    if (letter == 'ت') {
      return [
        {
          'title': 'التَّاءُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'قَوْسٌ أَعْلَاهُ نُقْطَتَانِ',
          'positionCode': 'isolated',
          'letterShape': 'ت',
          'allForms': ['ت'],
          'formsNote': 'شَكْلٌ وَاحِدٌ فَقَطْ لِلتَّاءِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'تُفَّاحَة',
          'exampleEmoji': '🍎',
          'imageFile': 'assets/images/lessons/taa/sounds/tuffaha.png',
          'audio': 'audio/lessons/taa/writing/taa_write_intro.mp3',
          'wordAudio': 'audio/lessons/taa/sounds/word_tuffaha.mp3',
          'color': const Color(0xFF1565C0),
        },
        {
          'title': 'التَّاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ',
          'positionCode': 'start',
          'letterShape': 'تـ',
          'allForms': ['تـ'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي يَلِيهَا',
          'position': 'أَوَّلُ الْكَلِمَةِ',
          'exampleWord': 'تَاج',
          'exampleEmoji': '👑',
          'imageFile': 'assets/images/lessons/taa/sounds/taaj.png',
          'audio': 'audio/lessons/taa/writing/taa_write_first.mp3',
          'wordAudio': 'audio/lessons/taa/sounds/word_taaj.mp3',
          'color': const Color(0xFF1E88E5),
        },
        {
          'title': 'التَّاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَمَا بَعْدَهَا',
          'positionCode': 'middle',
          'letterShape': 'ـتـ',
          'allForms': ['ـتـ'],
          'formsNote': 'مُتَّصِلَةٌ مِنَ الْجِهَتَيْنِ',
          'position': 'وَسَطُ الْكَلِمَةِ',
          'exampleWord': 'كَتْكُوت',
          'exampleEmoji': '🐥',
          'imageFile': 'assets/images/lessons/taa/taa_words_p2_card_2.png',
          'audio': 'audio/lessons/taa/writing/taa_write_middle.mp3',
          'wordAudio': 'audio/lessons/taa/sounds/word_katkoot.mp3',
          'color': const Color(0xFF43A047),
        },
        {
          'title': 'التَّاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'end',
          'letterShape': 'ـت',
          'allForms': ['ـت'],
          'formsNote': 'التَّاءُ الْمَفْتُوحَةُ فِي آخِرِ الْكَلِمَةِ',
          'position': 'آخِرُ الْكَلِمَةِ',
          'exampleWord': 'بِنْت',
          'exampleEmoji': '👧',
          'imageFile': 'assets/images/lessons/taa/taa_words_p2_card_3.png',
          'audio': 'audio/lessons/taa/writing/taa_write_end.mp3',
          'wordAudio': 'audio/lessons/taa/sounds/word_bint.mp3',
          'color': const Color(0xFFFF6F00),
        },
      ];
    }

    if (letter == 'ب') {
      return [
        // ── 1. الباء الكاملة المفردة ──────────────────────────────
        {
          'title': 'الْبَاءُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'سِنَّتَانِ يَمِينًا وَيَسَارًا، وَنُقْطَةٌ أَسْفَلَهَا',
          'positionCode': 'isolated',
          'letterShape': 'ب',
          'allForms': ['ب'],
          'formsNote': 'شَكْلٌ وَاحِدٌ فَقَطْ لِلْحَرْفِ الْمُفْرَدِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'بَقَرَة',
          'exampleEmoji': '🐄',
          'imageFile': 'assets/images/lessons/baa/sounds/baqara.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w8.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_baqara.mp3',
          'color': const Color(0xFF673AB7),
        },
        // ── 2. الباء في أول الكلمة ───────────────────────────────
        {
          'title': 'الْبَاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'شَكْلٌ وَاحِدٌ فَقَطْ — تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ',
          'positionCode': 'start',
          'letterShape': 'بـ',
          'allForms': ['بـ'],
          'formsNote': 'لَيْسَ لِلْبَاءِ فِي الْبِدَايَةِ إِلَّا هَذَا الشَّكْلُ',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'بَاب',
          'exampleEmoji': '🚪',
          'imageFile': 'assets/images/lessons/baa/sounds/bab.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w9.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_bab.mp3',
          'color': const Color(0xFFE53935),
        },
        // ── 3. الباء في وسط الكلمة (شكل ①: بعد حرف متصل) ───────
        {
          'title': 'الْبَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الأَوَّلُ: بَعْدَ حَرْفٍ يَتَّصِلُ بِمَا بَعْدَهُ مِثْلَ (ث، ع، ن...)',
          'positionCode': 'middle',
          'letterShape': 'ـبـ',
          'allForms': ['ـبـ', 'بـ'],
          'formsNote': 'شَكْلَانِ حَسَبَ الْحَرْفِ الَّذِي قَبْلَهَا',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'وَسَطُ الْكَلِمَة (١)',
          'exampleWord': 'حُبُوب',
          'exampleEmoji': '🌾',
          'imageFile': 'assets/images/lessons/baa/sounds/hobob.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w10.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_hobob.mp3',
          'color': const Color(0xFFFF8F00),
        },
        // ── 4. الباء في وسط الكلمة (شكل ②: بعد حرف رافسة) ──────
        {
          'title': 'الْبَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الثَّانِي: بَعْدَ حَرْفٍ رَافِسٍ (ا، و، ر، ز، د، ذ، ...) تَبْدُو كَأَوَّلِ الْكَلِمَةِ',
          'positionCode': 'mid_disconnected',
          'letterShape': 'بـ',
          'allForms': ['ـبـ', 'بـ'],
          'formsNote': 'الْحُرُوفُ الرَّافِسَةُ: ا و ر ز د ذ',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'وَسَطُ الْكَلِمَة (٢)',
          'exampleWord': 'إِبْرَة',
          'exampleEmoji': '🪡',
          'imageFile': 'assets/images/lessons/baa/sounds/ibra.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w10.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_ibra.mp3',
          'color': const Color(0xFF1976D2),
        },
        // ── 5. الباء في آخر الكلمة (شكل ①: بعد حرف متصل) ───────
        {
          'title': 'الْبَاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الأَوَّلُ: بَعْدَ حَرْفٍ يَتَّصِلُ بِمَا بَعْدَهُ',
          'positionCode': 'end',
          'letterShape': 'ـب',
          'allForms': ['ـب', 'ب'],
          'formsNote': 'شَكْلَانِ حَسَبَ الْحَرْفِ الَّذِي قَبْلَهَا',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'آخِرُ الْكَلِمَة (١)',
          'exampleWord': 'يَكْتُب',
          'exampleEmoji': '✍️',
          'imageFile': 'assets/images/lessons/baa/sounds/yaktb.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w11.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_yaktb.mp3',
          'color': const Color(0xFF43A047),
        },
        // ── 6. الباء في آخر الكلمة (شكل ②: بعد حرف رافسة) ──────
        {
          'title': 'الْبَاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'الشَّكْلُ الثَّانِي: بَعْدَ حَرْفٍ رَافِسٍ — تُشْبِهُ شَكْلَهَا الْمُفْرَدَ',
          'positionCode': 'end_disconnected',
          'letterShape': 'ب',
          'allForms': ['ـب', 'ب'],
          'formsNote': 'مِثَالٌ: باب، ذَهَب',
          'formsLabels': ['بعد متصل', 'بعد رافسة'],
          'position': 'آخِرُ الْكَلِمَة (٢)',
          'exampleWord': 'بَاب',
          'exampleEmoji': '🚪',
          'imageFile': 'assets/images/lessons/baa/sounds/bab.png',
          'audio': 'audio/lessons/baa/writing/baa_write_w11.mp3',
          'wordAudio': 'audio/lessons/baa/sounds/word_bab.mp3',
          'color': const Color(0xFF00838F),
        },
      ];
    }

    if (letter == 'ح') {
      return [
        {
          'title': 'الْحَاءُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'شَكْلٌ مُغْلَقٌ مِنَ الْيَمِينِ — ابْدَأْ مِنَ الْأَعْلَى وَدُوَّرِ الشَّكْلَ',
          'positionCode': 'isolated',
          'letterShape': 'ح',
          'allForms': ['ح'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلْحَاءِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'حَمَل',
          'exampleEmoji': '🐑',
          'imageFile': 'assets/images/lessons/ha/ha_trace_isolated.png',
          'audio': 'audio/lessons/ha/final/ha_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_himal.mp3',
          'color': const Color(0xFF0277BD),
        },
        {
          'title': 'الْحَاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ — شَكْلُهَا قَرِيبٌ مِنَ الْمُفْرَدَةِ',
          'positionCode': 'start',
          'letterShape': 'حـ',
          'allForms': ['حـ'],
          'formsNote': 'لَيْسَ لِلْحَاءِ فِي الْبِدَايَةِ إِلَّا هَذَا الشَّكْلُ',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'حِصَان',
          'exampleEmoji': '🐴',
          'imageFile': 'assets/images/lessons/ha/ha_trace_start.png',
          'audio': 'audio/lessons/ha/final/ha_trace_start.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_hisaan.mp3',
          'color': const Color(0xFFE53935),
        },
        {
          'title': 'الْحَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَبِمَا بَعْدَهَا',
          'positionCode': 'middle',
          'letterShape': 'ـحـ',
          'allForms': ['ـحـ'],
          'formsNote': 'الْحَاءُ فِي الْوَسَطِ تَحْتَفِظُ بِشَكْلِهَا',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'نَحْل',
          'exampleEmoji': '🐝',
          'imageFile': 'assets/images/lessons/ha/ha_trace_middle.png',
          'audio': 'audio/lessons/ha/final/ha_trace_middle.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_nahl.mp3',
          'color': const Color(0xFFFF8F00),
        },
        {
          'title': 'الْحَاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَتُغْلَقُ مِنَ الْيَمِينِ',
          'positionCode': 'end',
          'letterShape': 'ـح',
          'allForms': ['ـح'],
          'formsNote': 'الْحَاءُ فِي الْآخِرِ تُشْبِهُ شَكْلَهَا الْمُفْرَدَ مَعَ ذَيْلٍ',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'فَرَح',
          'exampleEmoji': '😊',
          'imageFile': 'assets/images/lessons/ha/ha_trace_end.png',
          'audio': 'audio/lessons/ha/final/ha_trace_end.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_farah.mp3',
          'color': const Color(0xFF43A047),
        },
      ];
    }

    if (letter == 'خ') {
      return [
        {
          'title': 'الْخَاءُ الْكَامِلَةُ (مُفْرَدَة)',
          'subtitle': 'شَكْلٌ مُغْلَقٌ مِنَ الْيَمِينِ مَعَ نُقْطَةٍ فَوْقَهَا',
          'positionCode': 'isolated',
          'letterShape': 'خ',
          'allForms': ['خ'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلْخَاءِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'خَرُوف',
          'exampleEmoji': '🐑',
          'imageFile': 'assets/images/lessons/kha/kha_trace_isolated.png',
          'audio': 'audio/lessons/kha/final/kha_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_himal.mp3',
          'color': const Color(0xFF6A1B9A),
        },
        {
          'title': 'الْخَاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا بَعْدَهَا مِنَ الْيَسَارِ',
          'positionCode': 'start',
          'letterShape': 'خـ',
          'allForms': ['خـ'],
          'formsNote': 'لَيْسَ لِلْخَاءِ فِي الْبِدَايَةِ إِلَّا هَذَا الشَّكْلُ',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'خِيمَة',
          'exampleEmoji': '⛺',
          'imageFile': 'assets/images/lessons/kha/kha_trace_start.png',
          'audio': 'audio/lessons/kha/final/kha_trace_start.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_hisaan.mp3',
          'color': const Color(0xFFE53935),
        },
        {
          'title': 'الْخَاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَبِمَا بَعْدَهَا',
          'positionCode': 'middle',
          'letterShape': 'ـخـ',
          'allForms': ['ـخـ'],
          'formsNote': 'الْخَاءُ فِي الْوَسَطِ تَحْتَفِظُ بِشَكْلِهَا',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'نَخْل',
          'exampleEmoji': '🌴',
          'imageFile': 'assets/images/lessons/kha/kha_trace_middle.png',
          'audio': 'audio/lessons/kha/final/kha_trace_middle.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_nahl.mp3',
          'color': const Color(0xFFFF8F00),
        },
        {
          'title': 'الْخَاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَتُغْلَقُ مِنَ الْيَمِينِ',
          'positionCode': 'end',
          'letterShape': 'ـخ',
          'allForms': ['ـخ'],
          'formsNote': 'الْخَاءُ فِي الْآخِرِ تُشْبِهُ شَكْلَهَا الْمُفْرَدَ',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'مَخْبَز',
          'exampleEmoji': '🍞',
          'imageFile': 'assets/images/lessons/kha/kha_trace_end.png',
          'audio': 'audio/lessons/kha/final/kha_trace_end.mp3',
          'wordAudio': 'audio/lessons/ha/sounds/word_bahr.mp3',
          'color': const Color(0xFF43A047),
        },
      ];
    }

    if (letter == 'د') {
      return [
        {
          'title': 'الدَّالُ الْمُنْفَصِلَةُ (مُفْرَدَة)',
          'subtitle': 'تُكْتَبُ بِخَطٍّ مُنْحَنٍ كَالْقَوْسِ يَسْتَقِرُّ عَلَى السَّطْرِ',
          'positionCode': 'isolated',
          'letterShape': 'د',
          'allForms': ['د'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلدَّالِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'دُبّ',
          'exampleEmoji': '🐻',
          'imageFile': 'assets/images/lessons/dal/dal_trace_isolated.png',
          'audio': 'audio/lessons/dal/final/dal_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p1_1.mp3',
          'color': const Color(0xFF00695C),
        },
        {
          'title': 'الدَّالُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'لَا تَتَّصِلُ بِمَا بَعْدَهَا مِنْ حُرُوفِ الْفَصْلِ',
          'positionCode': 'start',
          'letterShape': 'د',
          'allForms': ['د'],
          'formsNote': 'الدَّالُ لَا تَتَّصِلُ بِمَا بَعْدَهَا أَبَدًا',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'دَار',
          'exampleEmoji': '🏠',
          'imageFile': 'assets/images/lessons/dal/dal_trace_start.png',
          'audio': 'audio/lessons/dal/final/dal_trace_start.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p1_4.mp3',
          'color': const Color(0xFFE53935),
        },
        {
          'title': 'الدَّالُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'middle',
          'letterShape': 'ـد',
          'allForms': ['ـد'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي قَبْلَهَا',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'جَدِيد',
          'exampleEmoji': '✨',
          'imageFile': 'assets/images/lessons/dal/dal_trace_middle.png',
          'audio': 'audio/lessons/dal/final/dal_trace_middle.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p4_4.mp3',
          'color': const Color(0xFFFF8F00),
        },
        {
          'title': 'الدَّالُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا أَو تأْتِي مُنْفَصِلَةً',
          'positionCode': 'end',
          'letterShape': 'ـد',
          'allForms': ['ـد', 'د'],
          'formsNote': 'إِمَّا مُتَّصِلَةً مِثْلَ: أَسَد، أَوْ مُنْفَصِلَةً مِثْلَ: وَرْد',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'أَسَد',
          'exampleEmoji': '🦁',
          'imageFile': 'assets/images/lessons/dal/dal_trace_end.png',
          'audio': 'audio/lessons/dal/final/dal_trace_end.mp3',
          'wordAudio': 'audio/lessons/dal/final/dal_word_p4_2.mp3',
          'color': const Color(0xFF43A047),
        },
      ];
    }

    if (letter == 'ذ') {
      return [
        {
          'title': 'الذَّالُ الْمُنْفَصِلَةُ (مُفْرَدَة)',
          'subtitle': 'تُكْتَبُ كَالدَّالِ مَعَ نُقْطَةٍ وَاحِدَةٍ فَوْقَهَا',
          'positionCode': 'isolated',
          'letterShape': 'ذ',
          'allForms': ['ذ'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلذَّالِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'ذِئْب',
          'exampleEmoji': '🐺',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_trace_isolated.png',
          'audio': 'audio/lessons/dhaal/final/dhaal_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p1_1.mp3',
          'color': const Color(0xFFE65100),
        },
        {
          'title': 'الذَّالُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'لَا تَتَّصِلُ بِمَا بَعْدَهَا مِنْ حُرُوفِ الْفَصْلِ',
          'positionCode': 'start',
          'letterShape': 'ذ',
          'allForms': ['ذ'],
          'formsNote': 'الذَّالُ لَا تَتَّصِلُ بِمَا بَعْدَهَا أَبَدًا',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'ذَهَب',
          'exampleEmoji': '✨',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_trace_start.png',
          'audio': 'audio/lessons/dhaal/final/dhaal_trace_start.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p1_3.mp3',
          'color': const Color(0xFFE53935),
        },
        {
          'title': 'الذَّالُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'middle',
          'letterShape': 'ـذ',
          'allForms': ['ـذ'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي قَبْلَهَا',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'جَذْر',
          'exampleEmoji': '🌱',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_trace_middle.png',
          'audio': 'audio/lessons/dhaal/final/dhaal_trace_middle.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p4_2.mp3',
          'color': const Color(0xFFFF8F00),
        },
        {
          'title': 'الذَّالُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا أَو تأْتِي مُنْفَصِلَةً',
          'positionCode': 'end',
          'letterShape': 'ـذ',
          'allForms': ['ـذ', 'ذ'],
          'formsNote': 'إِمَّا مُتَّصِلَةً مِثْلَ: قُنْفُذ، أَوْ مُنْفَصِلَةً مِثْلَ: أُسْتَاذ',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'قُنْفُذ',
          'exampleEmoji': '🦔',
          'imageFile': 'assets/images/lessons/dhaal/dhaal_trace_end.png',
          'audio': 'audio/lessons/dhaal/final/dhaal_trace_end.mp3',
          'wordAudio': 'audio/lessons/dhaal/final/dhaal_word_p4_1.mp3',
          'color': const Color(0xFF43A047),
        },
      ];
    }

    if (letter == 'س') {
      return [
        {
          'title': 'السِّينُ الْمُنْفَصِلَةُ (مُفْرَدَة)',
          'subtitle': 'ثَلَاثُ سِنَّاتٍ يَتْبَعُهَا كَأْسٌ يَهْبِطُ تَحْتَ السَّطْرِ',
          'positionCode': 'isolated',
          'letterShape': 'س',
          'allForms': ['س'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلسِّينِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'سَمَكَة',
          'exampleEmoji': '🐟',
          'imageFile': 'assets/images/lessons/seen/seen_trace_isolated.png',
          'audio': 'audio/lessons/seen/final/seen_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p1_1.mp3',
          'color': const Color(0xFF2E7D32),
        },
        {
          'title': 'السِّينُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا بَعْدَهَا فِي بِدَايَةِ الْكَلِمَةِ',
          'positionCode': 'start',
          'letterShape': 'سـ',
          'allForms': ['سـ'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي يَلِيهَا',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'سَفِينَة',
          'exampleEmoji': '🚢',
          'imageFile': 'assets/images/lessons/seen/seen_trace_start.png',
          'audio': 'audio/lessons/seen/final/seen_trace_start.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p1_2.mp3',
          'color': const Color(0xFF388E3C),
        },
        {
          'title': 'السِّينُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا وَمَا بَعْدَهَا',
          'positionCode': 'middle',
          'letterShape': 'ـسـ',
          'allForms': ['ـسـ'],
          'formsNote': 'مُتَّصِلَةٌ مِنَ الْجِهَتَيْنِ',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'مَسْجِد',
          'exampleEmoji': '🕌',
          'imageFile': 'assets/images/lessons/seen/seen_trace_middle.png',
          'audio': 'audio/lessons/seen/final/seen_trace_middle.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p4_1.mp3',
          'color': const Color(0xFF43A047),
        },
        {
          'title': 'السِّينُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا أَوْ تَأْتِي مُنْفَصِلَةً',
          'positionCode': 'end',
          'letterShape': 'ـس',
          'allForms': ['ـس', 'س'],
          'formsNote': 'فِي آخِرِ الْكَلِمَةِ تَعُودُ لَهَا كَأْسُهَا الْكَامِلَةُ',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'شَمْس',
          'exampleEmoji': '☀️',
          'imageFile': 'assets/images/lessons/seen/seen_trace_end.png',
          'audio': 'audio/lessons/seen/final/seen_trace_end.mp3',
          'wordAudio': 'audio/lessons/seen/final/seen_word_p4_3.mp3',
          'color': const Color(0xFF1B5E20),
        },
      ];
    }

    if (letter == 'ز') {
      return [
        {
          'title': 'الزَّايُ الْمُنْفَصِلَةُ (مُفْرَدَة)',
          'subtitle': 'تُكْتَبُ كَالرَّاءِ مَعَ نُقْطَةٍ وَاحِدَةٍ فَوْقَهَا',
          'positionCode': 'isolated',
          'letterShape': 'ز',
          'allForms': ['ز'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلزَّايِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'زَهْرَة',
          'exampleEmoji': '🌸',
          'imageFile': 'assets/images/lessons/zaay/zaay_trace_isolated.png',
          'audio': 'audio/lessons/zaay/final/zaay_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p1_1.mp3',
          'color': const Color(0xFF00838F),
        },
        {
          'title': 'الزَّايُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'تَبْدَأُ بِهَا الْكَلِمَةُ دُونَ اتِّصَالٍ بِمَا بَعْدَهَا',
          'positionCode': 'start',
          'letterShape': 'ز',
          'allForms': ['ز'],
          'formsNote': 'الزَّايُ لَا تَتَّصِلُ بِمَا بَعْدَهَا أَبَدًا',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'زَيْتُون',
          'exampleEmoji': '🫒',
          'imageFile': 'assets/images/lessons/zaay/zaay_trace_start.png',
          'audio': 'audio/lessons/zaay/final/zaay_trace_start.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p1_2.mp3',
          'color': const Color(0xFF00ACC1),
        },
        {
          'title': 'الزَّايُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'middle',
          'letterShape': 'ـز',
          'allForms': ['ـز'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي قَبْلَهَا',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'مِيزَان',
          'exampleEmoji': '⚖️',
          'imageFile': 'assets/images/lessons/zaay/zaay_trace_middle.png',
          'audio': 'audio/lessons/zaay/final/zaay_trace_middle.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p4_2.mp3',
          'color': const Color(0xFF00897B),
        },
        {
          'title': 'الزَّايُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا أَوْ تَأْتِي مُنْفَصِلَةً',
          'positionCode': 'end',
          'letterShape': 'ـز',
          'allForms': ['ـز', 'ز'],
          'formsNote': 'إِمَّا مُتَّصِلَةً مِثْلَ: خُبْز، أَوْ مُنْفَصِلَةً مِثْلَ: لَوْز',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'لَوْز',
          'exampleEmoji': '🥜',
          'imageFile': 'assets/images/lessons/zaay/zaay_trace_end.png',
          'audio': 'audio/lessons/zaay/final/zaay_trace_end.mp3',
          'wordAudio': 'audio/lessons/zaay/final/zaay_word_p4_4.mp3',
          'color': const Color(0xFF43A047),
        },
      ];
    }

    if (letter == 'ر') {
      return [
        {
          'title': 'الرَّاءُ الْمُنْفَصِلَةُ (مُفْرَدَة)',
          'subtitle': 'تُكْتَبُ هِلَالِيَّةً مُنْحَنِيَةً تَهْبِطُ تَحْتَ السَّطْرِ',
          'positionCode': 'isolated',
          'letterShape': 'ر',
          'allForms': ['ر'],
          'formsNote': 'شَكْلٌ وَاحِدٌ لِلرَّاءِ الْمُفْرَدَةِ',
          'position': 'مُفْرَدَة',
          'exampleWord': 'رَجُل',
          'exampleEmoji': '🧑‍🚀',
          'imageFile': 'assets/images/lessons/raa/raa_trace_isolated.png',
          'audio': 'audio/lessons/raa/final/raa_trace_isolated.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p1_1.mp3',
          'color': const Color(0xFFC2185B),
        },
        {
          'title': 'الرَّاءُ فِي أَوَّلِ الْكَلِمَةِ',
          'subtitle': 'لَا تَتَّصِلُ بِمَا بَعْدَهَا مِنْ حُرُوفِ الْفَصْلِ',
          'positionCode': 'start',
          'letterShape': 'ر',
          'allForms': ['ر'],
          'formsNote': 'الرَّاءُ لَا تَتَّصِلُ بِمَا بَعْدَهَا أَبَدًا',
          'position': 'أَوَّلُ الْكَلِمَة',
          'exampleWord': 'رُمَّان',
          'exampleEmoji': '🍎',
          'imageFile': 'assets/images/lessons/raa/raa_trace_start.png',
          'audio': 'audio/lessons/raa/final/raa_trace_start.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p1_2.mp3',
          'color': const Color(0xFFE53935),
        },
        {
          'title': 'الرَّاءُ فِي وَسَطِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا فَقَطْ',
          'positionCode': 'middle',
          'letterShape': 'ـر',
          'allForms': ['ـر'],
          'formsNote': 'تَتَّصِلُ بِالْحَرْفِ الَّذِي قَبْلَهَا',
          'position': 'وَسَطُ الْكَلِمَة',
          'exampleWord': 'بَحْر',
          'exampleEmoji': '🌊',
          'imageFile': 'assets/images/lessons/raa/raa_trace_middle.png',
          'audio': 'audio/lessons/raa/final/raa_trace_middle.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p4_1.mp3',
          'color': const Color(0xFFFF8F00),
        },
        {
          'title': 'الرَّاءُ فِي آخِرِ الْكَلِمَةِ',
          'subtitle': 'تَتَّصِلُ بِمَا قَبْلَهَا أَوْ تَأْتِي مُنْفَصِلَةً',
          'positionCode': 'end',
          'letterShape': 'ـر',
          'allForms': ['ـر', 'ر'],
          'formsNote': 'إِمَّا مُتَّصِلَةً مِثْلَ: صَقْر، أَوْ مُنْفَصِلَةً مِثْلَ: قَمَر',
          'position': 'آخِرُ الْكَلِمَة',
          'exampleWord': 'قَمَر',
          'exampleEmoji': '🌙',
          'imageFile': 'assets/images/lessons/raa/raa_trace_end.png',
          'audio': 'audio/lessons/raa/final/raa_trace_end.mp3',
          'wordAudio': 'audio/lessons/raa/final/raa_word_p4_3.mp3',
          'color': const Color(0xFF43A047),
        },
      ];
    }

    // افتراضي لحرف الألف (مطابقة للأسطوانة الأصلية ahdaf_a3)
    return [
      {
        'title': 'كَيْفِيَّةُ كِتَابَةِ حَرْفِ الْأَلِفِ',
        'subtitle': 'نَبْدَأُ مِنْ أَعْلَى إِلَى أَسْفَلَ، ثُمَّ نَكْتُبُ الْهَمْزَةَ',
        'positionCode': 'isolated',
        'letterShape': 'أ',
        'position': 'رَسْمُ الْحَرْفِ',
        'exampleWord': 'أَسَد',
        'exampleEmoji': '🦁',
        'imageFile': 'assets/images/lessons/alif/alif_word_asad.jpg',
        'audio': 'audio/stories/alif_trace_intro.mp3',
        'wordAudio': 'audio/stories/alif_word_asad.mp3',
        'color': const Color(0xFF673AB7),
      },
      {
        'title': 'الْأَلِفُ فِي أَوَّلِ الْكَلِمَةِ',
        'subtitle': 'يَأْتِي مُنْفَصِلاً غَيْرَ مُتَّصِلٍ بِمَا بَعْدَهُ: أَكَلَ',
        'positionCode': 'start',
        'letterShape': 'أ',
        'position': 'أَوَّلُ الْكَلِمَةِ',
        'exampleWord': 'أَكَلَ',
        'exampleEmoji': '🍽️',
        'imageFile': 'assets/images/lessons/alif/alif_scene_akala.jpg',
        'audio': 'audio/stories/alif_pos_start.mp3',
        'wordAudio': 'audio/stories/alif_word_akala.mp3',
        'color': const Color(0xFFE53935),
      },
      {
        'title': 'الْأَلِفُ فِي وَسَطِ الْكَلِمَةِ',
        'subtitle': 'يَتَّصِلُ بِمَا قَبْلَهُ وَلَا يَتَّصِلُ بِمَا بَعْدَهُ: سَأَلَ',
        'positionCode': 'middle',
        'letterShape': 'ـأ',
        'position': 'وَسَطُ الْكَلِمَةِ',
        'exampleWord': 'سَأَلَ',
        'exampleEmoji': '🙋‍♂️',
        'imageFile': 'assets/images/lessons/alif/alif_scene_saala.jpg',
        'audio': 'audio/stories/alif_pos_middle.mp3',
        'wordAudio': 'audio/stories/alif_word_saala.mp3',
        'color': const Color(0xFFFF8F00),
      },
      {
        'title': 'الْأَلِفُ فِي آخِرِ الْكَلِمَةِ',
        'subtitle': 'يَأْتِي مُتَّصِلاً بِمَا قَبْلَهُ أَوْ مُنْفَصِلاً: قَرَأَ',
        'positionCode': 'end',
        'letterShape': 'ـأ',
        'position': 'آخِرُ الْكَلِمَةِ',
        'exampleWord': 'قَرَأَ',
        'exampleEmoji': '📖',
        'imageFile': 'assets/images/lessons/alif/alif_scene_qaraa.jpg',
        'audio': 'audio/stories/alif_pos_end.mp3',
        'wordAudio': 'audio/stories/alif_word_qaraa.mp3',
        'color': const Color(0xFF43A047),
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted && _steps.isNotEmpty) _playAudio(_steps[0]['audio'] as String);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playAudio(String path) async {
    await AudioService.instance.stop();
    try {
      await AudioService.instance.playAsset(path);
    } catch (e) {
      debugPrint('Trace audio error: $e');
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
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
          // ─── Header ───
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
                      'كِتَابَةُ وَمَوَاضِعُ الْحَرْفِ (${_currentStep + 1}/${_steps.length}) — ${_steps[_currentStep]['position']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playAudio(_steps[_currentStep]['audio'] as String),
                ),
              ],
            ),
          ),

          // ─── PageView of Steps ───
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // منع إزاحة الشاشة أثناء سحب الإصبع والرسم
              onPageChanged: (index) {
                setState(() => _currentStep = index);
                _playAudio(_steps[index]['audio'] as String);
              },
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                final s = _steps[index];
                final color = s['color'] as Color;
                final shape = s['letterShape'] as String;
                final example = s['exampleWord'] as String;
                final imageFile = s['imageFile'] as String;
                final positionCode = s['positionCode'] as String;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 700 : double.infinity),
                      child: Column(
                        children: [
                          // 1. بطاقة العنوان + الصورة + المثال
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── عنوان كبير واضح ──
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        s['title'] as String,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: isTablet ? 22 : 18,
                                          fontWeight: FontWeight.w900,
                                          color: color,
                                        ),
                                      ),
                                    ),
                                    // زر استماع للشرح الصوتي الأصلي
                                    GestureDetector(
                                      onTap: () => _playAudio(s['audio'] as String),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(Icons.volume_up_rounded,
                                            color: Colors.white, size: 22),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s['subtitle'] as String,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // ── الصورة + المثال ──
                                GestureDetector(
                                  onTap: () => _playAudio(s['wordAudio'] as String),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: SizedBox(
                                          width: isTablet ? 130.0 : 100.0,
                                          height: isTablet ? 100.0 : 75.0,
                                          child: Image.asset(
                                            imageFile,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Container(
                                              color: Colors.grey.shade200,
                                              child: const Icon(Icons.image, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'مِثَالٌ: $example ${s['exampleEmoji']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Icon(Icons.volume_up_rounded, size: 18, color: color),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // 2. ── شريط أشكال الحرف في هذا الموضع ──
                          if (s.containsKey('allForms')) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                              ),
                              child: Column(
                                children: [
                                  // ملاحظة الشكل
                                  Text(
                                    s['formsNote'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: color.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // الأشكال
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: () {
                                      final forms = s['allForms'] as List<dynamic>;
                                      final labels = s['formsLabels'] as List<dynamic>?;
                                      return List.generate(forms.length, (fi) {
                                        final f = forms[fi] as String;
                                        final isActive = f == shape;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                          child: Column(
                                            children: [
                                              AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: isActive ? color : Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: isActive ? color : Colors.grey.shade300,
                                                    width: isActive ? 2.5 : 1,
                                                  ),
                                                  boxShadow: isActive ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))] : [],
                                                ),
                                                child: Text(
                                                  f,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w900,
                                                    color: isActive ? Colors.white : Colors.grey.shade500,
                                                  ),
                                                ),
                                              ),
                                              if (labels != null && fi < labels.length) ...[
                                                const SizedBox(height: 4),
                                                Text(
                                                  labels[fi] as String,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14,
                                                    color: isActive ? color : Colors.grey,
                                                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        );
                                      });
                                    }(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],

                          // 3. لوحة التتبع والكتابة التفاعلية
                          ArabicLetterTracingCanvas(
                            letterChar: widget.letterChar,
                            position: positionCode,
                            exampleWord: example,
                            exampleEmoji: s['exampleEmoji'] as String,
                            primaryColor: color,
                            onComplete: () {
                              _playAudio(s['wordAudio'] as String);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── Navigation Buttons ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _prevStep,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  label: const Text(
                    'السابق',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDay,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                ),

                const SizedBox(width: 6),
                // Dots
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _steps.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentStep == i ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentStep == i ? AppColors.primaryDay : Colors.grey.shade300,
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
                    onPressed: _nextStep,
                    label: Text(
                      _currentStep == _steps.length - 1 ? 'التالي: ألعاب الحرف 🎮' : 'التالي',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      _currentStep == _steps.length - 1 ? Icons.videogame_asset_rounded : Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentStep == _steps.length - 1 ? AppColors.oasisGreen : AppColors.primaryDay,
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


