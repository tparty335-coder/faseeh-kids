/// LetterUnitManifest — مخطط البيانات الصارم الأنواع لكل وحدة حرف من الحروف الـ 28
/// الاستخدام: كل حرف = ملف manifest واحد يُغذّي LetterLessonShellScreen
/// المبدأ: صفر تكرار كود — المحرك واحد، البيانات مختلفة
library;

import 'package:flutter/material.dart';

// ─── الأهداف ────────────────────────────────────────────────────────────────

/// أهداف الوحدة — ما سيتعلمه الطفل في هذا الدرس
class ObjectivesSpec {
  final List<String> objectives;
  final String audioPath; // audio/lessons/xxx/xxx_goal.mp3
  const ObjectivesSpec({required this.objectives, required this.audioPath});
}

// ─── قصة الحرف ──────────────────────────────────────────────────────────────

/// نوع تفاعل المشهد
sealed class StoryInteraction {
  const StoryInteraction();
}

/// تفاعل منطقة لمس (كأرنب الألف — اضغط على الشيء المخفي)
class HotspotInteraction extends StoryInteraction {
  /// النسب المئوية من حجم الشاشة (0.0–1.0)
  final double left;
  final double top;
  final double right;
  final double bottom;
  final String revealAudioPath;
  final String hintText;
  const HotspotInteraction({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.revealAudioPath,
    required this.hintText,
  });
}

/// تفاعل اختيار متعدد (كبقرة الباء — أي البيوت تبدأ بالباء؟)
class MultipleChoiceInteraction extends StoryInteraction {
  final String question;
  final List<String> choiceImagePaths;
  final List<bool> correctAnswers;
  final String correctAudioPath;
  final String wrongAudioPath;
  const MultipleChoiceInteraction({
    required this.question,
    required this.choiceImagePaths,
    required this.correctAnswers,
    required this.correctAudioPath,
    required this.wrongAudioPath,
  });
}

/// عنصر لمس تفاعلي داخل تمرين المشهد المصور
class StoryTargetItem {
  final String label; // مثلاً: 'بَيْت'
  final double left; // نسبة مئوية (0.0–1.0) من عرض الصورة
  final double top; // نسبة مئوية (0.0–1.0) من ارتفاع الصورة
  final double right;
  final double bottom;
  final bool isCorrect; // هل الإجابة صحيحة (تحتوي على الحرف المطلوب)
  final String? wordAudioPath; // صوت الكلمة عند الضغط عليها

  const StoryTargetItem({
    required this.label,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.isCorrect,
    this.wordAudioPath,
  });
}

/// تمرين البحث عن الكلمات التي تحتوي على الحرف والضغط عليها في المشهد المصور
class WordFindStoryInteraction extends StoryInteraction {
  final String? instructionText; // "تامر حوله عناصر كثيرة بها حرف التاء، ابحث عنها واضغط عليها"
  final String? instructionAudioPath;
  final String correctAudioPath; // صوت التشجيع عند الإجابة الصحيحة
  final String wrongAudioPath; // صوت المحاولة مرة أخرى عند الخطأ
  final List<StoryTargetItem> targets;

  const WordFindStoryInteraction({
    this.instructionText,
    this.instructionAudioPath,
    required this.correctAudioPath,
    required this.wrongAudioPath,
    required this.targets,
  });
}

/// مشهد واحد في قصة الحرف
class StoryScene {
  final String imagePath;
  final String audioPath;
  final StoryInteraction? interaction; // null = مشهد سردي عادي
  final bool isNasheed; // المشهد الأخير — نشيد الحرف
  final String? captionText; // نص وصفي يظهر أسفل الصورة
  const StoryScene({
    required this.imagePath,
    required this.audioPath,
    this.interaction,
    this.isNasheed = false,
    this.captionText,
  });
}

/// مواصفات قصة الحرف كاملة
class StorySpec {
  final List<StoryScene> scenes;
  const StorySpec({required this.scenes});
}

// ─── أصوات الحرف (حركات قصيرة) ──────────────────────────────────────────────

