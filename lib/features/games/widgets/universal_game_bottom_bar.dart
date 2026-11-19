import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// شريط التنقّل السفلي الموحّد للألعاب — تصميم واضح وعالي التباين ومتجاوب
/// مع الهواتف الصغيرة والأجهزة اللوحية.
class UniversalGameBottomBar extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback onNext;
  final VoidCallback onReplayAudio;
  final VoidCallback? onGamesMenu;
  final Color accentColor;
  final bool isLastRound;

  const UniversalGameBottomBar({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.onReplayAudio,
    this.onGamesMenu,
    this.accentColor = const Color(0xFF1565C0),
    this.isLastRound = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final compact = w < 420;
    final hPad = compact ? 8.0 : 14.0;
    final gap = compact ? 6.0 : 10.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 8),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              // ── السابق (يمين في RTL) ───────────────────────────────────
              Flexible(
                flex: 3,
                child: _PillActionButton(
                  label: 'السابق',
                  icon: Icons.arrow_forward_rounded,
                  iconLeading: true,
                  enabled: onPrevious != null,
                  backgroundColor: const Color(0xFF1E88E5),
                  disabledBackgroundColor: const Color(0xFFECEFF1),
                  disabledForegroundColor: const Color(0xFF546E7A),
                  disabledBorderColor: const Color(0xFFB0BEC5),
                  compact: compact,
                  onTap: onPrevious == null
                      ? null
                      : () {
                          HapticFeedback.lightImpact();
                          onPrevious!();
                        },
                ),
              ),
              SizedBox(width: gap),

              // ── قائمة الألعاب (بارز في المنتصف) ──────────────────────────
              if (onGamesMenu != null) ...[
                Flexible(
                  flex: 4,
                  child: _PillActionButton(
                    label: 'قائمة الألعاب',
                    icon: Icons.grid_view_rounded,
                    iconLeading: true,
                    enabled: true,
                    gradientColors: const [
                      Color(0xFF2E7D32),
                      Color(0xFF43A047),
                    ],
                    backgroundColor: const Color(0xFF2E7D32),
                    compact: compact,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onGamesMenu!();
                    },
                  ),
                ),
                SizedBox(width: gap),
              ],

              // ── إعادة الصوت ─────────────────────────────────────────────
              Tooltip(
                message: 'إعادة الصوت',
                child: Material(
                  color: const Color(0xFFFB8C00),
                  shape: const CircleBorder(),
                  elevation: 3,
                  shadowColor: const Color(0xFFFB8C00).withValues(alpha: 0.45),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onReplayAudio();
                    },
                    child: const SizedBox(
                      width: 46,
                      height: 46,
                      child: Icon(
                        Icons.volume_up_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: gap),

              // ── التالي (يسار في RTL) ─────────────────────────────────────
              Flexible(
                flex: 3,
                child: _PillActionButton(
                  label: 'التالي',
                  icon: Icons.arrow_back_rounded,
                  iconLeading: false,
                  enabled: true,
                  backgroundColor: const Color(0xFFE53935),
                  compact: compact,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onNext();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool iconLeading;
  final bool enabled;
  final Color backgroundColor;
  final List<Color>? gradientColors;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBorderColor;
  final bool compact;
  final VoidCallback? onTap;

  const _PillActionButton({
    required this.label,
    required this.icon,
    required this.iconLeading,
    required this.enabled,
    required this.backgroundColor,
    this.gradientColors,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.disabledBorderColor,
    required this.compact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = enabled
        ? Colors.white
        : (disabledForegroundColor ?? const Color(0xFF546E7A));
    final radius = BorderRadius.circular(24);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 46, minWidth: 64),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: Ink(
          decoration: BoxDecoration(
            color: enabled
                ? (gradientColors == null ? backgroundColor : null)
                : (disabledBackgroundColor ?? const Color(0xFFECEFF1)),
            gradient: enabled && gradientColors != null
                ? LinearGradient(
                    colors: gradientColors!,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            borderRadius: radius,
            border: !enabled && disabledBorderColor != null
                ? Border.all(color: disabledBorderColor!, width: 1.5)
                : null,
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: backgroundColor.withValues(alpha: 0.32),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 10 : 16,
                vertical: 10,
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconLeading) ...[
                        Icon(icon, color: fg, size: compact ? 18 : 20),
                        const SizedBox(width: 5),
                      ],
                      Text(
                        label,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: compact ? 14 : 15,
                          fontWeight: FontWeight.w800,
                          color: fg,
                        ),
                      ),
                      if (!iconLeading) ...[
                        const SizedBox(width: 5),
                        Icon(icon, color: fg, size: compact ? 18 : 20),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
