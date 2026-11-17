# دليل نشر وأصول متجر Google Play — تطبيق فصيح الصغار (`Faseeh Kids`)

وثيقة مرجعية سريعة لأي مطور أو وكيل يبحث عن ملفات المتجر، إعدادات الإصدار، وملخص جاهزية التطبيق.

## 1. بيانات التطبيق التقنية

- **اسم التطبيق في النظام (`AndroidManifest.xml`):** `فصيح الصغار`
- **معرّف الحزمة (`applicationId` / `namespace`):** `com.faseeh.kids`
- **إعدادات Android (`android/app/build.gradle`):**
  - `minSdk = 24`
  - `compileSdk = 36`
  - `targetSdk = 36`
  - تفعيل تقليص الكود والموارد: `minifyEnabled = true`, `shrinkResources = true`
  - التوقيع: `signingConfigs.release` باستخدام `android/key.properties` و `android/app/upload-keystore.jks`

## 2. مواقع الأصول الرسومية المعتمدة

تُحفظ جميع صور المتجر تحت المجلد `play_store_assets/` (مفهرسة أيضًا في [`../play_store_assets/README.md`](../play_store_assets/README.md)):

| الملف | المسار | الأبعاد | الحجم |
|---|---|---:|---:|
| أيقونة المتجر | `play_store_assets/icon_512x512.png` | `512 × 512` | `411,126` بايت |
| البانر الترويجي | `play_store_assets/feature_graphic_1024x500.png` | `1024 × 500` | `459,805` بايت |
| لقطة 1 | `play_store_assets/screenshots/screenshot_01_home.png` | `1080 × 1920` | `1,781,467` بايت |
| لقطة 2 | `play_store_assets/screenshots/screenshot_02_letters_map.png` | `1080 × 1920` | `1,001,948` بايت |
| لقطة 3 | `play_store_assets/screenshots/screenshot_03_letter_lesson.png` | `1080 × 1920` | `631,936` بايت |
| لقطة 4 | `play_store_assets/screenshots/screenshot_04_coloring.png` | `1080 × 1920` | `529,598` بايت |
| لقطة 5 | `play_store_assets/screenshots/screenshot_05_parent_dashboard.png` | `1080 × 1920` | `953,136` بايت |

كما تم تحديث الأيقونة التكيفية والأساسية داخل المشروع (`assets/images/ui/app_logo.webp`, `android/app/src/main/res/mipmap-*/ic_launcher.png`, `android/app/src/main/res/drawable-*/ic_launcher_foreground.png`, و`android/app/src/main/res/values/ic_launcher_background.xml`) لإزالة الحواف البيضاء وضمان تطابق أيقونة اللانشر على الأجهزة مع أيقونة الصقر الذهبي.

## 3. حزم البناء الصادرة

- **حزمة النشر على Google Play Console (`.aab`):**
  - `build/app/outputs/bundle/release/app-release.aab` (`223,117,996` بايت / `212.8 MB`).
  - يتضمن الملف `2,919` ملفًا صوتيًا ضمن `base/assets` (`156.61 MB` مضغوطة)، و`26.12 MB` عبر جميع معماريات `base/lib` (`arm64-v8a`, `armeabi-v7a`, `x86_64`)، بينما تبقى `30.32 MB` لرموز التصحيح و`3.80 MB` لخريطة ProGuard في `BUNDLE-METADATA/` ولا تُحمَّل للمستخدم النهائي.
  - تم التحقق من التوقيع عبر `jarsigner -verify -certs`: `jar verified.` (`META-INF/UPLOAD.SF`).
- **نسخة المراجعة والاختبار الشامل (`APK`):**
  - `build/faseeh_kids_all_unlocked_review.apk` (`231,402,824` بايت / `220.7 MB`) بوضع `unlockAllLettersForReview = true` وتم تثبيتها بنجاح على جهاز `HVA63BT9` (`TB350XU`).

## 4. نصوص مقترحة لصفحة المتجر (Google Play Listing Copy)

- **اسم التطبيق (App Name):** `فصيح الصغار — تعلّم الحروف العربية`
- **الوصف المختصر (Short Description — 78 حرفًا):**
  `تعلّم الحروف العربية الـ٢٨ بالصوت الفصيح والقصص والألعاب والتلوين بدون إعلانات`
- **الفئة والعمر المستهدف:** التعليم (`Education`) • للأطفال من `3` إلى `10` سنوات • خالٍ من الإعلانات.
- **الوصف الكامل (Full Description):**
  > رحلة ممتعة وآمنة لتعليم الأطفال اللغة العربية الفصحى من حرف الألف حتى حرف الياء (`28` حرفًا)!
  >
  > يقدّم تطبيق **فصيح الصغار** تجربة تعليمية تفاعلية متكاملة بإشراف الصقر **فصيح**:
  > - **خريطة الواحات التفاعلية:** مسار متدرج يشوّق الطفل لاكتشاف الحروف الـ`28` خطوة بخطوة.
  > - **قصص وأناشيد مصورة:** حكايات هادفة وأناشيد مسموعة تنمّي الاستماع والمفردات.
  > - **أصوات الحروف والحركات والمدود:** نطق فصيح واضح للفتحة والضمة والكسرة والسكون والمد بالألف والواو والياء مع أمثلة مصورة.
  > - **التتبع والكتابة بالقلم:** تعليم رسم كل حرف في أول ووسط وآخر الكلمة ومنفصلًا بخطوات موجهة.
  > - **٥ ألعاب تفاعلية وتلوين:** خلية النحل، صيد الحروف، السيرك، مطابقة الكلمات، والتلوين الذكي.
  > - **بيئة آمنة للطفل:** ١٠٠٪ بدون إعلانات مع بوابة أبوية وإعدادات متابعة في لوحة الوالدين.

## 5. سجل التحقق النهائي

- **الصوتيات والأصول:** `2,919` ملف MP3 مفهرسة في `lib/core/constants/audio_manifest.dart` و`lib/core/audio_clip_durations.dart`؛ و`0` مجلدات مفقودة في `pubspec.yaml` (`249` إدخال أصول صوتية مقابل `222` مجلدًا على القرص).
- **التحليل الساكن (`flutter analyze`):** `0` أخطاء (`7` تحذيرات `unused_element` سابقة غير مؤثرة على حقل `_maddAudio`).
- **الاختبارات (`flutter test`):** اجتياز `619/619` اختبارًا (`All tests passed!`).
- **فهرس المعرفة (`graphify update .`):** تم التحديث (`7024` عقدة، `9473` رابطًا، `314` مجتمعًا).
