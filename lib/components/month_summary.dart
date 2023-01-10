// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import '../dateTime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.white,
        textColor: Colors.black,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(19, 179, 2, 2),
          2: Color.fromARGB(40, 179, 2, 2),
          3: Color.fromARGB(58, 179, 2, 2),
          4: Color.fromARGB(80, 179, 2, 2),
          5: Color.fromARGB(98, 179, 2, 2),
          6: Color.fromARGB(120, 179, 2, 2),
          7: Color.fromARGB(148, 179, 2, 2),
          8: Color.fromARGB(180, 179, 2, 2),
          9: Color.fromARGB(220, 179, 2, 2),
          10: Color.fromARGB(255, 179, 2, 2),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
