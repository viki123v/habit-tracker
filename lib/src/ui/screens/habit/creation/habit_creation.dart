import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/core/theme/border_sizings.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_dto.dart';

class HabitCreation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HabitCreationState();
}

//TODO: create some components
//-Input field
//-Circular buttons
//-Buttons
class _HabitCreationState extends State<HabitCreation> {
  final _habitDto = HabitDto();

  final _titleController = TextEditingController();
  final _priorityContorller = TextEditingController();
  final _selected_freq = 1;
  final _fire_selected = 0;

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
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
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
                  children: ["Daily", "Weekly", "Montly"].asMap().entries.map((
                    entry,
                  ) {
                    final index = entry.key;
                    final frequency = entry.value;

                    return Expanded(
                      child: _selected_freq == index
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
            _MontlyInputState(),
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
                        final opacity = _fire_selected == i ? 0.9 : 0.2;
                        return Icon(
                          Icons.local_fire_department_outlined,
                          size: constraints.maxWidth * .2 > 70
                              ? 40
                              : constraints.maxWidth * .2,
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
            Padding(
              padding: EdgeInsetsDirectional.only(top: 20),
              child: FilledButton(
                onPressed: () {},
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: ColorPalette.primary, // STATE:
                    child: Text("Save Habit", textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyDays extends StatelessWidget {
  final _selectedDays = <int>[1];
  static const _days = ["M", "T", "W", "T", "F", "S", "S"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.stylus,
          },
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _days.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            if (_selectedDays.contains(index)) {
              return FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: const Size.square(52),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                onPressed: () {},
                child: Text(_days[index]).bodyText(),
              );
            }

            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.square(52),
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: Colors.grey.withAlpha((.03 * 255).round()),
              ),
              onPressed: () {},
              child: Text(_days[index]).bodyText(),
            );
          },
        ),
      ),
    );
  }
}

class _DayInput extends StatefulWidget {
  @override
  State<_DayInput> createState() => _DayInputState();
}

class _DayInputState extends State<_DayInput> {
  static const _inputHeight = 48.0;

  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  String _selectedMeridian = 'AM';

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 56,
          height: _inputHeight,
          child: TextFormField(
            controller: _hourController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              const _IntegerRangeFormatter(min: 1, max: 12),
            ],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ),
        Text(":").bodyText(),
        SizedBox(
          width: 56,
          height: _inputHeight,
          child: TextFormField(
            controller: _minuteController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              const _IntegerRangeFormatter(min: 0, max: 59),
            ],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          height: _inputHeight,
          child: DropdownButtonFormField<String>(
            initialValue: _selectedMeridian,
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'AM', child: Text('AM')),
              DropdownMenuItem(value: 'PM', child: Text('PM')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedMeridian = value);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _MontlyInputState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text("monthly");
  }
}

class _IntegerRangeFormatter extends TextInputFormatter {
  const _IntegerRangeFormatter({required this.min, required this.max});

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}