/// عنصر حركة قصيرة واحدة
class VowelItem {
  final String displayChar; // 'بَ' / 'بُ' / 'بِ'
  final String fathaAudio;
  final String dammaAudio;
  final String kasraAudio;
  const VowelItem({
    required this.displayChar,
    required this.fathaAudio,
    required this.dammaAudio,
    required this.kasraAudio,
  });
}

/// بطاقة صوت قصير غنية بالبيانات (للمحرك الموحّد بدءاً من الشين)
class VowelCardSpec {
  final String vowelName; // فَتْحَة / ضَمَّة / كَسْرَة / سُكُون
  final String displayForm; // شَ / شُ / شِ / شْ
  final String exampleWord; // شَمْس
  final String exampleEmoji;
  final String vowelAudio; // audio/letters/short_vowels/...
  final String fullRuleAudio; // نطق القاعدة من الأسطوانة (mov1..4)
  final String? wordAudio;
  final String? slideImagePath;
  const VowelCardSpec({
    required this.vowelName,
    required this.displayForm,
    required this.exampleWord,
    required this.exampleEmoji,
    required this.vowelAudio,
    required this.fullRuleAudio,
    this.wordAudio,
    this.slideImagePath,
  });
}

/// مواصفات محطة أصوات الحرف
class VowelsSpec {
  final String letterChar; // 'أ' / 'ب' / 'ت' ...
  final List<VowelItem> items;
  final List<VowelCardSpec>? cards;
  const VowelsSpec({
    required this.letterChar,
    required this.items,
    this.cards,
  });
}

// ─── المدود (حركات طويلة) ────────────────────────────────────────────────────

/// عنصر مد واحد
class MaddItem {
  final String displayChar; // 'بَا' / 'بِي' / 'بُو'
  final String audioPath;
  final String imagePath;
  final String? exampleWord;
  final String? explanation;
  final String? wordAudioPath;
  final Color? accentColor;
  const MaddItem({
    required this.displayChar,
    required this.audioPath,
    required this.imagePath,
    this.exampleWord,
    this.explanation,
    this.wordAudioPath,
    this.accentColor,
  });
}

/// مواصفات محطة المدود
class MaddSpec {
  final String letterChar;
  final List<MaddItem> items;
  final bool useManifestMadd;
  const MaddSpec({
    required this.letterChar,
    required this.items,
    this.useManifestMadd = false,
  });
}

// ─── كتابة الحرف ─────────────────────────────────────────────────────────────

/// موضع كتابة واحد مع مثاله وصورته وصوته
class TracingPositionSpec {
  final String position; // 'isolated', 'start', 'middle', 'end'
  final String title; // 'مُنْفَصِل' / 'فِي أَوَّلِ الْكَلِمَة' ...
  final String displayForm; // 'ش' / 'شـ' / 'ـشـ' / 'ـش'
  final String exampleWord;
  final String exampleEmoji;
  final String audioPath;
  final String? imagePath;
  const TracingPositionSpec({
    required this.position,
    required this.title,
    required this.displayForm,
    required this.exampleWord,
    required this.exampleEmoji,
    required this.audioPath,
    this.imagePath,
  });
}

/// مواصفات محطة الكتابة والتتبع
class TracingSpec {
  final String letterChar;
  final List<String> stepImagePaths; // صور مراحل رسم الحرف
  final String audioIntroPath;
  final List<TracingPositionSpec>? positions;
  const TracingSpec({
    required this.letterChar,
    required this.stepImagePaths,
    required this.audioIntroPath,
    this.positions,
  });
}

// ─── كلمات الحرف ─────────────────────────────────────────────────────────────

/// منطقة لمس المثلث (إحداثيات نسبية 0.0–1.0 من عرض/ارتفاع الصورة)
class WordHotspot {
  final double left;
  final double top;
  final double right;
  final double bottom;
  const WordHotspot({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });
}

/// كلمة واحدة في صفحة الكلمات
class WordItem {
  final String word; // الكلمة بالتشكيل
  final String cardImagePath; // صورة البطاقة المنبثقة
  final double cardHeight;
  final String audioPath;
  final WordHotspot hotspot; // موضع المثلث في صورة القائمة
  final Offset speakerOffset; // موضع زر السماعة في البطاقة (نسبي)
  final Offset closeOffset; // موضع زر الإغلاق في البطاقة (نسبي)
  const WordItem({
    required this.word,
    required this.cardImagePath,
    required this.cardHeight,
    required this.audioPath,
    required this.hotspot,
    required this.speakerOffset,
    required this.closeOffset,
  });
}

