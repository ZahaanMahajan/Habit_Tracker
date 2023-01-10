// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:habit_tracker/components/month_summary.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/adapters.dart';
import '../components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDataBase db = HabitDataBase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // if there is no current habit, then it is the first
    // time opening the app, then create the default data.

    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // there already exists data, this is not the first time.
    else {
      db.loadData();
    }

    // update database
    db.updateDataBase();

    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateDataBase();
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onCancel: cancelDialogBox,
          onSave: saveNewHabit,
          hintText: "Enter Habit Name",
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();

    db.updateDataBase();
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitNameController,
            onSave: () => saveExistingHabit(index),
            onCancel: cancelDialogBox,
            hintText: db.todaysHabitList[index][0],
          );
        });
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Habit Tracker",
          style: TextStyle(
            color: Color(0xFF292D32),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Color(0xFFEFEEEE),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFEFEEEE),
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: ListView(
        children: [
          // monthly summary
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                deleteFunction: (context) => deleteHabit(index),
                settingFunction: (context) => openHabitSettings(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
