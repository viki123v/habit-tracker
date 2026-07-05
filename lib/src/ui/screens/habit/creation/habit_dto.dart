
import 'package:habit_tracker/src/data/models/habit.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';

class HabitDto {
  String? name;
  List<DateTime>? dates;
  HabitType? type;
  int? priorityLevel; 

  void _valid() {
    if (name == null) {
      throw ArgumentError.notNull('name');
    }
    if (dates == null) {
      throw ArgumentError.notNull('dates');
    }
    if (type == null) {
      throw ArgumentError.notNull('type');
    }
    if (priorityLevel == null) {
      throw ArgumentError.notNull('priorityLevel');
    }
    if(priorityLevel! > 4){
      throw ArgumentError.value(priorityLevel, "The priority level cannot be greater than 5");
    }
  }

  HabitWithDates toModel() {
    _valid();

    return HabitWithDates(
      habit: Habit(name!, type!.name, priorityLevel!),
      dates: dates!,
    );
  }
}
