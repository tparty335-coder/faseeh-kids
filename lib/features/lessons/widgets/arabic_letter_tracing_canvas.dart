import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// تعريف مقطع كتابة الحرف (Stroke)
class LetterStroke {
  final int index;
  final String label; // "١", "٢", "٣", "٤"
  final Offset start; // Normalized (0.0 to 1.0)
  final Offset end;   // Normalized (0.0 to 1.0)
  final List<Offset> pathPoints; // Normalized path points
  final String hintText;
  final bool isTapOnly;
  final double strokeWidth; // عرض الخط - قابل للتخصيص لكل مقطع

  const LetterStroke({
    required this.index,
    required this.label,
    required this.start,
    required this.end,
    required this.pathPoints,
    required this.hintText,
    this.isTapOnly = false,
    this.strokeWidth = 22.0,
  });
}

/// بيانات مقاطع الحروف العربية ومواضعها بدقة متناهية
class ArabicLetterTracingData {
  static List<LetterStroke> getStrokesForLetter(String letter, {String position = 'isolated'}) {
    switch (letter) {
      case 'ب':
        return _getBaaStrokes(position);
      case 'ت':
        return _getTaaStrokes(position);
      case 'ث':
        return _getThaaStrokes(position);
      case 'ج':
        return _getJeemFamilyStrokes(position, letter: 'ج', dotMode: 'inside');
      case 'ح':
        return _getJeemFamilyStrokes(position, letter: 'ح', dotMode: 'none');
      case 'خ':
        return _getJeemFamilyStrokes(position, letter: 'خ', dotMode: 'above');
      case 'د':
        return _getDalFamilyStrokes(position, letter: 'د', hasDot: false);
      case 'ذ':
        return _getDalFamilyStrokes(position, letter: 'ذ', hasDot: true);
      case 'ر':
        return _getRaaFamilyStrokes(position, letter: 'ر', hasDot: false);
      case 'ز':
        return _getRaaFamilyStrokes(position, letter: 'ز', hasDot: true);
      case 'س':
        return _getSeenFamilyStrokes(position, letter: 'س', hasThreeDots: false);
      case 'ش':
        return _getSeenFamilyStrokes(position, letter: 'ش', hasThreeDots: true);
      case 'ص':
        return _getSaadFamilyStrokes(position, hasDot: false);
      case 'ض':
        return _getSaadFamilyStrokes(position, hasDot: true);
      case 'ط':
        return _getTaaTFamilyStrokes(position, hasDot: false);
      case 'ظ':
        return _getTaaTFamilyStrokes(position, hasDot: true);
      case 'ع':
        return _getAynFamilyStrokes(position, hasDot: false);
      case 'غ':
        return _getAynFamilyStrokes(position, hasDot: true);
      case 'ف':
        return _getFaaQaafStrokes(position, isQaaf: false);
      case 'ق':
        return _getFaaQaafStrokes(position, isQaaf: true);
      case 'ك':
        return _getKaafStrokes(position);
      case 'ل':
        return _getLaamStrokes(position);
      case 'م':
        return _getMeemStrokes(position);
      case 'ن':
        return _getNoonStrokes(position);
      case 'ه':
      case 'هـ':
        return _getHaaEndStrokes(position);
      case 'و':
        return _getWaawStrokes(position);
      case 'ي':
        return _getYaaStrokes(position);
      default:
        return _getAlifStrokes(position);
    }
  }

