import 'package:floor/floor.dart';

@Entity(tableName: 'CompletedHabits', primaryKeys: ['habitName', 'date'])
class CompletedHabit {
  final String habitName;
  final DateTime date;

  const CompletedHabit({required this.habitName, required this.date});
}
