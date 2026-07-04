import 'package:floor/floor.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';

import '../models/habit.dart';
import '../models/habit_date.dart';

@dao
abstract class HabitDao {
  @Query("SELECT * FROM Habit")
  Future<List<Habit>> getHabits();

  @Query("SELECT * FROM HabitDate WHERE habitName = :habitName")
  Future<List<HabitDate>> getDatesForHabit(String habitName);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> saveHabit(Habit habit);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveHabitDates(List<HabitDate> dates);

  @Query("DELETE FROM HabitDate WHERE habitName = :habitName")
  Future<void> deleteDatesForHabit(String habitName);

  @Query('''
    SELECT DISTINCT Habit.*
    FROM Habit
    LEFT JOIN HabitDate ON Habit.name = HabitDate.habitName
    WHERE Habit.type = 'daily'
       OR (
         HabitDate.date >= :startDate
         AND HabitDate.date < :endDate
       )
    ''')
  Future<List<Habit>> getHabitsScheduledBetween(
    DateTime startDate,
    DateTime endDate,
  );

  @transaction
  Future<List<HabitWithDates>> getHabitsForDate(DateTime date) async {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day + 1);
    final habits = await getHabitsScheduledBetween(startDate, endDate);

    return Future.wait(
      habits.map((habit) async {
        final dateRows = await getDatesForHabit(habit.name);

        return HabitWithDates(
          habit: habit,
          dates: dateRows.map((row) => row.date).toList(),
        );
      }),
    );
  }
}
