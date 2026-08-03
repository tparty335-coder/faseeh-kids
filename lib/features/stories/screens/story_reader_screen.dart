import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/stories/data/stories_data.dart';
import 'package:faseeh_kids/features/stories/logic/story_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/shared/widgets/arabic_text.dart';
import 'package:faseeh_kids/shared/widgets/mascot_widget.dart';

class StoryReaderScreen extends ConsumerStatefulWidget {
  final String storyId;

  const StoryReaderScreen({super.key, required this.storyId});

  @override
  ConsumerState<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends ConsumerState<StoryReaderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isFinished = false;

  late Story _story;

  @override
  void initState() {
    super.initState();
    _story = storiesData.firstWhere((s) => s.id == widget.storyId, orElse: () => storiesData.first);
  }

  String _getStoryImagePath(String id) {
    switch (id) {
      case 'story_1':
        return 'assets/images/stories/rabbit_turtle.jpg';
      case 'story_2':
        return 'assets/images/stories/falcon_learns.jpg';
      case 'story_3':
        return 'assets/images/stories/letter_oasis.jpg';
      default:
        return 'assets/images/stories/letter_oasis.jpg';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    ref.read(storyProgressProvider(widget.storyId).notifier).updateProgress(index);
  }

  void _nextPage() {
    if (_currentPage < _story.pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      setState(() {
        _isFinished = true;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return Scaffold(
        backgroundColor: AppColors.backgroundCream,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MascotWidget(
                expression: MascotExpression.celebrating,
                speechText: 'أحسنت! لقد أنهيت القصة بنجاح.',
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.oasisGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const ArabicText('العودة', variant: ArabicTextVariant.label, color: Colors.white),
              )
            ],
          ).animate().fade().scale(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: ArabicText(_story.title, variant: ArabicTextVariant.heading),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_rounded, color: AppColors.skyBlue),
            onPressed: () {
              AudioManager.instance.speakText(_story.pages[_currentPage]);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _story.pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              _getStoryImagePath(_story.id),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).animate().scale(duration: 500.ms, curve: Curves.easeOutCubic),
                      ),
                      const SizedBox(height: 32),
                      ArabicText(
                        _story.pages[index],
                        variant: ArabicTextVariant.heading,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _currentPage < _story.pages.length - 1 ? _nextPage : () => setState(() => _isFinished = true),
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 32, color: AppColors.primaryDay),
                ),
                Row(
                  children: List.generate(_story.pages.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? AppColors.gold : AppColors.gold.withValues(alpha: 0.3),
                      ),
                    );
                  }).reversed.toList(),
                ),
                IconButton(
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  icon: Icon(Icons.arrow_forward_ios_rounded, size: 32, color: _currentPage > 0 ? AppColors.primaryDay : Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
