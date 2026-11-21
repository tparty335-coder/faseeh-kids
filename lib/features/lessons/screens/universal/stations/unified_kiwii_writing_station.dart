import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_tracing_words_catalog.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// محطة كتابة وتتبّع الحرف الموحّدة لجميع الحروف الـ 28 بأسلوب Kiwii / Montessori
/// - بطاقة بيضاء ناصعة مع حرف مفرّغ بإطار ملون وخطوط متقطعة وأسهم توجيهية ونقطة بداية ذهبية
/// - 4 مواضع تفاعلية كاملة (منفصل / أول / وسط / آخر الكلمة) مع نطق صوتي لكل موضع
/// - 4 كلمات مصوّرة ناطقة على خلفية بيضاء ناصعة تحيط بالحرف (مثل ا.jpg و م.jpg)
class UnifiedKiwiiWritingStation extends StatefulWidget {
  final String letterChar;
  final TracingSpec? tracingSpec;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UnifiedKiwiiWritingStation({
    super.key,
    required this.letterChar,
    this.tracingSpec,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<UnifiedKiwiiWritingStation> createState() => _UnifiedKiwiiWritingStationState();
}

class _UnifiedKiwiiWritingStationState extends State<UnifiedKiwiiWritingStation> {
  static const Color _navyTitle = Color(0xFF1B2A4A);

  late TracingLetterProfile _profile;
  int _selectedPosIndex = 0;
  int _audioToken = 0;
  int? _activeWordIndex;
  final Set<String> _completedPositions = {};

  @override
  void initState() {
    super.initState();
    _profile = LetterTracingWordsCatalog.getProfile(
      widget.letterChar,
      tracingSpec: widget.tracingSpec,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _playAudio(_profile.introAudioPath);
    });
  }

  @override
  void didUpdateWidget(covariant UnifiedKiwiiWritingStation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letterChar != widget.letterChar ||
        oldWidget.tracingSpec != widget.tracingSpec) {
      setState(() {
        _profile = LetterTracingWordsCatalog.getProfile(
          widget.letterChar,
          tracingSpec: widget.tracingSpec,
        );
        _selectedPosIndex = 0;
        _activeWordIndex = null;
        _completedPositions.clear();
      });
    }
  }

