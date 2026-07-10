import 'package:floor/floor.dart';

@Entity(tableName: 'DailyReflections')
class DailyReflection {
  @primaryKey
  final DateTime date;
  final String note;

  const DailyReflection({required this.date, required this.note});
}
