import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';

const double _defaultDayWidgetSize = 40;

abstract class DayStatusWidget extends StatelessWidget{
  const DayStatusWidget({super.key});
}

class CompletedDayWidget extends DayStatusWidget{
  const CompletedDayWidget({super.key, this.size = _defaultDayWidgetSize});

  final double size;

  @override
  Widget build(BuildContext context) {
    return _DayWidget(
      size: size,
      backgroundColor: ColorPalette.supportColor1,
      semanticLabel: 'Completed day',
      child: Icon(
        Icons.check_rounded,
        color: ColorPalette.neutral,
        size: size * 0.48,
      ),
    );
  }
}

/// A missed day, represented by a pale red circle and an exclamation mark.
class MissedDayWidget extends DayStatusWidget {
  const MissedDayWidget({super.key, this.size = _defaultDayWidgetSize});

  final double size;

  @override
  Widget build(BuildContext context) {
    return _DayWidget(
      size: size,
      backgroundColor: ColorPalette.danger.withAlpha(20),
      borderColor: ColorPalette.danger.withAlpha(75),
      semanticLabel: 'Missed day',
      child: Icon(
        Icons.priority_high_rounded,
        color: ColorPalette.danger,
        size: size * 0.38,
      ),
    );
  }
}

/// A future day, represented by an empty circle and a small gray square.
class UpcomingDayWidget extends DayStatusWidget {
  const UpcomingDayWidget({super.key, this.size = _defaultDayWidgetSize});

  final double size;

  @override
  Widget build(BuildContext context) {
    return _DayWidget(
      size: size,
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFD9DDE1),
      semanticLabel: 'Upcoming day',
      child: Container(
        width: size * 0.13,
        height: size * 0.13,
        color: const Color(0xFFDDE1E5),
      ),
    );
  }
}

class _DayWidget extends StatelessWidget {
  const _DayWidget({
    required this.size,
    required this.backgroundColor,
    required this.semanticLabel,
    required this.child,
    this.borderColor,
  });

  final double size;
  final Color backgroundColor;
  final Color? borderColor;
  final String semanticLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      image: true,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: borderColor == null
              ? null
              : Border.all(color: borderColor!, width: 2),
        ),
        child: child,
      ),
    );
  }
}
