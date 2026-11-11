import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_word_fishing_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_beehive_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_circus_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_words_match_game.dart';
import 'package:faseeh_kids/features/games/screens/universal/generic_coloring_game.dart';
import 'package:faseeh_kids/services/audio_service.dart';

enum _GameType { fishing, beehive, circus, words, coloring }

/// محطة الألعاب الموحّدة — تعمل لأي LetterUnitManifest دون تكرار شاشات
class UniversalGamesStation extends StatefulWidget {
  final LetterUnitManifest manifest;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalGamesStation({
    super.key,
    required this.manifest,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<UniversalGamesStation> createState() => _UniversalGamesStationState();
}

class _UniversalGamesStationState extends State<UniversalGamesStation> {
  _GameType? _selectedGame;
  int _menuToken = 0;

  @override
  void initState() {
    super.initState();
    final tk = ++_menuToken;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 350), () async {
        if (mounted && tk == _menuToken && _selectedGame == null) {
          try {
            await AudioService.instance.stop();
            await AudioService.instance.playAsset(
              'audio/games/games_intro.mp3',
              channel: AudioChannel.voice,
            );
          } catch (_) {}
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

  void _backToMenu() {
    AudioService.instance.stop();
    setState(() => _selectedGame = null);
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedGame != null) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: widget.manifest.topBarColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: _backToMenu,
                  icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  tooltip: 'العودة للألعاب',
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _gameTitle(_selectedGame!),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildSelectedGame(_selectedGame!)),
        ],
      );
    }
    return _buildMenu();
  }

  String _gameTitle(_GameType t) {
    final l = widget.manifest.letter;
    switch (t) {
      case _GameType.fishing:
        return '🎣 صيد الكلمات ($l)';
      case _GameType.beehive:
        return '🍯 خلية النحل ($l)';
      case _GameType.circus:
        return '🎪 السيرك ($l)';
      case _GameType.words:
        return '📝 مطابقة الكلمات ($l)';
      case _GameType.coloring:
        return '🎨 التلوين والمدود ($l)';
    }
  }

  Widget _buildSelectedGame(_GameType t) {
    switch (t) {
      case _GameType.fishing:
        return GenericWordFishingGame(manifest: widget.manifest, onExit: _backToMenu);
      case _GameType.beehive:
        return GenericBeehiveGame(manifest: widget.manifest, onExit: _backToMenu);
      case _GameType.circus:
        return GenericCircusGame(manifest: widget.manifest, onExit: _backToMenu);
      case _GameType.words:
        return GenericWordsMatchGame(manifest: widget.manifest, onExit: _backToMenu);
      case _GameType.coloring:
        return GenericColoringGame(manifest: widget.manifest, onExit: _backToMenu);
    }
  }

  Widget _buildMenu() {
    final m = widget.manifest;
    final cards = [
      ('🎣', 'لعبة صيد الحروف', 'اصطد الكلمات التي تحتوي حرف (${m.letter})', _GameType.fishing, const [Color(0xFF00838F), Color(0xFF26C6DA)]),
      ('🍯', 'خلية النحل', 'اختر الحركة الصحيحة لحرف (${m.letter})', _GameType.beehive, const [Color(0xFFF9A825), Color(0xFFFFD54F)]),
      ('🎪', 'السيرك', 'اعثر على الكلمات التي بها حرف (${m.letter})', _GameType.circus, const [Color(0xFFC62828), Color(0xFFEF9A9A)]),
      ('📝', 'مطابقة الكلمات', 'طابق الصورة مع الكلمة الصحيحة', _GameType.words, const [Color(0xFF6A1B9A), Color(0xFFBA68C8)]),
      ('🎨', 'التلوين', 'لوّن الكلمات التي بها مد', _GameType.coloring, const [Color(0xFF1565C0), Color(0xFF42A5F5)]),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final isTablet = constraints.maxWidth >= 600;

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: isTablet ? 14 : 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [m.topBarColor, m.topBarColor.withValues(alpha: 0.78)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(m.mascotEmoji, style: TextStyle(fontSize: isTablet ? 34 : 26)),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'ألعاب حرف (${m.letter})',
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        AudioService.instance.stop();
                        widget.onPrevious();
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      label: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'السابق',
                          maxLines: 1,
                          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        AudioService.instance.stop();
                        widget.onNext();
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                      label: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'إنهاء الدرس 🎉',
                          maxLines: 1,
                          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: m.topBarColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(isTablet ? 18 : 12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLandscape ? 3 : 2,
                  crossAxisSpacing: isTablet ? 14 : 10,
                  mainAxisSpacing: isTablet ? 14 : 10,
                  childAspectRatio: isTablet ? 1.15 : 0.95,
                ),
                itemCount: cards.length,
                itemBuilder: (ctx, i) {
                  final (emoji, title, subtitle, type, grad) = cards[i];
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      AudioService.instance.stop();
                      setState(() => _selectedGame = type);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: grad,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: grad.first.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 34)),
                          const SizedBox(height: 6),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
