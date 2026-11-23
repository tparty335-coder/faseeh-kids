import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// يعرض الرسم الكرتوني المقصوص بدقة عالية على خلفية بيضاء نقية (0 KB حجم إضافي)
/// ويستجيب بسلاسة لكل أحجام الشاشات دون تشويه أو قصّ زائد
class CroppedIllustrationBox extends StatefulWidget {
  final String imagePath;
  final Rect cropRect;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  const CroppedIllustrationBox({
    super.key,
    required this.imagePath,
    required this.cropRect,
    this.width,
    this.height,
    this.borderRadius = 18,
    this.borderColor = const Color(0xFFE2E8F0),
    this.borderWidth = 1.5,
  });

  @override
  State<CroppedIllustrationBox> createState() => _CroppedIllustrationBoxState();
}

class _CroppedIllustrationBoxState extends State<CroppedIllustrationBox> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  ui.Image? _image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
  }

  @override
  void didUpdateWidget(covariant CroppedIllustrationBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _resolve();
    }
  }

  void _unsubscribe() {
    if (_stream != null && _listener != null) {
      _stream!.removeListener(_listener!);
    }
    _stream = null;
    _listener = null;
  }

  void _resolve() {
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
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: widget.borderColor, width: widget.borderWidth),
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(6),
      child: _image == null
          ? const ColoredBox(color: Colors.white)
          : CustomPaint(
              painter: _IllustrationCropPainter(
                image: _image!,
                cropRect: widget.cropRect,
              ),
              size: Size.infinite,
            ),
    );
  }
}

class _IllustrationCropPainter extends CustomPainter {
  final ui.Image image;
  final Rect cropRect;

  const _IllustrationCropPainter({
    required this.image,
    required this.cropRect,
  });

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
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(covariant _IllustrationCropPainter oldDelegate) {
    return oldDelegate.image != image || oldDelegate.cropRect != cropRect;
  }
}
