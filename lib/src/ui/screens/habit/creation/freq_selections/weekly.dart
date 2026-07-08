import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_dto.dart';

class WeeklyWidget extends StatefulWidget {
  static const option = "Weekly";
  static const _days = ["M", "T", "W", "T", "F", "S", "S"];
  final HabitDto dto;

  const WeeklyWidget({super.key, required this.dto});

  @override
  State<StatefulWidget> createState() => _WeeklyDays();
}

class _WeeklyDays extends State<WeeklyWidget> {
  final _selectedDays = <int>[];

  List<DateTime> _selectedDaysToCurrentWeekDates(List<int> selectedDays) {
    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);
    final monday = currentDate.subtract(
      Duration(days: currentDate.weekday - DateTime.monday),
    );

    return selectedDays.map((selectedDay) {
      if (selectedDay < 0 || selectedDay >= WeeklyWidget._days.length) {
        throw RangeError.range(
          selectedDay,
          0,
          WeeklyWidget._days.length - 1,
          'selectedDay',
        );
      }

      return monday.add(Duration(days: selectedDay));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    widget.dto.dates = _selectedDaysToCurrentWeekDates(_selectedDays);

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
          itemCount: WeeklyWidget._days.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            if (_selectedDays.contains(index)) {
              return FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: const Size.square(52),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  setState(() {
                    _selectedDays.remove(index);
                  });
                },
                child: Text(WeeklyWidget._days[index]).bodyText(),
              );
            }

            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.square(52),
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: Colors.grey.withAlpha((.03 * 255).round()),
              ),
              onPressed: () {
                setState(() {
                  _selectedDays.add(index);
                });
              },
              child: Text(WeeklyWidget._days[index]).bodyText(),
            );
          },
        ),
      ),
    );
  }
}