/// صفحة واحدة من صفحات كلمات الحرف
class WordsPage {
  final String listImagePath; // صورة قائمة الصفحة
  final double listImageHeight;
  final List<WordItem> words;
  const WordsPage({
    required this.listImagePath,
    required this.listImageHeight,
    required this.words,
  });
}

/// مواصفات محطة كلمات الحرف (5 صفحات لأ، 4 لب، ...)
class WordsSpec {
  final List<WordsPage> pages;
  const WordsSpec({required this.pages});
}

// ─── الألعاب ─────────────────────────────────────────────────────────────────

/// عنصر خيار/منطقة تفاعلية داخل الألعاب الموحدة
class GameZoneChoice {
  final String label;
  final bool isCorrect;
  final double px;
  final double py;
  final double w;
  final double h;
  final String? wordAudio;
  final int? colorValue;
  const GameZoneChoice({
    required this.label,
    required this.isCorrect,
    this.px = 0,
    this.py = 0,
    this.w = 220,
    this.h = 90,
    this.wordAudio,
    this.colorValue,
  });
}

/// جولة لعبة صيد الكلمات
class FishingRound {
  final String word;
  final String imagePath;
  final String audioPath;
  final bool isCorrect; // هذه الكلمة تبدأ بحرف الدرس؟
  final String? correctPraiseAudio;
  final String? roundEndPraiseAudio;
  final List<GameZoneChoice>? zones;
  final double imgW;
  final double imgH;
  const FishingRound({
    required this.word,
    required this.imagePath,
    required this.audioPath,
    required this.isCorrect,
    this.correctPraiseAudio,
    this.roundEndPraiseAudio,
    this.zones,
    this.imgW = 800,
    this.imgH = 490,
  });
}

/// جولة لعبة خلية النحل
class BeehiveRound {
  final String word;
  final String imagePath;
  final String audioPath;
  final String? praiseAudio;
  final List<GameZoneChoice>? cells;
  final double imgW;
  final double imgH;
  final double speakerPx;
  final double speakerPy;
  const BeehiveRound({
    required this.word,
    required this.imagePath,
    required this.audioPath,
    this.praiseAudio,
    this.cells,
    this.imgW = 800,
    this.imgH = 440,
    this.speakerPx = 502,
    this.speakerPy = 138,
  });
}

/// جولة لعبة السيرك
class CircusRound {
  final String word;
  final String imagePath;
  final String audioPath;
  final String? praiseAudio;
  final List<GameZoneChoice>? zones;
  final double imgW;
  final double imgH;
  const CircusRound({
    required this.word,
    required this.imagePath,
    required this.audioPath,
    this.praiseAudio,
    this.zones,
    this.imgW = 800,
    this.imgH = 456,
  });
}

/// زوج لعبة مطابقة الكلمات
class WordsMatchPair {
  final String word;
  final String imagePath;
  final String audioPath;
  final String? praiseAudio;
  final List<GameZoneChoice>? cards;
  final double imgW;
  final double imgH;
  final double cardPx;
  final List<double> cardPyList;
  final double dropPx;
  final double dropPy;
  const WordsMatchPair({
    required this.word,
    required this.imagePath,
    required this.audioPath,
    this.praiseAudio,
    this.cards,
    this.imgW = 800,
    this.imgH = 446,
    this.cardPx = 170,
    this.cardPyList = const [128, 236, 353],
    this.dropPx = 550,
    this.dropPy = 420,
  });
}

/// شريحة تلوين واحدة (قطعة من صورة الكلمة)
class ColoringSlice {
  final String maskImagePath; // صورة القناع الشفاف للشريحة
  final Color color; // اللون المطلوب تطبيقه
  const ColoringSlice({
    required this.maskImagePath,
    required this.color,
  });
}

