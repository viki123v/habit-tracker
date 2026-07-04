import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/shared/full_width_button.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_creation_viewmodel.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/priority_level.dart';
import 'package:provider/provider.dart';

import 'frequency_selector.dart';

class HabitCreation extends StatefulWidget {
  const HabitCreation({super.key});

  @override
  State<StatefulWidget> createState() => _HabitCreationState();
}

class _HabitCreationState extends State<HabitCreation> {
  final _titleController = TextEditingController();
  String _selectedFreq = "Daily";
  static const _frequencyOptions = ["Daily", "Weekly", "Montly"];

  @override
  Widget build(BuildContext context) {
    final habitCraetionViewModel = context.watch<HabitCreationViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Create a habit").caption(),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
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
                onChanged: (value) {
                  habitCraetionViewModel.dto.name = value;
                },
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
                    children: _frequencyOptions
                        .map(
                          (option) => Expanded(
                            child: _selectedFreq == option
                                ? FilledButton(
                                    onPressed: () {},
                                    child: Text(option).bodyText(),
                                  )
                                : OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedFreq = option;
                                      });
                                    },
                                    child: Text(option).bodyText(),
                                  ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              FrequencySelector(selectedFreq: _selectedFreq, dto: habitCraetionViewModel.dto),
              PriorityLevel(dto: habitCraetionViewModel.dto),
              PrimaryFullWidthButton(
                "Save Habit",
                onPressed: () async {
                  habitCraetionViewModel.saveHabit(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
