// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part "database.g.dart"; // the generated code will be there

@Database(version: 1, entities: [ActiveUser])
abstract class AppDatabase extends FloorDatabase {
  ActiveUserDao get activeUserDao;
}
