# 🎼 Maestro + Flash — بروتوكول التدقيق الشامل لفصيح الصغار

> **المايسترو (Pro/Coordinator):** يخطط ويحلل فقط — لا يفتح المتصفح أبدًا.
> **Flash (browser subagent):** ذراع التنفيذ الثقيلة — يتولى كل فتح متصفح وتصوير.

---

## 🔑 بيانات التطبيق الثابتة

| المعلومة | القيمة |
|---|---|
| اسم التطبيق | فصيح الصغار (Faseeh Kids) |
| Package Name | `com.faseeh.kids` |
| Git Repo | `https://github.com/tparty335-coder/faseeh-kids.git` |
| RevenueCat App ID | `app4d38703f65` (Custom URL Scheme: `rc-4d38703f65`) |
| Firebase Project | `faseeh-kids` (فصيح كيدز) |
| Play Console App | Faseeh Kids — package `com.faseeh.kids` |
| RevenueCat Dashboard | `https://app.revenuecat.com/apps/app4d38703f65` |
| Crashlytics | `https://console.firebase.google.com/project/faseeh-kids/crashlytics` |

---

## 📋 جدول Checkpoints

| CP | المنصة | المهمة | الحالة |
|---|---|---|---|
| CP-1 | Play Console | قائمة المنتجات + Product IDs (Subscriptions) | ⬜ |
| CP-2 | Play Console | أسعار لكل دولة (EG / SA / US) + العملة الأساسية | ⬜ |
| CP-3 | Play Console | Payment profile + Base currency | ⬜ |
| CP-4 | Play Console | إحصائيات الاشتراكات والإيراد (Subscriptions report) | ⬜ |
| CP-5 | RevenueCat | Offerings + Packages + Products — كل شيء مكوّن؟ | ⬜ |
| CP-6 | RevenueCat | Entitlements — كل المنتجات مربوطة بـ premium_access؟ | ⬜ |
| CP-7 | RevenueCat | Revenue Charts + Conversion rate | ⬜ |
| CP-8 | RevenueCat | App config → Service Account JSON — هل هناك أخطاء؟ | ⬜ |
| CP-9 | Firebase | DAU/MAU + Retention (Analytics) | ⬜ |
| CP-10 | Firebase | Events + Funnel (paywall_shown → purchase_complete) | ⬜ |
| CP-11 | Firebase | Crashlytics — top crashes + affected versions | ⬜ |
| CP-12 | Firebase | Remote Config — كل القيم الحالية | ⬜ |

> **قاعدة الاستمرارية:** إذا انتهت الكوتة، سجّل آخر CP مكتمل. عند العودة ابدأ من CP التالي فورًا.

---

## 🚀 كيف يطلق المايسترو Flash subagent

```python
invoke_subagent(
    TypeName="browser",
    Model="flash",
    Role="Platform Auditor",
    Prompt="[مهمة Flash المفصّلة — انظر القسم أدناه]"
)
```

**قبل إطلاق أي Flash:** أخبر المستخدم بالمنصة المطلوبة وانتظر منه "جاهز" أو "تم تسجيل الدخول".

---

## 📝 قوالب مهام Flash المفصّلة

### Flash #1 — Google Play Console (CP-1 → CP-4)

```
Navigate to: https://play.google.com/console
App: Faseeh Kids — com.faseeh.kids

STEP 1: Monetize → Products → Subscriptions
- List ALL product IDs with status (active/inactive)
- Screenshot the full list

STEP 2: Open each subscription product:
- Base price + currency
- Price for Egypt (EGP), Saudi Arabia (SAR), USA (USD)
- Is auto-convert enabled?

STEP 3: Setup → Payments profile
- What is the base currency?
- Payment profile country?

STEP 4: Monetize → Subscriptions → Dashboard / Reports
- Current active subscribers count
- Revenue last 30 days
- Churn rate if visible

Report ALL findings. Take screenshots of each section.
Completion: When you have data for all 4 steps above.
```

### Flash #2 — RevenueCat Offerings + Entitlements (CP-5 → CP-6)

