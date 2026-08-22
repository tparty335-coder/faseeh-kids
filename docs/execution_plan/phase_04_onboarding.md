# المرحلة الرابعة: تدفق التأهيل (Onboarding Flow)

### P4-T001: إنشاء شاشة البداية (Splash Screen)
- **الوصف:** إنشاء ملف `lib/features/onboarding/screens/splash_screen.dart` يمثل شاشة كاملة تحتوي على شعار التطبيق (بحجم 250x250 في المنتصف)، وحركة الصقر، ولون الخلفية من `AppColors.primary`، مع تأثير ظهور تدريجي (FadeIn animation) لمدة 800 ملي ثانية.
- **المدخلات:** موارد الشعار ومكتبات الألوان.
- **المخرجات:** ملف `splash_screen.dart`.
- **التحقق:** `flutter analyze lib/features/onboarding/screens/splash_screen.dart`
- **الحالة:** ☐

### P4-T002: إضافة مسار البداية في الموجه (Add Splash Route to GoRouter)
- **الوصف:** إضافة مسار شاشة البداية (Splash Route) إلى `GoRouter` كمسار ابتدائي (Initial Route) `/`.
- **المدخلات:** ملف `splash_screen.dart` وملف الموجه الأساسي.
- **المخرجات:** الموجه مضبوط للبدء من شاشة البداية.
- **التحقق:** فحص ملف الموجه.
- **الحالة:** ☐

### P4-T003: إضافة التنقل التلقائي (Auto-navigation)
- **الوصف:** إضافة تنقل تلقائي (Auto-navigation) من شاشة البداية إلى شاشة التأهيل بعد ثانيتين (أو إلى شاشة اختيار الملف الشخصي إذا كان المستخدم عائداً).
- **المدخلات:** ملف `splash_screen.dart` والموجه.
- **المخرجات:** منطق التنقل التلقائي مدمج.
- **التحقق:** فحص الكود الخاص بالتنقل في شاشة البداية.
- **الحالة:** ☐

### P4-T004: إنشاء شاشة التأهيل (Onboarding Screen)
- **الوصف:** إنشاء ملف `lib/features/onboarding/screens/onboarding_screen.dart` يحتوي على واجهة تصفح (PageView carousel) من 3 صفحات لشرح ميزات التطبيق. كل صفحة تحتوي على مساحة رسم توضيحي (60% من الارتفاع)، نص عنوان، نص فرعي، ومؤشرات نقاط الصفحة (Page indicator dots).
- **المدخلات:** ملف `onboarding_screen.dart` جديد.
- **المخرجات:** واجهة التأهيل مكتملة التصميم.
- **التحقق:** `flutter analyze lib/features/onboarding/screens/onboarding_screen.dart`
- **الحالة:** ☐

### P4-T005: إضافة زر بدء المغامرة (Add Start Adventure Button)
- **الوصف:** إضافة زر 'ابدأ المغامرة' (بحجم 200x56) في الصفحة الأخيرة من شاشة التأهيل، والذي ينقل المستخدم إلى شاشة اختيار العمر.
- **المدخلات:** ملف `onboarding_screen.dart`.
- **المخرجات:** زر تفاعلي في الصفحة الأخيرة.
- **التحقق:** مراجعة كود واجهة شاشة التأهيل.
- **الحالة:** ☐

### P4-T006: إنشاء شاشة اختيار العمر (Age Selection Screen)
- **الوصف:** إنشاء ملف `lib/features/onboarding/screens/age_selection_screen.dart` يحتوي على 3 بطاقات (بحجم 150x150 لكل منها) للفئات العمرية. كل بطاقة تعرض النطاق العمري والرسم التوضيحي، مع حركة تكبير (Scale animation) إلى 1.1x عند النقر (200 ملي ثانية).
- **المدخلات:** ملف الشاشة الجديد.
- **المخرجات:** شاشة تفاعلية لاختيار العمر.
- **التحقق:** `flutter analyze lib/features/onboarding/screens/age_selection_screen.dart`
- **الحالة:** ☐

### P4-T007: إنشاء شاشة اختيار الصورة الرمزية (Avatar Selection Screen)
- **الوصف:** إنشاء ملف `lib/features/onboarding/screens/avatar_selection_screen.dart` يحتوي على شبكة (Grid) بحجم 3x3 لخيارات الصور الرمزية (بحجم 80x80 لكل منها). الصورة المحددة تحصل على إطار ذهبي.
- **المدخلات:** ملف الشاشة الجديد وصور الأفاتار.
- **المخرجات:** شاشة اختيار الصور الرمزية.
- **التحقق:** `flutter analyze lib/features/onboarding/screens/avatar_selection_screen.dart`
- **الحالة:** ☐

