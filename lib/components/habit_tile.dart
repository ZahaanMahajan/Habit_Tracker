// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.settingFunction,
  });

  final String habitName;
  final bool habitCompleted;
  void Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? settingFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // settings option
            SlidableAction(
              onPressed: settingFunction,
              icon: Icons.settings,
              backgroundColor: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(12),
            ),
            // delete option
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                offset: Offset(-6.0, -6.0),
                blurRadius: 5.0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(6.0, 6.0),
                blurRadius: 10.0,
              ),
            ],
            color: habitCompleted ? Color(0xFFEFEEEE) : Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.black,
                activeColor: Colors.white,
                value: habitCompleted,
                onChanged: onChanged,
              ),
              SizedBox(width: 20),
              Text(
                habitName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
