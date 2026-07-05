
import 'package:habit_tracker/src/data/models/habit.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';
import 'package:habit_tracker/src/exceptions/habit_dto_conversion.dart';

class HabitDto {
  String? name;
  List<DateTime>? dates;
  HabitType? type;
  int? priorityLevel; 

  void _validate() {
    final maxPriorityLevel = 4; 
    if (name == null || name!.trim().isEmpty) {
      throw HabitDtoConversionException(msg: "Name is empty");
    }
    if (dates == null || dates!.isEmpty) {
      throw HabitDtoConversionException(msg: "Dates are empty");
    }
    if (type == null) {
      throw HabitDtoConversionException(msg: "The type of the habit isn't defined");
    }
    if (priorityLevel == null) {
      throw HabitDtoConversionException(msg: "Priority level is empty"); 
    }
    if(priorityLevel! > maxPriorityLevel){
      throw HabitDtoConversionException(msg: "The priority level cannot be above ${maxPriorityLevel + 1}");
    }
  }

  HabitWithDates toModel() {
    _validate();

    return HabitWithDates(
      habit: Habit(name!, type!.name, priorityLevel!),
      dates: dates!,
    );
  }
}
