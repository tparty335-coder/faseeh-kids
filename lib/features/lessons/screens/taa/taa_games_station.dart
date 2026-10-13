import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/games/screens/Taa/taa_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/Taa/taa_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/Taa/taa_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/Taa/taa_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/Taa/taa_coloring_game.dart';

// â”€â”€â”€ ط£ظ†ظˆط§ط¹ ط§ظ„ط£ظ„ط¹ط§ط¨ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
enum _GameType { fishing, beehive, circus, words, coloring }

// â”€â”€â”€ ط¨ط·ط§ظ‚ط© ط§ظ„ظ„ط¹ط¨ط© ظپظٹ ط§ظ„ظ‚ط§ط¦ظ…ط© â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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

/// ظ…ط­ط·ط© ط£ظ„ط¹ط§ط¨ ط­ط±ظپ ط§ظ„ط¨ط§ط، â€” ظ…ط·ط§ط¨ظ‚ط© طھظ…ط§ظ…ط§ظ‹ ظ„ظ…ط­ط·ط© ط£ظ„ط¹ط§ط¨ ط­ط±ظپ ط§ظ„ط£ظ„ظپ
class TaaGamesStation extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const TaaGamesStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  ConsumerState<TaaGamesStation> createState() => _TaaGamesStationState();
}

class _TaaGamesStationState extends ConsumerState<TaaGamesStation> {
  _GameType? _selectedGame;

