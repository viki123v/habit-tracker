import 'package:flutter/material.dart';
import 'package:habit_tracker/src/data/models/habit_with_dates.dart';
import 'package:habit_tracker/src/domain/repostiories/habit_repository.dart';
import 'package:habit_tracker/src/ui/completion_feedback/nice_work.dart';

class HomeViewmodel extends ChangeNotifier{
  Widget? popUpWidget = null; 
  HabitRepository _habitRepository; 

  HomeViewmodel(this._habitRepository);

  void closePopUp(){
    popUpWidget = null; 
    notifyListeners();
  }

  void markedHabitAsDone(int points, ){
    popUpWidget = NiceWork(points: points, homeViewmodel: this);
    notifyListeners();
  }

  Future<List<HabitWithDates>> getHabitsForToday() async {
    return _habitRepository.getHabitForDate(DateTime.now()); 
  }
}