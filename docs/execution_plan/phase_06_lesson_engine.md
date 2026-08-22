# المرحلة السادسة: محرك الدروس (Lesson Engine)

### P6-T001: إنشاء أنواع الأنشطة (ActivityType Enum)
- **الوصف:** إنشاء ملف `lib/features/lessons/models/activity_type.dart` يحتوي على التعداد (Enum): `multipleChoice`, `dragAndDrop`, `coloring`, `voiceRecording`, `soundToImage`, `letterOrdering`, `fingerTracing`, `storytelling`, `fillInBlank`, `phonemicAwareness`, `letterForms`, `diacriticsPractice`.
- **المدخلات:** ملف نموذج جديد.
- **المخرجات:** أنواع الأنشطة محددة.
- **التحقق:** `flutter analyze lib/features/lessons/models/activity_type.dart`
- **الحالة:** ☐

### P6-T002: إنشاء إعدادات الدرس (LessonConfig Model)
- **الوصف:** إنشاء ملف `lib/features/lessons/models/lesson_config.dart` كفئة (Class) تحدد تسلسل الأنشطة لدرس معين، وتتضمن حقول: `lessonId`, `unitId`, `ageGroup`, والقائمة `List<ActivityConfig> activities`.
- **المدخلات:** ملف نموذج جديد.
- **المخرجات:** هيكل إعدادات الدرس.
- **التحقق:** `flutter analyze lib/features/lessons/models/lesson_config.dart`
- **الحالة:** ☐

### P6-T003: إنشاء إعدادات النشاط (ActivityConfig Model)
- **الوصف:** إنشاء ملف `lib/features/lessons/models/activity_config.dart` كفئة (Class) تحتوي على: `activityType`, `targetLetter`, `options`, `correctAnswer`, `durationSeconds`, `masteryThreshold`.
- **المدخلات:** ملف نموذج جديد.
- **المخرجات:** هيكل إعدادات النشاط.
- **التحقق:** `flutter analyze lib/features/lessons/models/activity_config.dart`
- **الحالة:** ☐

### P6-T004: إنشاء شاشة مشغل الدرس (LessonRunner Screen)
- **الوصف:** إنشاء ملف `lib/features/lessons/screens/lesson_runner_screen.dart` لتنسيق عرض الأنشطة بشكل متسلسل مع شريط تقدم (Progress bar).
- **المدخلات:** شاشة جديدة، نماذج الأنشطة.
- **المخرجات:** واجهة إدارة الدروس.
- **التحقق:** `flutter analyze lib/features/lessons/screens/lesson_runner_screen.dart`
- **الحالة:** ☐

### P6-T005: إنشاء قالب النشاط الأساسي (Activity Shell Widget)
- **الوصف:** إنشاء ملف `lib/features/lessons/widgets/activity_shell.dart` كغلاف مشترك يحتوي على: مؤقت، شريط تقدم، زر تلميحات الصقر، وزر الخروج.
- **المدخلات:** ملف أداة جديد.
- **المخرجات:** قالب موحد للأنشطة.
- **التحقق:** `flutter analyze lib/features/lessons/widgets/activity_shell.dart`
- **الحالة:** ☐

### P6-T006: إنشاء نشاط الاختيار من متعدد (Multiple Choice Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/multiple_choice_activity.dart` يعرض 3-4 خيارات (صور أو نص). عند اختيار الإجابة الصحيحة يظهر توهج أخضر + صوت، وعند الخطأ يحدث اهتزاز خفيف (Gentle shake 400ms, 3x, 10px) + صوت رياح.
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** واجهة ومنطق الاختيار من متعدد.
- **التحقق:** `flutter analyze lib/features/lessons/activities/multiple_choice_activity.dart`
- **الحالة:** ☐

### P6-T007: إنشاء نشاط السحب والإفلات (Drag and Drop Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/drag_and_drop_activity.dart` يتضمن عناصر قابلة للسحب ومناطق إفلات، مع حركة تثبيت (Snap animation) عند الوضع الصحيح.
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** واجهة السحب والإفلات.
- **التحقق:** `flutter analyze lib/features/lessons/activities/drag_and_drop_activity.dart`
- **الحالة:** ☐

### P6-T008: إنشاء نشاط تتبع الإصبع (Finger Tracing Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/finger_tracing_activity.dart` يعرض مسار حرف باستخدام `CustomPainter`، ويتتبع انحراف الإصبع (تجاوز النشاط إذا كان الانحراف أقل من 15%).
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** نشاط كتابة الحروف.
- **التحقق:** `flutter analyze lib/features/lessons/activities/finger_tracing_activity.dart`
- **الحالة:** ☐

### P6-T009: إنشاء نشاط مطابقة الصوت بالصورة (Sound to Image Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/sound_to_image_activity.dart` لتشغيل ملف صوتي وعرض 4 صور للطفل لينقر على الصورة المطابقة.
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** نشاط المطابقة.
- **التحقق:** `flutter analyze lib/features/lessons/activities/sound_to_image_activity.dart`
- **الحالة:** ☐

