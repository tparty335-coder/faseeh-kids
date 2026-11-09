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

/// مواصفات محطة أصوات الحرف
class VowelsSpec {
  final String letterChar; // 'أ' / 'ب' / 'ت' ...
  final List<VowelItem> items;
  const VowelsSpec({required this.letterChar, required this.items});
}

// ─── المدود (حركات طويلة) ────────────────────────────────────────────────────

/// عنصر مد واحد
class MaddItem {
  final String displayChar; // 'بَا' / 'بِي' / 'بُو'
  final String audioPath;
  final String imagePath;
  const MaddItem({
    required this.displayChar,
    required this.audioPath,
    required this.imagePath,
  });
}

/// مواصفات محطة المدود
class MaddSpec {
  final String letterChar;
  final List<MaddItem> items;
  const MaddSpec({required this.letterChar, required this.items});
}

// ─── كتابة الحرف ─────────────────────────────────────────────────────────────

/// مواصفات محطة الكتابة والتتبع
class TracingSpec {
  final String letterChar;
  final List<String> stepImagePaths; // صور مراحل رسم الحرف
  final String audioIntroPath;
  const TracingSpec({
    required this.letterChar,
    required this.stepImagePaths,
    required this.audioIntroPath,
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

/// جولة لعبة صيد الكلمات
class FishingRound {
  final String word;
  final String imagePath;
  final String audioPath;
  final bool isCorrect; // هذه الكلمة تبدأ بحرف الدرس؟
  const FishingRound({
    required this.word,
    required this.imagePath,
    required this.audioPath,
    required this.isCorrect,
  });
}

/// جولة لعبة خلية النحل
class BeehiveRound {
  final String word;
  final String imagePath;
  final String audioPath;
  const BeehiveRound({
    required this.word,
    required this.imagePath,
    required this.audioPath,
  });
}

/// جولة لعبة السيرك
class CircusRound {
  final String word;
  final String imagePath;
  final String audioPath;
  const CircusRound({
    required this.word,
    required this.imagePath,
    required this.audioPath,
  });
}

/// زوج لعبة مطابقة الكلمات
class WordsMatchPair {
  final String word;
  final String imagePath;
  final String audioPath;
  const WordsMatchPair({
    required this.word,
    required this.imagePath,
    required this.audioPath,
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
  const ColoringRound({
    required this.word,
    required this.bgImagePath,
    required this.wordRevealImagePath,
    required this.introAudioPath,
    required this.revealAudioPath,
    required this.slices,
  });
}

/// مواصفات الألعاب الخمس كاملة
class GamesSpec {
  final List<FishingRound> fishing;
  final List<BeehiveRound> beehive;
  final List<CircusRound> circus;
  final List<WordsMatchPair> wordsMatch;
  final List<ColoringRound> coloring;
  const GamesSpec({
    required this.fishing,
    required this.beehive,
    required this.circus,
    required this.wordsMatch,
    required this.coloring,
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
