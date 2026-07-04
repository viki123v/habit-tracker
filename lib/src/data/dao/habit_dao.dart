import 'package:floor/floor.dart';

import '../models/completed_day.dart';
import '../models/completed_habit.dart';
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

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveCompletedDay(CompletedDay completedDay);

  @Query("SELECT * FROM CompletedDays WHERE date = :date LIMIT 1")
  Future<CompletedDay?> getCompletedDay(DateTime date);

  @Query(
    "SELECT * FROM CompletedDays WHERE date >= :startDate AND date < :endDate",
  )
  Future<List<CompletedDay>> getCompletedDaysBetween(
    DateTime startDate,
    DateTime endDate,
  );

  @Query("DELETE FROM CompletedDays WHERE date = :date")
  Future<void> deleteCompletedDay(DateTime date);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveCompletedHabit(CompletedHabit completedHabit);

  @Query(
    "SELECT * FROM CompletedHabits "
    "WHERE habitName = :habitName AND date = :date LIMIT 1",
  )
  Future<CompletedHabit?> getCompletedHabit(String habitName, DateTime date);

  @Query("SELECT * FROM CompletedHabits WHERE date = :date")
  Future<List<CompletedHabit>> getCompletedHabitsForDate(DateTime date);
}
