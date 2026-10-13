import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';

class LongVowelsSequenceWidget extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String letterChar;
  final bool isActive;

  const LongVowelsSequenceWidget({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.letterChar,
    this.isActive = true,
  });

  @override
  State<LongVowelsSequenceWidget> createState() => _LongVowelsSequenceWidgetState();
}

class _LongVowelsSequenceWidgetState extends State<LongVowelsSequenceWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // طµظپط­ط§طھ ط§ظ„ظ…ط¯ظˆط¯: ط§ظ„طµظپط­ط© 0 ظ‡ظٹ ط´ط±ط­ ظ…ط¹ظ†ظ‰ ط§ظ„ظ…ط¯ ظˆط£ظ†ظˆط§ط¹ظ‡طŒ ط«ظ… ط£ظ…ط«ظ„ط© ط§ظ„ط£ط³ط·ظˆط§ظ†ط© ط§ظ„ط«ظ„ط§ط«ط©
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  List<Map<String, dynamic>> get _pages => _getPagesForLetter(widget.letterChar);

  static List<Map<String, dynamic>> _getPagesForLetter(String letter) {
    if (letter == 'ط¨') {
      return [
        {
          'type': 'intro',
          'id': 'madd_intro',
          'label': 'طھظژط¹ظ’ط±ظگظٹظپظڈ ط§ظ„ظ’ظ…ظژط¯ظگظ‘ ظˆظژط£ظژظ†ظ’ظˆظژط§ط¹ظڈظ‡ظڈ',
          'color': const Color(0xFF6A1B9A),
          'title': 'ط§ظ„ظ’ط­ظژط±ظژظƒظژط§طھظڈ ط§ظ„ط·ظژظ‘ظˆظگظٹظ„ظژط©ظڈ ظ…ظژط¹ظژ ط­ظژط±ظ’ظپظگ ط§ظ„ظ’ط¨ظژط§ط،ظگ',
          'explanation': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ظ‡ظڈظˆظژ ط¥ظگط·ظژط§ظ„ظژط©ظڈ ط²ظژظ…ظژظ†ظگ طµظژظˆظ’طھظگ ط§ظ„ظ’ط­ظژط±ظژظƒظژط©ظگ ط¥ظگظ„ظژظ‰ ط§ظ„ط¶ظگظ‘ط¹ظ’ظپظگ ط£ظژظˆظ’ ط£ظژظƒظ’ط«ظژط±ظژ.',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_def.mp3',
        },
        {
          'type': 'example',
          'id': 'madd_alif',
          'label': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط¨ظگط§ظ„ط£ظژظ„ظگظپظگ (ط¨ظژط§)',
          'maddChar': 'ط¨ظژط§',
          'color': const Color(0xFFD32F2F),
          'explanation': 'ظپظژطھظ’ط­ظژط©ظŒ ظٹظژظ„ظگظٹظ‡ظژط§ ط£ظژظ„ظگظپظŒ ظ…ظگط«ظ’ظ„ظڈ: ط«ظڈط¹ظ’ط¨ظژط§ظ†',
          'exampleWord': 'ط«ظڈط¹ظ’ط¨ظژط§ظ†',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_alif.mp3',
            'wordAudio': 'audio/lessons/baa/sounds/word_thoban.mp3',
          'imageFile': 'assets/images/lessons/baa/sounds/thoaban.png',
        },
        {
          'type': 'example',
          'id': 'madd_waw',
          'label': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط¨ظگط§ظ„ظ’ظˆظژط§ظˆظگ (ط¨ظڈظˆ)',
          'maddChar': 'ط¨ظڈظˆ',
          'color': const Color(0xFFF57C00),
          'explanation': 'ط¶ظژظ…ظژظ‘ط©ظŒ ظٹظژظ„ظگظٹظ‡ظژط§ ظˆظژط§ظˆظŒ ظ…ظگط«ظ’ظ„ظڈ: ط­ظڈط¨ظڈظˆط¨',
          'exampleWord': 'ط­ظڈط¨ظڈظˆط¨',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_waw.mp3',
            'wordAudio': 'audio/lessons/baa/sounds/word_hobob.mp3',
          'imageFile': 'assets/images/lessons/baa/sounds/hobob.png',
        },
        {
          'type': 'example',
          'id': 'madd_yaa',
          'label': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط¨ظگط§ظ„ظ’ظٹظژط§ط،ظگ (ط¨ظگظٹ)',
          'maddChar': 'ط¨ظگظٹ',
          'color': const Color(0xFF1976D2),
          'explanation': 'ظƒظژط³ظ’ط±ظژط©ظŒ ظٹظژظ„ظگظٹظ‡ظژط§ ظٹظژط§ط،ظŒ ظ…ظگط«ظ’ظ„ظڈ: ط·ظژط¨ظگظٹط¨',
          'exampleWord': 'ط·ظژط¨ظگظٹط¨',
          'audioFile': 'audio/lessons/baa/sounds/baa_madd_yaa.mp3',
            'wordAudio': 'audio/lessons/baa/sounds/word_tabeeb.mp3',
          'imageFile': 'assets/images/lessons/baa/sounds/tabeeb.png',
        },
      ];
    }


    // ط§ظپطھط±ط§ط¶ظٹ ظ„ط­ط±ظپ ط§ظ„ط£ظ„ظپ (ظ…ط·ط§ط¨ظ‚ط© ظ„ظ„ط£ط³ط·ظˆط§ظ†ط© ط§ظ„ط£طµظ„ظٹط© ahdaf_a2)
    return [
      {
        'type': 'intro',
        'id': 'madd_intro',
        'label': 'طھظژط¹ظ’ط±ظگظٹظپظڈ ط§ظ„ظ’ظ…ظژط¯ظگظ‘ ظˆظژط£ظژظ†ظ’ظˆظژط§ط¹ظڈظ‡ظڈ',
        'color': const Color(0xFF6A1B9A),
        'title': 'ط§ظ„ظ’ط­ظژط±ظژظƒظژط§طھظڈ ط§ظ„ط·ظژظ‘ظˆظگظٹظ„ظژط©ظڈ (ط§ظ„ظ’ظ…ظڈط¯ظڈظˆط¯ظڈ)',
        'explanation': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ظ‡ظڈظˆظژ ط¥ظگط·ظژط§ظ„ظژط©ظڈ ط²ظژظ…ظژظ†ظگ طµظژظˆظ’طھظگ ط§ظ„ظ’ط­ظژط±ظژظƒظژط©ظگ (ط§ظ„ظ’ظپظژطھظ’ط­ظژط©ظگ ط£ظژظˆظگ ط§ظ„ط¶ظژظ‘ظ…ظژظ‘ط©ظگ ط£ظژظˆظگ ط§ظ„ظ’ظƒظژط³ظ’ط±ظژط©ظگ) ط¥ظگظ„ظژظ‰ ط§ظ„ط¶ظگظ‘ط¹ظ’ظپظگ ط£ظژظˆظ’ ط£ظژظƒظ’ط«ظژط±ظژ.',
        'audioFile': 'audio/stories/alif_mudud_intro.mp3',
      },
      {
        'type': 'example',
        'id': 'madd_alif',
        'label': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط¨ظگط§ظ„ط£ظژظ„ظگظپظگ (ط¢)',
        'maddChar': 'ط¢',
        'color': const Color(0xFFD32F2F),
        'explanation': 'ظپظژطھظ’ط­ظژط©ظŒ ظٹظژظ„ظگظٹظ‡ظژط§ ط£ظژظ„ظگظپظŒ ظ…ظگط«ظ’ظ„ظڈ: ط¢ظ…ظژط§ظ„',
        'exampleWord': 'ط¢ظ…ظژط§ظ„',
        'audioFile': 'audio/stories/alif_madd_amal.mp3',
        'imageFile': 'assets/images/lessons/alif/alif_word_amal.jpg',
      },
      {
        'type': 'example',
        'id': 'madd_waw',
        'label': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط¨ظگط§ظ„ظ’ظˆظژط§ظˆظگ (ط£ظڈظˆ)',
        'maddChar': 'ط£ظڈظˆ',
        'color': const Color(0xFFF57C00),
        'explanation': 'ط¶ظژظ…ظژظ‘ط©ظŒ ظٹظژظ„ظگظٹظ‡ظژط§ ظˆظژط§ظˆظŒ ظ…ظگط«ظ’ظ„ظڈ: ط§ظ„ط£ظڈظˆظ„ظژظ‰',
        'exampleWord': 'ط§ظ„ط£ظڈظˆظ„ظژظ‰',
        'audioFile': 'audio/stories/alif_madd_oula.mp3',
        'imageFile': 'assets/images/lessons/alif/alif_word_oula.jpg',
      },
      {
        'type': 'example',
        'id': 'madd_yaa',
        'label': 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط¨ظگط§ظ„ظ’ظٹظژط§ط،ظگ (ط¥ظگظٹ)',
        'maddChar': 'ط¥ظگظٹ',
        'color': const Color(0xFF1976D2),
        'explanation': 'ظƒظژط³ظ’ط±ظژط©ظŒ ظٹظژظ„ظگظٹظ‡ظژط§ ظٹظژط§ط،ظŒ ظ…ظگط«ظ’ظ„ظڈ: ط¥ظگظٹظ†ظژط§ط³',
        'exampleWord': 'ط¥ظگظٹظ†ظژط§ط³',
        'audioFile': 'audio/stories/alif_madd_inas.mp3',
        'imageFile': 'assets/images/lessons/alif/alif_scene_inas.jpg',
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _triggerAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant LongVowelsSequenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _triggerAutoPlay();
    }
  }

  void _triggerAutoPlay() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _playPageAudio(_pages[_currentPage]);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _playPageAudio(Map<String, dynamic> page) async {
    await AudioService.instance.stop();
    try {
      final path = page['audioFile'] as String;
      await AudioService.instance.playAsset(path);
      final wordPath = page['wordAudio'] as String?;
      if (wordPath != null) {
        await Future.delayed(const Duration(milliseconds: 1500));
        await AudioService.instance.playAsset(wordPath);
      }
    } catch (e) {
      debugPrint('Madd audio error: $e');
    }
  }


  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onNext();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      AudioService.instance.stop();
      widget.onPrevious();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // â”€â”€â”€ 1. ط´ط±ظٹط· ط§ظ„ط¹ظ†ظˆط§ظ† ط§ظ„ط¹ظ„ظˆظٹ â”€â”€â”€
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDay,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'ط§ظ„ظ’ط­ظژط±ظژظƒظژط§طھظڈ ط§ظ„ط·ظژظ‘ظˆظگظٹظ„ظژط©ظڈ â€” ${_pages[_currentPage]['label']}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primaryDay, size: 28),
                  onPressed: () => _playPageAudio(_pages[_currentPage]),
                ),
              ],
            ),
          ),

          // â”€â”€â”€ 2. ط¹ط±ط¶ ط§ظ„طµظپط­ط§طھ (ط§ظ„ظ…ظ‚ط¯ظ…ط© ط£ظˆظ„ط§ظ‹ ط«ظ… ط£ظ…ط«ظ„ط© ط§ظ„ظ…ط¯ظˆط¯) â”€â”€â”€
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                _playPageAudio(_pages[index]);
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final page = _pages[index];
                final color = page['color'] as Color;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isTablet ? 560 : double.infinity),
                      child: page['type'] == 'intro'
                          ? _buildIntroPage(page, color)
                          : _buildExamplePage(page, color),
                    ),
                  ),
                );
              },
            ),
          ),

          // â”€â”€â”€ 3. ط£ط²ط±ط§ط± ط§ظ„طھظ†ظ‚ظ„ ط§ظ„ط³ظپظ„ظٹط© â”€â”€â”€
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  label: const Text('ط§ظ„ط³ط§ط¨ظ‚',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryDay,
                    side: const BorderSide(color: AppColors.primaryDay, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),

                Row(
                  children: List.generate(_pages.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == i ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _currentPage == i ? AppColors.primaryDay : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                ),

                ElevatedButton.icon(
                  onPressed: _nextPage,
                  label: Text(
                    _currentPage == _pages.length - 1
                        ? 'ط§ظ„طھط§ظ„ظٹ: ط§ظ„ظ’ظƒظژظ„ظگظ…ظژط§طھ'
                        : _currentPage == 0
                            ? 'ط£ظژظ…ظ’ط«ظگظ„ظژط©ظڈ ط§ظ„ظ’ظ…ظژط¯ظگظ‘'
                            : 'ط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط§ظ„طھظژظ‘ط§ظ„ظگظٹ',
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDay,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ ط¨ظ†ط§ط، طµظپط­ط© ط´ط±ط­ ظ…ط¹ظ†ظ‰ ط§ظ„ظ…ط¯ ظˆط£ظ†ظˆط§ط¹ظ‡ ط§ظ„ط«ظ„ط§ط«ط© â”€â”€
  Widget _buildIntroPage(Map<String, dynamic> page, Color color) {
    // ط§ط³طھط®ط±ط¬ طµظپط­ط§طھ ط§ظ„ط£ظ…ط«ظ„ط© ظ„ظ„ط¹ط±ط¶ ط¯ط§ط®ظ„ ط§ظ„ظ…ظ‚ط¯ظ…ط©
    final examplePages = _pages.where((p) => p['type'] == 'example').toList();

    return Column(
      children: [
        // ط¨ط·ط§ظ‚ط© ط§ظ„طھط¹ط±ظٹظپ
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, color: color, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    'ظ…ظژط§ ظ‡ظڈظˆظژ ط§ظ„ظ’ظ…ظژط¯ظڈظ‘طں',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                page['explanation'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDay,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              // ط²ط± طھط´ط؛ظٹظ„ ط§ظ„ط´ط±ط­ ط§ظ„ظƒط§ظ…ظ„
              GestureDetector(
                onTap: () => _playPageAudio(page),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_circle_rounded, color: color, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'ط§ط¶ظ’ط؛ظژط·ظ’ ظ„ظگط³ظژظ…ظژط§ط¹ظگ ط´ظژط±ظ’ط­ظگ ط§ظ„ظ’ظ…ظژط¯ظگظ‘ ظƒظژط§ظ…ظگظ„ط§ظ‹',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ط£ظ†ظˆط§ط¹ ط§ظ„ظ…ط¯ ط§ظ„ط«ظ„ط§ط«ط© ظ…ط¹ طµظˆط±ظ‡ط§ â€” طھط¸ظ‡ط± ظ…ط±ط§ظپظ‚ط©ظ‹ ظ„ظ„ط´ط±ط­ ط§ظ„طµظˆطھظٹ
        Text(
          'ظˆظژط§ظ„ظ’ظ…ظژط¯ظڈظ‘ ط«ظژظ„ط§ط«ظژط©ظڈ ط£ظژظ†ظ’ظˆظژط§ط¹ظچ:',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 10),

        ...examplePages.map((ex) {
          final exColor = ex['color'] as Color;
          final hasImage = ex.containsKey('imageFile');
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => _playPageAudio(ex),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: exColor.withValues(alpha: 0.4), width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    // طµظˆط±ط© ط§ظ„ظ…ط«ط§ظ„
                    if (hasImage)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          width: 88,
                          height: 72,
                          child: Image.asset(
                            ex['imageFile'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: exColor.withValues(alpha: 0.1),
                              child: Icon(Icons.image, color: exColor, size: 32),
                            ),
                          ),
                        ),
                      ),
                    if (hasImage) const SizedBox(width: 12),
                    // ط§ظ„ظ†طµ
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ex['label'] as String,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: exColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ex['explanation'] as String,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              color: AppColors.textPrimaryDay,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ex['exampleWord'] as String,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: exColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.volume_up_rounded, color: exColor.withValues(alpha: 0.8), size: 22),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }


  // â”€â”€ ط¨ظ†ط§ط، طµظپط­ط© ط§ظ„ظ…ط«ط§ظ„ ط§ظ„ظپط±ط¯ظٹ ظ„ظ„ظ…ط¯ â”€â”€
  Widget _buildExamplePage(Map<String, dynamic> m, Color color) {
    return Column(
      children: [
        // ط¨ط·ط§ظ‚ط© ط§ظ„ظ‚ط§ط¹ط¯ط© ظˆط´ظƒظ„ ط§ظ„ظ…ط¯
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  m['maddChar'] as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m['explanation'] as String,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDay,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ط¨ط·ط§ظ‚ط© ط§ظ„ظ…ط«ط§ظ„ ط§ظ„ظ…ط±ظƒط²ظٹط© ط§ظ„ظƒط¨ظٹط±ط©
        GestureDetector(
          onTap: () => _playPageAudio(m),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ظ…ظگط«ظژط§ظ„ظŒ: ',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      m['exampleWord'] as String,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      color: Colors.grey.shade100,
                      child: Image.asset(
                        m['imageFile'] as String,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade100,
                          child: const Icon(Icons.image, size: 64, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.volume_up_rounded, color: color, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'ط§ط¶ظ’ط؛ظژط·ظ’ ظ„ظگط³ظژظ…ظژط§ط¹ظگ ظ†ظڈط·ظ’ظ‚ظگ ط§ظ„ظ’ظƒظژظ„ظگظ…ظژط©ظگ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

