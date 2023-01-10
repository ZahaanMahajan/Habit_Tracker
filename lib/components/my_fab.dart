// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  MyFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      elevation: 0,
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
