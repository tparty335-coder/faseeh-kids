import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_train_navbar.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_objectives_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_story_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_sounds_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_words_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_games_station.dart';

// ═══ UPGRADED: baa_lesson_screen.dart ═══

class BaaLessonScreen extends StatefulWidget {
  const BaaLessonScreen({super.key});

  @override
  State<BaaLessonScreen> createState() => _BaaLessonScreenState();
}

class _BaaLessonScreenState extends State<BaaLessonScreen> {
  final PageController _pageController = PageController();
  int _currentStationIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStation(int index) {
    setState(() => _currentStationIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _nextStation() {
    if (_currentStationIndex < 5) {
      _goToStation(_currentStationIndex + 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _previousStation() {
    if (_currentStationIndex > 0) {
      _goToStation(_currentStationIndex - 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar with Maroon background from CD
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: AppColors.baaTopBar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'الْوَحْدَةُ الثَّانِيَةُ | حَرْفُ الْبَاءِ (ب)',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.baaHighlightYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'حَرْفُ (ب)',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.baaTopBar,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Lesson Content (6 Authentic Stations)
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Controlled via train and next/prev buttons
                onPageChanged: (i) => setState(() => _currentStationIndex = i),
                children: [
                  BaaObjectivesStation(onNext: _nextStation),
                  BaaStoryStation(onNext: _nextStation, onPrevious: _previousStation),
                  BaaSoundsStation(onNext: _nextStation, onPrevious: _previousStation),
                  BaaWritingStation(onNext: _nextStation, onPrevious: _previousStation),
                  BaaWordsStation(onNext: _nextStation, onPrevious: _previousStation),
                  BaaGamesStation(onPrevious: _previousStation),
                ],
              ),
            ),

            // Authentic Lesson Train Bottom Navigation Bar
            BaaTrainNavBar(
              activeStationIndex: _currentStationIndex,
              onStationSelected: _goToStation,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══ END OF FILE ═══
