# المرحلة الخامسة: خريطة الواحة الرئيسية (Home Oasis Map)

### P5-T001: إنشاء شاشة الخريطة الرئيسية (Home Screen)
- **الوصف:** إنشاء ملف `lib/features/home/screens/home_screen.dart` يستخدم `Scaffold` مع `CustomScrollView` لعمل خريطة قابلة للتمرير العمودي (Vertical scrolling map).
- **المدخلات:** ملف جديد.
- **المخرجات:** الهيكل الأساسي لشاشة الخريطة.
- **التحقق:** `flutter analyze lib/features/home/screens/home_screen.dart`
- **الحالة:** ☐

### P5-T002: إنشاء رسام خلفية الصحراء (Desert Background Painter)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/desert_background_painter.dart` يستخدم `CustomPainter` لرسم تدرج الكثبان الرملية (أعلى: السماء #87CEEB للنهار / #1A1A2E لليل، أسفل: الرمل #F4D03F للنهار / #2C2C54 لليل).
- **المدخلات:** ملف أداة جديد (Widget).
- **المخرجات:** خلفية متدرجة للصحراء.
- **التحقق:** `flutter analyze lib/features/home/widgets/desert_background_painter.dart`
- **الحالة:** ☐

### P5-T003: إنشاء أداة النخلة (Palm Tree Widget)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/palm_tree_widget.dart` يعرض شجرة نخل (SVG) مع حركة تمايل خفيفة (2000ms loop, SineInOut).
- **المدخلات:** ملف SVG للنخلة.
- **المخرجات:** نخلة متحركة في الواحة.
- **التحقق:** `flutter analyze lib/features/home/widgets/palm_tree_widget.dart`
- **الحالة:** ☐

### P5-T004: إنشاء أداة عقدة الواحة (Oasis Node Widget)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/oasis_node.dart` كعقدة دائرية (60x60) بثلاث حالات: مقفلة (رمادية + أيقونة قفل)، نشطة (نبض مشع بتكبير 1.2x)، مكتملة (ذهبية + 3 نجوم).
- **المدخلات:** ملف أداة جديد.
- **المخرجات:** عقدة تمثل مرحلة في الخريطة.
- **التحقق:** `flutter analyze lib/features/home/widgets/oasis_node.dart`
- **الحالة:** ☐

### P5-T005: إنشاء مسار الصحراء (Desert Path Painter)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/desert_path.dart` يستخدم `CustomPainter` لرسم مسار منحني (Curved path) يربط بين العقد (Nodes).
- **المدخلات:** مسافات ومواقع العقد.
- **المخرجات:** خط مسار متصل.
- **التحقق:** `flutter analyze lib/features/home/widgets/desert_path.dart`
- **الحالة:** ☐

### P5-T006: إنشاء أداة شخصية الصقر (Falcon Mascot Widget)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/falcon_mascot.dart` لعرض الصقر (200x200) مع حركة طفو (Floating animation) (2000ms loop, SineInOut للأعلى/الأسفل 10px).
- **المدخلات:** صورة شخصية الصقر.
- **المخرجات:** شخصية متحركة على الخريطة.
- **التحقق:** `flutter analyze lib/features/home/widgets/falcon_mascot.dart`
- **الحالة:** ☐

### P5-T007: إنشاء عداد نقاط الخبرة (XP Counter Widget)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/xp_counter.dart` كشريط علوي (Top bar) يعرض إجمالي نقاط الخبرة (XP) مع أيقونة نجمة.
- **المدخلات:** ملف أداة جديد.
- **المخرجات:** عداد النقاط.
- **التحقق:** `flutter analyze lib/features/home/widgets/xp_counter.dart`
- **الحالة:** ☐

### P5-T008: إنشاء مؤشر الحماس (Streak Indicator Widget)
- **الوصف:** إنشاء ملف `lib/features/home/widgets/streak_indicator.dart` يعرض أيقونة لهب مع عدد أيام الاستمرار (Streak count).
- **المدخلات:** ملف أداة جديد.
- **المخرجات:** مؤشر الحماس.
- **التحقق:** `flutter analyze lib/features/home/widgets/streak_indicator.dart`
- **الحالة:** ☐

### P5-T009: إنشاء مزود حالة الخريطة (Map Provider)
- **الوصف:** إنشاء ملف `lib/features/home/logic/map_provider.dart` لتوفير قائمة العقد (Nodes) وحالتها بناءً على تقدم الدروس (LessonProgress) المخزن في Hive.
- **المدخلات:** قاعدة بيانات Hive.
- **المخرجات:** مزود بيانات الخريطة.
- **التحقق:** `flutter analyze lib/features/home/logic/map_provider.dart`
- **الحالة:** ☐

### P5-T010: ربط العقد بشاشة الدرس (Wire Node to Lesson Screen)
- **الوصف:** برمجة النقر على العقدة للتنقل (Navigate) إلى شاشة الدرس إذا كانت العقدة غير مقفلة أو نشطة (Unlocked/Active).
- **المدخلات:** شاشة الخريطة والموجه.
- **المخرجات:** تنقل سليم للدروس.
- **التحقق:** فحص كود التوجيه في شاشة الخريطة.
- **الحالة:** ☐

### P5-T011: إضافة سلوك التمرير التلقائي (Snap-to-Active-Node Scroll)
- **الوصف:** إضافة سلوك التمرير التلقائي في `CustomScrollView` للقفز إلى موقع العقدة النشطة حالياً عند فتح الخريطة.
- **المدخلات:** شاشة الخريطة، وحدة التحكم بالتمرير.
- **المخرجات:** تمرير تلقائي مريح.
- **التحقق:** تجربة التمرير بعد الفتح.
- **الحالة:** ☐

### P5-T012: إضافة تبديل وضع النهار/الليل (Day/Night Mode Toggle)
- **الوصف:** إضافة منطق لتبديل وضع النهار والليل في الخريطة بناءً على التوقيت المحلي للجهاز (6 صباحاً إلى 6 مساءً = نهار).
- **المدخلات:** مكتبة الوقت، مزود حالة الخريطة.
- **المخرجات:** واجهة تتفاعل مع الوقت الحقيقي.
- **التحقق:** مراجعة كود التوقيت في الشاشة.
- **الحالة:** ☐

### P5-T013: الاختبار الشامل على الجهاز (Test Home Map on Device)
- **الوصف:** تشغيل التطبيق على جهاز فعلي للتحقق من ظهور الخريطة، عملية التمرير، وأن العقد قابلة للنقر بشكل صحيح.
- **المدخلات:** جهاز فعلي / محاكي.
- **المخرجات:** خريطة تعمل بشكل مثالي.
- **التحقق:** التجربة اليدوية على الجهاز.
- **الحالة:** ☐
