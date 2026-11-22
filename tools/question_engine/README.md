# 🎓 محرك توليد أسئلة الحروف العربية
## Arabic Letters Question Generator Engine

> محرك Python يولّد أسئلة تعليمية **لا نهائية** لجميع الحروف العربية الـ 28، بـ 11 نوعاً مختلفاً من التمارين.

---

## 🚀 الاستخدام السريع

```bash
# الانتقال للمجلد
cd tools/question_engine

# توليد 5 أسئلة حركات لحرف الباء
python3.12 cli.py --letter ب --type harakat --count 5

# ورقة عمل كاملة لحرف الميم (كل أنواع التمارين)
python3.12 cli.py --letter م --worksheet

# اختبار قياس مستوى للوحدة الأولى
python3.12 cli.py --unit 1 --exam

# توليد لا نهائي (يتوقف بـ Ctrl+C)
python3.12 cli.py --infinite --count 20

# تصدير كل الحروف الـ 28 دفعة واحدة
python3.12 cli.py --all --format json
```

---

## 📋 أنواع التمارين الـ 11

| # | الكود | النوع | الوصف |
|---|-------|-------|-------|
| 1 | `tracing` | 🖊️ تتبع الحرف | تتبع المسار المفرّغ بالنقطة الصفراء والأسهم — المواضع الأربعة |
| 2 | `matching` | 🔵 صل الصورة بالحرف | توصيل الصورة بالحرف الذي تبدأ به |
| 3 | `find_color` | 🔍 ابحث ولوّن | البحث عن الحرف بين حروف مختلطة وتلوينه |
| 4 | `positions` | 🔗 مواضع الحرف | الحرف في أول/وسط/آخر الكلمة (متصل ومنفصل) |
| 5 | `harakat` | 🏷️ اختر الحركة | اختيار الحركة الصحيحة (فتحة/ضمة/كسرة) |
| 6 | `scramble` | 🧩 رتّب الحروف | ترتيب حروف الكلمة حسب الصورة |
| 7 | `word_build` | 📝 ركّب كلمة | تركيب الكلمة من حروف مفرّقة |
| 8 | `fill_blank` | ✏️ الحرف الناقص | إكمال الكلمة بالحرف الناقص |
| 9 | `classify` | 📊 صنّف الكلمات | تصنيف الكلمات حسب حرف البداية + الغريب في المجموعة |
| 10 | `similar` | 👁️ الحروف المتشابهة | تمييز الحروف المتشابهة (ب/ت/ث، س/ش، إلخ) |
| 11 | `sentence` | 📖 كوّن جملة | ترتيب كلمات الجملة وإكمالها |

---

## 🏗️ هيكل المشروع

```
question_engine/
├── engine.py              ← المحرك الرئيسي (نقطة الدخول)
├── cli.py                 ← واجهة سطر الأوامر
├── run_tests.py           ← 31 اختبار (100% ناجح)
├── data/
│   ├── letters.py         ← الحروف الـ 28 بجميع أشكالها ومجموعاتها
│   └── vocabulary.py      ← 280+ كلمة موزعة على جميع الحروف
├── generators/
│   ├── tracing.py         ← المولّد 1
│   ├── matching.py        ← المولّد 2
│   ├── find_color.py      ← المولّد 3
│   ├── positions.py       ← المولّد 4
│   ├── harakat.py         ← المولّد 5
│   ├── scramble.py        ← المولّد 6
│   ├── word_build.py      ← المولّد 7
│   ├── fill_blank.py      ← المولّد 8
│   ├── classify.py        ← المولّد 9
│   ├── similar.py         ← المولّد 10
│   └── sentence_build.py  ← المولّد 11
├── exporters/
│   └── json_export.py     ← تصدير JSON للتطبيق
└── output/
    └── json/              ← 28 ورقة عمل + اختبارات الوحدات
```

---

## 🔌 الاستخدام كـ API (Python)

```python
import sys; sys.path.insert(0, 'tools/question_engine')
import engine

# سؤال واحد من أي نوع
q = engine.generate_question('ب', 'harakat')

# ورقة عمل كاملة لحرف
ws = engine.generate_worksheet('م', count_each=5)

# اختبار وحدة (100 درجة، 5 مهام)
exam = engine.generate_unit_exam(1, questions_per_type=5)

# خطة علاجية للطالب الضعيف
plan = engine.generate_remedial_plan('س', weakness_types=['harakat', 'positions'])

# توليد لا نهائي
questions = engine.generate_infinite(letter='ت', q_type='scramble', count=100)
```

---

## 📊 التحقق

```bash
python3.12 run_tests.py
# TOTAL: 31 | PASS: 31 | FAIL: 0  ✅
```

---

## 🗂️ الربط بالخطة التعليمية

هذا المحرك مصمم ليتكامل مع [الخطة العلمية لتعليم الحروف](../../خطة_تعليم_الحروف.md):
- **الوحدة 1** (ا ب ت ث ج ح خ): `--unit 1`
- **الوحدة 2** (د ذ ر ز س ش ص): `--unit 2`
- **الوحدة 3** (ض ط ظ ع غ ف ق): `--unit 3`
- **الوحدة 4** (ك ل م ن ه و ي): `--unit 4`
