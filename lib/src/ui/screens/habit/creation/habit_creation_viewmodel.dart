import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/domain/repostiories/habit_repository.dart';
import 'package:habit_tracker/src/ui/screens/habit/creation/habit_dto.dart';

class HabitCreationViewmodel extends ChangeNotifier {
  final HabitDto dto = HabitDto();
  final HabitRepository _habitRepository;

  HabitCreationViewmodel(this._habitRepository);

  void saveHabit(BuildContext ctx) async {
    await _habitRepository.saveHabitWithDates(dto.toModel());
    if (ctx.mounted) {
      ctx.pop();
    }
  }
}
