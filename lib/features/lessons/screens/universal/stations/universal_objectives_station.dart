import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// ═══════════════════════════════════════════════════════════════════════
/// محطة أهداف الوحدة — عامة ومدفوعة بالبيانات (ObjectivesSpec)
/// مطابقة بصرياً لتصميم محطة أهداف الألف والباء (شخصية متحركة + بطاقة أهداف صفراء غنية)
/// ═══════════════════════════════════════════════════════════════════════
class UniversalObjectivesStation extends StatefulWidget {
  final ObjectivesSpec spec;
  final String letter;
  final String mascotEmoji;
  final Color accentColor;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const UniversalObjectivesStation({
    super.key,
    required this.spec,
    required this.letter,
    required this.mascotEmoji,
    required this.accentColor,
    required this.onNext,
    this.onPrevious,
  });

  @override
  State<UniversalObjectivesStation> createState() =>
      _UniversalObjectivesStationState();
}

class _UniversalObjectivesStationState
    extends State<UniversalObjectivesStation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bobController;
  late final Animation<double> _bobAnimation;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _bobAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _bobController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _playAudio());
  }

  @override
  void dispose() {
    _bobController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playAudio() async {
    if (!mounted) return;
    setState(() => _isPlaying = true);
    try {
      await AudioService.instance.stop();
      await AudioService.instance.playAsset(widget.spec.audioPath);
      final done = AudioService.instance.onPlayerComplete(AudioChannel.voice);
      if (done != null) {
        await done.first.timeout(const Duration(seconds: 40), onTimeout: () {});
      }
    } catch (_) {}
    if (mounted) setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.accentColor;
    final isWide = MediaQuery.sizeOf(context).width > 560;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          // ── 1. خلفية المشهد المشرقة ──────────────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF81D4FA),
                    const Color(0xFFE1F5FE),
                    const Color(0xFFC8E6C9),
                    AppColors.lessonGrass.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),

          // شمس مشرقة في الزاوية العلوية
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.amber.shade300.withValues(alpha: 0.7),
                    Colors.amber.shade100.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // ── 2. رأس الشاشة (كبسولة العنوان) ──────────────────────────────────
          Positioned(
            top: 10,
            left: 12,
            right: 12,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: color, width: 2.2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wb_sunny_rounded, color: Colors.orange, size: 22),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'هَيَّا نَقْرَأُ اللُّغَةَ الْعَرَبِيَّةَ — حَرْفُ (${widget.letter})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
            ),
          ),

          // ── 3. المنطقة الرئيسية (الشخصية + بطاقة الأهداف الصفراء) ─────────────
          Positioned(
            top: 58,
            left: 14,
            right: 14,
            bottom: 68,
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child: _buildMascotColumn(color)),
                      const SizedBox(width: 12),
                      Expanded(flex: 7, child: _buildObjectivesCard(color)),
                    ],
                  )
                : Column(
                    children: [
                      _buildCompactMascotHeader(color),
                      const SizedBox(height: 8),
                      Expanded(child: _buildObjectivesCard(color)),
                    ],
                  ),
          ),

          // ── 4. زر الرجوع وزر التالي ──────────────────────────────────────────
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: widget.onPrevious ?? () {
                      AudioService.instance.stop();
                      Navigator.of(context).maybePop();
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'الرُّجُوعُ لِلْخَرِيطَةِ',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDay,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed: widget.onNext,
                    icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'ابْدَأِ الدَّرْسَ (قِصَّةُ الْحَرْفِ)',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.oasisGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 6,
                    ),
                  ).animate(delay: 400.ms).shimmer(duration: 2.seconds),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMascotColumn(Color color) {
    return AnimatedBuilder(
      animation: _bobAnimation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _bobAnimation.value),
        child: child,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.95),
                border: Border.all(color: Colors.amber.shade400, width: 4),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
              child: Center(
                child: Text(
                  widget.mascotEmoji,
                  style: const TextStyle(fontSize: 60),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                'صَدِيقُ حَرْفِ (${widget.letter})',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _playAudio,
              icon: Icon(
                _isPlaying ? Icons.volume_up_rounded : Icons.replay_rounded,
                size: 18,
              ),
              label: Text(
                _isPlaying ? 'جارٍ الاستماع' : 'اسْتَمِعْ لِلْأَهْدَافِ',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactMascotHeader(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.shade600, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber.shade50,
              border: Border.all(color: Colors.amber.shade400, width: 2.5),
            ),
            child: Center(
              child: Text(widget.mascotEmoji, style: const TextStyle(fontSize: 30)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'صَدِيقُ حَرْفِ (${widget.letter}) يُرَحِّبُ بِكُمْ!',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _playAudio,
            icon: Icon(
              _isPlaying ? Icons.volume_up_rounded : Icons.replay_rounded,
              size: 16,
            ),
            label: Text(
              _isPlaying ? 'يُتلى الآن' : 'اسْتَمِعْ',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectivesCard(Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7).withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFF5D4037), width: 3),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Color(0xFFD84315), size: 26),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'أَهْدَافُ دَرْسِ حَرْفِ (${widget.letter}):',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFBF360C),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.brown.withValues(alpha: 0.35), thickness: 1.5, height: 8),
          const SizedBox(height: 4),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.spec.objectives.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3, left: 8),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.spec.objectives[i],
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A237E),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: (i * 50).ms).fadeIn().slideX(begin: 0.08);
              },
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 350.ms, curve: Curves.easeOutBack);
  }
}
