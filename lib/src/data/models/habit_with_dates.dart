import 'habit.dart';

class HabitWithDates {
  final Habit habit;
  final List<DateTime> dates;

  HabitWithDates({required this.habit, required this.dates});

  /// Whether this habit is scheduled for [date].
  ///
  /// The dates are recurrence selectors rather than concrete occurrences:
  /// weekly habits compare weekdays and monthly habits compare days of month.
  bool occursOn(DateTime date) {
    final type = HabitType.values.byName(habit.type);

    return switch (type) {
      HabitType.daily => true,
      HabitType.weekly => dates.any(
        (selectedDate) => selectedDate.weekday == date.weekday,
      ),
      HabitType.monthly => dates.any(
        (selectedDate) => selectedDate.day == date.day,
      ),
    };
  }
}
