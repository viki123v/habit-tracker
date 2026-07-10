import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/models/completed_habit.dart';
import 'package:habit_tracker/src/domain/repostiories/habit_repository.dart';

enum ReportLoadStatus { loading, ready, error }

class DailyReport {
  DailyReport({
    required this.date,
    required this.scheduledCount,
    required this.completedCount,
  });

  final DateTime date;
  final int scheduledCount;
  final int completedCount;

  int get failedCount => scheduledCount - completedCount;
  bool get hasHabits => scheduledCount > 0;
  bool get isSuccessful => hasHabits && failedCount == 0;
  double get completionRate => hasHabits ? completedCount / scheduledCount : 0;
}

class ReportInsights {
  const ReportInsights({
    required this.bestDayLabel,
    required this.toughestDayLabel,
    required this.recoveryLabel,
  });

  final String bestDayLabel;
  final String toughestDayLabel;
  final String recoveryLabel;
}

class ReportViewModel extends ChangeNotifier {
  ReportViewModel(this._habitRepository) {
    loadReport();
  }

  final HabitRepository _habitRepository;
  final List<DailyReport> _days = [];

  ReportLoadStatus _status = ReportLoadStatus.loading;
  String _reflectionNote = '';
  bool _isSavingReflection = false;
  String? _errorMessage;

  ReportLoadStatus get status => _status;
  List<DailyReport> get days => List.unmodifiable(_days);
  String get reflectionNote => _reflectionNote;
  bool get isSavingReflection => _isSavingReflection;
  String? get errorMessage => _errorMessage;

  DateTime get today => _dateOnly(DateTime.now());
  DateTime get startDate => today.subtract(const Duration(days: 13));
  DateTime get endExclusive => today.add(const Duration(days: 1));

  int get completedHabits =>
      _days.fold(0, (total, day) => total + day.completedCount);

  int get failedHabits =>
      _days.fold(0, (total, day) => total + day.failedCount);

  int get successfulDays => _days.where((day) => day.isSuccessful).length;

  int get trackedDays => _days.where((day) => day.hasHabits).length;

  double get successRate {
    if (trackedDays == 0) return 0;
    return successfulDays / trackedDays;
  }

  ReportInsights get insights {
    final activeDays = _days.where((day) => day.hasHabits).toList();
    if (activeDays.isEmpty) {
      return const ReportInsights(
        bestDayLabel: 'No scheduled habits yet',
        toughestDayLabel: 'No missed habits yet',
        recoveryLabel: 'Add habits to start building a report',
      );
    }

    final bestDay = activeDays.reduce((best, day) {
      if (day.completionRate != best.completionRate) {
        return day.completionRate > best.completionRate ? day : best;
      }
      return day.completedCount > best.completedCount ? day : best;
    });

    final toughestDay = activeDays.reduce((toughest, day) {
      if (day.failedCount != toughest.failedCount) {
        return day.failedCount > toughest.failedCount ? day : toughest;
      }
      return day.scheduledCount > toughest.scheduledCount ? day : toughest;
    });

    final recentSuccessful = activeDays.reversed.any((day) => day.isSuccessful);

    return ReportInsights(
      bestDayLabel:
          '${_shortWeekday(bestDay.date)}: ${bestDay.completedCount}/${bestDay.scheduledCount} done',
      toughestDayLabel: toughestDay.failedCount == 0
          ? 'No missed habits in this window'
          : '${_shortWeekday(toughestDay.date)}: ${toughestDay.failedCount} missed',
      recoveryLabel: recentSuccessful
          ? 'You have at least one fully completed day in this window'
          : 'Pick one small habit to complete today',
    );
  }

  Future<void> loadReport() async {
    _status = ReportLoadStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final habits = await _habitRepository.getHabitsWithDates();
      final completedHabits = await _habitRepository.getCompletedHabitsBetween(
        startDate,
        endExclusive,
      );
      final reflection = await _habitRepository.getDailyReflection(today);
      final completedKeys = completedHabits.map(_completedHabitKey).toSet();

      _days
        ..clear()
        ..addAll(
          List.generate(14, (index) {
            final date = startDate.add(Duration(days: index));
            final scheduledHabits = habits
                .where((habit) => habit.occursOn(date))
                .toList();
            final completedCount = scheduledHabits
                .where(
                  (habit) => completedKeys.contains(
                    _habitDateKey(habit.habit.name, date),
                  ),
                )
                .length;

            return DailyReport(
              date: date,
              scheduledCount: scheduledHabits.length,
              completedCount: completedCount,
            );
          }),
        );

      _reflectionNote = reflection;
      _status = ReportLoadStatus.ready;
    } catch (error) {
      debugPrint('Failed to load report: $error');
      _errorMessage = 'Could not load report';
      _status = ReportLoadStatus.error;
    }

    notifyListeners();
  }

  Future<void> saveReflection(String note) async {
    final normalizedNote = note.trim();
    _isSavingReflection = true;
    notifyListeners();

    try {
      await _habitRepository.saveDailyReflection(today, normalizedNote);
      _reflectionNote = normalizedNote;
    } catch (error) {
      debugPrint('Failed to save reflection: $error');
      _errorMessage = 'Could not save reflection';
    }

    _isSavingReflection = false;
    notifyListeners();
  }

  String _completedHabitKey(CompletedHabit completedHabit) {
    return _habitDateKey(completedHabit.habitName, completedHabit.date);
  }

  String _habitDateKey(String habitName, DateTime date) {
    final dateOnly = _dateOnly(date);
    return '$habitName:${dateOnly.millisecondsSinceEpoch}';
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  String _shortWeekday(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }
}
