// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';
import 'package:habit_tracker/src/data/models/completed_day.dart';
import 'package:habit_tracker/src/data/models/completed_habit.dart';
import 'package:habit_tracker/src/data/models/daily_reflection.dart';
import 'package:habit_tracker/src/data/models/habit_date.dart';
import 'package:habit_tracker/src/data/type_converters/date_time_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/habit_dao.dart';
import 'models/habit.dart';

part "database.g.dart"; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(
  version: 6,
  entities: [
    ActiveUser,
    Habit,
    HabitDate,
    CompletedDay,
    CompletedHabit,
    DailyReflection,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  ActiveUserDao get activeUserDao;
  HabitDao get habitDao;
}
