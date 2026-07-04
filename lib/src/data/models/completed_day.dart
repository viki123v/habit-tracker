import 'package:floor/floor.dart';

@Entity(tableName: 'CompletedDays')
class CompletedDay {
  @primaryKey
  final DateTime date;

  const CompletedDay(this.date);
}
