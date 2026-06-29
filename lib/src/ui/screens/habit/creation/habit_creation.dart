import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/shared/full_width_button.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/freq_selections/monthly.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/priority_level.dart';

class HabitCreation extends StatefulWidget {
  const HabitCreation({super.key});

  @override
  State<StatefulWidget> createState() => _HabitCreationState();
}

class _HabitCreationState extends State<HabitCreation> {
  final _titleController = TextEditingController();
  final _selectedFreq = 2;
  static const _frequencyOptions = ["Daily", "Weekly", "Montly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a habit").caption(),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(Spacings.buttonVertical),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacings.buttonVertical,
            children: [
              Text("What's your goal").subheading(),
              Text("Start small to build lasting consistency.").caption(),
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                style: TextStylePalette.bodyText,
                maxLength: 20,
              ),
              Text("How often ?").subheading(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha((.1 * 255).round()),
                    borderRadius: BorderSizings.m,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _frequencyOptions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final frequency = entry.value;

                      return Expanded(
                        child: _selectedFreq == index
                            ? FilledButton(
                                onPressed: () {},
                                child: Text(frequency).bodyText(),
                              )
                            : OutlinedButton(
                                onPressed: () {}, //STATE: //DEFEAULT_SELECTION
                                child: Text(frequency).bodyText(),
                              ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              MontlyWidget(),
              PriorityLevel(),
              PrimaryFullWidthButton("Save Habit"),
            ],
          ),
        ),
      ),
    );
  }
}