  // ─── مقاطع حرف الألف (أ) ───────────────────────────────────────────
  //
  //  الألف مكوّنة من جزأين:
  //  ① عصا الألف: خط عمودي من الأعلى للأسفل
  //  ② الهمزة (ء): قوس كبير يبدأ من اليسار، يصعد لليمين ثم ينزل
  //     + ذيل الهمزة: خط أفقي قصير
  //
  //  المقاسات المثالية على لوحة 300×340 px (نسب مئوية):
  //  - الهمزة تمتد من x=0.22 إلى x=0.76 = 54% = 162px (واضحة كفاية)
  //  - الهمزة ارتفاعها من y=0.02 إلى y=0.26 = 24% = 82px
  // ──────────────────────────────────────────────────────────────────────
  static List<LetterStroke> _getAlifStrokes(String position) {

    // ─── الهمزة مشتركة في كل المواضع (فقط موضعها على المحور Y يختلف) ───
    // قوس الهمزة الرئيسي: يبدأ من أسفل-اليسار، يصعد لليمين ثم ينزل
    // هكذا يرسم أطفال المدارس حرف الهمزة:
    // ابدأ من اليسار (منتصف الهمزة)، صعوداً لليمين، ثم دوران لأسفل-اليسار

    if (position == 'middle' || position == 'end') {
      // ─── الألف المتصلة (ـأ) ───
      return [
        // ① خط الاتصال من اليمين لليسار (ـ)
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.86, 0.86),
          end: const Offset(0.50, 0.86),
          pathPoints: const [
            Offset(0.86, 0.86),
            Offset(0.68, 0.86),
            Offset(0.50, 0.86),
          ],
          hintText: '① ابدأ من اليمين واسحب خط الاتصال ⬅️',
          strokeWidth: 20.0,
        ),
        // ② عصا الألف صاعدة للأعلى (ا)
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.50, 0.86),
          end: const Offset(0.50, 0.36),
          pathPoints: const [
            Offset(0.50, 0.86),
            Offset(0.50, 0.61),
            Offset(0.50, 0.36),
          ],
          hintText: '② من النقطة (٢) اصعد بعصا الألف للأعلى ⬆️',
          strokeWidth: 20.0,
        ),
        // ③ قوس الهمزة المفتوح (مطابق للرسم المدرسي ا.jpg)
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.60, 0.08),
          end: const Offset(0.47, 0.21),
          pathPoints: const [
            Offset(0.60, 0.08),
            Offset(0.45, 0.07),
            Offset(0.39, 0.14),
            Offset(0.47, 0.21),
          ],
          hintText: '③ دوّر قوس الهمزة فوق الألف ↶',
          strokeWidth: 15.0,
        ),
        // ④ قاعدة الهمزة الأفقية (من اليمين لليسار بفراغ واضح فوق العصا)
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.66, 0.21),
          end: const Offset(0.34, 0.24),
          pathPoints: const [
            Offset(0.66, 0.21),
            Offset(0.50, 0.225),
            Offset(0.34, 0.24),
          ],
          hintText: '④ اسحب خط الهمزة الأفقي لليسار ⬅️',
          strokeWidth: 15.0,
        ),
      ];
    }

    // ─── الألف المنفصلة أو أول الكلمة (أ) — مطابقة لـ ا.jpg ───
    return [
      // ① عصا الألف (من الأعلى إلى الأسفل بفراغ واضح تحت الهمزة)
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.50, 0.36),
        end: const Offset(0.50, 0.90),
        pathPoints: const [
          Offset(0.50, 0.36),
          Offset(0.50, 0.54),
          Offset(0.50, 0.72),
          Offset(0.50, 0.90),
        ],
        hintText: '① ابدأ من أعلى واسحب عصا الألف لأسفل ⬇️',
        strokeWidth: 20.0,
      ),
      // ② قوس الهمزة المفتوح (مطابق لـ ا.jpg)
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.60, 0.08),
        end: const Offset(0.47, 0.21),
        pathPoints: const [
          Offset(0.60, 0.08),
          Offset(0.45, 0.07),
          Offset(0.39, 0.14),
          Offset(0.47, 0.21),
        ],
        hintText: '② دوّر قوس الهمزة فوق الألف ↶',
        strokeWidth: 15.0,
      ),
      // ③ قاعدة الهمزة الأفقية (من اليمين لليسار)
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.66, 0.21),
        end: const Offset(0.34, 0.24),
        pathPoints: const [
          Offset(0.66, 0.21),
          Offset(0.50, 0.225),
          Offset(0.34, 0.24),
        ],
        hintText: '③ اسحب خط الهمزة الأفقي لليسار ⬅️',
        strokeWidth: 15.0,
      ),
    ];
  }

  // ─── مقاطع حرف الباء ───
  static List<LetterStroke> _getBaaStrokes(String position) {
    // الباء بعد حرف رافس في الوسط = نفس شكل أول الكلمة (بـ)
    if (position == 'mid_disconnected') {
      return _getBaaStrokes('start');
    }
    // الباء بعد حرف رافس في الآخر = نفس شكل المفردة (ب)
    if (position == 'end_disconnected') {
      return _getBaaStrokes('isolated');
    }
    if (position == 'start') {
      // الباء في أول الكلمة (بـ)
      return [
        // 1. السنّة اليمنى هبوطاً
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.80, 0.42),
          end: const Offset(0.80, 0.65),
          pathPoints: [
            const Offset(0.80, 0.42),
            const Offset(0.80, 0.54),
            const Offset(0.80, 0.65),
          ],
          hintText: 'ابدأ من النقطة (١) وانزل بالسنّة اليمنى ⬇️',
        ),
        // 2. خط الاتصال لليسار
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.80, 0.65),
          end: const Offset(0.20, 0.65),
          pathPoints: [
            const Offset(0.80, 0.65),
            const Offset(0.60, 0.65),
            const Offset(0.40, 0.65),
            const Offset(0.20, 0.65),
          ],
          hintText: 'من النقطة (٢) اسحب خط الاتصال لليسار ⬅️',
        ),
        // 3. نقطة الباء
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [const Offset(0.50, 0.82)],
          hintText: 'اضغط على النقطة (٣) لوضع نقطة الباء •',
          isTapOnly: true,
        ),
      ];
    } else if (position == 'middle') {
      // الباء في وسط الكلمة (ـبـ)
      return [
        // 1. خط الاتصال الأيمن
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.85, 0.65),
          end: const Offset(0.50, 0.65),
          pathPoints: [
            const Offset(0.85, 0.65),
            const Offset(0.68, 0.65),
            const Offset(0.50, 0.65),
          ],
          hintText: 'ابدأ من النقطة (١) واسحب خط الاتصال ⬅️',
        ),
        // 2. سنّة الباء الوسطى
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.50, 0.65),
          end: const Offset(0.50, 0.42),
          pathPoints: [
            const Offset(0.50, 0.65),
            const Offset(0.50, 0.42),
          ],
          hintText: 'من النقطة (٢) ارفع سنّة الباء للأعلى ⬆️',
        ),
        // 3. خط الاتصال الأيسر
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.50, 0.65),
          end: const Offset(0.15, 0.65),
          pathPoints: [
            const Offset(0.50, 0.65),
            const Offset(0.32, 0.65),
            const Offset(0.15, 0.65),
          ],
          hintText: 'من النقطة (٣) اسحب خط الاتصال لليسار ⬅️',
        ),
        // 4. نقطة الباء
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [const Offset(0.50, 0.82)],
          hintText: 'اضغط على النقطة (٤) لوضع نقطة الباء •',
          isTapOnly: true,
        ),
      ];
    } else if (position == 'end') {
      // الباء في آخر الكلمة متصلة (ـب)
      return [
        // 1. خط الاتصال الأيمن
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.85, 0.65),
          end: const Offset(0.18, 0.65),
          pathPoints: [
            const Offset(0.85, 0.65),
            const Offset(0.50, 0.65),
            const Offset(0.18, 0.65),
          ],
          hintText: 'ابدأ من النقطة (١) واسحب خط الاتصال لليسار ⬅️',
        ),
        // 2. السنّة اليسرى صعوداً
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.18, 0.65),
          end: const Offset(0.18, 0.45),
          pathPoints: [
            const Offset(0.18, 0.65),
            const Offset(0.18, 0.55),
            const Offset(0.18, 0.45),
          ],
          hintText: 'من النقطة (٢) ارفع السنّة اليسرى للأعلى ⬆️',
        ),
        // 3. نقطة الباء بالأسفل
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [const Offset(0.50, 0.82)],
          hintText: 'اضغط على النقطة (٣) لوضع نقطة الباء •',
          isTapOnly: true,
        ),
      ];
    }

    // الباء الكاملة المنفصلة (ب)
    return [
      // 1. السنّة اليمنى هبوطاً
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.82, 0.45),
        end: const Offset(0.82, 0.65),
        pathPoints: [
          const Offset(0.82, 0.45),
          const Offset(0.82, 0.55),
          const Offset(0.82, 0.65),
        ],
        hintText: 'ابدأ من النقطة (١) وانزل بالسنّة اليمنى ⬇️',
      ),
      // 2. جسم الباء الأفقي
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.82, 0.65),
        end: const Offset(0.18, 0.65),
        pathPoints: [
          const Offset(0.82, 0.65),
          const Offset(0.60, 0.65),
          const Offset(0.40, 0.65),
          const Offset(0.18, 0.65),
        ],
        hintText: 'من النقطة (٢) اسحب جسم الباء لليسار ⬅️',
      ),
      // 3. السنّة اليسرى صعوداً
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.18, 0.65),
        end: const Offset(0.18, 0.45),
        pathPoints: [
          const Offset(0.18, 0.65),
          const Offset(0.18, 0.55),
          const Offset(0.18, 0.45),
        ],
        hintText: 'من النقطة (٣) ارفع السنّة اليسرى للأعلى ⬆️',
      ),
      // 4. نقطة الباء بالأسفل
      LetterStroke(
        index: 4,
        label: '٤',
        start: const Offset(0.50, 0.82),
        end: const Offset(0.50, 0.82),
        pathPoints: [const Offset(0.50, 0.82)],
        hintText: 'اضغط على النقطة (٤) لوضع نقطة الباء •',
        isTapOnly: true,
      ),
    ];
  }

  // ─── مقاطع حرف التاء (ت) ───
  static List<LetterStroke> _getTaaStrokes(String position) {
    if (position == 'mid_disconnected') {
      return _getTaaStrokes('start');
    }
    if (position == 'end_disconnected') {
      return _getTaaStrokes('isolated');
    }
    if (position == 'start') {
      // التاء في أول الكلمة (تـ)
      return [
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.80, 0.46),
          end: const Offset(0.80, 0.68),
          pathPoints: [
            const Offset(0.80, 0.46),
            const Offset(0.80, 0.57),
            const Offset(0.80, 0.68),
          ],
          hintText: 'ابدأ من النقطة (١) وانزل بالسنّة اليمنى للتاء ⬇️',
        ),
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.80, 0.68),
          end: const Offset(0.20, 0.68),
          pathPoints: [
            const Offset(0.80, 0.68),
            const Offset(0.60, 0.68),
            const Offset(0.40, 0.68),
            const Offset(0.20, 0.68),
          ],
          hintText: 'من النقطة (٢) اسحب خط الاتصال لليسار ⬅️',
        ),
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.58, 0.30),
          end: const Offset(0.58, 0.30),
          pathPoints: [const Offset(0.58, 0.30)],
          hintText: 'اضغط على النقطة (٣) لوضع النقطة الأولى للتاء في الأعلى •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.44, 0.30),
          end: const Offset(0.44, 0.30),
          pathPoints: [const Offset(0.44, 0.30)],
          hintText: 'اضغط على النقطة (٤) لوضع النقطة الثانية للتاء في الأعلى ••',
          isTapOnly: true,
        ),
      ];
    } else if (position == 'middle') {
      // التاء في وسط الكلمة (ـتـ)
      return [
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.85, 0.68),
          end: const Offset(0.50, 0.68),
          pathPoints: [
            const Offset(0.85, 0.68),
            const Offset(0.68, 0.68),
            const Offset(0.50, 0.68),
          ],
          hintText: 'ابدأ من النقطة (١) واسحب خط الاتصال الأيمن ⬅️',
        ),
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.50, 0.68),
          end: const Offset(0.50, 0.46),
          pathPoints: [
            const Offset(0.50, 0.68),
            const Offset(0.50, 0.46),
          ],
          hintText: 'من النقطة (٢) ارفع سنّة التاء للأعلى ⬆️',
        ),
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.50, 0.68),
          end: const Offset(0.15, 0.68),
          pathPoints: [
            const Offset(0.50, 0.68),
            const Offset(0.32, 0.68),
            const Offset(0.15, 0.68),
          ],
          hintText: 'من النقطة (٣) اسحب خط الاتصال لليسار ⬅️',
        ),
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.57, 0.28),
          end: const Offset(0.57, 0.28),
          pathPoints: [const Offset(0.57, 0.28)],
          hintText: 'اضغط على النقطة (٤) لوضع النقطة الأولى للتاء •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 5,
          label: '٥',
          start: const Offset(0.43, 0.28),
          end: const Offset(0.43, 0.28),
          pathPoints: [const Offset(0.43, 0.28)],
          hintText: 'اضغط على النقطة (٥) لوضع النقطة الثانية للتاء ••',
          isTapOnly: true,
        ),
      ];
    } else if (position == 'end') {
      // التاء في آخر الكلمة متصلة (ـت)
      return [
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.85, 0.68),
          end: const Offset(0.18, 0.68),
          pathPoints: [
            const Offset(0.85, 0.68),
            const Offset(0.50, 0.68),
            const Offset(0.18, 0.68),
          ],
          hintText: 'ابدأ من النقطة (١) واسحب جسم التاء المتصل لليسار ⬅️',
        ),
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.18, 0.68),
          end: const Offset(0.18, 0.48),
          pathPoints: [
            const Offset(0.18, 0.68),
            const Offset(0.18, 0.58),
            const Offset(0.18, 0.48),
          ],
          hintText: 'من النقطة (٢) ارفع السنّة اليسرى للتاء للأعلى ⬆️',
        ),
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.57, 0.32),
          end: const Offset(0.57, 0.32),
          pathPoints: [const Offset(0.57, 0.32)],
          hintText: 'اضغط على النقطة (٣) لوضع النقطة الأولى للتاء •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.43, 0.32),
          end: const Offset(0.43, 0.32),
          pathPoints: [const Offset(0.43, 0.32)],
          hintText: 'اضغط على النقطة (٤) لوضع النقطة الثانية للتاء ••',
          isTapOnly: true,
        ),
      ];
    }

    // التاء الكاملة المنفصلة (ت)
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.82, 0.48),
        end: const Offset(0.82, 0.68),
        pathPoints: [
          const Offset(0.82, 0.48),
          const Offset(0.82, 0.58),
          const Offset(0.82, 0.68),
        ],
        hintText: 'ابدأ من النقطة (١) وانزل بالسنّة اليمنى لحرف التاء ⬇️',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.82, 0.68),
        end: const Offset(0.18, 0.68),
        pathPoints: [
          const Offset(0.82, 0.68),
          const Offset(0.60, 0.68),
          const Offset(0.40, 0.68),
          const Offset(0.18, 0.68),
        ],
        hintText: 'من النقطة (٢) اسحب صحن التاء لليسار ⬅️',
      ),
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.18, 0.68),
        end: const Offset(0.18, 0.48),
        pathPoints: [
          const Offset(0.18, 0.68),
          const Offset(0.18, 0.58),
          const Offset(0.18, 0.48),
        ],
        hintText: 'من النقطة (٣) ارفع السنّة اليسرى للتاء للأعلى ⬆️',
      ),
      LetterStroke(
        index: 4,
        label: '٤',
        start: const Offset(0.57, 0.32),
        end: const Offset(0.57, 0.32),
        pathPoints: [const Offset(0.57, 0.32)],
        hintText: 'اضغط على النقطة (٤) لوضع النقطة اليمنى للتاء في الأعلى •',
        isTapOnly: true,
      ),
      LetterStroke(
        index: 5,
        label: '٥',
        start: const Offset(0.43, 0.32),
        end: const Offset(0.43, 0.32),
        pathPoints: [const Offset(0.43, 0.32)],
        hintText: 'اضغط على النقطة (٥) لوضع النقطة اليسرى للتاء في الأعلى ••',
        isTapOnly: true,
      ),
    ];
  }

  // ─── مقاطع حرف الثاء (ث) ───
  static List<LetterStroke> _getThaaStrokes(String position) {
    final taaStrokes = _getTaaStrokes(position);
    // استبدال النقطتين بثلاث نقاط في الأعلى
    final bodyStrokes = taaStrokes.where((s) => !s.isTapOnly).map((s) {
      return LetterStroke(
        index: s.index,
        label: s.label,
        start: s.start,
        end: s.end,
        pathPoints: s.pathPoints,
        hintText: s.hintText.replaceAll('التاء', 'الثاء'),
        strokeWidth: s.strokeWidth,
      );
    }).toList();
    const arabicLabels = ['١', '٢', '٣', '٤', '٥', '٦'];
    final n1 = bodyStrokes.length + 1;
    final n2 = bodyStrokes.length + 2;
    final n3 = bodyStrokes.length + 3;
    return [
      ...bodyStrokes,
      LetterStroke(
        index: n1,
        label: arabicLabels[n1 - 1],
        start: const Offset(0.59, 0.30),
        end: const Offset(0.59, 0.30),
        pathPoints: const [Offset(0.59, 0.30)],
        hintText: 'اضغط لوضع النقطة الأولى للثاء •',
        isTapOnly: true,
      ),
      LetterStroke(
        index: n2,
        label: arabicLabels[n2 - 1],
        start: const Offset(0.41, 0.30),
        end: const Offset(0.41, 0.30),
        pathPoints: const [Offset(0.41, 0.30)],
        hintText: 'اضغط لوضع النقطة الثانية للثاء ••',
        isTapOnly: true,
      ),
      LetterStroke(
        index: n3,
        label: arabicLabels[n3 - 1],
        start: const Offset(0.50, 0.17),
        end: const Offset(0.50, 0.17),
        pathPoints: const [Offset(0.50, 0.17)],
        hintText: 'اضغط لوضع النقطة الثالثة للثاء في القمة •••',
        isTapOnly: true,
      ),
    ];
  }

  // ─── مقاطع عائلة الجيم والحاء والخاء (ج / ح / خ) ───
  static List<LetterStroke> _getJeemFamilyStrokes(
    String position, {
    required String letter,
    required String dotMode, // 'inside' | 'none' | 'above'
  }) {
    final name = letter == 'ج' ? 'الجيم' : (letter == 'ح' ? 'الحاء' : 'الخاء');
    final isMid = position == 'middle';
    final isEnd = position == 'end';
    final isJoinedLeft = position == 'start' || isMid || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [];

    if (isJoinedLeft) {
      strokes.add(
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.28, 0.42),
          end: const Offset(0.74, 0.58),
          pathPoints: const [
            Offset(0.28, 0.42),
            Offset(0.46, 0.36),
            Offset(0.64, 0.46),
            Offset(0.74, 0.58),
          ],
          hintText: '① ابدأ من اليسار وارسم حاجب $name نحو اليمين ↷',
        ),
      );
      strokes.add(
        LetterStroke(
          index: 2,
          label: '٢',
          start: isMid ? const Offset(0.90, 0.58) : const Offset(0.74, 0.58),
          end: const Offset(0.16, 0.58),
          pathPoints: isMid
              ? const [
                  Offset(0.90, 0.58),
                  Offset(0.74, 0.58),
                  Offset(0.45, 0.58),
                  Offset(0.16, 0.58),
                ]
              : const [
                  Offset(0.74, 0.58),
                  Offset(0.45, 0.58),
                  Offset(0.16, 0.58),
                ],
          hintText: isMid
              ? '② اسحب خط الاتصال من اليمين إلى اليسار على السطر ⬅️'
              : '② اسحب خط الاتصال على السطر لليسار ⬅️',
        ),
      );
    } else {
      // مفرد (ج) أو آخر الكلمة متصل (ـج)
      strokes.add(
        LetterStroke(
          index: 1,
          label: '١',
          start: isEnd ? const Offset(0.88, 0.38) : const Offset(0.28, 0.32),
          end: const Offset(0.72, 0.38),
          pathPoints: isEnd
              ? const [
                  Offset(0.88, 0.38),
                  Offset(0.72, 0.38),
                  Offset(0.50, 0.28),
                  Offset(0.28, 0.34),
                  Offset(0.50, 0.28),
                  Offset(0.72, 0.38),
                ]
              : const [
                  Offset(0.28, 0.32),
                  Offset(0.50, 0.28),
                  Offset(0.72, 0.38),
                ],
          hintText: '① ارسم حاجب $name في الأعلى ↷',
        ),
      );
      strokes.add(
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.72, 0.38),
          end: const Offset(0.66, 0.85),
          pathPoints: const [
            Offset(0.72, 0.38),
            Offset(0.44, 0.50),
            Offset(0.30, 0.67),
            Offset(0.42, 0.85),
            Offset(0.66, 0.85),
          ],
          hintText: '② انزل ببطن $name المقوّس للأسفل ↶',
        ),
      );
    }

    if (dotMode == 'inside') {
      final dotPos = isJoinedLeft ? const Offset(0.50, 0.77) : const Offset(0.54, 0.66);
      strokes.add(
        LetterStroke(
          index: 3,
          label: '٣',
          start: dotPos,
          end: dotPos,
          pathPoints: [dotPos],
          hintText: '③ اضغط لوضع نقطة الجيم •',
          isTapOnly: true,
        ),
      );
    } else if (dotMode == 'above') {
      final dotPos = isJoinedLeft ? const Offset(0.50, 0.21) : const Offset(0.50, 0.14);
      strokes.add(
        LetterStroke(
          index: 3,
          label: '٣',
          start: dotPos,
          end: dotPos,
          pathPoints: [dotPos],
          hintText: '③ اضغط لوضع نقطة الخاء في الأعلى •',
          isTapOnly: true,
        ),
      );
    }
    return strokes;
  }

  // ─── مقاطع عائلة الدال والذال (د / ذ) ───
  static List<LetterStroke> _getDalFamilyStrokes(
    String position, {
    required String letter,
    required bool hasDot,
  }) {
    final name = hasDot ? 'الذال' : 'الدال';
    final isConnectedRight = position == 'middle' || position == 'end';
    final List<LetterStroke> strokes = [
      if (isConnectedRight)
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.88, 0.68),
          end: const Offset(0.68, 0.68),
          pathPoints: const [
            Offset(0.88, 0.68),
            Offset(0.78, 0.68),
            Offset(0.68, 0.68),
          ],
          hintText: '① اسحب خط الاتصال الأيمن على السطر ⬅️',
        ),
      LetterStroke(
        index: isConnectedRight ? 2 : 1,
        label: isConnectedRight ? '٢' : '١',
        start: Offset(isConnectedRight ? 0.56 : 0.60, 0.34),
        end: Offset(isConnectedRight ? 0.68 : 0.74, 0.68),
        pathPoints: isConnectedRight
            ? const [
                Offset(0.56, 0.34),
                Offset(0.64, 0.50),
                Offset(0.68, 0.68),
              ]
            : const [
                Offset(0.60, 0.34),
                Offset(0.70, 0.50),
                Offset(0.74, 0.68),
              ],
        hintText: 'ابدأ من أعلى وانزل بظهر $name المائل ⬇️',
      ),
      LetterStroke(
        index: isConnectedRight ? 3 : 2,
        label: isConnectedRight ? '٣' : '٢',
        start: Offset(isConnectedRight ? 0.68 : 0.74, 0.68),
        end: Offset(isConnectedRight ? 0.24 : 0.28, 0.68),
        pathPoints: isConnectedRight
            ? const [
                Offset(0.68, 0.68),
                Offset(0.46, 0.68),
                Offset(0.24, 0.68),
              ]
            : const [
                Offset(0.74, 0.68),
                Offset(0.51, 0.68),
                Offset(0.28, 0.68),
              ],
        hintText: 'اسحب قاعدة $name على السطر لليسار ⬅️',
      ),
    ];
    if (hasDot) {
      final dotIdx = strokes.length + 1;
      const labels = ['١', '٢', '٣', '٤'];
      final dotPt = Offset(isConnectedRight ? 0.54 : 0.58, 0.18);
      strokes.add(
        LetterStroke(
          index: dotIdx,
          label: labels[dotIdx - 1],
          start: dotPt,
          end: dotPt,
          pathPoints: [dotPt],
          hintText: 'اضغط لوضع نقطة الذال في الأعلى •',
          isTapOnly: true,
        ),
      );
    }
    return strokes;
  }

  // ─── مقاطع عائلة الراء والزاي (ر / ز) ───
  static List<LetterStroke> _getRaaFamilyStrokes(
    String position, {
    required String letter,
    required bool hasDot,
  }) {
    final name = hasDot ? 'الزاي' : 'الراء';
    final isConnectedRight = position == 'middle' || position == 'end';
    final List<LetterStroke> strokes = [
      if (isConnectedRight)
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.88, 0.54),
          end: const Offset(0.64, 0.54),
          pathPoints: const [
            Offset(0.88, 0.54),
            Offset(0.76, 0.54),
            Offset(0.64, 0.54),
          ],
          hintText: '① اسحب خط الاتصال الأيمن على السطر ⬅️',
        ),
      LetterStroke(
        index: isConnectedRight ? 2 : 1,
        label: isConnectedRight ? '٢' : '١',
        start: const Offset(0.64, 0.36),
        end: const Offset(0.62, 0.56),
        pathPoints: const [
          Offset(0.64, 0.36),
          Offset(0.64, 0.46),
          Offset(0.62, 0.56),
        ],
        hintText: 'ابدأ بسنّة $name من الأعلى للأسفل ⬇️',
      ),
      LetterStroke(
        index: isConnectedRight ? 3 : 2,
        label: isConnectedRight ? '٣' : '٢',
        start: const Offset(0.62, 0.56),
        end: const Offset(0.24, 0.84),
        pathPoints: const [
          Offset(0.62, 0.56),
          Offset(0.50, 0.72),
          Offset(0.36, 0.81),
          Offset(0.24, 0.84),
        ],
        hintText: 'اسحب ذيل $name المقوّس تحت السطر لليسار ↙️',
      ),
    ];
    if (hasDot) {
      final dotIdx = strokes.length + 1;
      const labels = ['١', '٢', '٣', '٤'];
      strokes.add(
        LetterStroke(
          index: dotIdx,
          label: labels[dotIdx - 1],
          start: const Offset(0.64, 0.17),
          end: const Offset(0.64, 0.17),
          pathPoints: const [Offset(0.64, 0.17)],
          hintText: 'اضغط لوضع نقطة الزاي في الأعلى •',
          isTapOnly: true,
        ),
      );
    }
    return strokes;
  }

  // ─── مقاطع عائلة السين والشين (س / ش) — مطابقة لـ س.jpg و ش.jpg ───
  static List<LetterStroke> _getSeenFamilyStrokes(
    String position, {
    required String letter,
    required bool hasThreeDots,
  }) {
    final name = hasThreeDots ? 'الشين' : 'السين';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isFlatTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.92, 0.58) : const Offset(0.84, 0.37),
        end: const Offset(0.66, 0.58),
        pathPoints: isMidOrEnd
            ? const [
                Offset(0.92, 0.58),
                Offset(0.82, 0.58),
                Offset(0.82, 0.37),
                Offset(0.82, 0.58),
                Offset(0.65, 0.58),
                Offset(0.65, 0.37),
                Offset(0.65, 0.58),
              ]
            : const [
                Offset(0.84, 0.37),
                Offset(0.84, 0.58),
                Offset(0.66, 0.58),
                Offset(0.66, 0.37),
                Offset(0.66, 0.58),
              ],
        hintText: '① ارسم السنّة الأولى والثانية لحرف $name ⬅️',
        strokeWidth: 17.5,
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: Offset(isMidOrEnd ? 0.65 : 0.66, 0.58),
        end: const Offset(0.48, 0.58),
        pathPoints: isMidOrEnd
            ? const [
                Offset(0.65, 0.58),
                Offset(0.48, 0.58),
                Offset(0.48, 0.37),
                Offset(0.48, 0.58),
              ]
            : const [
                Offset(0.66, 0.58),
                Offset(0.48, 0.58),
                Offset(0.48, 0.37),
                Offset(0.48, 0.58),
              ],
        hintText: '② ارسم السنّة الثالثة لحرف $name ⬅️',
        strokeWidth: 17.5,
      ),
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.48, 0.58),
        end: isFlatTail ? const Offset(0.14, 0.58) : const Offset(0.16, 0.52),
        pathPoints: isFlatTail
            ? const [
                Offset(0.48, 0.58),
                Offset(0.31, 0.58),
                Offset(0.14, 0.58),
              ]
            : const [
                Offset(0.48, 0.58),
                Offset(0.44, 0.80),
                Offset(0.28, 0.84),
                Offset(0.16, 0.74),
                Offset(0.16, 0.52),
              ],
        hintText: isFlatTail
            ? '③ اسحب خط الاتصال على السطر لليسار ⬅️'
            : '③ ارسم كأس $name العميق وصعوداً لليسار ↶',
        strokeWidth: 18.0,
      ),
    ];
    if (hasThreeDots) {
      strokes.addAll(const [
        LetterStroke(
          index: 4,
          label: '٤',
          start: Offset(0.75, 0.23),
          end: Offset(0.75, 0.23),
          pathPoints: [Offset(0.75, 0.23)],
          hintText: '④ اضغط لوضع النقطة الأولى للشين •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 5,
          label: '٥',
          start: Offset(0.57, 0.23),
          end: Offset(0.57, 0.23),
          pathPoints: [Offset(0.57, 0.23)],
          hintText: '⑤ اضغط لوضع النقطة الثانية للشين ••',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 6,
          label: '٦',
          start: Offset(0.66, 0.11),
          end: Offset(0.66, 0.11),
          pathPoints: [Offset(0.66, 0.11)],
          hintText: '⑥ اضغط لوضع النقطة الثالثة للشين •••',
          isTapOnly: true,
        ),
      ]);
    }
    return strokes;
  }

  // ─── مقاطع عائلة الصاد والضاد (ص / ض) — مطابقة لـ ص.jpg بعين بيضاوية واسعة ───
  static List<LetterStroke> _getSaadFamilyStrokes(String position, {required bool hasDot}) {
    final name = hasDot ? 'الضاد' : 'الصاد';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isFlatTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.92, 0.62) : const Offset(0.47, 0.56),
        end: const Offset(0.46, 0.62),
        pathPoints: isMidOrEnd
            ? const [
                Offset(0.92, 0.62),
                Offset(0.47, 0.62),
                Offset(0.56, 0.42),
                Offset(0.72, 0.34),
                Offset(0.84, 0.44),
                Offset(0.84, 0.62),
                Offset(0.46, 0.62),
              ]
            : const [
                Offset(0.47, 0.56),
                Offset(0.58, 0.40),
                Offset(0.74, 0.34),
                Offset(0.85, 0.44),
                Offset(0.85, 0.62),
                Offset(0.46, 0.62),
              ],
        hintText: '① ارسم رأس $name البيضاوي صعوداً لليمين ثم للسطر ↶',
        strokeWidth: 17.5,
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.46, 0.42),
        end: isFlatTail ? const Offset(0.14, 0.62) : const Offset(0.15, 0.52),
        pathPoints: isFlatTail
            ? const [
                Offset(0.46, 0.42),
                Offset(0.46, 0.62),
                Offset(0.30, 0.62),
                Offset(0.14, 0.62),
              ]
            : const [
                Offset(0.46, 0.42),
                Offset(0.46, 0.62),
                Offset(0.41, 0.82),
                Offset(0.27, 0.85),
                Offset(0.15, 0.72),
                Offset(0.15, 0.52),
              ],
        hintText: isFlatTail
            ? '② ارسم سنّة $name ثم اسحب خط الاتصال ⬅️'
            : '② ارسم سنّة $name ثم الكأس العميق وصعوداً ↶',
        strokeWidth: 18.0,
      ),
    ];
    if (hasDot) {
      strokes.add(const LetterStroke(
        index: 3,
        label: '٣',
        start: Offset(0.68, 0.17),
        end: Offset(0.68, 0.17),
        pathPoints: [Offset(0.68, 0.17)],
        hintText: '③ اضغط لوضع نقطة الضاد فوق الحرف •',
        isTapOnly: true,
      ));
    }
    return strokes;
  }

  // ─── مقاطع عائلة الطاء والظاء (ط / ظ) — عين بيضاوية واضحة ───
  static List<LetterStroke> _getTaaTFamilyStrokes(String position, {required bool hasDot}) {
    final name = hasDot ? 'الظاء' : 'الطاء';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final hasTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.92, 0.66) : const Offset(0.44, 0.66),
        end: hasTail ? const Offset(0.14, 0.66) : const Offset(0.26, 0.66),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.92, 0.66),
          const Offset(0.44, 0.66),
          const Offset(0.55, 0.44),
          const Offset(0.73, 0.37),
          const Offset(0.84, 0.48),
          const Offset(0.82, 0.66),
          const Offset(0.44, 0.66),
          hasTail ? const Offset(0.14, 0.66) : const Offset(0.26, 0.66),
        ],
        hintText: '① ارسم قوس $name البيضاوي ثم اسحبه على السطر ⬅️',
        strokeWidth: 17.5,
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.46, 0.13),
        end: const Offset(0.46, 0.66),
        pathPoints: const [
          Offset(0.46, 0.13),
          Offset(0.46, 0.40),
          Offset(0.46, 0.66),
        ],
        hintText: '② اسحب الألف العمودية للأسفل فوق $name ⬇️',
        strokeWidth: 18.0,
      ),
    ];
    if (hasDot) {
      strokes.add(const LetterStroke(
        index: 3,
        label: '٣',
        start: Offset(0.72, 0.20),
        end: Offset(0.72, 0.20),
        pathPoints: [Offset(0.72, 0.20)],
        hintText: '③ اضغط لوضع نقطة الظاء على اليمين •',
        isTapOnly: true,
      ));
    }
    return strokes;
  }

  // ─── مقاطع عائلة العين والغين (ع / غ) ───
  static List<LetterStroke> _getAynFamilyStrokes(String position, {required bool hasDot}) {
    final name = hasDot ? 'الغين' : 'العين';
    final List<LetterStroke> strokes = [];
    if (position == 'isolated' || position == 'end_disconnected') {
      strokes.addAll([
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.68, 0.34),
          end: const Offset(0.58, 0.54),
          pathPoints: const [
            Offset(0.68, 0.34),
            Offset(0.52, 0.30),
            Offset(0.42, 0.42),
            Offset(0.58, 0.54),
          ],
          hintText: '① ارسم النصف دائرة الصغيرة للعين من اليمين ↶',
        ),
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.58, 0.54),
          end: const Offset(0.74, 0.80),
          pathPoints: const [
            Offset(0.58, 0.54),
            Offset(0.36, 0.64),
            Offset(0.34, 0.80),
            Offset(0.56, 0.86),
            Offset(0.74, 0.80),
          ],
          hintText: '② أكمل القوس الكبير لأسفل نحو اليمين ↷',
        ),
      ]);
    } else if (position == 'start' || position == 'mid_disconnected') {
      strokes.add(LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.68, 0.36),
        end: const Offset(0.18, 0.60),
        pathPoints: const [
          Offset(0.68, 0.36),
          Offset(0.50, 0.34),
          Offset(0.42, 0.48),
          Offset(0.58, 0.60),
          Offset(0.18, 0.60),
        ],
        hintText: '① ارسم رأس $name ثم خط الاتصال على السطر ⬅️',
      ));
    } else {
      // middle or end (مثلث مقلوب واسع بفتحة واضحة)
      strokes.add(LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.88, 0.60),
        end: position == 'end' ? const Offset(0.74, 0.80) : const Offset(0.16, 0.60),
        pathPoints: position == 'end'
            ? const [
                Offset(0.88, 0.60),
                Offset(0.66, 0.60),
                Offset(0.44, 0.32),
                Offset(0.72, 0.32),
                Offset(0.56, 0.60),
                Offset(0.36, 0.70),
                Offset(0.36, 0.82),
                Offset(0.58, 0.86),
                Offset(0.74, 0.80),
              ]
            : const [
                Offset(0.88, 0.60),
                Offset(0.66, 0.60),
                Offset(0.44, 0.32),
                Offset(0.72, 0.32),
                Offset(0.54, 0.60),
                Offset(0.16, 0.60),
              ],
        hintText: '① اسحب من اليمين، اصعد للمثلث المقلوب ثم أكمل $name ⬅️',
        strokeWidth: 17.5,
      ));
    }
    if (hasDot) {
      strokes.add(LetterStroke(
        index: strokes.length + 1,
        label: strokes.length == 1 ? '٢' : '٣',
        start: const Offset(0.57, 0.16),
        end: const Offset(0.57, 0.16),
        pathPoints: const [Offset(0.57, 0.16)],
        hintText: 'اضغط لوضع نقطة الغين في الأعلى •',
        isTapOnly: true,
      ));
    }
    return strokes;
  }

  // ─── مقاطع الفاء والقاف (ف / ق) — رأس دائري مفتوح وواضح ───
  static List<LetterStroke> _getFaaQaafStrokes(String position, {required bool isQaaf}) {
    final name = isQaaf ? 'القاف' : 'الفاء';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isLineTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.90, 0.62) : const Offset(0.76, 0.44),
        end: isLineTail ? const Offset(0.16, 0.62) : const Offset(0.18, 0.50),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.90, 0.62),
          if (isMidOrEnd) const Offset(0.74, 0.62),
          const Offset(0.77, 0.44),
          const Offset(0.69, 0.30),
          const Offset(0.55, 0.32),
          const Offset(0.51, 0.46),
          const Offset(0.61, 0.56),
          const Offset(0.75, 0.50),
          const Offset(0.74, 0.62),
          if (isLineTail) const Offset(0.16, 0.62)
          else if (isQaaf) ...[
            const Offset(0.70, 0.80),
            const Offset(0.46, 0.86),
            const Offset(0.24, 0.76),
            const Offset(0.18, 0.50),
          ] else ...[
            const Offset(0.34, 0.62),
            const Offset(0.18, 0.50),
          ],
        ],
        hintText: isQaaf
            ? '① لف رأس القاف ثم ارسم الكأس العميق ↶'
            : '① لف رأس الفاء ثم اسحب الطبق على السطر ⬅️',
        strokeWidth: 16.5,
      ),
    ];
    if (isQaaf) {
      strokes.addAll(const [
        LetterStroke(
          index: 2,
          label: '٢',
          start: Offset(0.74, 0.14),
          end: Offset(0.74, 0.14),
          pathPoints: [Offset(0.74, 0.14)],
          hintText: '② اضغط لوضع النقطة الأولى للقاف •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 3,
          label: '٣',
          start: Offset(0.56, 0.14),
          end: Offset(0.56, 0.14),
          pathPoints: [Offset(0.56, 0.14)],
          hintText: '③ اضغط لوضع النقطة الثانية للقاف ••',
          isTapOnly: true,
        ),
      ]);
    } else {
      strokes.add(LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.64, 0.14),
        end: const Offset(0.64, 0.14),
        pathPoints: const [Offset(0.64, 0.14)],
        hintText: '② اضغط لوضع نقطة $name في الأعلى •',
        isTapOnly: true,
      ));
    }
    return strokes;
  }

  // ─── مقاطع حرف الكاف (ك) ───
  static List<LetterStroke> _getKaafStrokes(String position) {
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isJoinedLeft = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    if (isJoinedLeft) {
      return [
        if (isMidOrEnd)
          const LetterStroke(
            index: 1,
            label: '١',
            start: Offset(0.90, 0.64),
            end: Offset(0.64, 0.64),
            pathPoints: [
              Offset(0.90, 0.64),
              Offset(0.77, 0.64),
              Offset(0.64, 0.64),
            ],
            hintText: '① اسحب خط الاتصال الأيمن على السطر ⬅️',
            strokeWidth: 18.0,
          ),
        LetterStroke(
          index: isMidOrEnd ? 2 : 1,
          label: isMidOrEnd ? '٢' : '١',
          start: const Offset(0.74, 0.22),
          end: const Offset(0.64, 0.56),
          pathPoints: const [
            Offset(0.74, 0.22),
            Offset(0.42, 0.36),
            Offset(0.64, 0.56),
          ],
          hintText: 'ارسم خط الكاف المائل من الأعلى للداخل ↙️',
          strokeWidth: 18.0,
        ),
        LetterStroke(
          index: isMidOrEnd ? 3 : 2,
          label: isMidOrEnd ? '٣' : '٢',
          start: const Offset(0.64, 0.56),
          end: const Offset(0.16, 0.64),
          pathPoints: const [
            Offset(0.64, 0.56),
            Offset(0.64, 0.64),
            Offset(0.16, 0.64),
          ],
          hintText: 'انزل للسطر واسحب خط الاتصال لليسار ⬅️',
          strokeWidth: 18.0,
        ),
      ];
    }
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.90, 0.68) : const Offset(0.74, 0.18),
        end: const Offset(0.18, 0.54),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.90, 0.68),
          if (isMidOrEnd) const Offset(0.74, 0.68),
          const Offset(0.74, 0.18),
          const Offset(0.74, 0.68),
          const Offset(0.28, 0.68),
          const Offset(0.18, 0.54),
        ],
        hintText: '① انزل عمودياً ثم اسحب القاعدة لليسار وارفع الطرف ⬅️',
        strokeWidth: 18.5,
      ),
      const LetterStroke(
        index: 2,
        label: '٢',
        start: Offset(0.54, 0.28),
        end: Offset(0.36, 0.47),
        pathPoints: [
          Offset(0.54, 0.28),
          Offset(0.40, 0.35),
          Offset(0.54, 0.41),
          Offset(0.36, 0.47),
        ],
        hintText: '② ارسم الهمزة الصغيرة داخل الكاف ✍️',
        strokeWidth: 13.5,
      ),
    ];
  }

  // ─── مقاطع حرف اللام (ل) ───
  static List<LetterStroke> _getLaamStrokes(String position) {
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isJoinedLeft = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.84, 0.58) : const Offset(0.64, 0.18),
        end: isJoinedLeft ? const Offset(0.20, 0.58) : const Offset(0.28, 0.56),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.84, 0.58),
          if (isMidOrEnd) const Offset(0.64, 0.58),
          const Offset(0.64, 0.18),
          const Offset(0.64, 0.58),
          if (isJoinedLeft) const Offset(0.20, 0.58)
          else ...[
            const Offset(0.60, 0.78),
            const Offset(0.44, 0.80),
            const Offset(0.30, 0.72),
            const Offset(0.28, 0.56),
          ],
        ],
        hintText: isJoinedLeft
            ? '① اسحب عصا اللام للسطر ثم لليسار ⬅️'
            : '① انزل بعصا اللام ثم اصنع الكأس واصعد قليلاً ↶',
      ),
    ];
  }

  // ─── مقاطع حرف الميم (م) — مطابقة لـ م.jpg بدائرة واضحة مفتوحة ───
  static List<LetterStroke> _getMeemStrokes(String position) {
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isJoinedLeft = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    if (isJoinedLeft) {
      return [
        LetterStroke(
          index: 1,
          label: '١',
          start: isMidOrEnd ? const Offset(0.90, 0.62) : const Offset(0.46, 0.60),
          end: const Offset(0.15, 0.62),
          pathPoints: isMidOrEnd
              ? const [
                  Offset(0.90, 0.62),
                  Offset(0.76, 0.62),
                  Offset(0.76, 0.40),
                  Offset(0.62, 0.30),
                  Offset(0.46, 0.40),
                  Offset(0.46, 0.62),
                  Offset(0.76, 0.62),
                  Offset(0.15, 0.62),
                ]
              : const [
                  Offset(0.46, 0.60),
                  Offset(0.46, 0.40),
                  Offset(0.62, 0.30),
                  Offset(0.78, 0.40),
                  Offset(0.78, 0.62),
                  Offset(0.46, 0.62),
                  Offset(0.15, 0.62),
                ],
          hintText: '① لف دائرة الميم الواضحة ثم اسحبها على السطر ⬅️',
          strokeWidth: 16.5,
        ),
      ];
    }
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.90, 0.56) : const Offset(0.48, 0.52),
        end: const Offset(0.24, 0.88),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.90, 0.56),
          if (isMidOrEnd) const Offset(0.78, 0.56),
          const Offset(0.48, 0.52),
          const Offset(0.48, 0.32),
          const Offset(0.64, 0.22),
          const Offset(0.80, 0.32),
          const Offset(0.80, 0.54),
          const Offset(0.64, 0.58),
          const Offset(0.32, 0.58),
          const Offset(0.24, 0.66),
          const Offset(0.24, 0.88),
        ],
        hintText: '① لف دائرة الميم ثم اسحبها لليسار وانزل بالذيل ⬇️',
        strokeWidth: 17.5,
      ),
    ];
  }

  // ─── مقاطع حرف النون (ن) ───
  static List<LetterStroke> _getNoonStrokes(String position) {
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isJoinedLeft = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.88, 0.62) : const Offset(0.72, 0.44),
        end: isJoinedLeft ? const Offset(0.18, 0.62) : const Offset(0.26, 0.48),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.88, 0.62),
          if (isMidOrEnd) const Offset(0.68, 0.62),
          Offset(isJoinedLeft ? 0.68 : 0.72, 0.44),
          if (isJoinedLeft) ...[
            const Offset(0.68, 0.62),
            const Offset(0.18, 0.62),
          ] else ...[
            const Offset(0.70, 0.76),
            const Offset(0.50, 0.84),
            const Offset(0.28, 0.74),
            const Offset(0.26, 0.48),
          ],
        ],
        hintText: isJoinedLeft
            ? '① ارسم سنّة النون ثم خط الاتصال على السطر ⬅️'
            : '① ارسم كأس النون المستدير وصعوداً ↶',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: isJoinedLeft ? const Offset(0.68, 0.25) : const Offset(0.50, 0.30),
        end: isJoinedLeft ? const Offset(0.68, 0.25) : const Offset(0.50, 0.30),
        pathPoints: [isJoinedLeft ? const Offset(0.68, 0.25) : const Offset(0.50, 0.30)],
        hintText: '② اضغط لوضع نقطة النون في الأعلى •',
        isTapOnly: true,
      ),
    ];
  }

  // ─── مقاطع حرف الهاء (هـ / ه) — مطابقة لـ ه.jpg ───
  static List<LetterStroke> _getHaaEndStrokes(String position) {
    if (position == 'isolated' || position == 'end_disconnected') {
      return const [
        LetterStroke(
          index: 1,
          label: '١',
          start: Offset(0.50, 0.26),
          end: Offset(0.50, 0.26),
          pathPoints: [
            Offset(0.50, 0.26),
            Offset(0.70, 0.44),
            Offset(0.66, 0.68),
            Offset(0.34, 0.68),
            Offset(0.30, 0.44),
            Offset(0.50, 0.26),
          ],
          hintText: '① ارسم دائرة الهاء المغلقة ⭕',
          strokeWidth: 18.0,
        ),
      ];
    }
    if (position == 'start' || position == 'mid_disconnected') {
      // مطابقة تماماً لصورة Kiwii (ه.jpg) بمسار واحد متّصل صحيح الترتيب:
      // النقطة الصفراء أعلى القبة → نزول مائل لأسفل-اليمين → التفاف داخل الدائرة الداخلية مع عقارب الساعة → انطلاق أفقي لخط النهاية يساراً
      return const [
        LetterStroke(
          index: 1,
          label: '١',
          start: Offset(0.52, 0.29),
          end: Offset(0.13, 0.72),
          pathPoints: [
            // 1. البداية من النقطة الصفراء ثم النزول المائل لليمين والأسفل
            Offset(0.52, 0.29),
            Offset(0.66, 0.39),
            Offset(0.79, 0.48),
            Offset(0.85, 0.58),
            Offset(0.81, 0.68),
            Offset(0.71, 0.72),
            Offset(0.56, 0.72),
            // 2. الالتفاف صعوداً داخل الدائرة الداخلية (مع عقارب الساعة: يسار ← أعلى ← يمين ← أسفل)
            Offset(0.41, 0.71),
            Offset(0.36, 0.61),
            Offset(0.36, 0.49),
            Offset(0.44, 0.40),
            Offset(0.54, 0.41),
            Offset(0.61, 0.49),
            Offset(0.61, 0.61),
            Offset(0.55, 0.71),
            // 3. الانطلاق أفقياً على السطر إلى خط النهاية يساراً
            Offset(0.42, 0.72),
            Offset(0.27, 0.72),
            Offset(0.13, 0.72),
          ],
          hintText: 'ابدأ من النقطة الصفراء، انزل للأسفل ثم لُفَّ الدائرة الداخلية وانطلق لخط النهاية ⬅️',
          strokeWidth: 18.0,
        ),
      ];
    }
    if (position == 'middle') {
      // الهاء الوسطى (ـهـ) بحلقتين واضحتين مفتوحتين (علوية وسفلية)
      return const [
        LetterStroke(
          index: 1,
          label: '١',
          start: Offset(0.90, 0.54),
          end: Offset(0.12, 0.54),
          pathPoints: [
            Offset(0.90, 0.54),
            Offset(0.66, 0.54),
            Offset(0.64, 0.30),
            Offset(0.50, 0.22),
            Offset(0.36, 0.30),
            Offset(0.38, 0.54),
            Offset(0.62, 0.54),
            Offset(0.64, 0.78),
            Offset(0.50, 0.86),
            Offset(0.36, 0.78),
            Offset(0.38, 0.54),
            Offset(0.12, 0.54),
          ],
          hintText: '① اصعد للحلقة العليا ثم انزل للسفلى وأكمل لليسار ⬅️',
          strokeWidth: 14.5,
        ),
      ];
    }
    // end (connected ـه بعنق واضح ورأس مفتوح)
    return const [
      LetterStroke(
        index: 1,
        label: '١',
        start: Offset(0.88, 0.64),
        end: Offset(0.64, 0.60),
        pathPoints: [
          Offset(0.88, 0.64),
          Offset(0.66, 0.64),
          Offset(0.66, 0.26),
          Offset(0.42, 0.30),
          Offset(0.32, 0.46),
          Offset(0.42, 0.62),
          Offset(0.64, 0.60),
        ],
        hintText: '① اسحب على السطر ثم اصعد وأغلق عنق الهاء المتصلة ↶',
        strokeWidth: 17.0,
      ),
    ];
  }

  // ─── مقاطع حرف الواو (و) — رأس دائري مفتوح وواضح ───
  static List<LetterStroke> _getWaawStrokes(String position) {
    final isConnectedRight = position == 'middle' || position == 'end';
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isConnectedRight ? const Offset(0.90, 0.54) : const Offset(0.74, 0.42),
        end: const Offset(0.22, 0.82),
        pathPoints: [
          if (isConnectedRight) const Offset(0.90, 0.54),
          if (isConnectedRight) const Offset(0.74, 0.54),
          const Offset(0.75, 0.38),
          const Offset(0.65, 0.24),
          const Offset(0.50, 0.28),
          const Offset(0.46, 0.44),
          const Offset(0.58, 0.55),
          const Offset(0.73, 0.50),
          const Offset(0.68, 0.70),
          const Offset(0.48, 0.84),
          const Offset(0.22, 0.82),
        ],
        hintText: '① لف رأس الواو ثم انزل بالذيل المقوّس أسفل السطر ↙️',
        strokeWidth: 16.5,
      ),
    ];
  }

  // ─── مقاطع حرف الياء (ي) ───
  static List<LetterStroke> _getYaaStrokes(String position) {
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isJoinedLeft = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    if (isJoinedLeft) {
      return [
        LetterStroke(
          index: 1,
          label: '١',
          start: isMidOrEnd ? const Offset(0.88, 0.58) : const Offset(0.68, 0.42),
          end: const Offset(0.20, 0.58),
          pathPoints: [
            if (isMidOrEnd) const Offset(0.88, 0.58),
            if (isMidOrEnd) const Offset(0.68, 0.58),
            const Offset(0.68, 0.42),
            const Offset(0.68, 0.58),
            const Offset(0.20, 0.58),
          ],
          hintText: '① ارسم سنّة الياء ثم اسحب خط الاتصال على السطر ⬅️',
        ),
        const LetterStroke(
          index: 2,
          label: '٢',
          start: Offset(0.74, 0.77),
          end: Offset(0.74, 0.77),
          pathPoints: [Offset(0.74, 0.77)],
          hintText: '② اضغط لوضع النقطة الأولى تحت الياء •',
          isTapOnly: true,
        ),
        const LetterStroke(
          index: 3,
          label: '٣',
          start: Offset(0.56, 0.77),
          end: Offset(0.56, 0.77),
          pathPoints: [Offset(0.56, 0.77)],
          hintText: '③ اضغط لوضع النقطة الثانية تحت الياء ••',
          isTapOnly: true,
        ),
      ];
    }
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.88, 0.48) : const Offset(0.74, 0.36),
        end: const Offset(0.20, 0.46),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.88, 0.48),
          const Offset(0.74, 0.36),
          const Offset(0.58, 0.30),
          const Offset(0.48, 0.40),
          const Offset(0.66, 0.52),
          const Offset(0.60, 0.70),
          const Offset(0.42, 0.75),
          const Offset(0.24, 0.66),
          const Offset(0.20, 0.46),
        ],
        hintText: '① انحني برأس الياء ثم ارسم الكأس الكبير وصعوداً لليسار ↶',
        strokeWidth: 18.0,
      ),
      const LetterStroke(
        index: 2,
        label: '٢',
        start: Offset(0.56, 0.90),
        end: Offset(0.56, 0.90),
        pathPoints: [Offset(0.56, 0.90)],
        hintText: '② اضغط لوضع النقطة الأولى تحت الياء •',
        isTapOnly: true,
      ),
      const LetterStroke(
        index: 3,
        label: '٣',
        start: Offset(0.38, 0.90),
        end: Offset(0.38, 0.90),
        pathPoints: [Offset(0.38, 0.90)],
        hintText: '③ اضغط لوضع النقطة الثانية تحت الياء ••',
        isTapOnly: true,
      ),
    ];
  }
}

