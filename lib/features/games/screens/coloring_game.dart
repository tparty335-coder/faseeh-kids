import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// لعبة التلوين التربوية: الطفل يلوّن حروف كلمة تحتوي على مدود
/// كل حرف يُلوَّن بلون مختلف أو بلون واحد — مما يعزز التركيز البصري على المد
class ColoringGame extends ConsumerStatefulWidget {
  const ColoringGame({super.key});

  @override
  ConsumerState<ColoringGame> createState() => _ColoringGameState();
}

class _ColoringGameState extends ConsumerState<ColoringGame> {
  late ConfettiController _confetti;

  // Words with long vowels (مدود) for each letter
  static const Map<String, List<String>> _wordsWithMadda = {
    'ا': ['بَـابٌ', 'نَـارٌ', 'كِتَابٌ'],
    'ب': ['كِتَابٌ', 'بَابٌ', 'حِسَابٌ'],
    'ت': ['تُفَّاحٌ', 'تَاجٌ', 'كِتَابٌ'],
    'ث': ['ثَمَارٌ', 'ثَوْبٌ', 'ثَاءٌ'],
    'ج': ['جَارٌ', 'جِبَالٌ', 'جُوعٌ'],
    'ح': ['حَارٌّ', 'حِمَارٌ', 'حُوتٌ'],
    'خ': ['خِيَارٌ', 'خُبْزٌ', 'خَاتَمٌ'],
    'د': ['دِيكٌ', 'دَارٌ', 'دُودٌ'],
    'ذ': ['ذِئْبٌ', 'ذَهَبٌ', 'ذُرَةٌ'],
    'ر': ['رِيحٌ', 'رَمَالٌ', 'رُومٌ'],
    'ز': ['زِيتٌ', 'زَرَافَةٌ', 'زُهُورٌ'],
    'س': ['سَمَاءٌ', 'سِمَاكٌ', 'سُوقٌ'],
    'ش': ['شِتَاءٌ', 'شَمَاعَةٌ', 'شُمُوعٌ'],
    'ص': ['صَيَّادٌ', 'صِيَامٌ', 'صُوَرٌ'],
    'ض': ['ضِيَاءٌ', 'ضَارٌّ', 'ضُفَادِعٌ'],
    'ط': ['طَائِرٌ', 'طِيبٌ', 'طُورٌ'],
    'ظ': ['ظِلٌّ', 'ظَاهِرٌ', 'ظُبَيٌّ'],
    'ع': ['عِنَابٌ', 'عَالِمٌ', 'عُودٌ'],
    'غ': ['غِيَابٌ', 'غَابَةٌ', 'غُصْنٌ'],
    'ف': ['فِيلٌ', 'فَارِسٌ', 'فُولٌ'],
    'ق': ['قِيلٌ', 'قَامَةٌ', 'قُوَّةٌ'],
    'ك': ['كِتَابٌ', 'كَاتِبٌ', 'كُورَةٌ'],
    'ل': ['لَيْلٌ', 'لِيمُونٌ', 'لُؤْلُؤٌ'],
    'م': ['مِيزَانٌ', 'مَاءٌ', 'مُوزٌ'],
    'ن': ['نِيلٌ', 'نَاجِحٌ', 'نُورٌ'],
    'ه': ['هِلَالٌ', 'هَاتِفٌ', 'هُدُوءٌ'],
    'و': ['وِدَادٌ', 'وَادٍ', 'وُجُودٌ'],
    'ي': ['يَدٌ', 'يَاسِمِينٌ', 'يُوسُفُ'],
  };

  static const List<Color> _palette = [
    Color(0xFFE53935), // Red
    Color(0xFFFB8C00), // Orange
    Color(0xFFFDD835), // Yellow
    Color(0xFF43A047), // Green
    Color(0xFF039BE5), // Blue
    Color(0xFF8E24AA), // Purple
    Color(0xFFEC407A), // Pink
    Color(0xFF00897B), // Teal
    Color(0xFF6D4C41), // Brown
  ];

