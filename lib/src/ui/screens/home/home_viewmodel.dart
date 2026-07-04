import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:habit_tracker/src/domain/repostiories/habit_repository.dart';
import 'package:habit_tracker/src/ui/completion_feedback/nice_work.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel(this._habitRepository, this._activeUserRepository) {
    _habitsForToday = _loadHabitsForToday();
  }

  final HabitRepository _habitRepository;
  final ActiveUserRepository _activeUserRepository;
  final List<HabitWithDates> _habits = [];
  final List<bool> _weeklyCompletionStatuses = [];
  late Future<void> _habitsForToday;

  Widget? popUpWidget;

  Future<void> getHabitsForToday() => _habitsForToday;

  List<HabitWithDates> get habits => List.unmodifiable(_habits);

  int get habitsLeft => _habits.length;

  List<bool> get weeklyCompletionStatuses =>
      List.unmodifiable(_weeklyCompletionStatuses);

  double get weeklyCompletionPercent {
    if (_weeklyCompletionStatuses.isEmpty) return 0;
    final completed = _weeklyCompletionStatuses
        .where((status) => status)
        .length;
    return completed / _weeklyCompletionStatuses.length;
  }

  void closePopUp() {
    popUpWidget = null;
    notifyListeners();
  }

  Future<void> markHabitAsDone(HabitWithDates habitWithDates) async {
    final habitIndex = _habits.indexWhere(
      (item) => item.habit.name == habitWithDates.habit.name,
    );
    if (habitIndex == -1) return;

    _habits.removeAt(habitIndex);
    final earnedPoints = habitWithDates.habit.priorityLevel + 1;
    popUpWidget = NiceWork(points: earnedPoints, homeViewmodel: this);
    notifyListeners();

    await _habitRepository.markHabitAsCompleted(
      habitWithDates.habit.name,
      DateTime.now(),
    );
    await _activeUserRepository.addPoints(earnedPoints);

    if (_habits.isEmpty) {
      await _habitRepository.markDayAsCompleted(DateTime.now());
      await _loadWeeklyCompletionStatuses();
    }

    notifyListeners();
  }

  Future<void> refreshHabitsForToday() async {
    _habitsForToday = _loadHabitsForToday();
    notifyListeners();
    await _habitsForToday;
  }

  Future<void> _loadHabitsForToday() async {
    final today = DateTime.now();
    final habits = await _habitRepository.getHabitForDate(today);

    _habits
      ..clear()
      ..addAll(habits);

    if (_habits.isEmpty) {
      await _habitRepository.markDayAsCompleted(today);
    } else {
      await _habitRepository.markDayAsIncomplete(today);
    }

    await _loadWeeklyCompletionStatuses();
    notifyListeners();
  }

  Future<void> _loadWeeklyCompletionStatuses() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final tomorrow = today.add(const Duration(days: 1));
    final completedDays = await _habitRepository.getCompletedDaysBetween(
      monday,
      tomorrow,
    );
    final completedDates = completedDays
        .map((date) => DateTime(date.year, date.month, date.day))
        .toSet();

    _weeklyCompletionStatuses
      ..clear()
      ..addAll(
        List.generate(
          today.difference(monday).inDays + 1,
          (index) => completedDates.contains(monday.add(Duration(days: index))),
        ),
      );
  }
}
