import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_dto.dart';

class MontlyWidget extends StatefulWidget {
  static const option = "Montly";
  final HabitDto dto;

  const MontlyWidget({super.key, required this.dto});

  @override
  State<MontlyWidget> createState() => _MontlyWidgetState();
}


class _MontlyWidgetState extends State<MontlyWidget> {
  List<DateTime?> _selectedDates = [];

  List<DateTime> _selectedCalendarDatesToDates(List<DateTime?> selectedDates) {
    return selectedDates.whereType<DateTime>().map((selectedDate) {
      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    widget.dto.dates = _selectedCalendarDatesToDates(_selectedDates);

    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.multi,
        firstDayOfWeek: 1,
        controlsHeight: 0,
        hideLastMonthIcon: true,
        hideNextMonthIcon: true,
        disableModePicker: true,
        modePickerBuilder:
            ({required viewMode, required monthDate, isMonthPicker}) =>
                const SizedBox.shrink(),
        dayBorderRadius: BorderRadius.circular(8),
        selectedDayHighlightColor: ColorPalette.primary,
      ),
      value: _selectedDates,
      onValueChanged: (dates) {
        setState(() => _selectedDates = dates);
      },
    );
  }
}
