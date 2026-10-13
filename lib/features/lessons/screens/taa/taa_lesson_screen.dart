import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_train_navbar.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_objectives_station.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_story_station.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_sounds_station.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_madd_station.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/Taa/taa_games_station.dart';

/// ط´ط§ط´ط© ط¯ط±ط³ ط­ط±ظپ ط§ظ„ط¨ط§ط، â€” ط§ظ„ظ…ط­ط·ط§طھ: ط§ظ„ط£ظ‡ط¯ط§ظپطŒ ظ‚طµط© ط§ظ„ط­ط±ظپطŒ ط£طµظˆط§طھ ط§ظ„ط­ط±ظپطŒ ط§ظ„ظ…ط¯ظˆط¯طŒ ط§ظ„ظƒطھط§ط¨ط©
class TaaLessonScreen extends StatefulWidget {
  final int initialStationIndex;

  const TaaLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  State<TaaLessonScreen> createState() => _TaaLessonScreenState();
}

class _TaaLessonScreenState extends State<TaaLessonScreen> {
  late final PageController _pageController;
  late int _currentStationIndex;

  static const int _stationCount = 6; // ط§ظ„ط£ظ‡ط¯ط§ظپ + ظ‚طµط© + ط£طµظˆط§طھ + ظ…ط¯ظˆط¯ + ظƒطھط§ط¨ط© + ط£ظ„ط¹ط§ط¨

  @override
  void initState() {
    super.initState();
    _currentStationIndex = widget.initialStationIndex.clamp(0, _stationCount - 1);
    _pageController = PageController(initialPage: _currentStationIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStation(int index) {
    if (index < 0 || index >= _stationCount) return;
    setState(() => _currentStationIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _nextStation() {
    if (_currentStationIndex < _stationCount - 1) {
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
            // ط´ط±ظٹط· ط§ظ„ط¹ظ†ظˆط§ظ† ط§ظ„ط¹ظ„ظˆظٹ
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: AppColors.TaaTopBar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'ط§ظ„ظ’ظˆظژط­ظ’ط¯ظژط©ظڈ ط§ظ„ط«ظژظ‘ط§ظ†ظگظٹظژط©ظڈ | ط­ظژط±ظ’ظپظڈ ط§ظ„ظ’ط¨ظژط§ط،ظگ (ط¨)',
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
                      color: AppColors.TaaHighlightYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'ط­ظژط±ظ’ظپظڈ (ط¨)',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.TaaTopBar,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ط§ظ„ظ…ط­طھظˆظ‰ ط§ظ„ط±ط¦ظٹط³ظٹ â€” ط§ظ„ظ…ط­ط·طھط§ظ† ظپظ‚ط·
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStationIndex = i),
                children: [
                  TaaObjectivesStation(onNext: _nextStation),
                  TaaStoryStation(onNext: _nextStation, onPrevious: _previousStation),
                  TaaSoundsStation(onNext: _nextStation, onPrevious: _previousStation),
                  TaaMaddStation(onNext: _nextStation, onPrevious: _previousStation),
                  TaaWritingStation(onNext: _nextStation, onPrevious: _previousStation),
                  TaaGamesStation(onNext: _nextStation, onPrevious: _previousStation),
                ],
              ),
            ),

            // ط´ط±ظٹط· ط§ظ„طھظ†ظ‚ظ„ ط§ظ„ط³ظپظ„ظٹ
            TaaTrainNavBar(
              activeStationIndex: _currentStationIndex,
              onStationSelected: _goToStation,
            ),
          ],
        ),
      ),
    );
  }
}


