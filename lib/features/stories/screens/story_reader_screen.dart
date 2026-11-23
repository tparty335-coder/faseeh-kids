import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/stories/data/stories_data.dart';
import 'package:faseeh_kids/features/stories/logic/story_provider.dart';
import 'package:faseeh_kids/services/audio_service.dart';
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
    _story = storiesData.firstWhere(
      (s) => s.id == widget.storyId,
      orElse: () => storiesData.first,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playCurrentPageAudio();
    });
  }

  void _selectStory(Story s) {
    AudioService.instance.stop();
    setState(() {
      _story = s;
      _currentPage = 0;
      _isFinished = false;
    });
    if (_pageController.hasClients) {
      _pageController.jumpToPage(0);
    }
    _playCurrentPageAudio();
  }

  String _getPageImagePath(int pageIndex) {
    if (pageIndex < _story.pageImages.length && _story.pageImages[pageIndex].isNotEmpty) {
      return _story.pageImages[pageIndex];
    }
    switch (_story.id) {
      case 'story_1':
        return 'assets/images/stories/rabbit_turtle.webp';
      case 'story_2':
        return 'assets/images/stories/falcon_learns.webp';
      default:
        return 'assets/images/stories/letter_oasis.webp';
    }
  }

  Future<void> _playCurrentPageAudio() async {
    if (!mounted || _isFinished) return;
    if (_currentPage < _story.pageAudios.length && _story.pageAudios[_currentPage].isNotEmpty) {
      try {
        await AudioService.instance.stop();
        await AudioService.instance.playAsset(
          _story.pageAudios[_currentPage],
          channel: AudioChannel.voice,
        );
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    AudioService.instance.stop();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    ref.read(storyProgressProvider(_story.id).notifier).updateProgress(index);
    _playCurrentPageAudio();
  }

  void _nextPage() {
    if (_currentPage < _story.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      AudioService.instance.playAsset('audio/sfx/celebration.mp3', channel: AudioChannel.sfx);
      setState(() {
        _isFinished = true;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
                ),
              ],
            ).animate().fade().scale(),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
              tooltip: 'سماع المشهد بصوت بشري',
              onPressed: _playCurrentPageAudio,
            ),
          ],
        ),
        body: Column(
          children: [
            // شريط اختيار القصة من مكتبة القصص المصورة
            SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: storiesData.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, idx) {
                  final s = storiesData[idx];
                  final selected = s.id == _story.id;
                  return ChoiceChip(
                    label: Text(
                      s.letterTag != null ? 'حرف (${s.letterTag})' : s.title,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: selected ? Colors.white : Colors.brown.shade800,
                      ),
                    ),
                    selected: selected,
                    selectedColor: AppColors.oasisGreen,
                    backgroundColor: Colors.white,
                    onSelected: (_) => _selectStory(s),
                  );
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _story.pages.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                _getPageImagePath(index),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ).animate().scale(duration: 400.ms, curve: Curves.easeOutCubic),
                        ),
                        const SizedBox(height: 20),
                        ArabicText(
                          _story.pages[index],
                          variant: ArabicTextVariant.heading,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: const Duration(milliseconds: 400)),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _currentPage < _story.pages.length - 1
                        ? _nextPage
                        : () => setState(() => _isFinished = true),
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
                          color: _currentPage == index
                              ? AppColors.gold
                              : AppColors.gold.withValues(alpha: 0.3),
                        ),
                      );
                    }).reversed.toList(),
                  ),
                  IconButton(
                    onPressed: _currentPage > 0 ? _previousPage : null,
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 32,
                      color: _currentPage > 0 ? AppColors.primaryDay : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