/// لوحة تتبع وكتابة الحرف العربي بأسلوب لينغو بنانا التفاعلي
class ArabicLetterTracingCanvas extends StatefulWidget {
  final String letterChar;
  final String position; // 'isolated', 'start', 'middle', 'end'
  final String exampleWord;
  final String exampleEmoji;
  final VoidCallback? onComplete;
  final Color primaryColor;
  final bool compactChrome;

  const ArabicLetterTracingCanvas({
    super.key,
    required this.letterChar,
    this.position = 'isolated',
    this.exampleWord = 'أَسَد',
    this.exampleEmoji = '🦁',
    this.onComplete,
    this.primaryColor = const Color(0xFFE53935),
    this.compactChrome = false,
  });


  @override
  State<ArabicLetterTracingCanvas> createState() =>
      _ArabicLetterTracingCanvasState();
}

class _ArabicLetterTracingCanvasState extends State<ArabicLetterTracingCanvas>
    with SingleTickerProviderStateMixin {
  late List<LetterStroke> _strokes;
  int _currentStrokeIndex = 0;
  final List<List<Offset>> _completedStrokePaths = [];
  final List<Offset> _currentDrawingPoints = [];
  final Set<int> _coveredGuideIndices = {};
  int _highestReachedPointIndex = 0;
  int _mistakeCount = 0;
  int _earnedStars = 0;
  bool _isDrawing = false;
  bool _isWrongStartShake = false;
  bool _isAllCompleted = false;

  late AnimationController _pulseController;

  String get _starsStorageKey => 'trace_stars_${widget.letterChar}_${widget.position}';

  void _loadSavedStars() {
    try {
      if (Hive.isBoxOpen(AppConstants.lessonProgressBox)) {
        final box = Hive.box(AppConstants.lessonProgressBox);
        _earnedStars = (box.get(_starsStorageKey, defaultValue: 0) as int?) ?? 0;
      }
    } catch (_) {}
  }

  void _saveStars(int stars) {
    try {
      if (Hive.isBoxOpen(AppConstants.lessonProgressBox)) {
        final box = Hive.box(AppConstants.lessonProgressBox);
        final prev = (box.get(_starsStorageKey, defaultValue: 0) as int?) ?? 0;
        if (stars > prev) {
          box.put(_starsStorageKey, stars);
        }
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _strokes = ArabicLetterTracingData.getStrokesForLetter(
      widget.letterChar,
      position: widget.position,
    );
    _loadSavedStars();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant ArabicLetterTracingCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letterChar != widget.letterChar ||
        oldWidget.position != widget.position) {
      setState(() {
        _strokes = ArabicLetterTracingData.getStrokesForLetter(
          widget.letterChar,
          position: widget.position,
        );
        _resetCanvas();
        _loadSavedStars();
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _resetCanvas() {
    setState(() {
      _currentStrokeIndex = 0;
      _completedStrokePaths.clear();
      _currentDrawingPoints.clear();
      _coveredGuideIndices.clear();
      _highestReachedPointIndex = 0;
      _mistakeCount = 0;
      _isDrawing = false;
      _isWrongStartShake = false;
      _isAllCompleted = false;
    });
  }

  void _onTapDown(TapDownDetails details, Size canvasSize) {
    if (_isAllCompleted || _currentStrokeIndex >= _strokes.length) return;
    final stroke = _strokes[_currentStrokeIndex];
    if (!stroke.isTapOnly || stroke.pathPoints.isEmpty) return;
    final startPx = Offset(
      stroke.pathPoints.first.dx * canvasSize.width,
      stroke.pathPoints.first.dy * canvasSize.height,
    );
    if ((details.localPosition - startPx).distance <= 68.0) {
      _completeCurrentStroke([startPx]);
    }
  }

  void _onPanStart(DragStartDetails details, Size canvasSize) {
    if (_isAllCompleted || _currentStrokeIndex >= _strokes.length) return;

    final stroke = _strokes[_currentStrokeIndex];
    final guidePx = stroke.pathPoints.map((p) => Offset(
      p.dx * canvasSize.width,
      p.dy * canvasSize.height,
    )).toList();

    if (guidePx.isEmpty) return;

    final startPx = guidePx.first;
    final touchPos = details.localPosition;
    final distToStart = (touchPos - startPx).distance;

    // دائرة التسامح لبداية النقطة (Tolerance radius = 65px للأطفال)
    bool isNearStart = distToStart <= 65.0;

    // التحقق أيضاً مما إذا كان اللمس قريباً من النقطة الثانية في المسار
    if (!isNearStart && guidePx.length > 1) {
      if ((touchPos - guidePx[1]).distance <= 60.0) {
        isNearStart = true;
      }
    }

    if (isNearStart) {
      if (stroke.isTapOnly) {
        _completeCurrentStroke([startPx]);
        return;
      }
      setState(() {
        _isDrawing = true;
        _isWrongStartShake = false;
        _currentDrawingPoints.clear();
        _currentDrawingPoints.add(startPx);
        _coveredGuideIndices
          ..clear()
          ..add(0);
        _highestReachedPointIndex = 0;
      });
    } else {
      // لمس نقطة خاطئة أو بعيدة عن النقطة المحددة
      setState(() {
        _mistakeCount++;
        _isWrongStartShake = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _isWrongStartShake = false);
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details, Size canvasSize) {
    if (!_isDrawing || _isAllCompleted || _currentStrokeIndex >= _strokes.length) return;

    final touchPos = details.localPosition;
    final stroke = _strokes[_currentStrokeIndex];
    final guidePx = stroke.pathPoints.map((p) => Offset(
      p.dx * canvasSize.width,
      p.dy * canvasSize.height,
    )).toList();

    if (guidePx.isEmpty) return;

    // التحقق من التقدم والتغطية على المسار
    for (int i = 0; i < guidePx.length; i++) {
      final target = guidePx[i];
      final distToTarget = (touchPos - target).distance;
      if (distToTarget <= 65.0) {
        _coveredGuideIndices.add(i);
        if (i > _highestReachedPointIndex) {
          _highestReachedPointIndex = i;
        }
      }
    }

    setState(() {
      _currentDrawingPoints.add(touchPos);
    });

    // هل وصل لنهاية المقطع أو اقترب من النقطة الأخيرة؟
    // في المقاطع الطويلة ذات الحلقات الداخلية (مثل هـ، م، ص) نتأكد من مرور الطفل بجزء كافٍ من الحلقة قبل الإتمام
    final distToEnd = (touchPos - guidePx.last).distance;
    final minLoopPoints = guidePx.length >= 10 ? (guidePx.length * 0.45).floor() : 1;
    final passedEnough = _coveredGuideIndices.length >= minLoopPoints;
    if (passedEnough && (_highestReachedPointIndex >= guidePx.length - 1 || distToEnd <= 55.0)) {
      _completeCurrentStroke(guidePx);
    }
  }

  void _onPanEnd(DragEndDetails details, Size canvasSize) {
    if (!_isDrawing) return;

    final stroke = _strokes[_currentStrokeIndex];
    final guidePx = stroke.pathPoints.map((p) => Offset(
      p.dx * canvasSize.width,
      p.dy * canvasSize.height,
    )).toList();

    if (guidePx.isEmpty) return;

    // عتبة تغطية متكيفة (Adaptive threshold) حسب طول وتعقيد المقطع
    final double adaptiveThreshold = guidePx.length <= 3 ? 0.65 : 0.55;
    final double coverage = _coveredGuideIndices.length / guidePx.length;

    if (coverage >= adaptiveThreshold ||
        _highestReachedPointIndex >= (guidePx.length / 2).floor() ||
        guidePx.length <= 2) {
      _completeCurrentStroke(guidePx);
    } else {
      // لم يكمل المقطع بشكل كافٍ -> إعادة المحاولة لهذا المقطع
      setState(() {
        _mistakeCount++;
        _currentDrawingPoints.clear();
        _coveredGuideIndices.clear();
        _highestReachedPointIndex = 0;
        _isDrawing = false;
      });
    }
  }

  void _completeCurrentStroke(List<Offset> guidePx) {
    setState(() {
      _completedStrokePaths.add(List.from(guidePx));
      _currentDrawingPoints.clear();
      _coveredGuideIndices.clear();
      _highestReachedPointIndex = 0;
      _isDrawing = false;
      _currentStrokeIndex++;

      if (_currentStrokeIndex >= _strokes.length) {
        _isAllCompleted = true;
        _earnedStars = _mistakeCount <= 1 ? 3 : (_mistakeCount <= 3 ? 2 : 1);
        _saveStars(_earnedStars);
        AudioService.instance.playAsset('audio/sfx/celebration.mp3', channel: AudioChannel.sfx);
        final encIdx = (_earnedStars % 3) + 1;
        AudioService.instance.playAsset('audio/common/encourage_$encIdx.mp3', channel: AudioChannel.voice);
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      } else {
        AudioService.instance.playAsset('audio/sfx/correct.mp3', channel: AudioChannel.sfx);
      }
    });
  }

  static String _letterBadge(String letter) {
    const letters = [
      'أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص',
      'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'هـ', 'و', 'ي'
    ];
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    final normalizedLetter = letter == 'ه' ? 'هـ' : letter;
    final idx = letters.indexOf(normalizedLetter);
    final num = idx >= 0 ? idx + 1 : 1;
    final arabicNum = num.toString().split('').map((d) => arabicDigits[int.parse(d)]).join();
    return '$arabicNum / ٢٨';
  }

  @override
  Widget build(BuildContext context) {
    final stroke = _currentStrokeIndex < _strokes.length
        ? _strokes[_currentStrokeIndex]
        : null;

    final currentHint = _isAllCompleted
        ? 'مُمْتَازٌ! كَتَبْتَ حَرْفَ (${widget.letterChar}) بِنَجَاحٍ! (${'⭐' * _earnedStars}) 🎉'
        : (stroke?.hintText ?? '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.compactChrome) ...[
            // ─── 1. شريط الكبسولة العلوي (عند الاستخدام المنفرد) ───
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              decoration: BoxDecoration(
                color: widget.primaryColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: widget.primaryColor.withValues(alpha: 0.35), width: 1.8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: widget.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _letterBadge(widget.letterChar),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.exampleEmoji} ${widget.exampleWord}',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: widget.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  if (_earnedStars > 0) ...[
                    const SizedBox(width: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (i) {
                        return Icon(
                          i < _earnedStars ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: const Color(0xFFFFB300),
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // ─── 2. لوحة التتبع الفيكتورية البيضاء (أسلوب Kiwii / Montessori) ───
          LayoutBuilder(
            builder: (context, outerConstraints) {
              final maxW = outerConstraints.maxWidth.isFinite
                  ? outerConstraints.maxWidth
                  : 360.0;
              final screenWidth = MediaQuery.sizeOf(context).width;
              final isTablet = screenWidth > 600;
              final canvasWidth = widget.compactChrome
                  ? maxW.clamp(240.0, 440.0)
                  : (isTablet
                      ? (screenWidth * 0.50).clamp(320.0, 480.0)
                      : math.min(340.0, maxW));
              final canvasHeight = canvasWidth * (340.0 / 320.0);

              return Center(
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: canvasWidth,
                      height: canvasHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _isWrongStartShake
                              ? Colors.redAccent
                              : (_isAllCompleted
                                  ? const Color(0xFF16A34A)
                                  : (widget.compactChrome
                                      ? widget.primaryColor.withValues(alpha: 0.14)
                                      : widget.primaryColor.withValues(alpha: 0.28))),
                          width: _isWrongStartShake || _isAllCompleted
                              ? 2.8
                              : (widget.compactChrome ? 1.2 : 2.0),
                        ),
                        boxShadow: widget.compactChrome && !_isWrongStartShake
                            ? null
                            : [
                                BoxShadow(
                                  color: _isWrongStartShake
                                      ? Colors.redAccent.withValues(alpha: 0.25)
                                      : widget.primaryColor.withValues(alpha: 0.10),
                                  blurRadius: 18,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                      ),
                      child: child,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size = Size(constraints.maxWidth, constraints.maxHeight);

                        return GestureDetector(
                          onTapDown: (details) => _onTapDown(details, size),
                          onPanStart: (details) => _onPanStart(details, size),
                          onPanUpdate: (details) => _onPanUpdate(details, size),
                          onPanEnd: (details) => _onPanEnd(details, size),
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, _) => CustomPaint(
                              size: size,
                              painter: ArabicLetterTracingPainter(
                                strokes: _strokes,
                                currentStrokeIndex: _currentStrokeIndex,
                                completedStrokePaths: _completedStrokePaths,
                                currentDrawingPoints: _currentDrawingPoints,
                                pulseValue: _pulseController.value,
                                isAllCompleted: _isAllCompleted,
                                outlineColor: widget.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // ─── 3. شريط التوجيه التفاعلي + النجوم + زر إعادة الكتابة ───
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _isAllCompleted
                      ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                      : (_isWrongStartShake
                          ? Colors.red.withValues(alpha: 0.12)
                          : widget.primaryColor.withValues(alpha: 0.08)),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isAllCompleted
                        ? const Color(0xFF16A34A)
                        : (_isWrongStartShake
                            ? Colors.red
                            : widget.primaryColor.withValues(alpha: 0.28)),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isAllCompleted
                          ? Icons.check_circle_rounded
                          : (_isWrongStartShake
                              ? Icons.warning_amber_rounded
                              : Icons.touch_app_rounded),
                      color: _isAllCompleted
                          ? const Color(0xFF16A34A)
                          : (_isWrongStartShake ? Colors.red : widget.primaryColor),
                      size: 20,
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        currentHint,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: _isAllCompleted
                              ? const Color(0xFF15803D)
                              : (_isWrongStartShake ? Colors.red.shade700 : const Color(0xFF1B2A4A)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_completedStrokePaths.isNotEmpty || _isAllCompleted)
                OutlinedButton.icon(
                  onPressed: _resetCanvas,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text(
                    'إِعَادَةٌ',
                    style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: widget.primaryColor,
                    side: BorderSide(color: widget.primaryColor.withValues(alpha: 0.5)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// الرسام الفيكتوري المخصص بأسلوب المضمار المفرّغ ذي الإطار الملون (Kiwii / Montessori)
/// - إطار ملون خارجي حاد ومضمار أبيض ناصع مفرّغ بدون تقاطعات داخلية
/// - خط متقطع كحلي غامق (#1B2A4A) مع رؤوس أسهم مثلثية على المنعطفات والنهايات
/// - نقطة بداية صفراء ذهبية نابضة (#FBBF24) + ترقيم الخطوات
/// - دوائر مفرغة منقطة بأسهم دائرية للنقاط (ب، ت، ث، ن، ش، ذ، ز...)
/// - تلوين تفاعلي مقصوص بدقة داخل حدود المضمار (BlendMode.srcIn)
class ArabicLetterTracingPainter extends CustomPainter {
  final List<LetterStroke> strokes;
  final int currentStrokeIndex;
  final List<List<Offset>> completedStrokePaths;
  final List<Offset> currentDrawingPoints;
  final double pulseValue;
  final bool isAllCompleted;
  final Color outlineColor;

  static const Color _navyGuide = Color(0xFF1B2A4A);
  static const Color _goldStart = Color(0xFFFBBF24);
  static const Color _goldBorder = Color(0xFFD97706);

  ArabicLetterTracingPainter({
    required this.strokes,
    required this.currentStrokeIndex,
    required this.completedStrokePaths,
    required this.currentDrawingPoints,
    required this.pulseValue,
    required this.isAllCompleted,
    this.outlineColor = const Color(0xFFE53935),
  });

  double _trackWidthFor(LetterStroke stroke, double unit) {
    final factor = (stroke.strokeWidth / 22.0).clamp(0.62, 1.05);
    return (unit * 0.120 * factor).clamp(19.0, 54.0);
  }

  double _dotRadius(double unit) => (unit * 0.056).clamp(13.0, 24.0);

  /// يبني مسار Bezier ناعم يحافظ على الزوايا القائمة الحادة (مثل زاوية ب، س، د، ص)
  /// ويجعل المنحنيات (مثل قوس ن، م، هـ، و، ج) انسيابية تماماً كالخط المدرسي.
  Path _buildSmoothPath(List<Offset> pts) {
    final path = Path();
    if (pts.isEmpty) return path;
    path.moveTo(pts.first.dx, pts.first.dy);
    if (pts.length == 1) return path;
    if (pts.length == 2) {
      path.lineTo(pts[1].dx, pts[1].dy);
      return path;
    }

    for (int i = 1; i < pts.length - 1; i++) {
      final prev = pts[i - 1];
      final curr = pts[i];
      final next = pts[i + 1];
      final v1 = curr - prev;
      final v2 = next - curr;
      final d1 = v1.distance;
      final d2 = v2.distance;
      if (d1 < 0.001 || d2 < 0.001) continue;

      final cosAngle = (v1.dx * v2.dx + v1.dy * v2.dy) / (d1 * d2);
      if (cosAngle < 0.25) {
        // زاوية حادة مقصودة (≥ ~75°): نُبقيها حادة وأنيقة بحنيٍ صغير جداً
        final cornerPull = math.min(math.min(d1, d2) * 0.25, 10.0);
        final before = curr - (v1 / d1) * cornerPull;
        final after = curr + (v2 / d2) * cornerPull;
        path.lineTo(before.dx, before.dy);
        path.quadraticBezierTo(curr.dx, curr.dy, after.dx, after.dy);
      } else {
        // انحناء سلس: ربط عبر نقطة المنتصف بـ quadraticBezierTo
        final mid = Offset((curr.dx + next.dx) / 2, (curr.dy + next.dy) / 2);
        path.quadraticBezierTo(curr.dx, curr.dy, mid.dx, mid.dy);
      }
    }
    path.lineTo(pts.last.dx, pts.last.dy);
    return path;
  }

  bool _isDotStroke(LetterStroke s, List<Offset> pts) {
    return s.isTapOnly || pts.length == 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final unit = math.min(size.width, size.height);
    final borderW = (unit * 0.0095).clamp(2.2, 3.6);
    final dotR = _dotRadius(unit);
    final layerBounds = Offset.zero & size;

    final scaledPtsList = <List<Offset>>[];
    final smoothPaths = <Path?>[];
    for (final s in strokes) {
      final pts = s.pathPoints
          .map((p) => Offset(p.dx * size.width, p.dy * size.height))
          .toList();
      scaledPtsList.add(pts);
      smoothPaths.add(_isDotStroke(s, pts) ? null : _buildSmoothPath(pts));
    }

    // ── الطبقة 1: المضمار المفرّغ بإطار ملون متّصل نظيف (بدون خطوط متقاطعة بالداخل) ──
    canvas.saveLayer(layerBounds, Paint());
    // 1أ. الظل الخارجي الملون لكل المقاطع
    for (int i = 0; i < strokes.length; i++) {
      final s = strokes[i];
      final pts = scaledPtsList[i];
      if (pts.isEmpty) continue;
      if (_isDotStroke(s, pts)) {
        canvas.drawCircle(
          pts.first,
          dotR + borderW,
          Paint()..color = outlineColor..style = PaintingStyle.fill,
        );
      } else {
        final tw = _trackWidthFor(s, unit);
        canvas.drawPath(
          smoothPaths[i]!,
          Paint()
            ..color = outlineColor
            ..strokeWidth = tw + borderW * 2
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round
            ..style = PaintingStyle.stroke,
        );
      }
    }
    // 1ب. تفريغ الداخل باللون الأبيض الناصع لإزالة أي تقاطعات داخلية
    for (int i = 0; i < strokes.length; i++) {
      final s = strokes[i];
      final pts = scaledPtsList[i];
      if (pts.isEmpty) continue;
      if (_isDotStroke(s, pts)) {
        canvas.drawCircle(
          pts.first,
          dotR,
          Paint()..color = Colors.white..style = PaintingStyle.fill,
        );
      } else {
        final tw = _trackWidthFor(s, unit);
        canvas.drawPath(
          smoothPaths[i]!,
          Paint()
            ..color = Colors.white
            ..strokeWidth = tw
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round
            ..style = PaintingStyle.stroke,
        );
      }
    }
    canvas.restore();

    // ── الطبقة 2: التلوين التفاعلي للطفل مقصوصاً تماماً داخل حدود المضمار ──
    if (completedStrokePaths.isNotEmpty || currentDrawingPoints.isNotEmpty) {
      canvas.saveLayer(layerBounds, Paint());
      // قناع المضمار الداخلي (يمنع خروج تلوين الطفل خارج الحدود الملونة أبداً)
      for (int i = 0; i < strokes.length; i++) {
        final s = strokes[i];
        final pts = scaledPtsList[i];
        if (pts.isEmpty) continue;
        if (_isDotStroke(s, pts)) {
          canvas.drawCircle(pts.first, dotR - 0.8, Paint()..color = Colors.white);
        } else {
          final tw = _trackWidthFor(s, unit);
          canvas.drawPath(
            smoothPaths[i]!,
            Paint()
              ..color = Colors.white
              ..strokeWidth = tw - 1.2
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..style = PaintingStyle.stroke,
          );
        }
      }

      // رسم تلوين الطفل داخل القناع بـ BlendMode.srcIn
      canvas.saveLayer(layerBounds, Paint()..blendMode = BlendMode.srcIn);
      final fillColor = isAllCompleted
          ? const Color(0xFF10B981).withValues(alpha: 0.85)
          : outlineColor.withValues(alpha: 0.34);

      for (int i = 0; i < completedStrokePaths.length && i < strokes.length; i++) {
        final s = strokes[i];
        final pts = scaledPtsList[i];
        if (pts.isEmpty) continue;
        if (_isDotStroke(s, pts)) {
          canvas.drawCircle(pts.first, dotR, Paint()..color = fillColor);
        } else {
          final tw = _trackWidthFor(s, unit);
          canvas.drawPath(
            smoothPaths[i]!,
            Paint()
              ..color = fillColor
              ..strokeWidth = tw
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..style = PaintingStyle.stroke,
          );
        }
      }

      if (currentDrawingPoints.isNotEmpty && currentStrokeIndex < strokes.length) {
        final activeStroke = strokes[currentStrokeIndex];
        final tw = _trackWidthFor(activeStroke, unit);
        final activeInk = outlineColor.withValues(alpha: 0.52);
        if (currentDrawingPoints.length == 1) {
          canvas.drawCircle(currentDrawingPoints.first, tw * 0.45, Paint()..color = activeInk);
        } else {
          final drawPath = Path()..moveTo(currentDrawingPoints.first.dx, currentDrawingPoints.first.dy);
          for (int j = 1; j < currentDrawingPoints.length; j++) {
            drawPath.lineTo(currentDrawingPoints[j].dx, currentDrawingPoints[j].dy);
          }
          canvas.drawPath(
            drawPath,
            Paint()
              ..color = activeInk
              ..strokeWidth = tw * 0.92
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..style = PaintingStyle.stroke,
          );
        }
      }
      canvas.restore(); // srcIn
      canvas.restore(); // mask
    }

    // ── الطبقة 3: الخط المتقطع الكحلي (#1B2A4A) + رؤوس الأسهم المثلثية ──
    final dashLen = (unit * 0.025).clamp(6.0, 11.0);
    final gapLen = (unit * 0.018).clamp(4.5, 8.0);
    final dashStrokeW = (unit * 0.0085).clamp(2.0, 3.2);
    final arrowSize = (unit * 0.036).clamp(9.0, 15.0);

    for (int sIdx = 0; sIdx < strokes.length; sIdx++) {
      final s = strokes[sIdx];
      final pts = scaledPtsList[sIdx];
      if (pts.isEmpty) continue;
      final isCompleted = sIdx < currentStrokeIndex || isAllCompleted;
      final isCurrent = sIdx == currentStrokeIndex && !isAllCompleted;

      final guideColor = isCompleted
          ? Colors.white.withValues(alpha: isAllCompleted ? 0.45 : 0.0)
          : _navyGuide.withValues(alpha: isCurrent ? 0.95 : 0.65);

      if (guideColor.a == 0) continue;

      if (_isDotStroke(s, pts)) {
        // الدائرة المتقطعة بسهم دائري (مثل ب، ذ، ز، ش، ن في الصور المرجعية)
        _drawCircularDotGuide(
          canvas,
          pts.first,
          dotR * 0.54,
          guideColor,
          dashStrokeW,
          arrowSize * 0.72,
        );
      } else {
        final path = smoothPaths[sIdx]!;
        _drawDashedPathWithArrows(
          canvas,
          path,
          guideColor,
          dashStrokeW,
          dashLen,
          gapLen,
          arrowSize,
          unit,
        );
      }
    }

    // ── الطبقة 4: نقطة البداية الصفراء الذهبية (#FBBF24) + ترقيم الخطوات ──
    if (!isAllCompleted) {
      final dotStartR = (unit * 0.025).clamp(7.0, 11.5);
      final showNumbers = strokes.length > 1;

      for (int sIdx = strokes.length - 1; sIdx >= 0; sIdx--) {
        if (sIdx < currentStrokeIndex) continue;
        final s = strokes[sIdx];
        final pts = scaledPtsList[sIdx];
        if (pts.isEmpty) continue;

        final isCurrent = sIdx == currentStrokeIndex;
        final isDot = _isDotStroke(s, pts);
        final startPx = isDot
            ? Offset(pts.first.dx + dotR * 0.54, pts.first.dy)
            : pts.first;

        if (isCurrent) {
          final haloR = dotStartR * (1.45 + pulseValue * 0.65);
          canvas.drawCircle(
            startPx,
            haloR,
            Paint()..color = _goldStart.withValues(alpha: 0.36 * (1.0 - pulseValue)),
          );
        }

        final r = isDot ? dotStartR * 0.68 : (isCurrent ? dotStartR * 1.18 : dotStartR * 0.92);
        canvas.drawCircle(
          startPx,
          r,
          Paint()..color = isCurrent ? _goldStart : const Color(0xFFFDE047),
        );
        if (isCurrent) {
          canvas.drawCircle(
            startPx,
            r,
            Paint()
              ..color = _goldBorder
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.6,
          );
        }

        if (showNumbers && !isDot) {
          final tp = TextPainter(
            text: TextSpan(
              text: s.label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: (r * 1.15).clamp(9.0, 14.0),
                fontWeight: FontWeight.w900,
                color: _navyGuide,
                height: 1.0,
              ),
            ),
            textDirection: TextDirection.rtl,
          )..layout();
          tp.paint(canvas, startPx - Offset(tp.width / 2, tp.height / 2));
        }
      }
    }

    // مؤشر لطيف على طرف إصبع الطفل أثناء التتبع
    if (currentDrawingPoints.isNotEmpty && !isAllCompleted) {
      final tip = currentDrawingPoints.last;
      canvas.drawCircle(tip, 11.0, Paint()..color = Colors.white.withValues(alpha: 0.9));
      canvas.drawCircle(tip, 7.0, Paint()..color = _goldStart);
    }
  }

  void _drawDashedPathWithArrows(
    Canvas canvas,
    Path path,
    Color color,
    double strokeW,
    double dashLen,
    double gapLen,
    double arrowSize,
    double unit,
  ) {
    final dashPaint = Paint()
      ..color = color
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final metric in path.computeMetrics()) {
      final total = metric.length;
      if (total < 4.0) continue;

      // ترك هامش صغير قبل رأس السهم النهائي
      final dashEndLimit = math.max(0.0, total - arrowSize * 0.55);
      double dist = 0.0;
      while (dist < dashEndLimit) {
        final nextEnd = math.min(dist + dashLen, dashEndLimit);
        canvas.drawPath(metric.extractPath(dist, nextEnd), dashPaint);
        dist += dashLen + gapLen;
      }

      // سهم عند نهاية المسار دائماً
      final endOffset = math.max(0.0, total - 1.0);
      final endTan = metric.getTangentForOffset(endOffset);
      if (endTan != null) {
        _drawArrowHead(canvas, endTan.position, -endTan.angle, arrowSize, color);
      }

      // أسهم إضافية موزّعة بانتظام على المسارات الطويلة والحلقية (مطابقة لـ هـ، م، ص، ن، ب)
      if (total > unit * 0.42) {
        final List<double> midFractions;
        if (total > unit * 1.85) {
          midFractions = const [0.13, 0.28, 0.54, 0.72, 0.87];
        } else if (total > unit * 1.35) {
          midFractions = const [0.22, 0.50, 0.76];
        } else if (total > unit * 0.95) {
          midFractions = const [0.33, 0.66];
        } else {
          midFractions = const [0.50];
        }
        for (final f in midFractions) {
          final tan = metric.getTangentForOffset(total * f);
          if (tan != null) {
            _drawArrowHead(canvas, tan.position, -tan.angle, arrowSize * 0.88, color);
          }
        }
      }
    }
  }

  void _drawCircularDotGuide(
    Canvas canvas,
    Offset center,
    double radius,
    Color color,
    double strokeW,
    double arrowSize,
  ) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    // قوس منقط يبدأ من الساعة 3 ويدور مع عقارب الساعة 270 درجة (مثل الصور المرجعية)
    const startAngle = 0.25;
    const sweepTotal = math.pi * 1.48;
    const segments = 6;
    const segStep = sweepTotal / segments;
    final p = Paint()
      ..color = color
      ..strokeWidth = strokeW * 0.9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < segments; i++) {
      canvas.drawArc(rect, startAngle + i * segStep, segStep * 0.58, false, p);
    }

    const endAngle = startAngle + sweepTotal;
    final tip = Offset(
      center.dx + radius * math.cos(endAngle),
      center.dy + radius * math.sin(endAngle),
    );
    final tangentAngle = endAngle + math.pi / 2;
    _drawArrowHead(canvas, tip, tangentAngle, arrowSize, color);
  }

  void _drawArrowHead(
    Canvas canvas,
    Offset tip,
    double angle,
    double size,
    Color color,
  ) {
    final path = Path();
    final p1 = tip - Offset(size * math.cos(angle - 0.52), size * math.sin(angle - 0.52));
    final p2 = tip - Offset(size * math.cos(angle + 0.52), size * math.sin(angle + 0.52));
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.close();
    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant ArabicLetterTracingPainter oldDelegate) => true;
}
