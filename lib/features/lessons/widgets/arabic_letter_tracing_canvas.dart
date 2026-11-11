import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
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
          start: const Offset(0.88, 0.82),
          end: const Offset(0.50, 0.82),
          pathPoints: [
            const Offset(0.88, 0.82),
            const Offset(0.68, 0.82),
            const Offset(0.50, 0.82),
          ],
          hintText: '① ابدأ من اليمين واسحب خط الاتصال ⬅️',
          strokeWidth: 20.0,
        ),
        // ② عصا الألف صاعدة للأعلى (ا)
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.50, 0.82),
          end: const Offset(0.50, 0.28),
          pathPoints: [
            const Offset(0.50, 0.82),
            const Offset(0.50, 0.55),
            const Offset(0.50, 0.28),
          ],
          hintText: '② من النقطة ② اصعد بعصا الألف للأعلى ⬆️',
          strokeWidth: 20.0,
        ),
        // ③ قوس ورأس الهمزة (من اليمين للأعلى ثم نزول لأسفل)
        LetterStroke(
          index: 3,
          label: '٣',
          start: const Offset(0.58, 0.09),
          end: const Offset(0.47, 0.17),
          pathPoints: [
            const Offset(0.58, 0.09),
            const Offset(0.53, 0.05),
            const Offset(0.47, 0.05),
            const Offset(0.47, 0.17),
          ],
          hintText: '③ ابدأ من اليمين ودوّر قوس الهمزة لأسفل ↶',
          strokeWidth: 16.0,
        ),
        // ④ قاعدة وخط الهمزة الأفقي (من اليمين لليسار)
        LetterStroke(
          index: 4,
          label: '٤',
          start: const Offset(0.64, 0.17),
          end: const Offset(0.34, 0.17),
          pathPoints: [
            const Offset(0.64, 0.17),
            const Offset(0.49, 0.17),
            const Offset(0.34, 0.17),
          ],
          hintText: '④ من النقطة ④ اسحب خط الهمزة الأفقي لليسار ⬅️',
          strokeWidth: 16.0,
        ),
      ];
    }

    // ─── الألف المنفصلة أو أول الكلمة (أ) ───
    return [
      // ① عصا الألف (من الأعلى إلى الأسفل)
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.50, 0.28),
        end: const Offset(0.50, 0.88),
        pathPoints: [
          const Offset(0.50, 0.28),
          const Offset(0.50, 0.48),
          const Offset(0.50, 0.68),
          const Offset(0.50, 0.88),
        ],
        hintText: '① ابدأ من أعلى واسحب عصا الألف لأسفل ⬇️',
        strokeWidth: 20.0,
      ),
      // ② قوس ورأس الهمزة (من اليمين للأعلى ثم نزول لأسفل)
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.58, 0.09),
        end: const Offset(0.47, 0.17),
        pathPoints: [
          const Offset(0.58, 0.09),
          const Offset(0.53, 0.05),
          const Offset(0.47, 0.05),
          const Offset(0.47, 0.17),
        ],
        hintText: '② ابدأ من اليمين ودوّر قوس الهمزة لأسفل ↶',
        strokeWidth: 16.0,
      ),
      // ③ قاعدة وخط الهمزة الأفقي (من اليمين لليسار)
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.64, 0.17),
        end: const Offset(0.34, 0.17),
        pathPoints: [
          const Offset(0.64, 0.17),
          const Offset(0.49, 0.17),
          const Offset(0.34, 0.17),
        ],
        hintText: '③ من النقطة ③ اسحب خط الهمزة الأفقي لليسار ⬅️',
        strokeWidth: 16.0,
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
        start: const Offset(0.58, 0.34),
        end: const Offset(0.58, 0.34),
        pathPoints: [const Offset(0.58, 0.34)],
        hintText: 'اضغط لوضع النقطة الأولى للثاء •',
        isTapOnly: true,
      ),
      LetterStroke(
        index: n2,
        label: arabicLabels[n2 - 1],
        start: const Offset(0.42, 0.34),
        end: const Offset(0.42, 0.34),
        pathPoints: [const Offset(0.42, 0.34)],
        hintText: 'اضغط لوضع النقطة الثانية للثاء ••',
        isTapOnly: true,
      ),
      LetterStroke(
        index: n3,
        label: arabicLabels[n3 - 1],
        start: const Offset(0.50, 0.22),
        end: const Offset(0.50, 0.22),
        pathPoints: [const Offset(0.50, 0.22)],
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
    final List<LetterStroke> strokes = [];

    if (position == 'start' || position == 'middle' || position == 'mid_disconnected') {
      strokes.add(
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.28, 0.42),
          end: const Offset(0.75, 0.58),
          pathPoints: const [
            Offset(0.28, 0.42),
            Offset(0.48, 0.36),
            Offset(0.66, 0.46),
            Offset(0.75, 0.58),
          ],
          hintText: '① ابدأ من اليسار وارسم حاجب $name نحو اليمين ↷',
        ),
      );
      strokes.add(
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.75, 0.58),
          end: const Offset(0.18, 0.58),
          pathPoints: const [
            Offset(0.75, 0.58),
            Offset(0.46, 0.58),
            Offset(0.18, 0.58),
          ],
          hintText: '② اسحب خط الاتصال على السطر لليسار ⬅️',
        ),
      );
    } else {
      // مفرد أو آخر الكلمة
      strokes.add(
        LetterStroke(
          index: 1,
          label: '١',
          start: const Offset(0.28, 0.30),
          end: const Offset(0.74, 0.36),
          pathPoints: const [
            Offset(0.28, 0.30),
            Offset(0.50, 0.26),
            Offset(0.74, 0.36),
          ],
          hintText: '① ارسم حاجب $name في الأعلى ↷',
        ),
      );
      strokes.add(
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.74, 0.36),
          end: const Offset(0.66, 0.84),
          pathPoints: const [
            Offset(0.74, 0.36),
            Offset(0.45, 0.48),
            Offset(0.30, 0.65),
            Offset(0.42, 0.84),
            Offset(0.66, 0.84),
          ],
          hintText: '② انزل ببطن $name المقوّس للأسفل ↶',
        ),
      );
    }

    if (dotMode == 'inside') {
      final dotPos = (position == 'start' || position == 'middle' || position == 'mid_disconnected')
          ? const Offset(0.50, 0.76)
          : const Offset(0.54, 0.65);
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
      const dotPos = Offset(0.50, 0.16);
      strokes.add(
        LetterStroke(
          index: 3,
          label: '٣',
          start: dotPos,
          end: dotPos,
          pathPoints: const [dotPos],
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
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.62, 0.34),
        end: const Offset(0.74, 0.66),
        pathPoints: const [
          Offset(0.62, 0.34),
          Offset(0.70, 0.50),
          Offset(0.74, 0.66),
        ],
        hintText: '① ابدأ من أعلى وانزل بظهر $name المائل ⬇️',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.74, 0.66),
        end: const Offset(0.28, 0.66),
        pathPoints: const [
          Offset(0.74, 0.66),
          Offset(0.50, 0.66),
          Offset(0.28, 0.66),
        ],
        hintText: '② اسحب قاعدة $name على السطر لليسار ⬅️',
      ),
    ];
    if (hasDot) {
      strokes.add(
        const LetterStroke(
          index: 3,
          label: '٣',
          start: Offset(0.56, 0.20),
          end: Offset(0.56, 0.20),
          pathPoints: [Offset(0.56, 0.20)],
          hintText: '③ اضغط لوضع نقطة الذال في الأعلى •',
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
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.66, 0.36),
        end: const Offset(0.64, 0.56),
        pathPoints: const [
          Offset(0.66, 0.36),
          Offset(0.66, 0.46),
          Offset(0.64, 0.56),
        ],
        hintText: '① ابدأ بسنّة $name من الأعلى للأسفل ⬇️',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.64, 0.56),
        end: const Offset(0.26, 0.82),
        pathPoints: const [
          Offset(0.64, 0.56),
          Offset(0.52, 0.72),
          Offset(0.38, 0.80),
          Offset(0.26, 0.82),
        ],
        hintText: '② اسحب ذيل $name المقوّس تحت السطر لليسار ↙️',
      ),
    ];
    if (hasDot) {
      strokes.add(
        const LetterStroke(
          index: 3,
          label: '٣',
          start: Offset(0.64, 0.20),
          end: Offset(0.64, 0.20),
          pathPoints: [Offset(0.64, 0.20)],
          hintText: '③ اضغط لوضع نقطة الزاي في الأعلى •',
          isTapOnly: true,
        ),
      );
    }
    return strokes;
  }

  // ─── مقاطع عائلة السين والشين (س / ش) ───
  static List<LetterStroke> _getSeenFamilyStrokes(
    String position, {
    required String letter,
    required bool hasThreeDots,
  }) {
    final name = hasThreeDots ? 'الشين' : 'السين';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.84, 0.44),
        end: const Offset(0.66, 0.58),
        pathPoints: const [
          Offset(0.84, 0.44),
          Offset(0.84, 0.58),
          Offset(0.75, 0.58),
          Offset(0.66, 0.44),
          Offset(0.66, 0.58),
        ],
        hintText: '① ارسم السنّة الأولى والثانية لحرف $name ⬅️',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.66, 0.58),
        end: const Offset(0.48, 0.58),
        pathPoints: const [
          Offset(0.66, 0.58),
          Offset(0.57, 0.58),
          Offset(0.48, 0.44),
          Offset(0.48, 0.58),
        ],
        hintText: '② ارسم السنّة الثالثة لحرف $name ⬅️',
      ),
      LetterStroke(
        index: 3,
        label: '٣',
        start: const Offset(0.48, 0.58),
        end: const Offset(0.18, 0.56),
        pathPoints: (position == 'start' || position == 'middle' || position == 'mid_disconnected')
            ? const [
                Offset(0.48, 0.58),
                Offset(0.32, 0.58),
                Offset(0.18, 0.58),
              ]
            : const [
                Offset(0.48, 0.58),
                Offset(0.44, 0.78),
                Offset(0.30, 0.82),
                Offset(0.18, 0.74),
                Offset(0.18, 0.56),
              ],
        hintText: (position == 'start' || position == 'middle' || position == 'mid_disconnected')
            ? '③ اسحب خط الاتصال على السطر لليسار ⬅️'
            : '③ ارسم كأس $name العميق وصعوداً لليسار ↶',
      ),
    ];
    if (hasThreeDots) {
      strokes.addAll(const [
        LetterStroke(
          index: 4,
          label: '٤',
          start: Offset(0.72, 0.28),
          end: Offset(0.72, 0.28),
          pathPoints: [Offset(0.72, 0.28)],
          hintText: '④ اضغط لوضع النقطة الأولى للشين •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 5,
          label: '٥',
          start: Offset(0.58, 0.28),
          end: Offset(0.58, 0.28),
          pathPoints: [Offset(0.58, 0.28)],
          hintText: '⑤ اضغط لوضع النقطة الثانية للشين ••',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 6,
          label: '٦',
          start: Offset(0.65, 0.18),
          end: Offset(0.65, 0.18),
          pathPoints: [Offset(0.65, 0.18)],
          hintText: '⑥ اضغط لوضع النقطة الثالثة للشين •••',
          isTapOnly: true,
        ),
      ]);
    }
    return strokes;
  }

  // ─── مقاطع عائلة الصاد والضاد (ص / ض) ───
  static List<LetterStroke> _getSaadFamilyStrokes(String position, {required bool hasDot}) {
    final name = hasDot ? 'الضاد' : 'الصاد';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isFlatTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.88, 0.58) : const Offset(0.50, 0.58),
        end: const Offset(0.46, 0.58),
        pathPoints: isMidOrEnd
            ? const [
                Offset(0.88, 0.58),
                Offset(0.50, 0.58),
                Offset(0.62, 0.42),
                Offset(0.80, 0.44),
                Offset(0.76, 0.58),
                Offset(0.46, 0.58),
              ]
            : const [
                Offset(0.50, 0.58),
                Offset(0.62, 0.42),
                Offset(0.80, 0.44),
                Offset(0.76, 0.58),
                Offset(0.46, 0.58),
              ],
        hintText: '① ارسم رأس $name البيضاوي صعوداً لليمين ثم للسطر ↶',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.46, 0.58),
        end: isFlatTail ? const Offset(0.16, 0.58) : const Offset(0.18, 0.54),
        pathPoints: isFlatTail
            ? const [
                Offset(0.46, 0.48),
                Offset(0.46, 0.58),
                Offset(0.30, 0.58),
                Offset(0.16, 0.58),
              ]
            : const [
                Offset(0.46, 0.48),
                Offset(0.46, 0.58),
                Offset(0.40, 0.78),
                Offset(0.28, 0.80),
                Offset(0.18, 0.68),
                Offset(0.18, 0.54),
              ],
        hintText: isFlatTail
            ? '② ارسم سنّة $name ثم اسحب خط الاتصال ⬅️'
            : '② ارسم سنّة $name ثم الكأس العميق وصعوداً ↶',
      ),
    ];
    if (hasDot) {
      strokes.add(const LetterStroke(
        index: 3,
        label: '٣',
        start: Offset(0.66, 0.28),
        end: Offset(0.66, 0.28),
        pathPoints: [Offset(0.66, 0.28)],
        hintText: '③ اضغط لوضع نقطة الضاد فوق الحرف •',
        isTapOnly: true,
      ));
    }
    return strokes;
  }

  // ─── مقاطع عائلة الطاء والظاء (ط / ظ) ───
  static List<LetterStroke> _getTaaTFamilyStrokes(String position, {required bool hasDot}) {
    final name = hasDot ? 'الظاء' : 'الطاء';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final hasTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.88, 0.58) : const Offset(0.46, 0.58),
        end: hasTail ? const Offset(0.18, 0.58) : const Offset(0.28, 0.58),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.88, 0.58),
          const Offset(0.46, 0.58),
          const Offset(0.58, 0.40),
          const Offset(0.76, 0.44),
          const Offset(0.72, 0.58),
          const Offset(0.44, 0.58),
          hasTail ? const Offset(0.18, 0.58) : const Offset(0.28, 0.58),
        ],
        hintText: '① ارسم قوس $name البيضاوي ثم اسحبه على السطر ⬅️',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.52, 0.18),
        end: const Offset(0.52, 0.58),
        pathPoints: const [
          Offset(0.52, 0.18),
          Offset(0.52, 0.38),
          Offset(0.52, 0.58),
        ],
        hintText: '② اسحب الألف العمودية للأسفل فوق $name ⬇️',
      ),
    ];
    if (hasDot) {
      strokes.add(const LetterStroke(
        index: 3,
        label: '٣',
        start: Offset(0.72, 0.28),
        end: Offset(0.72, 0.28),
        pathPoints: [Offset(0.72, 0.28)],
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
          end: const Offset(0.74, 0.78),
          pathPoints: const [
            Offset(0.58, 0.54),
            Offset(0.36, 0.64),
            Offset(0.34, 0.78),
            Offset(0.56, 0.84),
            Offset(0.74, 0.78),
          ],
          hintText: '② أكمل القوس الكبير لأسفل نحو اليمين ↷',
        ),
      ]);
    } else if (position == 'start' || position == 'mid_disconnected') {
      strokes.add(LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.68, 0.36),
        end: const Offset(0.20, 0.58),
        pathPoints: const [
          Offset(0.68, 0.36),
          Offset(0.50, 0.34),
          Offset(0.44, 0.48),
          Offset(0.58, 0.58),
          Offset(0.20, 0.58),
        ],
        hintText: '① ارسم رأس $name ثم خط الاتصال على السطر ⬅️',
      ));
    } else {
      // middle or end (muttasil closed inverted triangle)
      strokes.add(LetterStroke(
        index: 1,
        label: '١',
        start: const Offset(0.86, 0.58),
        end: position == 'end' ? const Offset(0.74, 0.76) : const Offset(0.20, 0.58),
        pathPoints: position == 'end'
            ? const [
                Offset(0.86, 0.58),
                Offset(0.64, 0.58),
                Offset(0.50, 0.36),
                Offset(0.66, 0.36),
                Offset(0.56, 0.58),
                Offset(0.38, 0.68),
                Offset(0.36, 0.80),
                Offset(0.58, 0.84),
                Offset(0.74, 0.76),
              ]
            : const [
                Offset(0.86, 0.58),
                Offset(0.64, 0.58),
                Offset(0.50, 0.36),
                Offset(0.66, 0.36),
                Offset(0.56, 0.58),
                Offset(0.20, 0.58),
              ],
        hintText: '① اسحب من اليمين، اصعد للمثلث المقلوب ثم أكمل $name ⬅️',
      ));
    }
    if (hasDot) {
      strokes.add(LetterStroke(
        index: strokes.length + 1,
        label: strokes.length == 1 ? '٢' : '٣',
        start: const Offset(0.56, 0.20),
        end: const Offset(0.56, 0.20),
        pathPoints: const [Offset(0.56, 0.20)],
        hintText: 'اضغط لوضع نقطة الغين في الأعلى •',
        isTapOnly: true,
      ));
    }
    return strokes;
  }

  // ─── مقاطع الفاء والقاف (ف / ق) ───
  static List<LetterStroke> _getFaaQaafStrokes(String position, {required bool isQaaf}) {
    final name = isQaaf ? 'القاف' : 'الفاء';
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isLineTail = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    final List<LetterStroke> strokes = [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.68, 0.44),
        end: isLineTail ? const Offset(0.20, 0.58) : const Offset(0.22, 0.50),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.86, 0.58),
          if (isMidOrEnd) const Offset(0.70, 0.58),
          const Offset(0.72, 0.36),
          const Offset(0.58, 0.34),
          const Offset(0.58, 0.48),
          const Offset(0.70, 0.54),
          const Offset(0.68, 0.58),
          if (isLineTail) const Offset(0.20, 0.58)
          else if (isQaaf) ...[
            const Offset(0.64, 0.78),
            const Offset(0.44, 0.82),
            const Offset(0.26, 0.74),
            const Offset(0.22, 0.50),
          ] else ...[
            const Offset(0.36, 0.58),
            const Offset(0.22, 0.48),
          ],
        ],
        hintText: isQaaf
            ? '① لف رأس القاف ثم ارسم الكأس العميق ↶'
            : '① لف رأس الفاء ثم اسحب الطبق على السطر ⬅️',
      ),
    ];
    if (isQaaf) {
      strokes.addAll(const [
        LetterStroke(
          index: 2,
          label: '٢',
          start: Offset(0.72, 0.20),
          end: Offset(0.72, 0.20),
          pathPoints: [Offset(0.72, 0.20)],
          hintText: '② اضغط لوضع النقطة الأولى للقاف •',
          isTapOnly: true,
        ),
        LetterStroke(
          index: 3,
          label: '٣',
          start: Offset(0.58, 0.20),
          end: Offset(0.58, 0.20),
          pathPoints: [Offset(0.58, 0.20)],
          hintText: '③ اضغط لوضع النقطة الثانية للقاف ••',
          isTapOnly: true,
        ),
      ]);
    } else {
      strokes.add(LetterStroke(
        index: 2,
        label: '٢',
        start: const Offset(0.65, 0.20),
        end: const Offset(0.65, 0.20),
        pathPoints: const [Offset(0.65, 0.20)],
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
        LetterStroke(
          index: 1,
          label: '١',
          start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.68, 0.24),
          end: const Offset(0.62, 0.52),
          pathPoints: isMidOrEnd
              ? const [
                  Offset(0.86, 0.58),
                  Offset(0.68, 0.58),
                  Offset(0.68, 0.24),
                  Offset(0.46, 0.36),
                  Offset(0.62, 0.52),
                ]
              : const [
                  Offset(0.68, 0.24),
                  Offset(0.46, 0.36),
                  Offset(0.62, 0.52),
                ],
          hintText: '① ارسم خط الكاف المائل من الأعلى للداخل ↙️',
        ),
        LetterStroke(
          index: 2,
          label: '٢',
          start: const Offset(0.62, 0.52),
          end: const Offset(0.20, 0.58),
          pathPoints: const [
            Offset(0.62, 0.52),
            Offset(0.62, 0.58),
            Offset(0.20, 0.58),
          ],
          hintText: '② انزل للسطر واسحب خط الاتصال لليسار ⬅️',
        ),
      ];
    }
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.70, 0.22),
        end: const Offset(0.22, 0.50),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.86, 0.58),
          if (isMidOrEnd) const Offset(0.70, 0.58),
          const Offset(0.70, 0.22),
          const Offset(0.70, 0.58),
          const Offset(0.32, 0.58),
          const Offset(0.22, 0.50),
        ],
        hintText: '① انزل عمودياً ثم اسحب القاعدة لليسار وارفع الطرف ⬅️',
      ),
      const LetterStroke(
        index: 2,
        label: '٢',
        start: Offset(0.50, 0.36),
        end: Offset(0.38, 0.50),
        pathPoints: [
          Offset(0.50, 0.36),
          Offset(0.42, 0.42),
          Offset(0.50, 0.46),
          Offset(0.38, 0.50),
        ],
        hintText: '② ارسم الهمزة الصغيرة داخل الكاف ✍️',
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

  // ─── مقاطع حرف الميم (م) ───
  static List<LetterStroke> _getMeemStrokes(String position) {
    final isMidOrEnd = position == 'middle' || position == 'end';
    final isJoinedLeft = position == 'start' || position == 'middle' || position == 'mid_disconnected';
    if (isJoinedLeft) {
      return [
        LetterStroke(
          index: 1,
          label: '١',
          start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.66, 0.52),
          end: const Offset(0.20, 0.58),
          pathPoints: [
            if (isMidOrEnd) const Offset(0.86, 0.58),
            if (isMidOrEnd) const Offset(0.66, 0.58),
            const Offset(0.74, 0.44),
            const Offset(0.60, 0.42),
            const Offset(0.56, 0.58),
            const Offset(0.20, 0.58),
          ],
          hintText: '① لف دائرة الميم الصغيرة ثم اسحبها على السطر ⬅️',
        ),
      ];
    }
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.66, 0.48),
        end: const Offset(0.38, 0.54),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.86, 0.58),
          const Offset(0.66, 0.48),
          const Offset(0.74, 0.40),
          const Offset(0.58, 0.40),
          const Offset(0.54, 0.54),
          const Offset(0.38, 0.54),
        ],
        hintText: '① ارسم رأس الميم الصغير نحو اليسار ⬅️',
      ),
      const LetterStroke(
        index: 2,
        label: '٢',
        start: Offset(0.38, 0.54),
        end: Offset(0.38, 0.84),
        pathPoints: [
          Offset(0.38, 0.54),
          Offset(0.38, 0.70),
          Offset(0.38, 0.84),
        ],
        hintText: '② اسحب ذيل الميم عمودياً للأسفل ⬇️',
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
        start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.70, 0.44),
        end: isJoinedLeft ? const Offset(0.22, 0.58) : const Offset(0.28, 0.48),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.86, 0.58),
          if (isMidOrEnd) const Offset(0.70, 0.58),
          const Offset(0.70, 0.44),
          if (isJoinedLeft) ...[
            const Offset(0.68, 0.58),
            const Offset(0.22, 0.58),
          ] else ...[
            const Offset(0.68, 0.74),
            const Offset(0.50, 0.80),
            const Offset(0.30, 0.72),
            const Offset(0.28, 0.48),
          ],
        ],
        hintText: isJoinedLeft
            ? '① ارسم سنّة النون ثم خط الاتصال على السطر ⬅️'
            : '① ارسم كأس النون المستدير وصعوداً ↶',
      ),
      LetterStroke(
        index: 2,
        label: '٢',
        start: isJoinedLeft ? const Offset(0.68, 0.28) : const Offset(0.50, 0.36),
        end: isJoinedLeft ? const Offset(0.68, 0.28) : const Offset(0.50, 0.36),
        pathPoints: [isJoinedLeft ? const Offset(0.68, 0.28) : const Offset(0.50, 0.36)],
        hintText: '② اضغط لوضع نقطة النون في الأعلى •',
        isTapOnly: true,
      ),
    ];
  }

  // ─── مقاطع حرف الهاء (هـ / ه) ───
  static List<LetterStroke> _getHaaEndStrokes(String position) {
    if (position == 'isolated' || position == 'end_disconnected') {
      return [
        const LetterStroke(
          index: 1,
          label: '١',
          start: Offset(0.52, 0.34),
          end: Offset(0.52, 0.34),
          pathPoints: [
            Offset(0.52, 0.34),
            Offset(0.68, 0.46),
            Offset(0.64, 0.64),
            Offset(0.42, 0.64),
            Offset(0.38, 0.46),
            Offset(0.52, 0.34),
          ],
          hintText: '① ارسم دائرة الهاء المغلقة ⭕',
        ),
      ];
    }
    if (position == 'start' || position == 'mid_disconnected') {
      return [
        const LetterStroke(
          index: 1,
          label: '١',
          start: Offset(0.66, 0.58),
          end: Offset(0.20, 0.58),
          pathPoints: [
            Offset(0.66, 0.58),
            Offset(0.76, 0.42),
            Offset(0.60, 0.30),
            Offset(0.48, 0.44),
            Offset(0.64, 0.52),
            Offset(0.54, 0.58),
            Offset(0.20, 0.58),
          ],
          hintText: '① ارسم قبة الهاء ثم لف الدائرة الداخلية واخرج على السطر ⬅️',
        ),
      ];
    }
    if (position == 'middle') {
      return [
        const LetterStroke(
          index: 1,
          label: '١',
          start: Offset(0.86, 0.58),
          end: Offset(0.20, 0.58),
          pathPoints: [
            Offset(0.86, 0.58),
            Offset(0.64, 0.58),
            Offset(0.54, 0.36),
            Offset(0.46, 0.58),
            Offset(0.54, 0.76),
            Offset(0.64, 0.58),
            Offset(0.20, 0.58),
          ],
          hintText: '① اصعد للحلقة العليا ثم انزل للسفلى وأكمل لليسار ⬅️',
        ),
      ];
    }
    // end (connected ة / ـه)
    return [
      const LetterStroke(
        index: 1,
        label: '١',
        start: Offset(0.82, 0.58),
        end: Offset(0.60, 0.56),
        pathPoints: [
          Offset(0.82, 0.58),
          Offset(0.60, 0.58),
          Offset(0.60, 0.32),
          Offset(0.42, 0.40),
          Offset(0.44, 0.56),
          Offset(0.60, 0.56),
        ],
        hintText: '① اسحب على السطر ثم اصعد وأغلق عنق الهاء المتصلة ↶',
      ),
    ];
  }

  // ─── مقاطع حرف الواو (و) ───
  static List<LetterStroke> _getWaawStrokes(String position) {
    final isConnectedRight = position == 'middle' || position == 'end';
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isConnectedRight ? const Offset(0.84, 0.54) : const Offset(0.62, 0.44),
        end: const Offset(0.26, 0.76),
        pathPoints: [
          if (isConnectedRight) const Offset(0.84, 0.54),
          const Offset(0.62, 0.54),
          const Offset(0.72, 0.36),
          const Offset(0.56, 0.34),
          const Offset(0.54, 0.50),
          const Offset(0.64, 0.56),
          const Offset(0.58, 0.72),
          const Offset(0.42, 0.80),
          const Offset(0.26, 0.76),
        ],
        hintText: '① لف رأس الواو ثم انزل بالذيل المقوّس أسفل السطر ↙️',
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
          start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.68, 0.44),
          end: const Offset(0.24, 0.58),
          pathPoints: [
            if (isMidOrEnd) const Offset(0.86, 0.58),
            if (isMidOrEnd) const Offset(0.68, 0.58),
            const Offset(0.68, 0.44),
            const Offset(0.68, 0.58),
            const Offset(0.24, 0.58),
          ],
          hintText: '① ارسم سنّة الياء ثم اسحب خط الاتصال على السطر ⬅️',
        ),
        const LetterStroke(
          index: 2,
          label: '٢',
          start: Offset(0.72, 0.74),
          end: Offset(0.72, 0.74),
          pathPoints: [Offset(0.72, 0.74)],
          hintText: '② اضغط لوضع النقطة الأولى تحت الياء •',
          isTapOnly: true,
        ),
        const LetterStroke(
          index: 3,
          label: '٣',
          start: Offset(0.58, 0.74),
          end: Offset(0.58, 0.74),
          pathPoints: [Offset(0.58, 0.74)],
          hintText: '③ اضغط لوضع النقطة الثانية تحت الياء ••',
          isTapOnly: true,
        ),
      ];
    }
    return [
      LetterStroke(
        index: 1,
        label: '١',
        start: isMidOrEnd ? const Offset(0.86, 0.58) : const Offset(0.74, 0.46),
        end: const Offset(0.22, 0.52),
        pathPoints: [
          if (isMidOrEnd) const Offset(0.86, 0.58),
          const Offset(0.74, 0.46),
          const Offset(0.60, 0.38),
          const Offset(0.50, 0.46),
          const Offset(0.66, 0.58),
          const Offset(0.60, 0.76),
          const Offset(0.42, 0.82),
          const Offset(0.24, 0.72),
          const Offset(0.22, 0.52),
        ],
        hintText: '① انحني برأس الياء ثم ارسم الكأس الكبير وصعوداً لليسار ↶',
      ),
      const LetterStroke(
        index: 2,
        label: '٢',
        start: Offset(0.54, 0.88),
        end: Offset(0.54, 0.88),
        pathPoints: [Offset(0.54, 0.88)],
        hintText: '② اضغط لوضع النقطة الأولى تحت الياء •',
        isTapOnly: true,
      ),
      const LetterStroke(
        index: 3,
        label: '٣',
        start: Offset(0.42, 0.88),
        end: Offset(0.42, 0.88),
        pathPoints: [Offset(0.42, 0.88)],
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

  const ArabicLetterTracingCanvas({
    super.key,
    required this.letterChar,
    this.position = 'isolated',
    this.exampleWord = 'أَسَد',
    this.exampleEmoji = '🦁',
    this.onComplete,
    this.primaryColor = const Color(0xFF673AB7), // Purple theme matching Lingo Banana
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
  int _highestReachedPointIndex = 0;
  bool _isDrawing = false;
  bool _isWrongStartShake = false;
  bool _isAllCompleted = false;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _strokes = ArabicLetterTracingData.getStrokesForLetter(
      widget.letterChar,
      position: widget.position,
    );
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
      _highestReachedPointIndex = 0;
      _isDrawing = false;
      _isWrongStartShake = false;
      _isAllCompleted = false;
    });
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
        _highestReachedPointIndex = 0;
      });
    } else {
      // لمس نقطة خاطئة أو بعيدة عن النقطة المحددة
      setState(() {
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

    // التحقق من التقدم على المسار
    for (int i = _highestReachedPointIndex + 1; i < guidePx.length; i++) {
      final target = guidePx[i];
      final distToTarget = (touchPos - target).distance;
      if (distToTarget <= 65.0) {
        _highestReachedPointIndex = i;
      }
    }

    setState(() {
      _currentDrawingPoints.add(touchPos);
    });

    // هل وصل لنهاية المقطع أو اقترب من النقطة الأخيرة؟
    final distToEnd = (touchPos - guidePx.last).distance;
    if (_highestReachedPointIndex >= guidePx.length - 1 || distToEnd <= 55.0) {
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

    // إذا قطع التلميذ نصف المسار أو وصل لأكثر من نقطة، نعتبره مكتملاً ونسحبه للنهاية
    if (_highestReachedPointIndex >= (guidePx.length / 2).floor() || guidePx.length <= 2) {
      _completeCurrentStroke(guidePx);
    } else {
      // لم يكمل المقطع بشكل كافٍ -> إعادة المحاولة لهذا المقطع
      setState(() {
        _currentDrawingPoints.clear();
        _highestReachedPointIndex = 0;
        _isDrawing = false;
      });
    }
  }

  void _completeCurrentStroke(List<Offset> guidePx) {
    setState(() {
      _completedStrokePaths.add(List.from(guidePx));
      _currentDrawingPoints.clear();
      _highestReachedPointIndex = 0;
      _isDrawing = false;
      _currentStrokeIndex++;

      if (_currentStrokeIndex >= _strokes.length) {
        _isAllCompleted = true;
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      } else {
        AudioService.instance.playAsset('audio/stories/alif_correct.mp3');
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
        ? 'مُمْتَازٌ! كَتَبْتَ حَرْفَ (${widget.letterChar}) بِنَجَاحٍ! 🎉'
        : (stroke?.hintText ?? '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── 1. شريط الكبسولة العلوي (مثل لينغو بنانا: 1/26 🍎 APPLE) ───
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: widget.primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: widget.primaryColor.withValues(alpha: 0.4), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.oasisGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _letterBadge(widget.letterChar),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
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
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: widget.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ─── 2. إطار رسم الحرف المتوهج (Lingo Banana Canvas Box) ───
          LayoutBuilder(
            builder: (context, outerConstraints) {
              final screenWidth = MediaQuery.sizeOf(context).width;
              final isTablet = screenWidth > 600;
              // تكبير تناسبي: على الفون ~320, على التابلت ~480 (مع حد أقصى)
              final canvasWidth = isTablet
                  ? (screenWidth * 0.55).clamp(320.0, 520.0)
                  : math.min(320.0, outerConstraints.maxWidth);
              final canvasHeight = canvasWidth * (340.0 / 320.0); // نفس النسبة

              return Center(
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: canvasWidth,
                      height: canvasHeight,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D144B), // خلفية بنفسجية داكنة فاخرة
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: _isWrongStartShake
                              ? Colors.redAccent
                              : Colors.white.withValues(alpha: 0.85),
                          width: _isWrongStartShake ? 3.5 : 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isWrongStartShake
                                ? Colors.redAccent.withValues(alpha: 0.4)
                                : widget.primaryColor.withValues(alpha: 0.35),
                            blurRadius: 16,
                            spreadRadius: 2,
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
                          onPanStart: (details) => _onPanStart(details, size),
                          onPanUpdate: (details) => _onPanUpdate(details, size),
                          onPanEnd: (details) => _onPanEnd(details, size),
                          child: CustomPaint(
                            size: size,
                            painter: _ArabicLetterPainter(
                              strokes: _strokes,
                              currentStrokeIndex: _currentStrokeIndex,
                              completedStrokePaths: _completedStrokePaths,
                              currentDrawingPoints: _currentDrawingPoints,
                              pulseValue: _pulseController.value,
                              isAllCompleted: _isAllCompleted,
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

          const SizedBox(height: 14),

          // ─── 3. شريط التوجيه التفاعلي أسفل الإطار ───
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: _isAllCompleted
                  ? AppColors.oasisGreen.withValues(alpha: 0.15)
                  : (_isWrongStartShake
                      ? Colors.red.withValues(alpha: 0.15)
                      : widget.primaryColor.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isAllCompleted
                    ? AppColors.oasisGreen
                    : (_isWrongStartShake ? Colors.red : widget.primaryColor.withValues(alpha: 0.3)),
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
                      ? AppColors.oasisGreen
                      : (_isWrongStartShake ? Colors.red : widget.primaryColor),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    currentHint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _isAllCompleted
                          ? AppColors.oasisGreen
                          : (_isWrongStartShake ? Colors.red : AppColors.textPrimaryDay),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_isAllCompleted) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _resetCanvas,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text(
                'إِعَادَةُ الْكِتَابَةِ',
                style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: widget.primaryColor,
                side: BorderSide(color: widget.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// الرسام المخصص لمسارات وأسهم ونقاط الحرف العربي
class _ArabicLetterPainter extends CustomPainter {
  final List<LetterStroke> strokes;
  final int currentStrokeIndex;
  final List<List<Offset>> completedStrokePaths;
  final List<Offset> currentDrawingPoints;
  final double pulseValue;
  final bool isAllCompleted;

  _ArabicLetterPainter({
    required this.strokes,
    required this.currentStrokeIndex,
    required this.completedStrokePaths,
    required this.currentDrawingPoints,
    required this.pulseValue,
    required this.isAllCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ── 1. رسم المسار الشفاف العريض (Guide Track) — كل مقطع بعرضه ──
    for (final stroke in strokes) {
      final points = stroke.pathPoints.map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();
      if (points.length == 1) {
        canvas.drawCircle(points.first, 18.0, Paint()..color = Colors.white.withValues(alpha: 0.16));
      } else if (points.isNotEmpty) {
        final trackPaint = Paint()
          ..color = Colors.white.withValues(alpha: 0.16)
          ..strokeWidth = stroke.strokeWidth + 16.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        final path = Path();
        path.moveTo(points.first.dx, points.first.dy);
        for (int i = 1; i < points.length; i++) {
          path.lineTo(points[i].dx, points[i].dy);
        }
        canvas.drawPath(path, trackPaint);
      }
    }

    // ── 2. رسم الخط المنقط المركزي والأسهم التوجيهية ──
    for (int sIdx = 0; sIdx < strokes.length; sIdx++) {
      final stroke = strokes[sIdx];
      final points = stroke.pathPoints.map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();

      final dashPaint = Paint()
        ..color = (sIdx == currentStrokeIndex)
            ? Colors.cyanAccent.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.35)
        ..strokeWidth = 3.5
        ..style = PaintingStyle.stroke;

      if (points.length == 1) {
        canvas.drawCircle(
          points.first,
          10.0,
          dashPaint..style = PaintingStyle.stroke..strokeWidth = 2.5,
        );
      } else {
        _drawDashedPolyline(canvas, points, dashPaint);
        if (points.length >= 2) {
          final last = points.last;
          final prev = points[points.length - 2];
          final angle = (last - prev).direction;
          _drawArrowHead(canvas, last, angle, dashPaint.color);
        }
      }
    }

    // ── 3. رسم المقاطع المكتملة — كل مقطع بعرضه الخاص ──
    final baseColor = isAllCompleted ? const Color(0xFF00E676) : const Color(0xFFFFB300);
    for (int i = 0; i < completedStrokePaths.length; i++) {
      final pathPoints = completedStrokePaths[i];
      final sw = (i < strokes.length) ? strokes[i].strokeWidth : 22.0;
      final completedPaint = Paint()
        ..color = baseColor
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      if (pathPoints.length == 1) {
        canvas.drawCircle(pathPoints.first, sw * 0.6, Paint()..color = baseColor);
      } else if (pathPoints.isNotEmpty) {
        final p = Path();
        p.moveTo(pathPoints.first.dx, pathPoints.first.dy);
        for (int j = 1; j < pathPoints.length; j++) {
          p.lineTo(pathPoints[j].dx, pathPoints[j].dy);
        }
        canvas.drawPath(p, completedPaint);
      }
    }


    // ── 4. رسم الخط الحالي أثناء السحب بإصبع التلميذ ──
    if (currentDrawingPoints.isNotEmpty) {
      final activeDrawingPaint = Paint()
        ..color = const Color(0xFFFFC107)
        ..strokeWidth = 34.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      if (currentDrawingPoints.length == 1) {
        canvas.drawCircle(currentDrawingPoints.first, 15.0, Paint()..color = const Color(0xFFFFC107));
      } else {
        final p = Path();
        p.moveTo(currentDrawingPoints.first.dx, currentDrawingPoints.first.dy);
        for (int i = 1; i < currentDrawingPoints.length; i++) {
          p.lineTo(currentDrawingPoints[i].dx, currentDrawingPoints[i].dy);
        }
        canvas.drawPath(p, activeDrawingPaint);
      }

      // نقطة متوهجة على رأس إصبع التلميذ
      final tip = currentDrawingPoints.last;
      canvas.drawCircle(
        tip,
        14.0,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        tip,
        8.0,
        Paint()..color = Colors.amber,
      );
    }

    // ── 5. رسم نقاط البداية المرقمة (Numbered Start Badges) ──
    if (!isAllCompleted) {
      for (int sIdx = 0; sIdx < strokes.length; sIdx++) {
        final stroke = strokes[sIdx];
        final startPx = Offset(stroke.start.dx * size.width, stroke.start.dy * size.height);
        final isCurrent = (sIdx == currentStrokeIndex);
        final isPassed = (sIdx < currentStrokeIndex);

        if (isPassed) continue; // تم الانتهاء منه

        // دائرة النبض للنقطة النشطة الحالية
        if (isCurrent) {
          final pulseRadius = 18.0 + (pulseValue * 8.0);
          canvas.drawCircle(
            startPx,
            pulseRadius,
            Paint()..color = Colors.cyanAccent.withValues(alpha: 0.35 * (1.0 - pulseValue)),
          );
        }

        // الدائرة الخارجية للنقطة
        canvas.drawCircle(
          startPx,
          16.0,
          Paint()
            ..color = isCurrent ? const Color(0xFF00E5FF) : Colors.white.withValues(alpha: 0.4)
            ..style = PaintingStyle.fill,
        );

        // الدائرة البيضاء الداخلية
        canvas.drawCircle(
          startPx,
          13.0,
          Paint()
            ..color = isCurrent ? Colors.white : Colors.grey.shade300
            ..style = PaintingStyle.fill,
        );

        // رقم النقطة (١ ، ٢ ، ٣)
        final textPainter = TextPainter(
          text: TextSpan(
            text: stroke.label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: isCurrent ? const Color(0xFF00838F) : Colors.grey.shade600,
            ),
          ),
          textDirection: TextDirection.rtl,
        )..layout();

        textPainter.paint(
          canvas,
          startPx - Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }
  }

  void _drawDashedPolyline(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;

    const dashLength = 8.0;
    const gapLength = 6.0;

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final totalDist = (p2 - p1).distance;
      if (totalDist <= 0.0001) continue;
      final dir = (p2 - p1) / totalDist;

      double current = 0.0;
      while (current < totalDist) {
        final start = p1 + dir * current;
        final endDist = math.min(current + dashLength, totalDist);
        final end = p1 + dir * endDist;
        canvas.drawLine(start, end, paint);
        current += dashLength + gapLength;
      }
    }
  }

  void _drawArrowHead(Canvas canvas, Offset tip, double angle, Color color) {
    const arrowSize = 14.0;
    final path = Path();

    final p1 = tip - Offset(arrowSize * math.cos(angle - 0.5), arrowSize * math.sin(angle - 0.5));
    final p2 = tip - Offset(arrowSize * math.cos(angle + 0.5), arrowSize * math.sin(angle + 0.5));

    path.moveTo(tip.dx, tip.dy);
    path.lineTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.close();

    canvas.drawPath(path, Paint()..color = color..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant _ArabicLetterPainter oldDelegate) => true;
}
