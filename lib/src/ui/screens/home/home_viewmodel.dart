import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/completion_feedback/nice_work.dart';

class HomeViewmodel extends ChangeNotifier{
  Widget? popUpWidget = null; 

  HomeViewmodel();

  void closePopUp(){
    popUpWidget = null; 
    notifyListeners();
  }

  void markedHabitAsDone(int points, ){
    popUpWidget = NiceWork(points: points, homeViewmodel: this);
    notifyListeners();
  }
}