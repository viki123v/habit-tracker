import 'package:habit_tracker/src/data/models/completed_day.dart';
import 'package:habit_tracker/src/data/models/habit.dart';
import 'package:habit_tracker/src/data/models/habit_date.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';

import '../../data/dao/habit_dao.dart';

class HabitRepository {
  final HabitDao _habitDao;

  HabitRepository(this._habitDao);

  Future<List<HabitWithDates>> getHabitsWithDates() async {
    final habits = await _habitDao.getHabits();
    final habitsWithDates = <HabitWithDates>[];

    for (final habit in habits) {
      final dateRows = await _habitDao.getDatesForHabit(habit.name);
      habitsWithDates.add(
        HabitWithDates(
          habit: habit,
          dates: dateRows.map((row) => row.date).toList(),
        ),
      );
    }

    return habitsWithDates;
  }

  Future<void> saveHabitWithDates(HabitWithDates habitWithDates) async {
    await _habitDao.saveHabit(habitWithDates.habit);
    await _habitDao.deleteDatesForHabit(habitWithDates.habit.name);
    await _habitDao.saveHabitDates(
      habitWithDates.dates
          .map(
            (date) =>
                HabitDate(habitName: habitWithDates.habit.name, date: date),
          )
          .toList(),
    );

    final affectedDates = habitWithDates.habit.type == HabitType.daily.name
        ? [_dateOnly(DateTime.now())]
        : habitWithDates.dates.map(_dateOnly);

    for (final date in affectedDates) {
      await _habitDao.deleteCompletedDay(date);
    }
  }

  Future<List<HabitWithDates>> getHabitForDate(DateTime date) async {
    final habits = await getHabitsWithDates();
    return habits.where((habit) => habit.occursOn(date)).toList();
  }

  Future<bool> isDayCompleted(DateTime date) async {
    return await _habitDao.getCompletedDay(_dateOnly(date)) != null;
  }

  Future<void> markDayAsCompleted(DateTime date) {
    return _habitDao.saveCompletedDay(CompletedDay(_dateOnly(date)));
  }

  Future<List<DateTime>> getCompletedDaysBetween(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final completedDays = await _habitDao.getCompletedDaysBetween(
      _dateOnly(startDate),
      _dateOnly(endDate),
    );
    return completedDays.map((day) => day.date).toList();
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
