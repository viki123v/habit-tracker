import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/src/data/models/habit.dart';

import 'freq_selections/monthly.dart';
import 'freq_selections/weekly.dart';
import 'habit_dto.dart';

class FrequencySelector extends StatefulWidget {
  final String _selectedFreq;
  final HabitDto _dto;

  const FrequencySelector({
    super.key,
    required this._selectedFreq,
    required this._dto,
  });

  @override
  State<FrequencySelector> createState() => _FrequencySelectorState();
}

class _FrequencySelectorState extends State<FrequencySelector> {
  @override
  Widget build(BuildContext context) {
    late final Widget child;

    if (MontlyWidget.option == widget._selectedFreq) {
      widget._dto.type = HabitType.monthly;
      child = MontlyWidget(key: const ValueKey('monthly'), dto: widget._dto);
    } else if (WeeklyWidget.option == widget._selectedFreq) {
      widget._dto.type = HabitType.weekly;
      child = WeeklyWidget(key: const ValueKey('weekly'), dto: widget._dto);
    } else {
      widget._dto.type = HabitType.daily;
      widget._dto.dates = [];
      child = const SizedBox(key: ValueKey('daily'));
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }
}
