# ═══════════════════════════════════════════════════════════════════
# دستور فصيح — FASEEH LETTER LESSON CONSTITUTION v1.0
# الوثيقة المرجعية النهائية لبناء دروس الحروف العربية
# ═══════════════════════════════════════════════════════════════════
#
# هذه الوثيقة هي القانون الأعلى. أي إيجنت (Gemini, Claude, GPT,
# Copilot, أو أي نموذج آخر) يجب أن يلتزم بكل سطر فيها حرفياً.
# لا اجتهاد. لا هلوسة. لا افتراضات. البناء بموجب هذا الدستور فقط.
#
# آخر تحديث: 2026-08-19
# المشروع: D:\Projects\faseeh_kids
# ═══════════════════════════════════════════════════════════════════

---

## القسم ٠ — هوية المشروع (لا تُنشئ مشروعاً جديداً أبداً)

> **تحذير حرج:**
> **هذا مشروع Flutter قائم ومبني ويعمل.**
> لا تُنشئ `main.dart` جديداً. لا تُنشئ `pubspec.yaml` جديداً.
> لا تُنشئ `AudioManager` أو `AudioService` جديداً. كل هذا موجود.
> مهمتك الوحيدة: إضافة ملفات الدرس الجديد داخل البنية القائمة.

```
المشروع:      faseeh_kids
المسار:       D:\Projects\faseeh_kids
اللغة:        Dart / Flutter
SDK:          ^3.6.2
الحالة:       يبني وينشئ APK بنجاح (exit code 0)
```

---

## القسم ١ — البنية المعمارية القائمة (ممنوع تغييرها)

### ١.١ الخدمات الموجودة — استخدمها كما هي

| الخدمة | المسار | الاستخدام |
|--------|--------|-----------|
| `AudioService` | `lib/services/audio_service.dart` | **Singleton.** `AudioService.instance.playAsset(path)` |
| `AudioManager` | `lib/services/audio_manager.dart` | طبقة أعلى فوق AudioService لأصوات الحروف |
| `AudioRegistry` | `lib/services/audio_registry.dart` | خريطة مسارات الصوت لكل حرف |
| `AppColors` | `lib/core/theme/app_colors.dart` | ثوابت الألوان العامة |
| `AppRouter` | `lib/core/router/app_router.dart` | نظام التنقل (go_router) |
| `LessonProvider` | `lib/features/lessons/logic/lesson_provider.dart` | إدارة حالة الدرس (Riverpod) |

### ١.٢ واجهة AudioService — القواعد الصارمة

```dart
// ✅ الطريقة الصحيحة الوحيدة لتشغيل الصوت:
await AudioService.instance.playAsset(
  'audio/lessons/baa/short/baa_11.mp3',       // المسار نسبي من assets/
  channel: AudioChannel.voice,                 // voice | sfx | bgm
);

// ✅ إيقاف الصوت:
await AudioService.instance.stop();            // يوقف كل القنوات
await AudioService.instance.stop(channel: AudioChannel.voice); // قناة واحدة

// ❌ ممنوع مطلقاً:
// AudioManager.instance.speak(...)           — لا تستخدم TTS
// AudioPlayer().play(...)                    — لا تنشئ player مباشر
// just_audio / assets_audio_player          — لا تضف مكتبات صوت جديدة
```

### ١.٣ المكتبات المتاحة (لا تضف مكتبات جديدة بدون إذن)

```yaml
flutter_riverpod: ^2.4.9     # State management
audioplayers: ^5.2.1         # Audio (عبر AudioService فقط)
flutter_animate: ^4.2.0      # Declarative animations
confetti: ^0.7.0             # Celebration particle effects
flutter_svg: ^2.0.9          # SVG rendering
path_drawing: ^1.0.1         # Path/stroke drawing
google_fonts: ^6.2.1         # Cairo font
shimmer: ^3.0.0              # Loading effects
```

### ١.٤ هيكل الملفات — أين تضع ملفات الدرس