```
Navigate to: https://app.revenuecat.com/apps/app4d38703f65

STEP 1: Product catalog → Offerings
- List all offering IDs and their status (default/inactive)
- For each offering: list the packages inside it (monthly/annual/lifetime)
- For each package: what product ID is attached?
- Screenshot offerings page

STEP 2: Product catalog → Entitlements
- Is there an entitlement named "premium_access" or similar?
- Are ALL subscription products attached to it?
- Screenshot entitlements page

STEP 3: Product catalog → Products
- List all products and their store product IDs
- Any products with errors or warnings?

Report all findings and any mismatches between Play Console IDs and RevenueCat products.
Completion: When you have full data on Offerings, Entitlements, and Products.
```

### Flash #3 — RevenueCat Revenue + Config (CP-7 → CP-8)

```
Navigate to: https://app.revenuecat.com/apps/app4d38703f65

STEP 1: Analytics → Charts
- MRR (Monthly Recurring Revenue) — last 30 days
- Conversion rate (trial → paid if applicable)
- Churn rate
- Screenshot charts

STEP 2: Apps → Faseeh Kids (Play Store) → App settings
- Is there a Service Account JSON uploaded?
- Are there any error/warning banners?
- Screenshot the app config page

STEP 3: Integrations → check for Firebase/Slack integrations
- Are any integrations configured?

Report all findings including any errors or missing configuration.
Completion: When you have revenue data and config check done.
```

### Flash #4 — Firebase Analytics + Funnels (CP-9 → CP-10)

```
Navigate to: https://console.firebase.google.com/project/faseeh-kids/analytics

STEP 1: Dashboard
- DAU and MAU for last 30 days
- Retention D1, D7, D30
- Screenshot dashboard

STEP 2: Events
- List top 10 events by count
- Is "paywall_shown" event present?
- Is "purchase_complete" or "in_app_purchase" event present?
- Screenshot events list

STEP 3: If Funnel analysis available:
- Create or view funnel: paywall_shown → purchase_complete
- What is the conversion rate?

Report all findings.
Completion: When you have DAU/MAU + events list + funnel data.
```

### Flash #5 — Firebase Crashlytics + Remote Config (CP-11 → CP-12)

```
STEP 1: Navigate to: https://console.firebase.google.com/project/faseeh-kids/crashlytics
- List top 5 crashes by event count
- For each crash: title, affected versions, event count, users affected
- Is "GoRouterDelegate.pop" crash still showing? (Known issue — was fixed in 1.0.4+5)
- Screenshot crash list

STEP 2: Navigate to: https://console.firebase.google.com/project/faseeh-kids/config
- List ALL Remote Config parameters with their current values
- Any parameters related to paywall, features, or pricing?
- Screenshot the config table

Report all findings including whether the known crash is resolved.
Completion: When you have crash list + remote config values.
```

---

## 🧠 قواعد المايسترو

1. **لا تفتح المتصفح أبدًا** — كل فتح متصفح يذهب لـ Flash
2. **حد أقصى Flash واحد في نفس الوقت** (تعارض المتصفح)
3. **إذا عاد Flash بـ 429 أو BLOCKED:** انتظر 10-15 دقيقة ثم أطلق subagent جديدًا
4. **نتائج Flash غير موثّقة** حتى تؤكدها BROWSER_HOST_FACTS في السيستم
5. **حدّث جدول Checkpoints** بعد كل CP مكتمل: ⬜ → ✅ أو ❌
6. **إذا نفدت الكوتة:** سجّل CP الأخير المكتمل + ما وجدته حتى الآن
7. **لا تعطي المستخدم أرقامًا أو بيانات** إلا بعد التحقق من BROWSER_HOST_FACTS

---

## 📊 قالب تقرير المايسترو النهائي

```markdown
## تقرير التدقيق — فصيح الصغار
**التاريخ:** [DATE]
**الإصدار المدقق:** [VERSION]

### CP-1: منتجات Play Console
- [بيانات]

### CP-2: الأسعار
- [بيانات]

... (بقية CPs)

### 🔴 مشاكل حرجة
- [قائمة]

### 🟡 تحذيرات
- [قائمة]

### ✅ كل شيء يعمل
- [قائمة]

### 📋 توصيات
1. [توصية]
```

---

*آخر تحديث: نوفمبر 2026 | الإصدار: 1.0*