/// جولة لعبة التلوين — كلمة واحدة مع شرائحها
class ColoringRound {
  final String word;
  final String bgImagePath; // الخلفية الأساسية للصورة
  final String wordRevealImagePath; // الكلمة ملوّنة باللون الأحمر بعد التلوين
  final String introAudioPath; // صوت الكلمة عند بدء الجولة
  final String revealAudioPath; // صوت الكلمة عند اكتمال التلوين
  final List<ColoringSlice> slices;
  final String? wrongRevealAudioPath;
  final String? wordAudioPath;
  final List<GameZoneChoice>? options;
  final double imgW;
  final double imgH;
  final double wordX;
  final double wordY;
  final double wordW;
  final double wordH;
  final double cardCx;
  final List<double> cardCyList;
  const ColoringRound({
    required this.word,
    required this.bgImagePath,
    required this.wordRevealImagePath,
    required this.introAudioPath,
    required this.revealAudioPath,
    required this.slices,
    this.wrongRevealAudioPath,
    this.wordAudioPath,
    this.options,
    this.imgW = 800,
    this.imgH = 450,
    this.wordX = 162,
    this.wordY = 175,
    this.wordW = 384,
    this.wordH = 125,
    this.cardCx = 68,
    this.cardCyList = const [94, 219, 347],
  });
}

/// مواصفات الألعاب الخمس كاملة
class GamesSpec {
  final List<FishingRound> fishing;
  final List<BeehiveRound> beehive;
  final List<CircusRound> circus;
  final List<WordsMatchPair> wordsMatch;
  final List<ColoringRound> coloring;
  final String? fishingIntroAudio;
  final String? fishingPromptAudio;
  final String? fishingWrongAudio;
  final String? beehivePromptAudio;
  final String? beehiveWrongAudio;
  final String? circusPromptAudio;
  final String? circusWrongAudio;
  final String? wordsMatchPromptAudio;
  final String? wordsMatchWrongAudio;
  final String? coloringIntroAudio;
  final String? coloringStep1Audio;
  final String? coloringStep2Audio;
  final String? coloringWrongAudio;
  final String? praiseFinishAudio;
  const GamesSpec({
    required this.fishing,
    required this.beehive,
    required this.circus,
    required this.wordsMatch,
    required this.coloring,
    this.fishingIntroAudio,
    this.fishingPromptAudio,
    this.fishingWrongAudio,
    this.beehivePromptAudio,
    this.beehiveWrongAudio,
    this.circusPromptAudio,
    this.circusWrongAudio,
    this.wordsMatchPromptAudio,
    this.wordsMatchWrongAudio,
    this.coloringIntroAudio,
    this.coloringStep1Audio,
    this.coloringStep2Audio,
    this.coloringWrongAudio,
    this.praiseFinishAudio,
  });
}

// ─── المانيفست الرئيسي ───────────────────────────────────────────────────────

/// المانيفست الكامل لوحدة حرف — يُغذّي LetterLessonShellScreen
class LetterUnitManifest {
  /// الحرف الأساسي (أ / ب / ت ...)
  final String letter;

  /// عنوان الوحدة الكامل بالتشكيل
  final String unitTitle;

  /// لون شريط العنوان العلوي
  final Color topBarColor;

  /// لون التمييز (badge لون الحرف)
  final Color highlightColor;

  /// إيموجي ماسكوت الحرف
  final String mascotEmoji;

  /// فهرس الوحدة (1 = الألف، 2 = الباء ...)
  final int unitIndex;

  final ObjectivesSpec objectives;
  final StorySpec story;
  final VowelsSpec vowels;
  final MaddSpec madd;
  final TracingSpec tracing;
  final WordsSpec words;
  final GamesSpec games;

  /// الحرف التالي لفتحه عند إتمام الدرس (null = آخر حرف)
  final String? nextLetter;

  const LetterUnitManifest({
    required this.letter,
    required this.unitTitle,
    required this.topBarColor,
    required this.highlightColor,
    required this.mascotEmoji,
    required this.unitIndex,
    required this.objectives,
    required this.story,
    required this.vowels,
    required this.madd,
    required this.tracing,
    required this.words,
    required this.games,
    this.nextLetter,
  });
}
