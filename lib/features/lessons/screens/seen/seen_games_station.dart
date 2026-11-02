import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/seen/seen_coloring_game.dart';

enum _GameType { fishing, beehive, circus, words, coloring }

class _GameCard {
  final _GameType type;
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  const _GameCard({
    required this.type,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}

/// محطة ألعاب حرف السين — 5 ألعاب تفاعلية بثيم أزرق عميق 🦌
class SeenGamesStation extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const SeenGamesStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  ConsumerState<SeenGamesStation> createState() => _SeenGamesStationState();
}

class _SeenGamesStationState extends ConsumerState<SeenGamesStation> {
  _GameType? _selectedGame;
  int _menuToken = 0;

  static const List<_GameCard> _games = [
    _GameCard(
      type: _GameType.fishing,
      emoji: '🎣',
      title: 'لعبة صيد الحروف',
      subtitle: 'اصطد الأسماك التي تبدأ بحرف السين (س)',
      gradient: [Color(0xFF2E7D32), Color(0xFF00ACC1)],
    ),
    _GameCard(
      type: _GameType.beehive,
      emoji: '🍯',
      title: 'خلية النحل',
      subtitle: 'اختر الخلية الصحيحة حسب الحركة مع السين',
      gradient: [Color(0xFFF9A825), Color(0xFFFFD54F)],
    ),
    _GameCard(
      type: _GameType.circus,
      emoji: '🎪',
      title: 'السيرك',
      subtitle: 'اعثر على الكلمات التي تحتوي حرف السين (س)',
      gradient: [Color(0xFF2E7D32), Color(0xFFB2EBF2)],
    ),
    _GameCard(
      type: _GameType.words,
      emoji: '📝',
      title: 'مطابقة الكلمات',
      subtitle: 'طابق الصورة مع الكلمة الصحيحة',
      gradient: [Color(0xFF2E7D32), Color(0xFF42A5F5)],
    ),
    _GameCard(
      type: _GameType.coloring,
      emoji: '🎨',
      title: 'التلوين',
      subtitle: 'لوّن الصور وتعلم كلمات المد مع السين',
      gradient: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    final tk = ++_menuToken;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 350), () {
        if (mounted && tk == _menuToken && _selectedGame == null) {
          _playMenuIntro();
        }
      });
    });
  }

  @override
  void dispose() {
    _menuToken++;
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playMenuIntro() async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(
        'audio/games/games_intro.mp3',
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedGame != null) {
      return _buildGameScreen(_selectedGame!);
    }
    return _buildMenu();
  }

  Widget _buildMenu() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final isTablet = constraints.maxWidth >= 600;

        return Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: isTablet ? 16 : 12,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF01579B)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🦌', style: TextStyle(fontSize: isTablet ? 36 : 28)),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'ألعاب حرف السين (س)',
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navBtn('السابق', Icons.arrow_forward_ios_rounded, widget.onPrevious),
                  _navBtn('التالي', Icons.arrow_back_ios_rounded, widget.onNext, isNext: true),
                ],
              ),
            ),
            // Game grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(isTablet ? 20 : 12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLandscape ? 3 : 2,
                  crossAxisSpacing: isTablet ? 16 : 10,
                  mainAxisSpacing: isTablet ? 16 : 10,
                  childAspectRatio: isTablet ? 1.1 : 0.95,
                ),
                itemCount: _games.length,
                itemBuilder: (ctx, i) => _buildGameCard(_games[i], i),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _navBtn(String label, IconData icon, VoidCallback onTap, {bool isNext = false}) {
    return ElevatedButton.icon(
      onPressed: () {
        HapticFeedback.lightImpact();
        AudioService.instance.stop();
        onTap();
      },
      icon: isNext ? const SizedBox.shrink() : Icon(icon, size: 16),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
          if (isNext) const SizedBox(width: 4),
          if (isNext) Icon(icon, size: 16),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 2,
      ),
    );
  }

  Widget _buildGameCard(_GameCard game, int index) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        AudioService.instance.stop();
        setState(() => _selectedGame = game.type);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: game.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: game.gradient.first.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(game.emoji, style: TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(
              game.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                game.subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
        ),
      ).animate(delay: Duration(milliseconds: index * 60)).fadeIn().scale(),
    );
  }

  Widget _buildGameScreen(_GameType type) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(_gameEmoji(type), style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    _gameTitle(type),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  final tk = ++_menuToken;
                  AudioService.instance.stop();
                  setState(() => _selectedGame = null);
                  Future.delayed(const Duration(milliseconds: 350), () {
                    if (mounted && tk == _menuToken && _selectedGame == null) {
                      _playMenuIntro();
                    }
                  });
                },
                icon: const Icon(Icons.apps_rounded, size: 20),
                label: const Text(
                  'القائمة',
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _buildGame(type)),
      ],
    );
  }

  String _gameEmoji(_GameType type) {
    switch (type) {
      case _GameType.fishing: return '🎣';
      case _GameType.beehive: return '🍯';
      case _GameType.circus: return '🎪';
      case _GameType.words: return '📝';
      case _GameType.coloring: return '🎨';
    }
  }

  String _gameTitle(_GameType type) {
    switch (type) {
      case _GameType.fishing: return 'لعبة صيد الحروف';
      case _GameType.beehive: return 'خلية النحل';
      case _GameType.circus: return 'السيرك';
      case _GameType.words: return 'مطابقة الكلمات';
      case _GameType.coloring: return 'التلوين';
    }
  }

  Widget _buildGame(_GameType type) {
    switch (type) {
      case _GameType.fishing: return const SeenWordFishingGame();
      case _GameType.beehive: return const SeenBeeHiveGame();
      case _GameType.circus: return const SeenCircusGame();
      case _GameType.words: return const SeenWordsMatchGame();
      case _GameType.coloring: return const SeenColoringGame();
    }
  }
}
