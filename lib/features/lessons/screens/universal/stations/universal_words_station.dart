import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/services/audio_service.dart';

const double _imgW = 1024;

/// محطة «كلمات الحرف» الشاملة — تعمل بناءً على WordsSpec
/// تدعم الإحداثيات النسبية (0.0..1.0) وإحداثيات البكسل (0..1024)
class UniversalWordsStation extends StatefulWidget {
  final WordsSpec spec;
  final String letter;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const UniversalWordsStation({
    super.key,
    required this.spec,
    required this.letter,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<UniversalWordsStation> createState() => _UniversalWordsStationState();
}

class _UniversalWordsStationState extends State<UniversalWordsStation> {
  int _page = 0;
  int? _open; // فهرس الكلمة المفتوحة (null = القائمة)
  int _token = 0;

  List<WordsPage> get _pages => widget.spec.pages;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 400), _playIntro);
    });
  }

  @override
  void dispose() {
    _token++;
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _say(String path, {int maxMs = 4000}) async {
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
      final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
      if (done != null) {
        await done.first.timeout(
          Duration(milliseconds: maxMs),
          onTimeout: () {},
        );
      } else {
        await Future.delayed(Duration(milliseconds: maxMs));
      }
    } catch (_) {}
  }

  Future<void> _playIntro() async {
    final t = ++_token;
    await _say('audio/lessons/baa/words/kalmat_intro.mp3', maxMs: 2500);
    if (!mounted || t != _token || _open != null) return;
    await _say('audio/lessons/baa/words/kalmat_instruction.mp3', maxMs: 4500);
  }

  void _openWord(int i) {
    if (_pages.isEmpty || i >= _pages[_page].words.length) return;
    HapticFeedback.lightImpact();
    _token++;
    setState(() => _open = i);
    _say(_pages[_page].words[i].audioPath, maxMs: 2500);
  }

  void _closeWord() {
    HapticFeedback.lightImpact();
    _token++;
    AudioService.instance.stop();
    setState(() => _open = null);
  }

  void _setPage(int p) {
    if (p < 0 || p >= _pages.length) return;
    HapticFeedback.selectionClick();
    _token++;
    AudioService.instance.stop();
    setState(() {
      _page = p;
      _open = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.isEmpty) {
      return const Center(
        child: Text(
          'لَا تُوجَدُ كَلِمَاتٌ لِهَذَا الْحَرْفِ',
          style: TextStyle(fontFamily: 'Cairo', fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        Expanded(child: _buildStage()),
        _buildBar(),
      ],
    );
  }

  Widget _buildStage() {
    final pg = _pages[_page];
    final item = (_open != null && _open! < pg.words.length) ? pg.words[_open!] : null;
    final imgPath = item != null ? item.cardImagePath : pg.listImagePath;
    final imgH = item != null ? item.cardHeight : pg.listImageHeight;

    return LayoutBuilder(
      builder: (context, c) {
        final sw = c.maxWidth, sh = c.maxHeight;
        final ia = _imgW / (imgH > 0 ? imgH : 600);
        double dW, dH, ox, oy;
        if (sw / sh < ia) {
          dW = sw;
          dH = sw / ia;
          ox = 0;
          oy = (sh - dH) / 2;
        } else {
          dH = sh;
          dW = sh * ia;
          ox = (sw - dW) / 2;
          oy = 0;
        }
        final s = dW / _imgW;

        Widget spot(Offset center, double r, VoidCallback onTap) {
          final isNorm = center.dx <= 1.0 && center.dy <= 1.0;
          final cx = isNorm ? ox + center.dx * dW : ox + center.dx * s;
          final cy = isNorm ? oy + center.dy * dH : oy + center.dy * s;
          final rad = isNorm ? r * (dW / 800.0) : r * s;
          return Positioned(
            left: cx - rad,
            top: cy - rad,
            width: rad * 2,
            height: rad * 2,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: const SizedBox.expand(),
            ),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imgPath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.amber.shade50,
                  alignment: Alignment.center,
                  child: Text(
                    item != null ? item.word : 'كَلِمَاتُ حَرْفِ (${widget.letter})',
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            if (item == null)
              ...List.generate(pg.words.length, (i) {
                final h = pg.words[i].hotspot;
                final isNormalized = h.right <= 1.05 && h.bottom <= 1.05;
                final left = isNormalized ? ox + h.left * dW : ox + h.left * s;
                final top = isNormalized ? oy + h.top * dH : oy + h.top * s;
                final width = isNormalized ? (h.right - h.left) * dW : (h.right - h.left) * s;
                final height = isNormalized ? (h.bottom - h.top) * dH : (h.bottom - h.top) * s;
                return Positioned(
                  left: left,
                  top: top,
                  width: width,
                  height: height,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _openWord(i),
                    child: const SizedBox.expand(),
                  ),
                );
              })
            else ...[
              // زر السماعة 🔊
              spot(item.speakerOffset, 44, () => _say(item.audioPath, maxMs: 2500)),
              // زر الإغلاق ✖
              spot(item.closeOffset, 44, _closeWord),
            ],
            // مصاصة الانتقال للصفحة التالية
            spot(
              const Offset(876, 365),
              52,
              () => _setPage((_page + 1) % _pages.length),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBar() {
    final last = _page == _pages.length - 1;
    const arabicNums = ['١', '٢', '٣', '٤', '٥', '٦'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_open != null) {
                  _closeWord();
                } else if (_page > 0) {
                  _setPage(_page - 1);
                } else {
                  widget.onPrevious();
                }
              },
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: Text(
                _open != null
                    ? 'رجوع للكلمات'
                    : (_page > 0 ? 'الصفحة السابقة' : 'الكتابة'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43A047),
                foregroundColor: Colors.white,
                elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_pages.length, (i) {
              final active = i == _page;
              return GestureDetector(
                onTap: () => _setPage(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 32 : 26,
                  height: active ? 32 : 26,
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFFE91E63) : Colors.pink.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: active ? Colors.amber : Colors.white,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    i < arabicNums.length ? arabicNums[i] : '${i + 1}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: active ? 15 : 12,
                      fontWeight: FontWeight.w900,
                      color: active ? Colors.white : const Color(0xFF880E4F),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: ElevatedButton.icon(
              onPressed: () {
                if (!last) {
                  _setPage(_page + 1);
                } else {
                  AudioService.instance.stop();
                  widget.onNext();
                }
              },
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: Text(
                last ? 'الألعاب' : 'الصفحة التالية',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43A047),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
