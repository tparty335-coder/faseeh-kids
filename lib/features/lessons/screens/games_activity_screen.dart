import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/games/screens/audio_recognition_game.dart';
import 'package:faseeh_kids/features/games/screens/word_builder_game.dart';
import 'package:faseeh_kids/features/games/screens/catch_letter_game.dart';
import 'package:faseeh_kids/features/games/screens/coloring_game.dart';

enum _GameType { audio, word, catch_, coloring }

class GamesActivityScreen extends ConsumerStatefulWidget {
  const GamesActivityScreen({super.key});

  @override
  ConsumerState<GamesActivityScreen> createState() => _GamesActivityScreenState();
}

class _GamesActivityScreenState extends ConsumerState<GamesActivityScreen> {
  _GameType? _selectedGame;

  static const List<_GameCard> _games = [
    _GameCard(
      type: _GameType.audio,
      emoji: '🔊',
      title: 'تمييز الصوت',
      subtitle: 'استمع واختر الحرف الصحيح',
      gradient: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    ),
    _GameCard(
      type: _GameType.word,
      emoji: '🔤',
      title: 'تركيب الكلمة',
      subtitle: 'رتّب الحروف لتكوّن كلمة',
      gradient: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    ),
    _GameCard(
      type: _GameType.catch_,
      emoji: '🎯',
      title: 'صيد الحرف',
      subtitle: 'اصطد الحرف الصحيح!',
      gradient: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
    ),
    _GameCard(
      type: _GameType.coloring,
      emoji: '🎨',
      title: 'لعبة التلوين',
      subtitle: 'لوّن حروف المدود',
      gradient: [Color(0xFFE53935), Color(0xFFEF9A9A)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedGame != null) {
      return _buildGameScreen(_selectedGame!);
    }

    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Padding(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🕹️ ألعاب الحرف',
            style: TextStyle(
              fontSize: isTablet ? 32 : 26,
              fontWeight: FontWeight.bold,
              color: AppColors.desertSand,
              fontFamily: 'Cairo',
            ),
          ).animate().fadeIn().slideX(begin: -0.2),
          const SizedBox(height: 6),
          Text(
            'اختر لعبة وانطلق!',
            style: TextStyle(fontSize: isTablet ? 18 : 14, color: Colors.grey, fontFamily: 'Cairo'),
          ),
          SizedBox(height: isTablet ? 28 : 18),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: isTablet ? 20 : 14,
              mainAxisSpacing: isTablet ? 20 : 14,
              childAspectRatio: 0.9,
              children: _games.asMap().entries.map((entry) {
                final i = entry.key;
                final game = entry.value;
                return _buildGameTile(game, i, isTablet);
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
                  fontSize: isTablet ? 14 : 12,
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
        // Back to games menu bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.desertSand),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  setState(() => _selectedGame = null);
                },
              ),
              Text(
                _getGameTitle(type),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.desertSand,
                  fontFamily: 'Cairo',
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
      case _GameType.audio: return '🔊 تمييز الصوت';
      case _GameType.word: return '🔤 تركيب الكلمة';
      case _GameType.catch_: return '🎯 صيد الحرف';
      case _GameType.coloring: return '🎨 لعبة التلوين';
    }
  }

  Widget _buildGame(_GameType type) {
    switch (type) {
      case _GameType.audio: return const AudioRecognitionGame();
      case _GameType.word: return const WordBuilderGame();
      case _GameType.catch_: return const CatchLetterGame();
      case _GameType.coloring: return const ColoringGame();
    }
  }
}

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
