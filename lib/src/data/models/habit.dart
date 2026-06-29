import 'package:floor/floor.dart';

@entity
class Habit {
  @primaryKey
  final String name;
  final String type;
  final int priorityLevel;

  Habit(this.name, this.type, this.priorityLevel);
}

enum HabitType { daily, weekly, monthly }
