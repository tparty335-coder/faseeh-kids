import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/jeem/jeem_coloring_game.dart';

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

/// محطة ألعاب حرف الجيم — مطابقة تماماً لمحطة ألعاب حرف الباء
class JeemGamesStation extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const JeemGamesStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  ConsumerState<JeemGamesStation> createState() => _JeemGamesStationState();
}

class _JeemGamesStationState extends ConsumerState<JeemGamesStation> {
  _GameType? _selectedGame;
  int _menuToken = 0;

  static const List<_GameCard> _games = [
    _GameCard(
      type: _GameType.fishing,
      emoji: '🎣',
      title: 'صَيْدُ الْكَلِمَاتِ',
      subtitle: 'اِضْغَطْ عَلَى الْكَلِمَةِ الَّتِي بِهَا حَرْفُ (ج)',
      gradient: [Color(0xFF0277BD), Color(0xFF29B6F6)],
    ),
    _GameCard(
      type: _GameType.beehive,
      emoji: '🐝',
      title: 'خَلِيَّةُ الْحَرْفِ',
      subtitle: 'حَدِّدْ مَوْضِعَ الْجِيمِ فِي الْكَلِمَةِ',
      gradient: [Color(0xFFF9A825), Color(0xFFFFD54F)],
    ),
    _GameCard(
      type: _GameType.circus,
      emoji: '🎪',
      title: 'السِّيرْكُ',
      subtitle: 'اِضْغَطْ عَلَى الصُّورَةِ الَّتِي بِهَا حَرْفُ (ج)',
      gradient: [Color(0xFFC62828), Color(0xFFEF9A9A)],
    ),
    _GameCard(
      type: _GameType.words,
      emoji: '📖',
      title: 'لُعْبَةُ الْكَلِمَاتِ',
      subtitle: 'اِضْغَطْ عَلَى اسْمِ الصُّورَةِ الصَّحِيحِ',
      gradient: [Color(0xFF00695C), Color(0xFF42A5F5)],
    ),
    _GameCard(
      type: _GameType.coloring,
      emoji: '🎨',
      title: 'التَّلْوِينُ',
      subtitle: 'اِضْغَطْ عَلَى الْكَلِمَةِ الَّتِي بِهَا مَدٌّ',
      gradient: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: widget.onPrevious,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                    label: const Text(
                      'السَّابِقُ',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      foregroundColor: Colors.grey.shade800,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const Text(
                    '🎮 أَلْعَابُ حَرْفِ الْجِيمِ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF00695C),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: widget.onNext,
                    icon: const Icon(Icons.arrow_back_rounded, size: 20),
                    label: const Text(
                      'إِنْهَاءُ الدَّرْسِ',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00695C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: isLandscape
                    ? GridView.builder(
                        itemCount: _games.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, i) => _buildCard(_games[i], i, isTablet),
                      )
                    : GridView.builder(
                        itemCount: _games.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, i) => _buildCard(_games[i], i, isTablet),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard(_GameCard game, int index, bool isTablet) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _menuToken++;
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
              color: game.gradient.first.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(game.emoji, style: TextStyle(fontSize: isTablet ? 48 : 36)),
            const SizedBox(height: 8),
            Text(
              game.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
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
                      color: Color(0xFF00695C),
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
                  'الْأَلْعَابُ',
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00695C),
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
      case _GameType.beehive: return '🐝';
      case _GameType.circus: return '🎪';
      case _GameType.words: return '📖';
      case _GameType.coloring: return '🎨';
    }
  }

  String _gameTitle(_GameType type) {
    switch (type) {
      case _GameType.fishing: return 'صَيْدُ الْكَلِمَاتِ';
      case _GameType.beehive: return 'خَلِيَّةُ الْحَرْفِ';
      case _GameType.circus: return 'السِّيرْكُ';
      case _GameType.words: return 'لُعْبَةُ الْكَلِمَاتِ';
      case _GameType.coloring: return 'التَّلْوِينُ';
    }
  }

  Widget _buildGame(_GameType type) {
    switch (type) {
      case _GameType.fishing: return const JeemWordFishingGame();
      case _GameType.beehive: return const JeemBeeHiveGame();
      case _GameType.circus: return const JeemCircusGame();
      case _GameType.words: return const JeemWordsMatchGame();
      case _GameType.coloring: return const JeemColoringGame();
    }
  }
}