  Color _selectedColor = const Color(0xFFE53935);
  Map<int, Color> _charColors = {};
  List<String> _currentWordChars = [];
  bool _isComplete = false;
  int _round = 0;
  final int _totalRounds = 3;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupWord());
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  void _setupWord() {
    final letter = ref.read(currentLessonProvider).letter;
    if (letter == null) return;
    final words = _wordsWithMadda[letter.letter] ?? ['كِتَابٌ', 'بَابٌ', 'نَارٌ'];
    final word = words[_round % words.length];
    final chars = word.split('');

    setState(() {
      _currentWordChars = chars;
      _charColors = {};
      _isComplete = false;
    });

    // Play the paint instruction if available
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      final key = AudioRegistry.letterKeyFromChar(letter.letter);
      AudioManager.instance.playByKey(
        'instr_${key}_paint',
        fallbackText: 'لوّن حروف الكلمة!',
        channel: AudioChannel.voice,
      );
    });
  }

  void _colorChar(int index) {
    if (_isComplete) return;
    HapticFeedback.selectionClick();
    setState(() {
      _charColors[index] = _selectedColor;
    });

    // Check if all chars are colored
    if (_charColors.length == _currentWordChars.length) {
      setState(() => _isComplete = true);
      _confetti.play();
      HapticFeedback.heavyImpact();
      AudioManager.instance.playFeedback('wonderful');
    }
  }

  void _nextRound() {
    if (_round < _totalRounds - 1) {
      setState(() {
        _round++;
      });
      _setupWord();
    } else {
      ref.read(currentLessonProvider.notifier).completeCurrentActivity();
    }
  }

  @override
  Widget build(BuildContext context) {
    final letter = ref.watch(currentLessonProvider).letter;
    if (letter == null || _currentWordChars.isEmpty) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;
    final charBoxSize = isTablet ? 90.0 : 72.0;
    final charFontSize = isTablet ? 44.0 : 34.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 40,
          colors: _palette,
        ),

        SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            children: [
              // Title + round info
              Text('لوّن حروف الكلمة!', style: TextStyle(fontSize: isTablet ? 28 : 22, fontWeight: FontWeight.bold, color: AppColors.desertSand, fontFamily: 'Cairo')),
              Text('الكلمة ${_round + 1}/$_totalRounds', style: TextStyle(fontSize: isTablet ? 18 : 14, color: Colors.grey, fontFamily: 'Cairo')),

              SizedBox(height: isTablet ? 32 : 20),

              // Word display — colored letter boxes
              Container(
                padding: EdgeInsets.all(isTablet ? 24 : 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: Wrap(
                  spacing: isTablet ? 12 : 8,
                  runSpacing: isTablet ? 12 : 8,
                  alignment: WrapAlignment.center,
                  children: _currentWordChars.asMap().entries.map((entry) {
                    final i = entry.key;
                    final char = entry.value;
                    final colored = _charColors[i];
                    final isMaddaChar = 'اويآأإؤئى'.contains(char);

                    return GestureDetector(
                      onTap: () => _colorChar(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: charBoxSize,
                        height: charBoxSize,
                        decoration: BoxDecoration(
                          color: colored ?? Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colored ?? (isMaddaChar ? AppColors.oasisGreen.withValues(alpha: 0.5) : Colors.grey.shade300),
                            width: isMaddaChar ? 3 : 2,
                          ),
                          boxShadow: colored != null
                              ? [BoxShadow(color: colored.withValues(alpha: 0.3), blurRadius: 8)]
                              : null,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              char,
                              style: TextStyle(
                                fontSize: charFontSize,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: colored != null
                                    ? _contrastColor(colored)
                                    : Colors.grey.shade700,
                              ),
                            ),
                            // Madda indicator
                            if (isMaddaChar && colored == null)
                              Positioned(
                                bottom: 4,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.oasisGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ).animate(target: colored != null ? 1 : 0).scaleXY(end: 1.05, duration: 150.ms),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: isTablet ? 16 : 10),
              // Madda hint
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.oasisGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.oasisGreen.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppColors.oasisGreen, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text('الدائرة الخضراء = حرف المدّ', style: TextStyle(fontSize: isTablet ? 16 : 13, color: AppColors.oasisGreen, fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 32 : 20),

              // Color palette
              Text('اختر اللون:', style: TextStyle(fontSize: isTablet ? 20 : 16, color: AppColors.desertSand, fontFamily: 'Cairo')),
              SizedBox(height: isTablet ? 16 : 10),
              Wrap(
                spacing: isTablet ? 16 : 10,
                runSpacing: isTablet ? 16 : 10,
                alignment: WrapAlignment.center,
                children: _palette.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedColor = color);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isSelected ? (isTablet ? 60 : 48) : (isTablet ? 52 : 42),
                      height: isSelected ? (isTablet ? 60 : 48) : (isTablet ? 52 : 42),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: Colors.white, width: 4) : null,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: isSelected ? 0.6 : 0.3),
                            blurRadius: isSelected ? 16 : 6,
                          ),
                        ],
                      ),
                      child: isSelected ? const Icon(Icons.check_rounded, color: Colors.white, size: 22) : null,
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: isTablet ? 32 : 20),

              // Progress + actions
              if (_isComplete) ...[
                Text('أحسنت! الكلمة ملوّنة 🎨', style: TextStyle(fontSize: isTablet ? 26 : 20, fontWeight: FontWeight.bold, color: AppColors.oasisGreen, fontFamily: 'Cairo'))
                  .animate().scale(),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _nextRound,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(
                    _round < _totalRounds - 1 ? 'كلمة أخرى' : 'انتهينا! 🎉',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: isTablet ? 22 : 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.oasisGreen,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 28, vertical: isTablet ? 18 : 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ).animate().scale(delay: 300.ms),
              ] else ...[
                // Reset button
                TextButton.icon(
                  onPressed: () => setState(() => _charColors = {}),
                  icon: const Icon(Icons.refresh_rounded, color: Colors.grey),
                  label: Text('إعادة التلوين', style: TextStyle(color: Colors.grey, fontFamily: 'Cairo', fontSize: isTablet ? 18 : 14)),
                ),
                // Completion progress
                LinearProgressIndicator(
                  value: _currentWordChars.isEmpty ? 0 : _charColors.length / _currentWordChars.length,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(_selectedColor),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
                SizedBox(height: isTablet ? 8 : 4),
                Text('${_charColors.length}/${_currentWordChars.length} حروف ملوّنة', style: TextStyle(fontSize: isTablet ? 16 : 13, color: Colors.grey, fontFamily: 'Cairo')),
              ],
              SizedBox(height: isTablet ? 24 : 16),
            ],
          ),
        ),
      ],
    );
  }

  Color _contrastColor(Color bg) {
    final luminance = bg.computeLuminance();
    return luminance > 0.4 ? Colors.black87 : Colors.white;
  }
}