```
lib/features/lessons/screens/{letter_key}/
├── {letter_key}_lesson_screen.dart      # الشاشة الرئيسية (PageView + NavBar)
├── {letter_key}_train_navbar.dart       # قطار التنقل السفلي
├── {letter_key}_objectives_station.dart # المحطة ٠: الأهداف
├── {letter_key}_story_station.dart      # المحطة ١: قصة الحرف
├── {letter_key}_sounds_station.dart     # المحطة ٢: أصوات الحرف والمدود
├── {letter_key}_writing_station.dart    # المحطة ٣: كتابة الحرف
├── {letter_key}_words_station.dart      # المحطة ٤: كلمات الحرف
├── {letter_key}_games_station.dart      # المحطة ٥: الألعاب والأنشطة
├── {letter_key}_data.dart              # نموذج البيانات (LetterLessonData)
└── {letter_key}_colors.dart            # ألوان الدرس المستخرجة من الأسطوانة

assets/images/lessons/{letter_key}/      # صور المشاهد الأصلية (JPG/PNG)
assets/audio/lessons/{letter_key}/       # أصوات بشرية أصلية (MP3)
├── long/                                # مقاطع طويلة (قصص، شروحات)
├── medium/                              # مقاطع متوسطة (جمل، كلمات مع سياق)
└── short/                               # مقاطع قصيرة (حروف، حركات، مدح)
```

**مثال:** لحرف الباء، `{letter_key}` = `baa`

---

## القسم ٢ — نموذج البيانات المُهيكل (TYPE-SAFE)

> **ممنوع `Map<String, dynamic>` مطلقاً.** كل بيانات الدرس تُعرَّف بـ classes مُحددة النوع.

### ٢.١ ملف `{letter_key}_data.dart`

```dart
// ═══ lib/features/lessons/screens/baa/baa_data.dart ═══

/// نموذج صفحة الأصوات
enum SoundPageType {
  letterOnly,     // عرض الحرف فقط
  harakaFatha,    // حرف + فتحة
  harakaDamma,    // حرف + ضمة
  harakaKasra,    // حرف + كسرة
  harakaSukoon,   // حرف + سكون
  word,           // حرف + كلمة مع صورة
  maddTitle,      // عنوان "الحرف الممدود"
  maddAlif,       // مد بالألف
  maddWaw,        // مد بالواو
  maddYaa,        // مد بالياء
}

class SoundPageData {
  final SoundPageType type;
  final String letter;          // 'بَ' أو 'بُو' إلخ
  final String? word;           // 'بَقَرَة' — null إذا لم يكن صفحة كلمة
  final String? emoji;          // '🐄' — fallback بصري
  final String audioPath;       // مسار الصوت الكامل
  final Color color;            // لون الحركة

  const SoundPageData({
    required this.type,
    required this.letter,
    this.word,
    this.emoji,
    required this.audioPath,
    required this.color,
  });
}

class WordData {
  final String word;            // 'بَقَرَة' — مع التشكيل الكامل
  final String emoji;           // '🐄'
  final String audioPath;       // مسار صوت الكلمة
  final String letterPosition;  // 'أول' | 'وسط' | 'آخر'
  final String haraka;          // 'فتحة' | 'كسرة' | 'ضمة' | 'مد'

  const WordData({
    required this.word,
    required this.emoji,
    required this.audioPath,
    required this.letterPosition,
    required this.haraka,
  });
}

class GameChoiceData {
  final String text;            // الكلمة أو اسم الصورة
  final String emoji;           // الرمز البصري
  final bool isCorrect;         // هل هي الإجابة الصحيحة؟

  const GameChoiceData({
    required this.text,
    required this.emoji,
    required this.isCorrect,
  });
}

class GameData {
  final String title;           // 'صيد الكلمات'
  final String instruction;     // 'اضغط على الكلمة التي بها حرف ب'
  final String bgImagePath;     // مسار صورة الخلفية
  final Color themeColor;       // لون اللعبة
  final List<GameChoiceData> choices;

  const GameData({
    required this.title,
    required this.instruction,
    required this.bgImagePath,
    required this.themeColor,
    required this.choices,
  });
}

/// البيانات الكاملة لدرس حرف واحد
class LetterLessonData {
  final String letter;          // 'ب'
  final String letterName;      // 'الباء'
  final String letterKey;       // 'baa' — مفتاح المجلدات
  final Color letterColor;      // اللون الأساسي للحرف

  final List<String> objectives;           // أهداف الدرس التربوية
  final List<SoundPageData> soundPages;    // صفحات محطة الأصوات
  final List<WordData> words;              // كلمات محطة المفردات
  final List<GameData> games;              // ألعاب محطة الأنشطة

  final String storyText;                  // نص القصة الكامل مع التشكيل
  final String storyAudioPath;             // صوت القصة

  // مسارات الصور الأصلية لكل محطة
  final String storyBgPath;
  final String soundsBgPath;
  final String writingBgPath;
  final String wordsBgPath;
  final String wheelBgPath;

  const LetterLessonData({
    required this.letter,
    required this.letterName,
    required this.letterKey,
    required this.letterColor,
    required this.objectives,
    required this.soundPages,
    required this.words,
    required this.games,
    required this.storyText,
    required this.storyAudioPath,
    required this.storyBgPath,
    required this.soundsBgPath,
    required this.writingBgPath,
    required this.wordsBgPath,
    required this.wheelBgPath,
  });
}
```

