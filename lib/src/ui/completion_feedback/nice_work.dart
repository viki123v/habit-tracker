import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/core/theme/border_sizings.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/raw.dart';
import 'package:habit_tracker/src/ui/core/theme/spacings.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/home/home_viewmodel.dart';

class NiceWork extends StatelessWidget {
  const NiceWork({
    super.key,
    required this.points,
    required this.homeViewmodel,
  });

  final int points;
  final HomeViewmodel homeViewmodel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: Colors.black.withAlpha((255 * 0.58).round()),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                width: constraints.maxWidth * 0.8,
                height: constraints.maxHeight * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderSizings.xl,
                ),
                child: Padding(
                  padding: EdgeInsets.all(Spacings.comfortable),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: Spacings.cozy,
                        children: [
                          const _CompletionBadge(),
                          Text("Nice Work!").title(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderSizings.xl,
                              color: ColorPalette.secondary.withAlpha(
                                (255 * 0.1).round(),
                              ),
                              border: BoxBorder.all(
                                color: ColorPalette.secondary,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(Spacings.tight),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: ColorPalette.secondary,
                                  ),
                                  Text(
                                    "+$points Points",
                                    style: TextStyle(
                                      color: ColorPalette.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      FilledButton(
                        onPressed: () {
                          homeViewmodel.closePopUp();
                        },
                        style: FilledButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(40),
                            ),
                          ),
                        ),
                        child: Text(
                          "Keep going",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: rawProperties.textSize.size400.toDouble(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CompletionBadge extends StatelessWidget {
  const _CompletionBadge();

  static const double _size = 88;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Habit completed',
      child: SizedBox.square(
        dimension: _size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(ColorPalette.primary, Colors.white, 0.92),
          ),
          child: Center(
            child: SizedBox.square(
              dimension: 74,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(ColorPalette.primary, Colors.white, 0.78),
                ),
                child: Center(
                  child: SizedBox.square(
                    dimension: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primary,
                      ),
                      child: Center(
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 20,
                            weight: 700,
                          ),
                        ),
                      ),
                    ),
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
