import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';

class PriorityLevel extends StatefulWidget {
  const PriorityLevel({super.key});

  @override
  State<StatefulWidget> createState() => _PriorityLevelState();
}

class _PriorityLevelState extends State<PriorityLevel> {
  final _fireSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsGeometry.only(top: Spacings.buttonVertical),
      child:
      Column(
      spacing: Spacings.comfortable,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text("Priority Level").subheading(),
            Text("Mild".toUpperCase()), //STATE: This should be state
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: Color.lerp(
                ColorPalette.supportColor3,
                Colors.white,
                .6,
              )?.withAlpha((.3 * 255).round()),
              borderRadius: BorderSizings.m,
              border: BoxBorder.all(
                color: ColorPalette.supportColor3.withAlpha(
                  (0.8 * 255).round(),
                ),
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (i) {
                    final opacity = _fireSelected == i ? 0.9 : 0.2;
                    return Icon(
                      Icons.local_fire_department_outlined,
                      size: constraints.maxWidth * .5 > 100
                          ? 60
                          : constraints.maxWidth * .5,
                      color: ColorPalette.supportColor3.withAlpha(
                        (opacity * 255).round(),
                      ), //STATE:
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