---

## القسم ٣ — الألوان (مستخرجة بالقطّارة من الأسطوانة)

> **كل لون يُعرَّف مرة واحدة فقط في `{letter_key}_colors.dart`.**
> لا ألوان inline. لا `Color(0xFF...)` مبعثرة في widgets.

### ٣.١ ألوان الأسطوانة الأصلية (ثابتة لجميع الحروف)

```dart
// ═══ ألوان مشتركة بين كل الدروس ═══
class LessonColors {
  LessonColors._();

  // الشريط العلوي
  static const topBar = Color(0xFF4A1010);           // عنّابي داكن
  static const topBarText = Colors.white;

  // خلفيات طبيعية
  static const sky = Color(0xFF87CEEB);              // أزرق سماوي
  static const grass = Color(0xFF5CB85C);            // أخضر عشبي
  static const forestTrees = Color(0xFF2D6A2D);      // أخضر غابة
  static const treeTrunk = Color(0xFF5C3317);        // بني جذع

  // بطاقة الحرف
  static const cardBackground = Color(0xFFFFFDE7);   // كريمي فاتح
  static const cardBorderGreen = Color(0xFF66BB6A);  // حد أخضر منقّط
  static const cardRope = Color(0xFFD4A017);         // حبل ذهبي

  // نصوص
  static const titleText = Color(0xFF424242);        // رمادي داكن
  static const wordText = Color(0xFFF48FB1);         // وردي
  static const highlightedLetter = Color(0xFFFFD700);// ذهبي

  // أهداف
  static const objectivesCircle = Color(0xFFFFD740); // دائرة صفراء
  static const objectivesTitle = Color(0xFFE91E8C);  // عنوان وردي
  static const objectivesText = Color(0xFF1565C0);   // نص أزرق

  // بطاقة كلمات
  static const cardRedBorder = Color(0xFFC62828);    // حد أحمر
  static const cardWordText = Color(0xFF1565C0);     // نص أزرق

  // أزرار
  static const speakerButton = Color(0xFFF57C00);    // برتقالي
  static const navButton = Color(0xFFF5DEB3);        // قمحي
  static const nextButton = Color(0xFFFF9800);        // برتقالي

  // ردود الفعل
  static const correctFlash = Color(0xFFFFD700);     // ذهبي 30%
  static const wrongFlash = Color(0xFFFF0000);       // أحمر 40%

  // حركات
  static const fathaColor = Color(0xFFE53935);       // أحمر
  static const dammaColor = Color(0xFFFF6F00);       // برتقالي
  static const kasraColor = Color(0xFF1E88E5);       // أزرق
  static const sukoonColor = Color(0xFF757575);      // رمادي
  static const maddAlifColor = Color(0xFF8E24AA);    // بنفسجي
  static const maddWawColor = Color(0xFFD81B60);     // وردي غامق
  static const maddYaaColor = Color(0xFF00897B);     // أخضر مزرق
}
```

