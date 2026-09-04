import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/games/screens/word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/circus_game.dart';
import 'package:faseeh_kids/features/games/screens/words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/coloring_madd_game.dart';

enum _GameType { fishing, beehive, circus, words, coloring }

class GamesActivityScreen extends ConsumerStatefulWidget {
  const GamesActivityScreen({super.key});

  @override
  ConsumerState<GamesActivityScreen> createState() => _GamesActivityScreenState();
}

class _GamesActivityScreenState extends ConsumerState<GamesActivityScreen> {
  _GameType? _selectedGame;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 350), _playMenuIntro);
    });
  }

  void _playMenuIntro() async {
    if (!mounted || _selectedGame != null) return;
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(
        'audio/instructions/games_menu_intro.mp3',
        channel: AudioChannel.voice,
      );
    } catch (_) {}
  }

  static const List<_GameCard> _games = [
    _GameCard(
      type: _GameType.fishing,
      emoji: '🎣',
      title: 'صيد الكلمات',
      subtitle: 'اضغط على الكلمة التي بها حرف (أ)',
      gradient: [Color(0xFF0277BD), Color(0xFF29B6F6)],
    ),
    _GameCard(
      type: _GameType.beehive,
      emoji: '🐝',
      title: 'خلية الحرف',
      subtitle: 'اختر حرف الألف بحركته المناسبة',
      gradient: [Color(0xFFF9A825), Color(0xFFFFD54F)],
    ),
    _GameCard(
      type: _GameType.circus,
      emoji: '🎪',
      title: 'السيرك',
      subtitle: 'اضغط على الصورة التي بها حرف (أ)',
      gradient: [Color(0xFFC62828), Color(0xFFEF9A9A)],
    ),
    _GameCard(
      type: _GameType.words,
      emoji: '📖',
      title: 'لعبة الكلمات',
      subtitle: 'اضغط على اسم الصورة الصحيح',
      gradient: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    ),
    _GameCard(
      type: _GameType.coloring,
      emoji: '🎨',
      title: 'التلوين',
      subtitle: 'اضغط على الكلمة التي بها مد',
      gradient: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    ),
  ];

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
          Row(
            children: [
              Expanded(
                child: Text(
                  '🕹️ ألعاب الحرف',
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.desertSand,
                    fontFamily: 'Cairo',
                  ),
                ).animate().fadeIn().slideX(begin: -0.2),
              ),
              IconButton(
                onPressed: _playMenuIntro,
                icon: const Icon(Icons.volume_up_rounded, color: AppColors.desertSand, size: 32),
                tooltip: 'إعادة الاستماع',
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'أَمَامَكَ مَجْمُوعَةٌ مِنَ الْأَسْئِلَةِ الشَّقِيَّةِ.. اخْتَرْ نَوْعَ السُّؤَالِ الَّذِي تُحِبُّ أَنْ تُجِيبَ عَلَيْهِ 🌟',
            style: TextStyle(
              fontSize: isTablet ? 17 : 14,
              fontWeight: FontWeight.w600,
              color: Colors.brown.shade700,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: isTablet ? 24 : 16),
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
            Text(game.emoji, style: TextStyle(fontSize: isTablet ? 64 : 52)),
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
      .scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOutBack),
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
                  const Text('🕹️', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    _getGameTitle(type).replaceAll(RegExp(r'^[^\s]+\s'), ''), // Remove emoji
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.desertSand,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  setState(() => _selectedGame = null);
                  Future.delayed(const Duration(milliseconds: 300), _playMenuIntro);
                },
                icon: const Icon(Icons.apps_rounded, size: 20),
                label: const Text(
                  'العودة إلى الألعاب',
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.desertSand,
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

  String _getGameTitle(_GameType type) {
    switch (type) {
      case _GameType.fishing:  return '🎣 صيد الكلمات';
      case _GameType.beehive:  return '🐝 خلية الحرف';
      case _GameType.circus:   return '🎪 السيرك';
      case _GameType.words:    return '📖 لعبة الكلمات';
      case _GameType.coloring: return '🎨 التلوين';
    }
  }

  Widget _buildGame(_GameType type) {
    switch (type) {
      case _GameType.fishing:  return const WordFishingGame();
      case _GameType.beehive:  return const BeehiveGame();
      case _GameType.circus:   return const CircusGame();
      case _GameType.words:    return const WordsMatchGame();
      case _GameType.coloring: return const ColoringMaddGame();
    }
  }
}

class _GameCard {
  final _GameType type;
  final String emoji, title, subtitle;
  final List<Color> gradient;
  const _GameCard({
    required this.type,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}
