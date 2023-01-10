// ignore_for_file: unused_element

import 'package:habit_tracker/dateTime/date_time.dart';
import 'package:hive_flutter/adapters.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDataBase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

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

    // calculate habit complete percentage for each day
    calculateHabitPercentage();

    // load the HeatMap
    loadHeatMap();
  }

  void calculateHabitPercentage() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }
    String percentage = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    // put it in the database
    _myBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percentage);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (var i = 0; i < daysInBetween; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );
      double strength = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentforEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strength).toInt(),
      };

      heatMapDataSet.addEntries(percentforEachDay.entries);
    }
  }
}