---

## القسم ٤ — المحطات الست (STATIONS)

كل درس حرف يتكون من **6 محطات** بالترتيب التالي:

| الترتيب | المحطة | الوصف |
|---------|--------|-------|
| 0 | الأهداف | قائمة الأهداف التربوية + بطة + سحابة |
| 1 | قصة الحرف | مشهد طبيعي + قصة مسموعة + تفاعل |
| 2 | أصوات الحرف والمدود | شجرة مجوفة + بطاقة معلّقة + حركات/مدود |
| 3 | كتابة الحرف | كراسة + قلم متحرك + لوحة تتبع |
| 4 | كلمات الحرف | بنت + شرائط ملونة منزلقة |
| 5 | الألعاب والأنشطة | وردة خماسية → 5 ألعاب مصغرة |

### ٤.١ المحطة ٠ — الأهداف

- خلفية: صورة أصلية أو gradient (sky + grass + palm)
- دائرة بيضاوية صفراء (#FFD740) تحتوي قائمة الأهداف
- بطة كرتونية على اليسار (صورة أصلية أو emoji 🦆 مع تسمية)
- سحابة بيضاء أعلى اليسار: "هيّا نقرأ اللغة العربية"
- الأهداف تظهر واحداً تلو الآخر مع صوت التعليق

### ٤.٢ المحطة ١ — قصة الحرف

- خلفية المشهد الأصلي (مرعى، بقرة، بطة، بركة)
- فقاعة نص بيضاء شفافة مع حد أخضر (#81C784)
- نص القصة بالتشكيل الكامل، خط Cairo، حجم 20
- زر "استمع للقصة" يشغل الصوت البشري الأصلي
- نقاط تفاعلية (hotspots) على الحيوانات
- نافذة مكافأة (🎉 أَحْسَنْتَ!) عند التفاعل الصحيح

### ٤.٣ المحطة ٢ — أصوات الحرف والمدود

- خلفية الغابة الأصلية (شجرة مجوّفة)
- **بطاقة الحرف المعلّقة** — تتأرجح كبندول (انظر القسم ٥)
- شريط اختيار أفقي للحركات (7 خيارات)
- عند تغيير الحركة: **الحركة تطير** من الزاوية إلى الحرف
- عند صفحة كلمة: **الصورة تنبثق** + **الكلمة تنزلق**
- كل تغيير يشغل الصوت الأصلي تلقائياً

### ٤.٤ المحطة ٣ — كتابة الحرف

- خلفية كراسة مسطرة
- **شخصية القلم الأصفر** — تلوّح ثم تتحرك لترسم
- حرف شفاف (guide) في الخلفية، حجم 140
- **لوحة رسم تفاعلية** — GestureDetector + CustomPaint
- 4 أشكال: مستقل (ب)، أول (بـ)، وسط (ـبـ)، آخر (ـب)
- **أسهم وردية** تظهر اتجاه الكتابة
- بعد رسم خطين: صوت مدح "أحسنت!"

### ٤.٥ المحطة ٤ — كلمات الحرف

- لوحة خشبية "كلمات الحرف" مع أوراق شجر
- **بطاقة حمراء الحد**: 🔊 + صورة يسار + كلمة يمين
- الحرف ب **مُظلّل بالأحمر** (#C62828) داخل الكلمة
- **شرائط ملونة منزلقة** — كل كلمة في شريط ملون
- الضغط على الكلمة يشغل صوتها

### ٤.٦ المحطة ٥ — الألعاب والأنشطة (5 ألعاب)

| # | اللعبة | اللون | المطلوب |
|---|--------|-------|---------|
| 1 | صيد الكلمات | #D32F2F | أسماك sine wave + سلة + نجوم |
| 2 | خلية الحرف | #00ACC1 | نحلة + خيارات حركات |
| 3 | لعبة الكلمات | #F57C00 | مطابقة كلمة-صورة drag/tap |
| 4 | التلوين | #1976D2 | "اضغط على الكلمة التي بها مد" + زرافة |
| 5 | السيرك | #C2185B | مهرجة + 3 صور + أضواء مسرحية |

---

## القسم ٥ — مواصفات الرسوم المتحركة (13 رسماً)

> **لا شيء ثابت. كل شيء يتحرك ويتنفس.**

### ٥.١ بندول بطاقة الحرف
```
Duration: 3000ms, Curve: easeInOut
Rotation: -0.05 to +0.05 radians, looping forever
Alignment: topCenter (نقطة التعليق)
```

### ٥.٢ حركة طائرة (فتحة/ضمة/كسرة تطير إلى الحرف)
```
Start: Offset(-200, -200), End: Offset(0, 0)
Duration: 800ms, Curve: elasticOut
Scale: 0.0 → 1.2 → 1.0
```

### ٥.٣ انبثاق الصورة في الشجرة المجوفة
```
Scale: 0.0 → 1.3 → 1.0
Duration: 600ms, Curve: bounceOut
Delay: 200ms بعد تغيير الصفحة
```

### ٥.٤ انزلاق الكلمة من الأسفل
```
Start: Offset(0, 100), End: Offset(0, 0)
Duration: 500ms, Curve: easeOutCubic
Delay: 400ms بعد ظهور الصورة
Fade: 0.0 → 1.0
```

### ٥.٥ فراشات طائرة حول البطاقة
```
مسار دائري/بيضاوي مع اهتزاز عشوائي
Duration: 4000ms للدورة الكاملة
Opacity: 0.7-1.0
```

### ٥.٦ شخصية القلم المتحركة
```
مرحلة 1: تلويح يد (800ms)
مرحلة 2: انتقال أفقي (600ms, easeInOut)
مرحلة 3: رسم الحرف stroke-by-stroke (2000ms)
مرحلة 4: احتفال (scale bounce 400ms)
```

### ٥.٧ رسم الحرف خطوة بخطوة
```
CustomPainter + Path + PathMetric
خط أزرق #1565C0 سمك 10
أسهم وردية #F48FB1 لاتجاه الرسم
```

### ٥.٨ أسماك سابحة
```
أفقي: عرض الشاشة، Duration: 4000-7000ms عشوائي
عمودي: sin(t), amplitude: 30px, period: 2000ms
السمكة تنقلب أفقياً عند تغيير الاتجاه
```

### ٥.٩ احتفال الإجابة الصحيحة
```
1. Scale bounce: 1.0 → 1.4 → 1.0 (400ms)
2. 8 نجوم ذهبية من المركز (800ms) — confetti package
3. وميض شاشة: #FFD700 شفافية 30% (200ms)
4. صوت: baa_5.mp3 (أحسنت)
```

### ٥.١٠ اهتزاز الإجابة الخاطئة
```
1. اهتزاز أفقي: ±15px, 5 دورات (400ms)
2. وميض: #FF0000 شفافية 40% (200ms)
3. صوت: baa_77.mp3 (حاول مرة أخرى)
```

### ٥.١١ انتقال الصفحات
```
انزلاق RTL, Duration: 350ms, Curve: easeInOutCubic
```

### ٥.١٢ تفاعل الضغط على عربة القطار
```
scale: 1.0 → 0.9 → 1.0 (150ms)
العربة النشطة: مرتفعة + توهج
```

### ٥.١٣ تنفّس البطة (idle)
```
Offset Y: ±5px, Duration: 2000ms, يتكرر للأبد
```

---

## القسم ٦ — قواعد الصوت

### ٦.١ القواعد الصارمة

```
القاعدة ١: كل صوت يُشغَّل عبر AudioService.instance.playAsset() فقط.
القاعدة ٢: قبل تشغيل صوت جديد → await AudioService.instance.stop() أولاً.
القاعدة ٣: المسار نسبي من assets/ — لا تبدأ بـ assets/ ولا بـ /.
           ✅ 'audio/lessons/baa/short/baa_11.mp3'
           ❌ 'assets/audio/lessons/baa/short/baa_11.mp3'
القاعدة ٤: في dispose() دائماً أوقف الصوت.
القاعدة ٥: إذا فشل الصوت — صمت (لا crash).
القاعدة ٦: channel: AudioChannel.sfx لمؤثرات (أحسنت/خطأ).
القاعدة ٧: channel: AudioChannel.voice للأصوات التعليمية.
```

### ٦.٢ الأصوات الرئيسية لحرف الباء

| المعرف | المسار | المحتوى |
|--------|--------|---------|
| قصة | `audio/lessons/baa/long/baa_1.mp3` | قصة الحرف كاملة |
| فتحة | `audio/lessons/baa/short/baa_11.mp3` | بَ |
| ضمة | `audio/lessons/baa/short/baa_12.mp3` | بُ |
| كسرة | `audio/lessons/baa/short/baa_13.mp3` | بِ |
| سكون | `audio/lessons/baa/short/baa_15.mp3` | بْ |
| مد ألف | `audio/lessons/baa/medium/baa_28.mp3` | بَا |
| مد واو | `audio/lessons/baa/medium/baa_42.mp3` | بُو |
| مد ياء | `audio/lessons/baa/medium/baa_44.mp3` | بِي |
| أحسنت | `audio/lessons/baa/short/baa_5.mp3` | مدح |
| حاول | `audio/lessons/baa/short/baa_77.mp3` | حاول مرة أخرى |
| كتابة | `audio/lessons/baa/medium/baa_51.mp3` | توجيه الكتابة |
| بِنْت | `audio/lessons/baa/short/baa_17.mp3` | كلمة بنت |

---

## القسم ٧ — قواعد النص والخط

```
١. كل نص عربي: fontFamily: 'Cairo'
٢. كل النصوص: textDirection: TextDirection.rtl
٣. أحجام الخطوط المعيارية:
   - عرض الحرف الرئيسي:     fontSize: 120, w900
   - عرض الحرف في البطاقة:   fontSize: 64,  bold
   - نص الكلمة مع التشكيل:   fontSize: 56,  w700
   - عناوين الأقسام:         fontSize: 32,  w800
   - النص العادي:            fontSize: 20,  bold
   - أزرار التنقل:           fontSize: 16,  bold
٤. كل كلمة عربية مع التشكيل الكامل:
   ✅ 'بَقَرَة'  'بِطِّيخ'  'بِنْت'
   ❌ 'بقرة'    'بطيخ'    'بنت'
```

---

## القسم ٨ — معالجة الأصول (Asset Fallback)

> **التطبيق يجب أن يعمل بشكل مثالي حتى مع غياب كل الصور.**

```dart
// لكل صورة — errorBuilder إلزامي:
Image.asset(
  imagePath,
  fit: BoxFit.cover,
  errorBuilder: (_, __, ___) => _buildFallback(),
)

// Fallback ليس مجرد Container ملون!
// Fallback = gradient مناسب + emoji كبير + تسمية عربية

// خلفية طبيعية:
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF87CEEB), Color(0xFF5CB85C)], // سماء + عشب
    ),
  ),
)

// شخصية حيوان:
Column(children: [
  Text('🐄', style: TextStyle(fontSize: 48)),
  Text('بَقَرَة', style: TextStyle(fontFamily: 'Cairo', fontSize: 16)),
])
```

---

## القسم ٩ — قواعد التكامل (INTEGRATION)

### ٩.١ ربط الدرس بالتطبيق

```dart
// في universal_letter_hub_screen.dart:
if (letter.letter == 'ب') {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => const BaaLessonScreen()),
  );
} else {
  // fallback للحروف غير المبنية بعد
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => const LessonSequenceScreen()),
  );
}
```

### ٩.٢ تسجيل الأصول في pubspec.yaml

```yaml
- assets/images/lessons/{letter_key}/
- assets/audio/lessons/{letter_key}/long/
- assets/audio/lessons/{letter_key}/medium/
- assets/audio/lessons/{letter_key}/short/
```

### ٩.٣ قواعد الاستيراد

```dart
// ✅ مسموح:
import 'package:flutter/material.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';

// ❌ ممنوع: أي مكتبة غير موجودة في pubspec.yaml
```

---

## القسم ١٠ — بوابات الجودة (QUALITY GATES)

> **لا يُنشر أي كود حتى يجتاز كل البوابات.**

### البوابة ١ — الاكتمال
- [ ] لا يوجد `// TODO` في أي ملف
- [ ] كل function مكتملة التنفيذ

### البوابة ٢ — البناء
```bash
flutter analyze    # 0 errors, 0 warnings
flutter build apk --debug    # exit code 0
```

### البوابة ٣ — الحركة (13 رسماً من القسم ٥)
- [ ] بندول البطاقة يتأرجح
- [ ] الحركات تطير إلى الحرف
- [ ] الصور تنبثق + الكلمات تنزلق
- [ ] احتفال صحيح (نجوم + bounce)
- [ ] اهتزاز خاطئ (shake + وميض)
- [ ] أسماك sine wave

### البوابة ٤ — الصوت
- [ ] كل حركة لها صوت مختلف
- [ ] لا crash عند غياب ملف صوت

### البوابة ٥ — البصريات
- [ ] ألوان من القسم ٣
- [ ] Cairo font + تشكيل كامل + RTL
- [ ] Fallback ذكي لكل صورة

### البوابة ٦ — إذن المستخدم
- [ ] لا تثبيت على الجهاز بدون إذن صريح

---

## القسم ١١ — قالب التكرار (لكل حرف جديد)

```
الخطوة ١: استلم الأسطوانة/الفيديو الأصلي
الخطوة ٢: استخرج الأصول (صور + أصوات) من SWF/EXE
الخطوة ٣: أنشئ {key}_data.dart (type-safe)
الخطوة ٤: أنشئ {key}_colors.dart
الخطوة ٥: أنشئ المحطات الست
الخطوة ٦: أنشئ {key}_lesson_screen.dart
الخطوة ٧: أنشئ {key}_train_navbar.dart
الخطوة ٨: سجّل الأصول في pubspec.yaml
الخطوة ٩: اربط بـ universal_letter_hub_screen.dart
الخطوة ١٠: flutter analyze — 0 errors
الخطوة ١١: flutter build apk --debug — exit code 0
الخطوة ١٢: اعرض على المستخدم للمراجعة
```

---

## القسم ١٢ — الأصول المتاحة لحرف الباء

### صور (11 ملف)
```
baa_story.jpg (80KB)    baa_sounds.jpg (48KB)   baa_writing.jpg (57KB)
baa_words.jpg (56KB)    baa_wheel.jpg (63KB)    baa_madd.jpg (68KB)
baa_fishing.jpg (90KB)  baa_bee.jpg (61KB)      baa_drag_words.jpg (71KB)
baa_coloring.jpg (60KB) baa_circus.jpg (42KB)
```

### أصوات (98 ملف)
```
long/    3 ملفات   — قصة كاملة، شروحات طويلة
medium/ 30 ملف    — كلمات مع سياق، تعليمات
short/  55 ملف    — حركات، مدح، أخطاء، فواصل
```

---

> **هذا الدستور هو المرجع الوحيد. أي قرار تقني يتعارض معه — مرفوض.**
