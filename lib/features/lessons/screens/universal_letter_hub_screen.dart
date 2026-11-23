import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/dal/dal_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/dhaal/dhaal_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/ha/ha_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/jeem/jeem_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/kha/kha_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/lesson_sequence_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/raa/raa_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/seen/seen_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/taa/taa_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/thaa/thaa_lesson_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/letter_lesson_shell_screen.dart';
import 'package:faseeh_kids/features/lessons/screens/zaay/zaay_lesson_screen.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// بوابة وحدة الحرف — تصميم تعليمي عالمي متجاوب لجميع الحروف الـ 28
/// يجمع بين هوية الحرف اللونية، والنطق التفاعلي للحرف وحركاته القصيرة،
/// وخريطة المحطات السبع الفعلية، وأزرار فعل لمسية عالية التباين (WCAG AA+).
class UniversalLetterHubScreen extends ConsumerStatefulWidget {
  final String? letterChar;
  const UniversalLetterHubScreen({super.key, this.letterChar});

  @override
  ConsumerState<UniversalLetterHubScreen> createState() =>
      _UniversalLetterHubScreenState();
}

class _UniversalLetterHubScreenState
    extends ConsumerState<UniversalLetterHubScreen> {
  String? _activeAudioTag; // 'sound', 'name', 'fatha', 'damma', 'kasra'
  int _audioToken = 0;

  static const Map<String, String> _definiteNames = {
    'أ': 'الْأَلِفِ',
    'ب': 'الْبَاءِ',
    'ت': 'التَّاءِ',
    'ث': 'الثَّاءِ',
    'ج': 'الْجِيمِ',
    'ح': 'الْحَاءِ',
    'خ': 'الْخَاءِ',
    'د': 'الدَّالِ',
    'ذ': 'الذَّالِ',
    'ر': 'الرَّاءِ',
    'ز': 'الزَّايِ',
    'س': 'السِّينِ',
    'ش': 'الشِّينِ',
    'ص': 'الصَّادِ',
    'ض': 'الضَّادِ',
    'ط': 'الطَّاءِ',
    'ظ': 'الظَّاءِ',
    'ع': 'الْعَيْنِ',
    'غ': 'الْغَيْنِ',
    'ف': 'الْفَاءِ',
    'ق': 'الْقَافِ',
    'ك': 'الْكَافِ',
    'ل': 'اللَّامِ',
    'م': 'الْمِيمِ',
    'ن': 'النُّونِ',
    'ه': 'الْهَاءِ',
    'هـ': 'الْهَاءِ',
    'و': 'الْوَاوِ',
    'ي': 'الْيَاءِ',
  };

  static const List<String> _ordinalUnits = [
    'الْأُولَى',
    'الثَّانِيَةُ',
    'الثَّالِثَةُ',
    'الرَّابِعَةُ',
    'الْخَامِسَةُ',
    'السَّادِسَةُ',
    'السَّابِعَةُ',
    'الثَّامِنَةُ',
    'التَّاسِعَةُ',
    'الْعَاشِرَةُ',
    'الْحَادِيَةَ عَشْرَةَ',
    'الثَّانِيَةَ عَشْرَةَ',
    'الثَّالِثَةَ عَشْرَةَ',
    'الرَّابِعَةَ عَشْرَةَ',
    'الْخَامِسَةَ عَشْرَةَ',
    'السَّادِسَةَ عَشْرَةَ',
    'السَّابِعَةَ عَشْرَةَ',
    'الثَّامِنَةَ عَشْرَةَ',
    'التَّاسِعَةَ عَشْرَةَ',
    'الْعِشْرُونَ',
    'الْحَادِيَةُ وَالْعِشْرُونَ',
    'الثَّانِيَةُ وَالْعِشْرُونَ',
    'الثَّالِثَةُ وَالْعِشْرُونَ',
    'الرَّابِعَةُ وَالْعِشْرُونَ',
    'الْخَامِسَةُ وَالْعِشْرُونَ',
    'السَّادِسَةُ وَالْعِشْرُونَ',
    'السَّابِعَةُ وَالْعِشْرُونَ',
    'الثَّامِنَةُ وَالْعِشْرُونَ',
  ];

  static const List<_StationMeta> _stations = [
    _StationMeta(0, 'الْأَهْدَافُ', Icons.flag_rounded, Color(0xFFEF6C00)),
    _StationMeta(1, 'الْقِصَّةُ', Icons.auto_stories_rounded, Color(0xFF7B1FA2)),
    _StationMeta(2, 'الْأَصْوَاتُ', Icons.record_voice_over_rounded, Color(0xFFD84315)),
    _StationMeta(3, 'الْمُدُودُ', Icons.text_fields_rounded, Color(0xFF1565C0)),
    _StationMeta(4, 'الْكِتَابَةُ', Icons.edit_rounded, Color(0xFF00838F)),
    _StationMeta(5, 'الْكَلِمَاتُ', Icons.menu_book_rounded, Color(0xFF2E7D32)),
    _StationMeta(6, 'الْأَلْعَابُ', Icons.sports_esports_rounded, Color(0xFFC2185B)),
  ];

  static String _safeDecode(String input) {
    try {
      return Uri.decodeComponent(input);
    } catch (_) {
      return input;
    }
  }

  static String _toArabicDigits(int value) {
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return value
        .toString()
        .split('')
        .map((c) => digits[int.tryParse(c) ?? 0])
        .join();
  }

  static Color _resolveAccentColor(String char) {
    final manifest = findManifestForLetter(char);
    if (manifest != null) return _ensureAccessibleAccent(manifest.topBarColor);
    if (char == 'أ') return const Color(0xFFC64718);
    if (char == 'ب') return const Color(0xFF6A1B9A);
    return const Color(0xFF1565C0);
  }

  /// يضمن تبايناً عالياً (WCAG AA+) للنص الأبيض فوق لون الحرف
  /// مع تحويل الأصفر الفاقع (مثل حرف الميم) إلى كهرماني دافئ غني بدلاً من الزيتوني الباهت
  static Color _ensureAccessibleAccent(Color raw) {
    final hsl = HSLColor.fromColor(raw);
    if (hsl.hue >= 36 && hsl.hue <= 64 && hsl.lightness > 0.42) {
      return const Color(0xFFB45309); // Rich warm amber (WCAG AA+ with white)
    }
    if (hsl.lightness > 0.42) {
      return hsl.withLightness(0.36).toColor();
    }
    return raw;
  }

  static Color _darken(Color c, [double amount = 0.14]) {
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  static String _resolveMascotEmoji(String char) {
    final manifest = findManifestForLetter(char);
    if (manifest != null) return manifest.mascotEmoji;
    if (char == 'أ') return '🦁';
    if (char == 'ب') return '🦆';
    return '⭐';
  }

  static List<_VowelPreview> _vowelsForLetter(String char) {
    final isAlif = char == 'أ';
    final isHaa = char == 'ه' || char == 'هـ';
    return [
      _VowelPreview(
        variant: 'fatha',
        display: isAlif ? 'أَ' : (isHaa ? 'هَـ' : '$charَ'),
        label: 'فَتْحَة',
        color: const Color(0xFFD84315),
      ),
      _VowelPreview(
        variant: 'damma',
        display: isAlif ? 'أُ' : (isHaa ? 'هُـ' : '$charُ'),
        label: 'ضَمَّة',
        color: const Color(0xFF1565C0),
      ),
      _VowelPreview(
        variant: 'kasra',
        display: isAlif ? 'إِ' : (isHaa ? 'هِـ' : '$charِ'),
        label: 'كَسْرَة',
        color: const Color(0xFF2E7D32),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (widget.letterChar != null) {
        final raw = widget.letterChar!;
        final decoded = _safeDecode(raw);
        final matches = arabicLetters
            .where((l) => l.letter == decoded || l.letter == raw);
        if (matches.isNotEmpty) {
          ref.read(currentLessonProvider.notifier).setLetter(matches.first);
        }
      }
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        _playVariant('sound');
      }
    });
  }

  @override
  void dispose() {
    _audioToken++;
    try {
      AudioService.instance.stop();
    } catch (_) {}
    super.dispose();
  }

  ArabicLetter? _resolveLetter(ArabicLetter? providerLetter) {
    if (widget.letterChar != null && widget.letterChar!.isNotEmpty) {
      final raw = widget.letterChar!;
      final decoded = _safeDecode(raw);
      for (final l in arabicLetters) {
        if (l.letter == decoded ||
            l.letter == raw ||
            (decoded == 'هـ' && l.letter == 'ه')) {
          return l;
        }
      }
    }
    return providerLetter;
  }

  Future<void> _playVariant(String variant) async {
    final letter = _resolveLetter(ref.read(currentLessonProvider).letter);
    final char = letter?.letter ?? _safeDecode(widget.letterChar ?? 'ب');
    if (!mounted) return;

    final tk = ++_audioToken;
    setState(() => _activeAudioTag = variant);
    final key = AudioRegistry.letterKeyFromChar(char);

    try {
      HapticFeedback.selectionClick();
      await () async {
        await AudioManager.instance.playLetterAudio(key, variant);
        final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
        if (done != null) {
          await done.first;
        } else {
          await Future.delayed(const Duration(milliseconds: 1200));
        }
      }().timeout(const Duration(milliseconds: 2200), onTimeout: () {});
    } catch (e) {
      debugPrint('Hub audio [$variant] error: $e');
    } finally {
      if (mounted && tk == _audioToken) {
        setState(() => _activeAudioTag = null);
      }
    }
  }

  void _openLessonAt(String letterChar, int stationIndex) {
    HapticFeedback.mediumImpact();
    _audioToken++;
    try {
      AudioService.instance.stop();
    } catch (_) {}

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _buildLessonDestination(letterChar, stationIndex),
      ),
    );
  }

  Widget _buildLessonDestination(String char, int stationIndex) {
    switch (char) {
      case 'أ':
        return AlifLessonScreen(initialStationIndex: stationIndex);
      case 'ب':
        return BaaLessonScreen(initialStationIndex: stationIndex);
      case 'ت':
        return TaaLessonScreen(initialStationIndex: stationIndex);
      case 'ث':
        return ThaaLessonScreen(initialStationIndex: stationIndex);
      case 'ج':
        return JeemLessonScreen(initialStationIndex: stationIndex);
      case 'ح':
        return HaLessonScreen(initialStationIndex: stationIndex);
      case 'خ':
        return KhaLessonScreen(initialStationIndex: stationIndex);
      case 'د':
        return DalLessonScreen(initialStationIndex: stationIndex);
      case 'ذ':
        return DhaalLessonScreen(initialStationIndex: stationIndex);
      case 'ر':
        return RaaLessonScreen(initialStationIndex: stationIndex);
      case 'ز':
        return ZaayLessonScreen(initialStationIndex: stationIndex);
      case 'س':
        return SeenLessonScreen(initialStationIndex: stationIndex);
      default:
        final manifest = findManifestForLetter(char);
        if (manifest != null) {
          return LetterLessonShellScreen(
            manifest: manifest,
            initialStationIndex: stationIndex,
          );
        }
        return const LessonSequenceScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = _resolveLetter(lessonState.letter);

    if (letter == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('خَطَأ')),
          body: const Center(
            child: Text(
              'لَمْ يَتِمَّ اخْتِيَارُ حَرْفٍ',
              style: TextStyle(fontFamily: 'NotoNaskhArabic', fontSize: 18),
            ),
          ),
        ),
      );
    }

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.shortestSide >= 600;
    final isWide = size.width >= 600;

    final accent = _resolveAccentColor(letter.letter);
    final accentDark = _darken(accent, 0.14);
    final accentSoft = Color.lerp(Colors.white, accent, 0.10)!;
    final definiteName = _definiteNames[letter.letter] ?? 'الْ${letter.name}';
    final fullTitle = 'حَرْفُ $definiteName';

    final letterOrder =
        (arabicLetters.indexWhere((l) => l.letter == letter.letter) + 1)
            .clamp(1, arabicLetters.length);
    final unitOrdinal = _ordinalUnits[(letterOrder - 1).clamp(0, _ordinalUnits.length - 1)];
    final mascotEmoji = _resolveMascotEmoji(letter.letter);
    final vowels = _vowelsForLetter(letter.letter);

    final bgTop = Color.lerp(const Color(0xFFFFFDF8), accent, 0.05)!;
    final bgMid = const Color(0xFFFFFBF2);
    final bgBot = Color.lerp(const Color(0xFFFFF3E0), accent, 0.09)!;

    final router = GoRouter.maybeOf(context);
    final canPop = router?.canPop() ?? Navigator.of(context).canPop();

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (router != null) {
          router.go(AppRouter.homeMap);
        } else {
          Navigator.of(context).maybePop();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [bgTop, bgMid, bgBot],
              ),
            ),
            child: Stack(
              children: [
                // خلفية زخرفية ناعمة تعطي عمقاً دون تشتيت الطفل
                IgnorePointer(
                  child: Stack(
                    children: [
                      Positioned(
                        top: -70,
                        left: -60,
                        child: Container(
                          width: isTablet ? 280 : 180,
                          height: isTablet ? 280 : 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accent.withValues(alpha: 0.07),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 110,
                        right: -80,
                        child: Container(
                          width: isTablet ? 320 : 210,
                          height: isTablet ? 320 : 210,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFB300).withValues(alpha: 0.09),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // المحتوى الرئيسي المتجاوب
                SafeArea(
                  child: Column(
                    children: [
                      // ─── 1. الشريط العلوي الواضح وعالي التباين ───
                      _buildTopBar(
                        context: context,
                        accent: accent,
                        unitLabel: 'الْوَحْدَةُ $unitOrdinal',
                        letterOrder: letterOrder,
                        totalLetters: arabicLetters.length,
                        isTablet: isTablet,
                      ),

                      // ─── 2. المساحة المركزية التعليمية (بطاقة الحرف + المحطات) ───
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 28 : 16,
                              vertical: isTablet ? 12 : 8,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isTablet ? 700 : 500,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildHeroCard(
                                    letter: letter,
                                    fullTitle: fullTitle,
                                    definiteName: definiteName,
                                    mascotEmoji: mascotEmoji,
                                    vowels: vowels,
                                    accent: accent,
                                    accentDark: accentDark,
                                    accentSoft: accentSoft,
                                    isTablet: isTablet,
                                  ),
                                  SizedBox(height: isTablet ? 26 : 14),
                                  _buildStationsSection(
                                    letterChar: letter.letter,
                                    accent: accent,
                                    isTablet: isTablet,
                                  ),
                                  SizedBox(height: isTablet ? 28 : 16),
                                  _buildActionButtons(
                                    letter: letter,
                                    definiteName: definiteName,
                                    accent: accent,
                                    accentDark: accentDark,
                                    isTablet: isTablet,
                                    isWide: isWide,
                                  ),
                                  SizedBox(height: isTablet ? 24 : 12),
                                ],
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildTopBar({
    required BuildContext context,
    required Color accent,
    required String unitLabel,
    required int letterOrder,
    required int totalLetters,
    required bool isTablet,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isTablet ? 24 : 14,
        isTablet ? 12 : 8,
        isTablet ? 24 : 14,
        6,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isTablet ? 760 : double.infinity),
        child: Row(
          children: [
            // زر الرجوع الدائري بحجم لمس قياسي ≥ 48dp وتباين عالٍ
            Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 3,
              shadowColor: Colors.black26,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  HapticFeedback.lightImpact();
                  final router = GoRouter.maybeOf(context);
                  if (router != null) {
                    if (router.canPop()) {
                      router.pop();
                    } else {
                      router.go(AppRouter.homeMap);
                    }
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
                child: SizedBox(
                  width: isTablet ? 52 : 46,
                  height: isTablet ? 52 : 46,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: accent,
                    size: isTablet ? 28 : 24,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // شارة الوحدة والمحطات السبع الفعلية (بدلاً من العداد الوهمي 0/11)
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 18 : 12,
                  vertical: isTablet ? 10 : 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.28),
                    width: 1.6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: const Color(0xFFEF6C00),
                      size: isTablet ? 20 : 17,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        '$unitLabel  •  ${_toArabicDigits(_stations.length)} مَحَطَّاتٍ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: isTablet ? 16 : 13,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF263238),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // شارة ترتيب الحرف الحقيقي ضمن الأبجدية (مثلاً: ٢ / ٢٨)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 16 : 12,
                vertical: isTablet ? 10 : 8,
              ),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '${_toArabicDigits(letterOrder)} / ${_toArabicDigits(totalLetters)}',
                style: TextStyle(
                  fontFamily: 'NotoNaskhArabic',
                  fontSize: isTablet ? 15 : 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard({
    required ArabicLetter letter,
    required String fullTitle,
    required String definiteName,
    required String mascotEmoji,
    required List<_VowelPreview> vowels,
    required Color accent,
    required Color accentDark,
    required Color accentSoft,
    required bool isTablet,
  }) {
    final isPlayingMain =
        _activeAudioTag == 'sound' || _activeAudioTag == 'name';
    final medallionSize = isTablet ? 216.0 : 148.0;
    final letterFontSize = isTablet ? 124.0 : 84.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isTablet ? 28 : 18,
        isTablet ? 24 : 18,
        isTablet ? 28 : 18,
        isTablet ? 24 : 18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: accent.withValues(alpha: 0.22), width: 2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.14),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
          const BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── ترحيب الصقر «فَصِيح» في موضع مستقل أنيق (بلا تصادم مع الحرف) ──
          Row(
            children: [
              Container(
                width: isTablet ? 68 : 54,
                height: isTablet ? 68 : 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFF8E1),
                  border: Border.all(
                    color: const Color(0xFFFFB300),
                    width: 2.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/mascot/falcon_happy.webp',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Text(
                        mascotEmoji,
                        style: TextStyle(fontSize: isTablet ? 32 : 26),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 16 : 12,
                    vertical: isTablet ? 10 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: accentSoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.22),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullTitle,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: isTablet ? 24 : 19,
                          fontWeight: FontWeight.w900,
                          color: accentDark,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'مَرْحَبًا يَا بَطَلُ! اضْغَطْ عَلَى الْحَرْفِ لِتَسْمَعَ صَوْتَهُ',
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF455A64),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isTablet ? 24 : 16),

          // ── ميدالية الحرف التفاعلية الموحّدة (نقطة استماع واحدة واضحة) ──
          GestureDetector(
            onTap: () => _playVariant('sound'),
            child: Semantics(
              button: true,
              label: 'اسْتَمِعْ لِصَوْتِ $fullTitle',
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: medallionSize,
                    height: medallionSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isPlayingMain
                            ? [
                                Color.lerp(Colors.white, accent, 0.14)!,
                                Color.lerp(Colors.white, accent, 0.24)!,
                              ]
                            : [
                                Colors.white,
                                accentSoft,
                              ],
                      ),
                      border: Border.all(
                        color: accent,
                        width: isPlayingMain ? 6 : 4.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(
                            alpha: isPlayingMain ? 0.34 : 0.20,
                          ),
                          blurRadius: isPlayingMain ? 28 : 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        letter.letter == 'ه' ? 'هـ' : letter.letter,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: letterFontSize,
                          fontWeight: FontWeight.w900,
                          color: accentDark,
                          height: 1.05,
                        ),
                      ),
                    ),
                  ),

                  // شارة السماعة المدمجة على حافة الميدالية لتوضيح قابلية اللمس
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isTablet ? 52 : 44,
                      height: isTablet ? 52 : 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPlayingMain
                            ? const Color(0xFFEF6C00)
                            : accent,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.volume_up_rounded,
                        color: Colors.white,
                        size: isTablet ? 26 : 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().scale(duration: 420.ms, curve: Curves.easeOutBack),

          SizedBox(height: isTablet ? 14 : 10),

          // ── كلمات نموذجية مع إيموجي الحرف (بصري ومفيد تربوياً) ──
          if (letter.exampleWords.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 6,
              alignment: WrapAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFFFB300).withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    mascotEmoji,
                    style: TextStyle(fontSize: isTablet ? 18 : 16),
                  ),
                ),
                ...letter.exampleWords.take(3).map(
                      (word) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 14 : 11,
                          vertical: isTablet ? 5 : 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFCFD8DC)),
                        ),
                        child: Text(
                          word,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF263238),
                          ),
                        ),
                      ),
                    ),
              ],
            ),

          SizedBox(height: isTablet ? 20 : 14),
          Divider(color: accent.withValues(alpha: 0.14), height: 1),
          SizedBox(height: isTablet ? 16 : 12),

          // ── شريط الحركات القصيرة التفاعلي (تَنطق فور لمسها) ──
          Text(
            'جَرِّبْ أَصْوَاتَ حَرْفِ $definiteName بِالْحَرَكَاتِ:',
            style: TextStyle(
              fontFamily: 'NotoNaskhArabic',
              fontSize: isTablet ? 16 : 13,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF455A64),
            ),
          ),
          SizedBox(height: isTablet ? 14 : 8),
          Row(
            children: List.generate(vowels.length, (i) {
              final v = vowels[i];
              final isActive = _activeAudioTag == v.variant;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 7 : 4),
                  child: Material(
                    color: isActive
                        ? v.color
                        : v.color.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(18),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _playVariant(v.variant),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 16 : 9,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isActive
                                ? v.color
                                : v.color.withValues(alpha: 0.35),
                            width: isActive ? 2.5 : 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              v.display,
                              style: TextStyle(
                                fontFamily: 'NotoNaskhArabic',
                                fontSize: isTablet ? 34 : 26,
                                fontWeight: FontWeight.w900,
                                color: isActive ? Colors.white : v.color,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.volume_up_rounded,
                                  size: isTablet ? 15 : 13,
                                  color: isActive
                                      ? Colors.white
                                      : v.color.withValues(alpha: 0.85),
                                ),
                                const SizedBox(width: 3),
                                Flexible(
                                  child: Text(
                                    v.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'NotoNaskhArabic',
                                      fontSize: isTablet ? 13 : 11,
                                      fontWeight: FontWeight.w800,
                                      color: isActive
                                          ? Colors.white
                                          : const Color(0xFF37474F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 320.ms).slideY(begin: 0.04);
  }

  Widget _buildStationsSection({
    required String letterChar,
    required Color accent,
    required bool isTablet,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 18 : 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withValues(alpha: 0.18), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.route_rounded,
                color: accent,
                size: isTablet ? 22 : 19,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'مَحَطَّاتُ الدَّرْسِ — اخْتَرْ أَيَّ مَحَطَّةٍ لِلْبَدْءِ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: isTablet ? 15 : 13,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF263238),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 12 : 10),
          Wrap(
            spacing: isTablet ? 10 : 7,
            runSpacing: isTablet ? 10 : 7,
            alignment: WrapAlignment.center,
            children: _stations.map((st) {
              return Material(
                color: st.color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _openLessonAt(letterChar, st.index),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 18 : 10,
                      vertical: isTablet ? 11 : 7,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: st.color.withValues(alpha: 0.30),
                        width: 1.3,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          st.icon,
                          color: st.color,
                          size: isTablet ? 21 : 16,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          st.title,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: isTablet ? 15 : 12,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF263238),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate(delay: 90.ms).fadeIn(duration: 320.ms);
  }

  Widget _buildActionButtons({
    required ArabicLetter letter,
    required String definiteName,
    required Color accent,
    required Color accentDark,
    required bool isTablet,
    required bool isWide,
  }) {
    const gamesColor = Color(0xFF1B8A5A); // تباين عالٍ WCAG AA+ > 4.6:1
    const gamesLip = Color(0xFF11613E);

    final startButton = _TactileActionButton(
      label: 'ابْدَأْ دَرْسَ حَرْفِ $definiteName',
      icon: Icons.play_arrow_rounded,
      backgroundColor: accent,
      lipColor: accentDark,
      height: isTablet ? 64 : 56,
      fontSize: isTablet ? 20 : 17,
      onTap: () => _openLessonAt(letter.letter, 0),
    );

    final gamesButton = _TactileActionButton(
      label: 'أَلْعَابُ وَأَسْئِلَةُ الْحَرْفِ',
      icon: Icons.sports_esports_rounded,
      backgroundColor: gamesColor,
      lipColor: gamesLip,
      height: isTablet ? 64 : 54,
      fontSize: isTablet ? 19 : 16,
      onTap: () => _openLessonAt(letter.letter, 6),
    );

    // عرض متوازن على التابلت بدلاً من التمدد القبيح من الحافة للحافة
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isTablet ? 640 : 440),
      child: isWide
          ? Row(
              children: [
                Expanded(flex: 6, child: startButton),
                const SizedBox(width: 14),
                Expanded(flex: 5, child: gamesButton),
              ],
            )
          : Column(
              children: [
                startButton,
                const SizedBox(height: 12),
                gamesButton,
              ],
            ),
    ).animate(delay: 140.ms).fadeIn(duration: 320.ms);
  }
}

class _VowelPreview {
  final String variant;
  final String display;
  final String label;
  final Color color;
  const _VowelPreview({
    required this.variant,
    required this.display,
    required this.label,
    required this.color,
  });
}

class _StationMeta {
  final int index;
  final String title;
  final IconData icon;
  final Color color;
  const _StationMeta(this.index, this.title, this.icon, this.color);
}

/// زر تعليمي ثلاثي الأبعاد لمسي (Tactile 3D Button) بتباين عالٍ واستجابة فورية للضغط
class _TactileActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color lipColor;
  final double height;
  final double fontSize;
  final VoidCallback onTap;

  const _TactileActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.lipColor,
    required this.height,
    required this.fontSize,
    required this.onTap,
  });

  @override
  State<_TactileActionButton> createState() => _TactileActionButtonState();
}

class _TactileActionButtonState extends State<_TactileActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    const lipDepth = 5.0;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          margin: EdgeInsets.only(
            top: _pressed ? lipDepth : 0,
            bottom: _pressed ? 0 : lipDepth,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: _pressed
                ? null
                : [
                    BoxShadow(
                      color: widget.lipColor,
                      offset: const Offset(0, lipDepth),
                      blurRadius: 0,
                    ),
                    BoxShadow(
                      color: widget.backgroundColor.withValues(alpha: 0.28),
                      offset: const Offset(0, 10),
                      blurRadius: 16,
                    ),
                  ],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: Colors.white, size: widget.fontSize + 7),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