### P4-T008: إنشاء شاشة إدخال الاسم (Name Input Screen)
- **الوصف:** إنشاء ملف `lib/features/onboarding/screens/name_input_screen.dart` يحتوي على حقل نصي باللغة العربية لاسم الطفل، وزر 'التالي'، مع التحقق من عدم ترك الحقل فارغاً (Validate non-empty).
- **المدخلات:** ملف الشاشة الجديد.
- **المخرجات:** شاشة إدخال الاسم.
- **التحقق:** `flutter analyze lib/features/onboarding/screens/name_input_screen.dart`
- **الحالة:** ☐

### P4-T009: إنشاء شاشة اختبار تحديد المستوى (Placement Test Screen)
- **الوصف:** إنشاء ملف `lib/features/onboarding/screens/placement_test_screen.dart` لاختبار تكيفي (Adaptive test) يتكون من 10 أسئلة، وشريط تقدم في الأعلى، ومؤقت لكل سؤال (5 ثوانٍ للبسيط / 15 ثانية للمركب).
- **المدخلات:** ملف الشاشة الجديد.
- **المخرجات:** واجهة اختبار تحديد المستوى.
- **التحقق:** `flutter analyze lib/features/onboarding/screens/placement_test_screen.dart`
- **الحالة:** ☐

### P4-T010: إنشاء خوارزمية تحديد المستوى (Placement Algorithm)
- **الوصف:** إنشاء ملف `lib/features/onboarding/logic/placement_algorithm.dart` لبرمجة الخوارزمية حيث الإجابة الصحيحة تزيد الوزن بمقدار +1.5، والخاطئة تنقصه بمقدار -1. النتيجة النهائية تحدد الوحدة الدراسية التي سيبدأ منها الطفل.
- **المدخلات:** ملف منطق جديد.
- **المخرجات:** خوارزمية تحديد المستوى.
- **التحقق:** `flutter analyze lib/features/onboarding/logic/placement_algorithm.dart`
- **الحالة:** ☐

### P4-T011: إنشاء مزود حالة التأهيل (Onboarding Provider)
- **الوصف:** إنشاء ملف `lib/features/onboarding/logic/onboarding_provider.dart` باستخدام `StateNotifier` من حزمة Riverpod لإدارة حالة تدفق التأهيل بالكامل.
- **المدخلات:** تثبيت حزمة Riverpod.
- **المخرجات:** مزود الحالة لتدفق التأهيل.
- **التحقق:** `flutter analyze lib/features/onboarding/logic/onboarding_provider.dart`
- **الحالة:** ☐

### P4-T012: ربط شاشات التأهيل في الموجه (Wire Onboarding Screens in GoRouter)
- **الوصف:** ربط جميع شاشات التأهيل في `GoRouter` مع حركات انتقال مناسبة (SlideFromRight, 300ms, FastOutSlowIn).
- **المدخلات:** الموجه والشاشات المنشأة.
- **المخرجات:** تنقل متكامل وسلس.
- **التحقق:** مراجعة ملف الموجه والتأكد من إضافة الانتقالات.
- **الحالة:** ☐

### P4-T013: إنشاء ملف شخصي للطفل (Create ChildProfile in Hive)
- **الوصف:** إضافة الكود اللازم لإنشاء `ChildProfile` في قاعدة بيانات `Hive` بعد اكتمال التأهيل.
- **المدخلات:** مزود حالة التأهيل وقاعدة بيانات Hive.
- **المخرجات:** ملف الطفل يُحفظ محلياً بنجاح.
- **التحقق:** فحص دالة الحفظ في نهاية التأهيل.
- **الحالة:** ☐

### P4-T014: التحقق الشامل من الكود (Run Flutter Analyze)
- **الوصف:** تشغيل أمر `flutter analyze` والتأكد من خلو المشروع من أي مشكلات (0 issues).
- **المدخلات:** المشروع بالكامل.
- **المخرجات:** تقرير فحص نظيف.
- **التحقق:** `flutter analyze`
- **الحالة:** ☐

### P4-T015: الاختبار على جهاز فعلي (Test Onboarding Flow on Device)
- **الوصف:** تشغيل التطبيق على جهاز فعلي للتحقق من عمل تدفق التأهيل بالكامل (End-to-End).
- **المدخلات:** جهاز فعلي / محاكي.
- **المخرجات:** التطبيق يعمل بسلاسة من البداية للنهاية.
- **التحقق:** التجربة اليدوية على الجهاز.
- **الحالة:** ☐
