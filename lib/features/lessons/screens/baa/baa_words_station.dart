import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── محطة «كلمات الحرف» لحرف الباء (٤ صفحات × ٤ كلمات = ١٦ كلمة) ─────────────
// مطابقة تماماً لشاشات وأصوات الأسطوانة الأصلية (ka1b.swf .. ka4b.swf):
// • تعرض كل صفحة ٤ كلمات داخل مثلثات ملونة (أحمر، برتقالي، أخضر، أزرق).
// • عند الضغط على أي كلمة تفتح بطاقتها المنبثقة (الصورة + الكلمة بحرف الباء بالأحمر)
//   ويُنطق اسم الكلمة فوراً بالصوت الأصلي للأسطوانة.
// • زر السماعة 🔊 يعيد نطق الكلمة، وزر الإغلاق ✖ يعيد التلميذ لقائمة كلمات الصفحة.
// • يمكن التنقل بين الصفحات الأربع عبر المصاصة المرقّمة (١..٤) بيد الفتاة أو أزرار الشريط السفلي.

const double _imgW = 1024;
const String _dir = 'assets/images/lessons/baa/words/';

/// منطقة نقر مستطيلة بإحداثيات الصورة الأصلية
class _Hot {
  final double l, t, r, b;
  const _Hot(this.l, this.t, this.r, this.b);
}

class _WordItem {
  final String word;
  final String cardImage;
  final double cardH;
  final String audio;
  final _Hot triangle;
  final Offset speaker;
  final Offset close;
  const _WordItem({
    required this.word,
    required this.cardImage,
    required this.cardH,
    required this.audio,
    required this.triangle,
    required this.speaker,
    required this.close,
  });
}

class _WordsPage {
  final String listImage;
  final double listH;
  final List<_WordItem> words;
  const _WordsPage({
    required this.listImage,
    required this.listH,
    required this.words,
  });
}

