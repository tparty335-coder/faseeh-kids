import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ArabicTextVariant { heading, body, caption, label }

class ArabicText extends StatelessWidget {
  final String text;
  final ArabicTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final bool isFormal; 

  const ArabicText(
    this.text, {
    super.key,
    this.variant = ArabicTextVariant.body,
    this.color,
    this.textAlign,
    this.isFormal = false,
  });

  double _getFontSize(BuildContext context) {
    double baseSize;
    switch (variant) {
      case ArabicTextVariant.heading:
        baseSize = 24.0;
        break;
      case ArabicTextVariant.body:
        baseSize = 18.0;
        break;
      case ArabicTextVariant.label:
        baseSize = 16.0;
        break;
      case ArabicTextVariant.caption:
        baseSize = 14.0;
        break;
    }
    return baseSize; 
  }

  FontWeight _getFontWeight() {
    switch (variant) {
      case ArabicTextVariant.heading:
        return FontWeight.w800;
      case ArabicTextVariant.label:
        return FontWeight.w700;
      default:
        return FontWeight.w500;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = isFormal
        ? GoogleFonts.amiri(
            fontSize: _getFontSize(context),
            fontWeight: _getFontWeight(),
            color: color,
          )
        : GoogleFonts.cairo(
            fontSize: _getFontSize(context),
            fontWeight: _getFontWeight(),
            color: color,
          );

    return Text(
      text,
      style: style,
      textAlign: textAlign ?? TextAlign.right,
      textDirection: TextDirection.rtl,
    );
  }
}