  @override
  void dispose() {
    _audioToken++;
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playAudio(String path) async {
    if (path.isEmpty) return;
    final tk = ++_audioToken;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _audioToken) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  void _onSelectPosition(int index) {
    HapticFeedback.selectionClick();
    setState(() => _selectedPosIndex = index);
    _playAudio(_profile.positions[index].audioPath);
  }

  void _onTapWord(int idx, TracingWordIllustration item) {
    HapticFeedback.lightImpact();
    setState(() => _activeWordIndex = idx);
    _playAudio(item.audioPath);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted && _activeWordIndex == idx) {
        setState(() => _activeWordIndex = null);
      }
    });
  }

  void _onPositionCompleted(String posCode) {
    if (!mounted) return;
    setState(() => _completedPositions.add(posCode));
  }

  @override
  Widget build(BuildContext context) {
    final pos = _profile.positions[_selectedPosIndex];
    final accent = _profile.accentColor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: const Color(0xFFF8FAFC),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 560;
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 18 : 12,
                      vertical: 10,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 920),
                        child: Column(
                          children: [
                            // ── 1. شريط مواضع الحرف الـ 4 (منفصل / أول / وسط / آخر) ──
                            _buildPositionTabs(accent),
                            const SizedBox(height: 12),

                            // ── 2. بطاقة Kiwii البيضاء الناصعة (العنوان + المضمار + الكلمات الـ 4) ──
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: isWide ? 20 : 12,
                                vertical: isWide ? 18 : 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: accent.withValues(alpha: 0.24),
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // عنوان Kiwii الكحلي الداكن (مثل: حرف الألف / حرف الباء / حرف الميم)
                                  _buildWorksheetHeader(accent, pos),
                                  const SizedBox(height: 12),

                                  // التخطيط المتجاوب: تابلت (كلمات يمين + الحرف بالمنتصف + كلمات يسار)
                                  // أو هاتف (الحرف بالكامل فوق + شبكة الكلمات الـ 4 تحته)
                                  if (isWide)
                                    _buildWideWorksheetBody(pos, accent)
                                  else
                                    _buildCompactWorksheetBody(pos, accent),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ── 3. شريط التنقل السفلي الموحّد ──
            _buildBottomBar(accent),
          ],
        ),
      ),
    );
  }

  Widget _buildWorksheetHeader(Color accent, TracingPositionItem pos) {
    return Row(
      children: [
        // زر إعادة سماع صوت الموضع الحالي
        Tooltip(
          message: pos.shortLabel,
          child: Material(
            color: accent.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _playAudio(pos.audioPath),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Icon(Icons.volume_up_rounded, color: accent, size: 22),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _profile.definiteTitle,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: _navyTitle,
                  height: 1.15,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // زر شرح الكتابة
        Tooltip(
          message: 'شرح الكتابة',
          child: Material(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _playAudio(_profile.introAudioPath),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Icon(Icons.record_voice_over_rounded, color: _navyTitle, size: 21),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPositionTabs(Color accent) {
    return Row(
      children: List.generate(_profile.positions.length, (i) {
        final item = _profile.positions[i];
        final isSelected = i == _selectedPosIndex;
        final isDone = _completedPositions.contains(item.position);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == _profile.positions.length - 1 ? 0 : 6,
            ),
            child: Material(
              color: isSelected
                  ? accent
                  : (isDone ? const Color(0xFFECFDF5) : Colors.white),
              borderRadius: BorderRadius.circular(18),
              elevation: isSelected ? 3 : 0,
              shadowColor: accent.withValues(alpha: 0.35),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _onSelectPosition(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? accent
                          : (isDone
                              ? const Color(0xFF10B981)
                              : const Color(0xFFE2E8F0)),
                      width: isSelected ? 2.0 : 1.4,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.displayForm,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                color: isSelected ? Colors.white : _navyTitle,
                                height: 1.05,
                              ),
                            ),
                            if (isDone) ...[
                              const SizedBox(width: 3),
                              Icon(
                                Icons.check_circle_rounded,
                                size: 14,
                                color: isSelected ? Colors.white : const Color(0xFF10B981),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item.shortLabel,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.95)
                                : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// تخطيط التابلت والشاشات العريضة (مطابق لتكوين ا.jpg و م.jpg: كلمتان يمين + الحرف بالمنتصف + كلمتان يسار)
  Widget _buildWideWorksheetBody(TracingPositionItem pos, Color accent) {
    final words = _profile.words;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // العمود الأيمن: كلمتان مصوّرتان ناطقتان
        Expanded(
          flex: 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (words.isNotEmpty) _buildWordSticker(0, words[0], accent, imageHeight: 112),
              const SizedBox(height: 16),
              if (words.length > 1) _buildWordSticker(1, words[1], accent, imageHeight: 112),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // المنتصف: لوحة التتبع الفيكتورية البيضاء بحجم كبير ومريح للطفل
        Expanded(
          flex: 50,
          child: ArabicLetterTracingCanvas(
            key: ValueKey('kiwii_${_profile.letterChar}_${pos.position}'),
            letterChar: _profile.letterChar,
            position: pos.position,
            exampleWord: pos.exampleWord,
            primaryColor: accent,
            compactChrome: true,
            onComplete: () => _onPositionCompleted(pos.position),
          ),
        ),
        const SizedBox(width: 12),

        // العمود الأيسر: الكلمتان المصوّرتان الأخريان
        Expanded(
          flex: 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (words.length > 2) _buildWordSticker(2, words[2], accent, imageHeight: 112),
              const SizedBox(height: 16),
              if (words.length > 3) _buildWordSticker(3, words[3], accent, imageHeight: 112),
            ],
          ),
        ),
      ],
    );
  }

  /// تخطيط الهاتف (لوحة تتبع واسعة بالمنتصف + الكلمات الـ 4 أسفلها داخل نفس البطاقة البيضاء)
  Widget _buildCompactWorksheetBody(TracingPositionItem pos, Color accent) {
    final words = _profile.words;
    return Column(
      children: [
        ArabicLetterTracingCanvas(
          key: ValueKey('kiwii_${_profile.letterChar}_${pos.position}'),
          letterChar: _profile.letterChar,
          position: pos.position,
          exampleWord: pos.exampleWord,
          primaryColor: accent,
          compactChrome: true,
          onComplete: () => _onPositionCompleted(pos.position),
        ),
        const SizedBox(height: 14),
        const Divider(height: 1, color: Color(0xFFF1F5F9)),
        const SizedBox(height: 12),
        Row(
          children: List.generate(words.length, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: i == words.length - 1 ? 0 : 6),
                child: _buildWordSticker(i, words[i], accent, imageHeight: 68, compact: true),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildWordSticker(
    int idx,
    TracingWordIllustration item,
    Color accent, {
    required double imageHeight,
    bool compact = false,
  }) {
    final isPlaying = _activeWordIndex == idx;
    return AnimatedScale(
      scale: isPlaying ? 1.06 : 1.0,
      duration: const Duration(milliseconds: 180),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _onTapWord(idx, item),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 4 : 8,
              vertical: compact ? 6 : 8,
            ),
            decoration: BoxDecoration(
              color: isPlaying ? accent.withValues(alpha: 0.06) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isPlaying ? accent : Colors.transparent,
                width: 1.8,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: _CroppedWhiteIllustration(
                    imagePath: item.imagePath,
                    cropRect: item.cropRect,
                  ),
                ),
                SizedBox(height: compact ? 4 : 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.word,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: compact ? 13.5 : 19,
                          fontWeight: FontWeight.w900,
                          color: accent,
                          height: 1.15,
                        ),
                      ),
                      if (!compact) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.volume_up_rounded,
                          size: 15,
                          color: accent.withValues(alpha: isPlaying ? 1.0 : 0.55),
                        ),
                      ],
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

  Widget _buildBottomBar(Color accent) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  AudioService.instance.stop();
                  widget.onPrevious();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  foregroundColor: AppColors.textPrimaryDay,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward_ios_rounded, size: 15),
                      SizedBox(width: 5),
                      Text(
                        'السَّابِقُ',
                        maxLines: 1,
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            // مؤشر التقدم في المواضع الـ 4
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_completedPositions.length} / 4',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: accent,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  AudioService.instance.stop();
                  widget.onNext();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back_ios_rounded, size: 15),
                      SizedBox(width: 5),
                      Text(
                        'كَلِمَاتُ الْحَرْفِ',
                        maxLines: 1,
                        style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// يرسم المنطقة المقصوصة النظيفة فقط من صورة الكرتون بدقة متناهية على خلفية بيضاء ناصعة
/// بدون أي قصّ زائد أو تمدد أو تكرار أصول إضافية (0 KB حجم إضافي)
class _CroppedWhiteIllustration extends StatefulWidget {
  final String imagePath;
  final Rect cropRect;

  const _CroppedWhiteIllustration({
    required this.imagePath,
    required this.cropRect,
  });

  @override
  State<_CroppedWhiteIllustration> createState() => _CroppedWhiteIllustrationState();
}

class _CroppedWhiteIllustrationState extends State<_CroppedWhiteIllustration> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  ui.Image? _image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(covariant _CroppedWhiteIllustration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _resolveImage();
    }
  }

  void _unsubscribe() {
    if (_stream != null && _listener != null) {
      _stream!.removeListener(_listener!);
    }
    _stream = null;
    _listener = null;
  }

  void _resolveImage() {
    _unsubscribe();
    final provider = AssetImage(widget.imagePath);
    final stream = provider.resolve(createLocalImageConfiguration(context));
    _stream = stream;
    _listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        if (mounted) {
          setState(() => _image = info.image);
        }
      },
      onError: (Object _, StackTrace? __) {},
    );
    stream.addListener(_listener!);
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final img = _image;
    if (img == null) {
      return const ColoredBox(color: Colors.white);
    }
    return CustomPaint(
      painter: _CroppedImagePainter(image: img, cropRect: widget.cropRect),
    );
  }
}

class _CroppedImagePainter extends CustomPainter {
  final ui.Image image;
  final Rect cropRect;

  const _CroppedImagePainter({required this.image, required this.cropRect});

  @override
  void paint(Canvas canvas, Size size) {
    final imgW = image.width.toDouble();
    final imgH = image.height.toDouble();
    final src = Rect.fromLTRB(
      cropRect.left * imgW,
      cropRect.top * imgH,
      cropRect.right * imgW,
      cropRect.bottom * imgH,
    );
    if (src.width <= 0 || src.height <= 0 || size.isEmpty) return;

    final fitted = applyBoxFit(BoxFit.contain, src.size, size);
    final dst = Alignment.center.inscribe(fitted.destination, Offset.zero & size);
    canvas.drawImageRect(
      image,
      src,
      dst,
      Paint()..filterQuality = FilterQuality.medium,
    );
  }

  @override
  bool shouldRepaint(covariant _CroppedImagePainter oldDelegate) {
    return oldDelegate.image != image || oldDelegate.cropRect != cropRect;
  }
}
