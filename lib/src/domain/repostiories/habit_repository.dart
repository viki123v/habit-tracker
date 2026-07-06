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
  }
}