/// الصفحات الأربع لكلمات حرف الباء (١٦ كلمة أصلية من ka1b..ka4b.swf)
const List<_WordsPage> _pages = [
  // ─── الصفحة 1 (ka1b.swf): بَقَرَة ، بَاب ، بِطِّيخ ، بِنْت ───
  _WordsPage(
    listImage: '${_dir}baa_words_p1_list.png',
    listH: 503,
    words: [
      _WordItem(
        word: 'بَقَرَة',
        cardImage: '${_dir}baa_words_p1_card_1.png',
        cardH: 506,
        audio: 'audio/lessons/baa/words/p1_baqara.mp3',
        triangle: _Hot(465, 90, 795, 178),
        speaker: Offset(108, 147),
        close: Offset(758, 148),
      ),
      _WordItem(
        word: 'بَاب',
        cardImage: '${_dir}baa_words_p1_card_2.png',
        cardH: 505,
        audio: 'audio/lessons/baa/words/p1_bab.mp3',
        triangle: _Hot(78, 175, 395, 258),
        speaker: Offset(115, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'بِطِّيخ',
        cardImage: '${_dir}baa_words_p1_card_3.png',
        cardH: 504,
        audio: 'audio/lessons/baa/words/p1_betteekh.mp3',
        triangle: _Hot(465, 270, 795, 354),
        speaker: Offset(110, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'بِنْت',
        cardImage: '${_dir}baa_words_p1_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/baa/words/p1_bint.mp3',
        triangle: _Hot(78, 356, 395, 442),
        speaker: Offset(112, 147),
        close: Offset(768, 147),
      ),
    ],
  ),

  // ─── الصفحة 2 (ka2b.swf): بُرْج ، يَكْتُبُ ، ثُعْبَان ، إِبْرَة ───
  _WordsPage(
    listImage: '${_dir}baa_words_p2_list.png',
    listH: 470,
    words: [
      _WordItem(
        word: 'بُرْج',
        cardImage: '${_dir}baa_words_p2_card_1.png',
        cardH: 509,
        audio: 'audio/lessons/baa/words/p2_borg.mp3',
        triangle: _Hot(500, 88, 808, 166),
        speaker: Offset(108, 147),
        close: Offset(758, 148),
      ),
      _WordItem(
        word: 'يَكْتُبُ',
        cardImage: '${_dir}baa_words_p2_card_2.png',
        cardH: 511,
        audio: 'audio/lessons/baa/words/p2_yaktb.mp3',
        triangle: _Hot(138, 162, 438, 244),
        speaker: Offset(115, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'ثُعْبَان',
        cardImage: '${_dir}baa_words_p2_card_3.png',
        cardH: 512,
        audio: 'audio/lessons/baa/words/p2_thoban.mp3',
        triangle: _Hot(500, 252, 808, 334),
        speaker: Offset(118, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'إِبْرَة',
        cardImage: '${_dir}baa_words_p2_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/baa/words/p2_ibra.mp3',
        triangle: _Hot(138, 336, 438, 418),
        speaker: Offset(118, 147),
        close: Offset(768, 147),
      ),
    ],
  ),

  // ─── الصفحة 3 (ka3b.swf): حُبُوب ، طَبِيب ، أَرْنَب ، بَطَّة ───
  _WordsPage(
    listImage: '${_dir}baa_words_p3_list.png',
    listH: 512,
    words: [
      _WordItem(
        word: 'حُبُوب',
        cardImage: '${_dir}baa_words_p3_card_1.png',
        cardH: 515,
        audio: 'audio/lessons/baa/words/p3_hobob.mp3',
        triangle: _Hot(465, 96, 795, 182),
        speaker: Offset(108, 147),
        close: Offset(758, 148),
      ),
      _WordItem(
        word: 'طَبِيب',
        cardImage: '${_dir}baa_words_p3_card_2.png',
        cardH: 506,
        audio: 'audio/lessons/baa/words/p3_tabeeb.mp3',
        triangle: _Hot(78, 178, 395, 264),
        speaker: Offset(110, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'أَرْنَب',
        cardImage: '${_dir}baa_words_p3_card_3.png',
        cardH: 512,
        audio: 'audio/lessons/baa/words/p3_arnab.mp3',
        triangle: _Hot(465, 274, 795, 360),
        speaker: Offset(114, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'بَطَّة',
        cardImage: '${_dir}baa_words_p3_card_4.png',
        cardH: 510,
        audio: 'audio/lessons/baa/words/p3_bata.mp3',
        triangle: _Hot(78, 362, 395, 448),
        speaker: Offset(118, 147),
        close: Offset(768, 147),
      ),
    ],
  ),

  // ─── الصفحة 4 (ka4b.swf): كَلْب ، بِئْر ، بِرْسِيم ، لَبَن ───
  _WordsPage(
    listImage: '${_dir}baa_words_p4_list.png',
    listH: 517,
    words: [
      _WordItem(
        word: 'كَلْب',
        cardImage: '${_dir}baa_words_p4_card_1.png',
        cardH: 505,
        audio: 'audio/lessons/baa/words/p4_kalb.mp3',
        triangle: _Hot(465, 100, 795, 185),
        speaker: Offset(108, 147),
        close: Offset(758, 148),
      ),
      _WordItem(
        word: 'بِئْر',
        cardImage: '${_dir}baa_words_p4_card_2.png',
        cardH: 507,
        audio: 'audio/lessons/baa/words/p4_beer.mp3',
        triangle: _Hot(78, 182, 395, 268),
        speaker: Offset(108, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'بِرْسِيم',
        cardImage: '${_dir}baa_words_p4_card_3.png',
        cardH: 509,
        audio: 'audio/lessons/baa/words/p4_berseem.mp3',
        triangle: _Hot(465, 278, 795, 364),
        speaker: Offset(108, 147),
        close: Offset(764, 147),
      ),
      _WordItem(
        word: 'لَبَن',
        cardImage: '${_dir}baa_words_p4_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/baa/words/p4_laban.mp3',
        triangle: _Hot(78, 366, 395, 452),
        speaker: Offset(118, 147),
        close: Offset(768, 147),
      ),
    ],
  ),
];

class BaaWordsStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaWordsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<BaaWordsStation> createState() => _BaaWordsStationState();
}

class _BaaWordsStationState extends State<BaaWordsStation> {
  int _page = 0;
  int? _open; // فهرس الكلمة المفتوحة (null = القائمة)
  int _token = 0;

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
    HapticFeedback.lightImpact();
    _token++;
    setState(() => _open = i);
    _say(_pages[_page].words[i].audio, maxMs: 2500);
  }

  void _closeWord() {
    HapticFeedback.lightImpact();
    _token++;
    AudioService.instance.stop();
    setState(() => _open = null);
  }

  void _setPage(int targetPage) {
    if (targetPage < 0 || targetPage >= _pages.length) return;
    HapticFeedback.lightImpact();
    _token++;
    AudioService.instance.stop();
    setState(() {
      _page = targetPage;
      _open = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildScene()),
        _buildBar(),
      ],
    );
  }

  Widget _buildScene() {
    final pg = _pages[_page];
    final item = _open == null ? null : pg.words[_open!];
    final imgPath = item?.cardImage ?? pg.listImage;
    final imgH = item?.cardH ?? pg.listH;

    return LayoutBuilder(
      builder: (ctx, c) {
        final sw = c.maxWidth, sh = c.maxHeight;
        final ia = _imgW / imgH;
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
          return Positioned(
            left: ox + center.dx * s - r * s,
            top: oy + center.dy * s - r * s,
            width: r * 2 * s,
            height: r * 2 * s,
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
              child: Image.asset(imgPath, fit: BoxFit.contain),
            ),
            if (item == null)
              ...List.generate(pg.words.length, (i) {
                final h = pg.words[i].triangle;
                return Positioned(
                  left: ox + h.l * s,
                  top: oy + h.t * s,
                  width: (h.r - h.l) * s,
                  height: (h.b - h.t) * s,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _openWord(i),
                    child: const SizedBox.expand(),
                  ),
                );
              })
            else ...[
              // زر السماعة 🔊 أعلى يسار البطاقة
              spot(item.speaker, 36, () => _say(item.audio, maxMs: 2500)),
              // زر الإغلاق ✖ أعلى يمين البطاقة
              spot(item.close, 36, _closeWord),
            ],
            // منطقة النقر على المصاصة المرقّمة بيد الفتاة (للانتقال للصفحة التالية كما في الأسطوانة)
            spot(
              const Offset(876, 365),
              45,
              () => _setPage((_page + 1) % _pages.length),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBar() {
    final last = _page == _pages.length - 1;
    const arabicNums = ['١', '٢', '٣', '٤'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _btn(
            'السابق',
            Icons.arrow_forward_rounded,
            () {
              if (_open != null) {
                _closeWord();
              } else if (_page > 0) {
                _setPage(_page - 1);
              } else {
                widget.onPrevious();
              }
            },
          ),
          const SizedBox(width: 6),
          // أزرار صفحات الكلمات الأربع (١ ، ٢ ، ٣ ، ٤)
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_pages.length, (i) {
                  final active = _page == i;
                  return GestureDetector(
                    onTap: () => _setPage(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFFE91E63)
                            : Colors.pink.shade50,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: active
                              ? const Color(0xFFC2185B)
                              : Colors.pink.shade200,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          arabicNums[i],
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: active ? Colors.white : const Color(0xFFC2185B),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 6),
          _btn(
            'التالي',
            Icons.arrow_back_rounded,
            () {
              if (_open != null) {
                _closeWord();
              } else if (!last) {
                _setPage(_page + 1);
              } else {
                AudioService.instance.stop();
                widget.onNext();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _btn(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
