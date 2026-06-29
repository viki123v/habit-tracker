import 'package:floor/floor.dart';

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
}
