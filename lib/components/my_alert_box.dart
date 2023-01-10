// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyAlertBox extends StatefulWidget {
  MyAlertBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
  });

  final VoidCallback onSave;
  final VoidCallback onCancel;
  final controller;
  final String hintText;

  @override
  State<MyAlertBox> createState() => _MyAlertBoxState();
}

class _MyAlertBoxState extends State<MyAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFEFEEEE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 190, 190, 190)),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF292D32)),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: widget.onCancel,
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Color(0xFFEFEEEE),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                setState(() {
                  if (widget.controller.value.text.isNotEmpty) {
                    widget.onSave();
                  } else {
                    return null;
                  }
                });
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Color(0xFFEFEEEE),
            ),
          ],
        )
      ],
    );
  }
}