  // ط§ظ„ط£ظ„ط¹ط§ط¨ ط§ظ„ط®ظ…ط³ط© ظ…ط·ط§ط¨ظ‚ط© ظ„ظ„ط£ط³ط·ظˆط§ظ†ط© ط§ظ„ط£طµظ„ظٹط©
  static const List<_GameCard> _games = [
    _GameCard(
      type: _GameType.fishing,
      emoji: 'ًںژ£',
      title: 'طµظٹط¯ ط§ظ„ظƒظ„ظ…ط§طھ',
      subtitle: 'ط§ط¶ط؛ط· ط¹ظ„ظ‰ ط§ظ„ظƒظ„ظ…ط© ط§ظ„طھظٹ ط¨ظ‡ط§ ط­ط±ظپ (ط¨)',
      gradient: [Color(0xFF0277BD), Color(0xFF29B6F6)],
    ),
    _GameCard(
      type: _GameType.beehive,
      emoji: 'ًںگ‌',
      title: 'ط®ظ„ظٹط© ط§ظ„ط­ط±ظپ',
      subtitle: 'ط­ط¯ط¯ ظ…ظˆط¶ط¹ ط§ظ„ط¨ط§ط، ظپظٹ ط§ظ„ظƒظ„ظ…ط©',
      gradient: [Color(0xFFF9A825), Color(0xFFFFD54F)],
    ),
    _GameCard(
      type: _GameType.circus,
      emoji: 'ًںژھ',
      title: 'ط§ظ„ط³ظٹط±ظƒ',
      subtitle: 'ط§ط¶ط؛ط· ط¹ظ„ظ‰ ط§ظ„طµظˆط±ط© ط§ظ„طھظٹ ط¨ظ‡ط§ ط­ط±ظپ (ط¨)',
      gradient: [Color(0xFFC62828), Color(0xFFEF9A9A)],
    ),
    _GameCard(
      type: _GameType.words,
      emoji: 'ًں“–',
      title: 'ظ„ط¹ط¨ط© ط§ظ„ظƒظ„ظ…ط§طھ',
      subtitle: 'ط§ط¶ط؛ط· ط¹ظ„ظ‰ ط§ط³ظ… ط§ظ„طµظˆط±ط© ط§ظ„طµط­ظٹط­',
      gradient: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    ),
    _GameCard(
      type: _GameType.coloring,
      emoji: 'ًںژ¨',
      title: 'ط§ظ„طھظ„ظˆظٹظ†',
      subtitle: 'ط§ط¶ط؛ط· ط¹ظ„ظ‰ ط§ظ„ظƒظ„ظ…ط© ط§ظ„طھظٹ ط¨ظ‡ط§ ظ…ط¯',
      gradient: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 350), _playMenuIntro);
    });
  }

  Future<void> _playMenuIntro() async {
    if (!mounted || _selectedGame != null) return;
    try {
      await AudioService.instance.stop();
      // "ط£ظ…ط§ظ…ظƒ ظ…ط¬ظ…ظˆط¹ط© ظ…ظ†" â€” طµظˆطھ ظ‚ط§ط¦ظ…ط© ط§ظ„ط£ظ„ط¹ط§ط¨
      await AudioService.instance.playAsset(
        'audio/lessons/Taa/medium/taa_56.mp3',
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedGame != null) return _buildGameScreen(_selectedGame!);

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Padding(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // â”€â”€ ط¹ظ†ظˆط§ظ† ط§ظ„ظ…ط­ط·ط© â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Row(
            children: [
              Expanded(
                child: Text(
                  'ًں•¹ï¸ڈ ط£ظ„ط¹ط§ط¨ ط­ط±ظپ ط§ظ„ط¨ط§ط،',
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1565C0),
                    fontFamily: 'Cairo',
                  ),
                ).animate().fadeIn().slideX(begin: -0.2),
              ),
              IconButton(
                onPressed: _playMenuIntro,
                icon: const Icon(Icons.volume_up_rounded,
                    color: Color(0xFF1565C0), size: 32),
                tooltip: 'ط¥ط¹ط§ط¯ط© ط§ظ„ط§ط³طھظ…ط§ط¹',
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'ط£ظژظ…ظژط§ظ…ظژظƒظژ ظ…ظژط¬ظ’ظ…ظڈظˆط¹ظژط©ظŒ ظ…ظگظ†ظژ ط§ظ„ظ’ط£ظژظ„ظ’ط¹ظژط§ط¨ظگ ط§ظ„ط´ظژظ‘ظٹظگظ‘ظ‚ظژط©ظگ.. ط§ط®ظ’طھظژط±ظ’ ط§ظ„ظ„ظڈظ‘ط¹ظ’ط¨ظژط©ظژ ط§ظ„ظژظ‘طھظگظٹ طھظڈط­ظگط¨ظڈظ‘ ط£ظژظ†ظ’ طھظژظ„ظ’ط¹ظژط¨ظژظ‡ظژط§ ًںŒں',
            style: TextStyle(
              fontSize: isTablet ? 17 : 14,
              fontWeight: FontWeight.w600,
              color: Colors.brown.shade700,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: isTablet ? 24 : 16),
          // â”€â”€ ط´ط¨ظƒط© ط§ظ„ط£ظ„ط¹ط§ط¨ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: isTablet ? 20 : 14,
              mainAxisSpacing: isTablet ? 20 : 14,
              childAspectRatio: 0.9,
              children: _games.asMap().entries.map((entry) {
                return _buildGameTile(entry.value, entry.key, isTablet);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameTile(_GameCard game, int index, bool isTablet) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedGame = game.type);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: game.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: game.gradient.last.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(game.emoji,
                style: TextStyle(fontSize: isTablet ? 64 : 52)),
            SizedBox(height: isTablet ? 16 : 10),
            Text(
              game.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: isTablet ? 8 : 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                game.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 11,
                  color: Colors.white70,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
        ),
      )
          .animate(delay: Duration(milliseconds: index * 80))
          .fadeIn(duration: 300.ms)
          .scale(
              begin: const Offset(0.85, 0.85), curve: Curves.easeOutBack),
    );
  }

  Widget _buildGameScreen(_GameType type) {
    return Column(
      children: [
        // â”€â”€ ط´ط±ظٹط· ط¹ظ†ظˆط§ظ† ط§ظ„ظ„ط¹ط¨ط© + ط²ط± ط§ظ„ط¹ظˆط¯ط© â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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
                  Text(_gameEmoji(type),
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    _gameTitle(type),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  setState(() => _selectedGame = null);
                  Future.delayed(
                      const Duration(milliseconds: 300), _playMenuIntro);
                },
                icon: const Icon(Icons.apps_rounded, size: 20),
                label: const Text(
                  'ط§ظ„ط£ظ„ط¹ط§ط¨',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
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
      case _GameType.fishing:  return 'ًںژ£';
      case _GameType.beehive:  return 'ًںگ‌';
      case _GameType.circus:   return 'ًںژھ';
      case _GameType.words:    return 'ًں“–';
      case _GameType.coloring: return 'ًںژ¨';
    }
  }

  String _gameTitle(_GameType type) {
    switch (type) {
      case _GameType.fishing:  return 'طµظٹط¯ ط§ظ„ظƒظ„ظ…ط§طھ';
      case _GameType.beehive:  return 'ط®ظ„ظٹط© ط§ظ„ط­ط±ظپ';
      case _GameType.circus:   return 'ط§ظ„ط³ظٹط±ظƒ';
      case _GameType.words:    return 'ظ„ط¹ط¨ط© ط§ظ„ظƒظ„ظ…ط§طھ';
      case _GameType.coloring: return 'ط§ظ„طھظ„ظˆظٹظ†';
    }
  }

  Widget _buildGame(_GameType type) {
    switch (type) {
      case _GameType.fishing:  return const TaaWordFishingGame();
      case _GameType.beehive:  return const TaaBeeHiveGame();
      case _GameType.circus:   return const TaaCircusGame();
      case _GameType.words:    return const TaaWordsMatchGame();
      case _GameType.coloring: return const TaaColoringGame();
    }
  }
}


