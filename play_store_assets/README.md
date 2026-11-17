# حزمة متجر Google Play — تطبيق فصيح الصغار (`com.faseeh.kids`)

يضم هذا المجلد جميع أصول المتجر الرسمية المعتمدة وجاهزة للرفع مباشرةً إلى **Google Play Console**.

## 1. الملفات الرسومية واللقطات (`7` ملفات PNG)

| العنصر | المسار النسبي | الأبعاد (px) | الحجم (Bytes) | الاستخدام في Play Console |
|---|---|---:|---:|---|
| أيقونة التطبيق | `icon_512x512.png` | `512 × 512` | `411,126` | App icon (بدون حواف بيضاء / Full-bleed) |
| الصورة المميزة | `feature_graphic_1024x500.png` | `1024 × 500` | `459,805` | Feature graphic |
| لقطة 1 — خريطة الواحات | `screenshots/screenshot_01_home.png` | `1080 × 1920` | `1,781,467` | Phone / Tablet screenshots |
| لقطة 2 — القصص المصورة | `screenshots/screenshot_02_letters_map.png` | `1080 × 1920` | `1,001,948` | Phone / Tablet screenshots |
| لقطة 3 — أصوات الحروف والحركات | `screenshots/screenshot_03_letter_lesson.png` | `1080 × 1920` | `631,936` | Phone / Tablet screenshots |
| لقطة 4 — التتبع والكتابة بالقلم | `screenshots/screenshot_04_coloring.png` | `1080 × 1920` | `529,598` | Phone / Tablet screenshots |
| لقطة 5 — الألعاب والتلوين | `screenshots/screenshot_05_parent_dashboard.png` | `1080 × 1920` | `953,136` | Phone / Tablet screenshots |

> جميع اللقطات الخمس مبنية من شاشات تشغيل حقيقية للتطبيق (`v1.0.0+1`) بدقة `1080 × 1920` (`9:16`).

## 2. مخرجات البناء والنشر

- **حزمة النشر الرسمية لمتجر Google Play (`.aab`):**
  - المسار: `build/app/outputs/bundle/release/app-release.aab`
  - الحجم الكلي: `223,117,996` بايت (`212.8 MB`)
  - التحقق من التوقيع: موقّع بمفتاح الإصدار الرسمي (`META-INF/UPLOAD.SF`, تم التحقق عبر `jarsigner -verify`)
  - إعداد فتح المراحل: `unlockAllLettersForReview = false`
- **نسخة المراجعة المفتوحة بالكامل (`APK`):**
  - المسار: `build/faseeh_kids_all_unlocked_review.apk`
  - الحجم: `231,402,824` بايت (`220.7 MB`)
  - إعداد فتح المراحل: `unlockAllLettersForReview = true` (مخصصة للاختبار والمراجعة الشاملة لجميع الحروف الـ `28`، ومثبتة على التابلت `HVA63BT9`)

راجع الدليل الكامل للنشر وبيانات المتجر في [`../docs/PLAY_STORE_ASSETS.md`](../docs/PLAY_STORE_ASSETS.md).
