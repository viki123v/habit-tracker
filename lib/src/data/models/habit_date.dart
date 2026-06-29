import 'package:floor/floor.dart';

@entity
class HabitDate {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String habitName;
  final DateTime date;

  HabitDate({this.id, required this.habitName, required this.date});
}
