import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/services/audio_service.dart';

// ─── محطة «كلمات الحرف» لحرف الألف (٥ صفحات × ٤ كلمات = ٢٠ كلمة) ─────────────
// مطابقة تماماً لشاشات وأصوات الأسطوانة الأصلية (ahdaf_a4.swf) وبنفس هيكل BaaWordsStation:
// • تعرض كل صفحة ٤ كلمات داخل مثلثات ملونة (أحمر، برتقالي، أخضر، أزرق).
// • عند الضغط على أي كلمة تفتح بطاقتها المنبثقة (الصورة + الكلمة بحرف الألف بالأحمر)
//   ويُنطق اسم الكلمة فوراً بالصوت الأصلي للأسطوانة.
// • زر السماعة 🔊 يعيد نطق الكلمة، وزر الإغلاق ✖ يعيد التلميذ لقائمة كلمات الصفحة.
// • يمكن التنقل بين الصفحات الخمس عبر المصاصة المرقّمة (١..٥) بيد الفتاة أو أزرار الشريط السفلي.

const double _imgW = 1024;
const String _dir = 'assets/images/lessons/alif/words/';

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

const _Hot _triRed = _Hot(470, 96, 790, 178);
const _Hot _triOrange = _Hot(76, 178, 390, 260);
const _Hot _triGreen = _Hot(470, 274, 790, 356);
const _Hot _triBlue = _Hot(76, 360, 390, 444);

const Offset _speakerPos = Offset(115, 145);
const Offset _closePos = Offset(756, 145);

/// الصفحات الخمس لكلمات حرف الألف (٢٠ كلمة أصلية من ahdaf_a4.swf)
const List<_WordsPage> _pages = [
  // ─── الصفحة 1: أَشْجَار ، أَرْنَب ، أَسَد ، أَكَلَ ───
  _WordsPage(
    listImage: '${_dir}alif_words_p1_list.png',
    listH: 506,
    words: [
      _WordItem(
        word: 'أَشْجَار',
        cardImage: '${_dir}alif_words_p1_card_1.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p1_ashjar.mp3',
        triangle: _triRed,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'أَرْنَب',
        cardImage: '${_dir}alif_words_p1_card_2.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p1_arnab.mp3',
        triangle: _triOrange,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'أَسَد',
        cardImage: '${_dir}alif_words_p1_card_3.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p1_asad.mp3',
        triangle: _triGreen,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'أَكَلَ',
        cardImage: '${_dir}alif_words_p1_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p1_akala.mp3',
        triangle: _triBlue,
        speaker: _speakerPos,
        close: _closePos,
      ),
    ],
  ),

  // ─── الصفحة 2: سَأَلَ ، إِبْرَة ، قَرَأَ ، إِينَاسُ ───
  _WordsPage(
    listImage: '${_dir}alif_words_p2_list.png',
    listH: 506,
    words: [
      _WordItem(
        word: 'سَأَلَ',
        cardImage: '${_dir}alif_words_p2_card_1.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p2_saala.mp3',
        triangle: _triRed,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'إِبْرَة',
        cardImage: '${_dir}alif_words_p2_card_2.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p2_ibra.mp3',
        triangle: _triOrange,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'قَرَأَ',
        cardImage: '${_dir}alif_words_p2_card_3.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p2_qaraa.mp3',
        triangle: _triGreen,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'إِينَاسُ',
        cardImage: '${_dir}alif_words_p2_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p2_inas.mp3',
        triangle: _triBlue,
        speaker: _speakerPos,
        close: _closePos,
      ),
    ],
  ),

  // ─── الصفحة 3: أُذُن ، رَأْس ، أُمِّي ، فَأْس ───
  _WordsPage(
    listImage: '${_dir}alif_words_p3_list.png',
    listH: 506,
    words: [
      _WordItem(
        word: 'أُذُن',
        cardImage: '${_dir}alif_words_p3_card_1.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p3_udhun.mp3',
        triangle: _triRed,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'رَأْس',
        cardImage: '${_dir}alif_words_p3_card_2.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p3_ras.mp3',
        triangle: _triOrange,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'أُمِّي',
        cardImage: '${_dir}alif_words_p3_card_3.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p3_ummi.mp3',
        triangle: _triGreen,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'فَأْس',
        cardImage: '${_dir}alif_words_p3_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p3_faas.mp3',
        triangle: _triBlue,
        speaker: _speakerPos,
        close: _closePos,
      ),
    ],
  ),

  // ─── الصفحة 4: آمَالُ ، أَهْرَام ، الأُولَى ، حِصَان ───
  _WordsPage(
    listImage: '${_dir}alif_words_p4_list.png',
    listH: 506,
    words: [
      _WordItem(
        word: 'آمَالُ',
        cardImage: '${_dir}alif_words_p4_card_1.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p4_amal.mp3',
        triangle: _triRed,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'أَهْرَام',
        cardImage: '${_dir}alif_words_p4_card_2.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p4_ahram.mp3',
        triangle: _triOrange,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'الأُولَى',
        cardImage: '${_dir}alif_words_p4_card_3.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p4_oula.mp3',
        triangle: _triGreen,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'حِصَان',
        cardImage: '${_dir}alif_words_p4_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p4_hisan.mp3',
        triangle: _triBlue,
        speaker: _speakerPos,
        close: _closePos,
      ),
    ],
  ),

  // ─── الصفحة 5: زَرَافَة ، بَاب ، تُفَّاحَة ، كِتَاب ───
  _WordsPage(
    listImage: '${_dir}alif_words_p5_list.png',
    listH: 506,
    words: [
      _WordItem(
        word: 'زَرَافَة',
        cardImage: '${_dir}alif_words_p5_card_1.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p5_zarafa.mp3',
        triangle: _triRed,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'بَاب',
        cardImage: '${_dir}alif_words_p5_card_2.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p5_bab.mp3',
        triangle: _triOrange,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'تُفَّاحَة',
        cardImage: '${_dir}alif_words_p5_card_3.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p5_tuffaha.mp3',
        triangle: _triGreen,
        speaker: _speakerPos,
        close: _closePos,
      ),
      _WordItem(
        word: 'كِتَاب',
        cardImage: '${_dir}alif_words_p5_card_4.png',
        cardH: 506,
        audio: 'audio/lessons/alif/words/p5_kitab.mp3',
        triangle: _triBlue,
        speaker: _speakerPos,
        close: _closePos,
      ),
    ],
  ),
];

class AlifWordsStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AlifWordsStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<AlifWordsStation> createState() => _AlifWordsStationState();
}

class _AlifWordsStationState extends State<AlifWordsStation> {
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
    await _say('audio/lessons/alif/words/kalmat_intro.mp3', maxMs: 2500);
    if (!mounted || t != _token || _open != null) return;
    await _say('audio/lessons/alif/words/kalmat_instruction.mp3', maxMs: 5000);
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
              spot(item.speaker, 40, () => _say(item.audio, maxMs: 2500)),
              // زر الإغلاق ✖ أعلى يمين البطاقة
              spot(item.close, 40, _closeWord),
            ],
            // منطقة النقر على المصاصة المرقّمة بيد الفتاة (للانتقال للصفحة التالية كما في الأسطوانة)
            spot(
              const Offset(876, 355),
              48,
              () => _setPage((_page + 1) % _pages.length),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBar() {
    final last = _page == _pages.length - 1;
    const arabicNums = ['١', '٢', '٣', '٤', '٥'];
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
          // أزرار صفحات الكلمات الخمس (١ ، ٢ ، ٣ ، ٤ ، ٥)
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
