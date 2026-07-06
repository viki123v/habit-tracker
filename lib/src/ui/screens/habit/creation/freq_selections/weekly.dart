import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_dto.dart';

class WeeklyWidget extends StatefulWidget {
  static const option = "Weekly";
  final _selectedDays = <int>[];
  static const _days = ["M", "T", "W", "T", "F", "S", "S"];
  final HabitDto dto;

  WeeklyWidget({super.key, required this.dto});

  @override
  State<StatefulWidget> createState() => _WeeklyDays();
}

class _WeeklyDays extends State<WeeklyWidget> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
    widget.dto.dates = _selectedDaysToCurrentWeekDates(widget._selectedDays);

    return SizedBox(
      height: 60,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.stylus,
          },
        ),
        child: RawScrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          interactive: true,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          padding: EdgeInsets.zero,
          thickness: 4,
          radius: const Radius.circular(2),
          thumbColor: Theme.of(context).colorScheme.primary,
          trackColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          trackBorderColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: WeeklyWidget._days.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                if (widget._selectedDays.contains(index)) {
                  return FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: const Size.square(52),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      setState(() {
                        widget._selectedDays.remove(index);
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
                      widget._selectedDays.add(index);
                    });
                  },
                  child: Text(WeeklyWidget._days[index]).bodyText(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
