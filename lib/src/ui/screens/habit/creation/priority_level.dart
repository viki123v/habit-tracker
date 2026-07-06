import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_dto.dart';

class PriorityLevel extends StatefulWidget {
  HabitDto _dto;
  int _fireSelected = 0;
  static int _maxFireIconsCount = 5;

  PriorityLevel({super.key, required this._dto});

  @override
  State<StatefulWidget> createState() => _PriorityLevelState();
}

class _PriorityLevelState extends State<PriorityLevel> {

  @override
  Widget build(BuildContext context) {
    widget._dto.priorityLevel = widget._fireSelected;

    return Padding(
      padding: EdgeInsetsGeometry.only(top: Spacings.buttonVertical),
      child: Column(
        spacing: Spacings.compact,
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
                    children: List.generate(PriorityLevel._maxFireIconsCount, (i) {
                      final opacity =  widget._fireSelected >= i ? 0.9 : 0.2;
                      return IconButton(
                      onPressed: (){
                        setState(() {
                          widget._fireSelected = i;
                        });
                      },
                          icon: Icon(
                        Icons.local_fire_department_outlined,
                        size: constraints.maxWidth * .3 > 40
                            ? 50
                            : constraints.maxWidth * .3,
                        color: ColorPalette.supportColor3.withAlpha(
                          (opacity * 255).round(),
                        ), //STATE:
                      ));
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
