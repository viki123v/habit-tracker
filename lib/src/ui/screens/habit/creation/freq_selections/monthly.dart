import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';

class MontlyWidget extends StatefulWidget {
  const MontlyWidget({super.key});

  @override
  State<MontlyWidget> createState() => _MontlyWidgetState();
}


class _MontlyWidgetState extends State<MontlyWidget> {
  List<DateTime?> _selectedDates = [];

  @override
  Widget build(BuildContext context) {
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

