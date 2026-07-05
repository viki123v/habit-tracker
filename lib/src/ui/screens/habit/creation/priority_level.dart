import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_creation_viewmodel.dart';

class PriorityLevel extends StatefulWidget {
  final HabitCreationViewmodel habitCreationViewModel; 
  static final int _maxFireIconsCount = 5; 

  const PriorityLevel({super.key, required this.habitCreationViewModel});

  @override
  State<StatefulWidget> createState() => _PriorityLevelState();
}

class _PriorityLevelState extends State<PriorityLevel> {

  @override
  Widget build(BuildContext context) {
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
                      final opacity =  widget.habitCreationViewModel.dto.priorityLevel != null && widget.habitCreationViewModel.dto.priorityLevel! >= i ? 0.9 : 0.2;
                      return IconButton(
                      onPressed: (){
                        setState(() {
                          widget.habitCreationViewModel.selectFires(i); 
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
