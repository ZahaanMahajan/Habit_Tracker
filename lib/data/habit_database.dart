// ignore_for_file: unused_element

import 'package:habit_tracker/dateTime/date_time.dart';
import 'package:hive_flutter/adapters.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDataBase {
  List todaysHabitList = [];

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      ["Gym", false],
      ["Run", false],
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // if it is a new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    // it is not a new day, load todays data
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDataBase() {
    // update todays entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    //update universal list in case it changed
    //(new habit, edit habit, delete habit)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
  }
}
