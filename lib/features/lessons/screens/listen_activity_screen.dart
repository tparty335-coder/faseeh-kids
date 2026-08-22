import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class ListenActivityScreen extends ConsumerStatefulWidget {
  const ListenActivityScreen({super.key});

  @override
  ConsumerState<ListenActivityScreen> createState() => _ListenActivityScreenState();
}

class _ListenActivityScreenState extends ConsumerState<ListenActivityScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Define the 4 short vowels (Harakat)
  final List<Map<String, dynamic>> _harakat = [
    {
      'id': 'fatha',
      'title': 'الفَتْحَة',
      'vowel': 'َ',
      'color': const Color(0xFFE53935), // Red
      'demo_variant': 'fatha_demo',
      'rule_asset': 'fatha_rule', // Will try to load {letter}_fatha_rule.mp3 or use demo
    },
    {
      'id': 'kasra',
      'title': 'الكَسْرَة',
      'vowel': 'ِ',
      'color': const Color(0xFF1E88E5), // Blue
      'demo_variant': 'kasra_demo',
      'rule_asset': 'kasra_rule',
    },
    {
      'id': 'damma',
      'title': 'الضَّمَّة',
      'vowel': 'ُ',
      'color': const Color(0xFF43A047), // Green
      'demo_variant': 'damma_demo',
      'rule_asset': 'damma_rule',
    },
    {
      'id': 'sukoon',
      'title': 'السُّكُون',
      'vowel': 'ْ',
      'color': const Color(0xFF8E24AA), // Purple
      'demo_variant': 'sukoon',
      'rule_asset': 'sukoon_rule',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letter = lessonState.letter;

    if (letter == null) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Column(
      children: [
        // Navigation Dots
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_harakat.length, (index) {
              final isActive = _currentIndex == index;
              final color = _harakat[index]['color'] as Color;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 12,
                width: isActive ? 32 : 12,
                decoration: BoxDecoration(
                  color: isActive ? color : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            }),
          ),
        ),

        // Carousel of Harakat
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
              // Auto-play when swiping to a new haraka
              _playHarakaAudio(letter.letter, _harakat[index]);
            },
            itemCount: _harakat.length,
            itemBuilder: (context, index) {
              return _buildHarakaPage(letter.letter, _harakat[index], isTablet);
            },
          ),
        ),

        // Bottom Controls
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              if (_currentIndex > 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.desertSand, size: 32),
                  onPressed: () {
                    _pageController.previousPage(duration: 400.ms, curve: Curves.easeInOut);
                  },
                )
              else
                const SizedBox(width: 48), // Placeholder to keep layout balanced

              // Complete / Next Activity Button
              if (_currentIndex == _harakat.length - 1)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.oasisGreen,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24, vertical: isTablet ? 18 : 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                  ),
                  onPressed: () {
                    ref.read(currentLessonProvider.notifier).completeCurrentActivity();
                    ref.read(currentLessonProvider.notifier).nextActivity();
                  },
                  icon: const Icon(Icons.check_circle_outline, size: 28),
                  label: Text('انتهيت', style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                ).animate().scale(delay: 200.ms)
              else
                // Next Haraka button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _harakat[_currentIndex]['color'],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 20, vertical: isTablet ? 16 : 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    _pageController.nextPage(duration: 400.ms, curve: Curves.easeInOut);
                  },
                  label: const Text('الحركة التالية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHarakaPage(String letterChar, Map<String, dynamic> haraka, bool isTablet) {
    final title = haraka['title'] as String;
    final vowel = haraka['vowel'] as String;
    final color = haraka['color'] as Color;
    
    final circleSize = isTablet ? 280.0 : 200.0;
    final letterFontSize = circleSize * 0.6;
    
    // Example word for this letter (emoji & text)
    // Map of specific example words for each haraka (especially for Alif and Baa to match the audio)
    final Map<String, Map<String, String>> specificExamples = {
      'alif': {
        'fatha': 'أَرْنَب',
        'kasra': 'إِبْرِيق',
        'damma': 'أُذُن',
        'sukoon': 'فَأْر',
      },
      'baa': {
        'fatha': 'بَطَّة',
        'kasra': 'بِطْرِيق',
        'damma': 'بُومَة',
        'sukoon': 'حَبْل',
      },
    };

    final letterKey = AudioRegistry.letterKeyFromChar(letterChar);
    final harakaId = haraka['id'] as String;
    
    // Get the specific example word, fallback to general word, then 'كَلِمَة'
    String exampleWord = 'كَلِمَة';
    if (specificExamples.containsKey(letterKey) && specificExamples[letterKey]!.containsKey(harakaId)) {
      exampleWord = specificExamples[letterKey]![harakaId]!;
    } else {
      exampleWord = AudioRegistry.exampleWords[letterKey] ?? 'كَلِمَة';
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title of Haraka
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 36 : 28,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Cairo',
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
          
          SizedBox(height: isTablet ? 40 : 24),
          
          // Big Letter with Haraka
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$letterChar$vowel',
                style: TextStyle(
                  fontSize: letterFontSize,
                  color: AppColors.desertSand,
                  fontFamily: 'Cairo',
                  height: 1,
                ),
              ),
            ),
          ).animate().scale(begin: const Offset(0.8, 0.8), duration: 500.ms, curve: Curves.easeOutBack),
          
          SizedBox(height: isTablet ? 40 : 30),
          
          // Play Rich Audio Button (الشرح والأمثلة)
          GestureDetector(
            onTap: () => _playHarakaAudio(letterChar, haraka),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 48 : 32, vertical: isTablet ? 20 : 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.7)]),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.volume_up_rounded, color: Colors.white, size: 36),
                  const SizedBox(width: 16),
                  Text(
                    'استمع للشرح والمثال',
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
          
          SizedBox(height: isTablet ? 30 : 20),
          
          // Example Word Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مثال:',
                  style: TextStyle(fontSize: isTablet ? 20 : 16, color: Colors.grey, fontFamily: 'Cairo'),
                ),
                const SizedBox(width: 12),
                Text(
                  exampleWord,
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDay,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  void _playHarakaAudio(String letterChar, Map<String, dynamic> haraka) async {
    final letterKey = AudioRegistry.letterKeyFromChar(letterChar);
    final harakaId = haraka['id'] as String; // fatha, kasra, damma, sukoon
    
    // The user provided accurate rule files in the root folder like: alif_fatha_rule.mp3
    final rulePath = 'audio/${letterKey}_${harakaId}_rule.mp3';
    
    try {
      // We will try to play the rule file directly via AudioService
      await AudioService.instance.playAsset(rulePath);
    } catch (e) {
      // Fallback: If rule doesn't exist, just play the short vowel sound to avoid playing the wrong MADD demo
      AudioManager.instance.playLetterAudio(letterKey, harakaId);
    }
  }
}