### P6-T010: إنشاء نشاط ترتيب الحروف (Letter Ordering Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/letter_ordering_activity.dart` يعرض حروفاً مبعثرة لسحبها وترتيبها في الكلمة الصحيحة.
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** نشاط الترتيب.
- **التحقق:** `flutter analyze lib/features/lessons/activities/letter_ordering_activity.dart`
- **الحالة:** ☐

### P6-T011: إنشاء نشاط ملء الفراغ (Fill in Blank Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/fill_in_blank_activity.dart` يعرض جملة ينقصها حرف أو كلمة، ويسحب الطفل الخيار الصحيح إلى الفراغ.
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** نشاط الإكمال.
- **التحقق:** `flutter analyze lib/features/lessons/activities/fill_in_blank_activity.dart`
- **الحالة:** ☐

### P6-T012: إنشاء نشاط الوعي الصوتي (Phonemic Awareness Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/phonemic_awareness_activity.dart` يقوم بتشغيل صوت كلمة، وينقر الطفل مرة واحدة لكل مقطع صوتي (نقر إيقاعي).
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** نشاط المقاطع الصوتية.
- **التحقق:** `flutter analyze lib/features/lessons/activities/phonemic_awareness_activity.dart`
- **الحالة:** ☐

### P6-T013: إنشاء نشاط التدريب على التشكيل (Diacritics Practice Activity)
- **الوصف:** إنشاء ملف `lib/features/lessons/activities/diacritics_practice_activity.dart` لتمكين الطفل من سحب الحركة الصحيحة (فتحة، كسرة، ضمة، سكون) ووضعها على الحرف.
- **المدخلات:** ملف نشاط جديد.
- **المخرجات:** نشاط التشكيل.
- **التحقق:** `flutter analyze lib/features/lessons/activities/diacritics_practice_activity.dart`
- **الحالة:** ☐

### P6-T014: إنشاء متتبع الإتقان (Mastery Tracker)
- **الوصف:** إنشاء ملف `lib/features/lessons/logic/mastery_tracker.dart` لتتبع صحة الإجابات لكل نشاط، وحساب ما إذا تم الوصول إلى حد الإتقان (Mastery threshold).
- **المدخلات:** ملف منطق جديد.
- **المخرجات:** منطق تقييم الإتقان.
- **التحقق:** `flutter analyze lib/features/lessons/logic/mastery_tracker.dart`
- **الحالة:** ☐

### P6-T015: إنشاء مزود حالة الدرس (Lesson Provider)
- **الوصف:** إنشاء ملف `lib/features/lessons/logic/lesson_provider.dart` كـ Riverpod Provider لإدارة حالة الدرس، مؤشر النشاط الحالي، والنتيجة (Score).
- **المدخلات:** حزمة Riverpod، ملفات الأنشطة.
- **المخرجات:** مزود تحكم شامل في سير الدرس.
- **التحقق:** `flutter analyze lib/features/lessons/logic/lesson_provider.dart`
- **الحالة:** ☐

### P6-T016: إنشاء شاشة الاحتفال (Celebration Screen)
- **الوصف:** إنشاء ملف `lib/features/lessons/screens/celebration_screen.dart` يعرض انفجار قصاصات ورقية (Confetti explosion)، ودوران نجمة ذهبية، وحركة احتفال للصقر، مع زر 'متابعة'.
- **المدخلات:** شاشة جديدة ومؤثرات بصرية.
- **المخرجات:** شاشة نهاية الدرس.
- **التحقق:** `flutter analyze lib/features/lessons/screens/celebration_screen.dart`
- **الحالة:** ☐

### P6-T017: ربط إكمال الدرس بقاعدة البيانات (Wire Lesson Completion)
- **الوصف:** ربط إنهاء الدرس بعملية حفظ نتيجة الأنشطة (ActivityResult) في Hive، تحديث تقدم الدرس (LessonProgress)، التحقق من الإتقان، وفتح العقدة التالية (Unlock next node).
- **المدخلات:** مزود حالة الدرس ومزود الخريطة وقاعدة البيانات.
- **المخرجات:** تحديث البيانات تلقائياً بعد الإكمال.
- **التحقق:** مراجعة دالة الإكمال في `LessonProvider`.
- **الحالة:** ☐

### P6-T018: الاختبار الشامل لمحرك الدروس (Test Complete Lesson Flow)
- **الوصف:** تشغيل التطبيق على جهاز فعلي للتحقق من دورة درس كاملة (5 أنشطة متعاقبة → شاشة الاحتفال → العودة للخريطة).
- **المدخلات:** جهاز فعلي / محاكي.
- **المخرجات:** درس يعمل بدون أعطال.
- **التحقق:** التجربة اليدوية على الجهاز.
- **الحالة:** ☐
