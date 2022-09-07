import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskCalendar extends StatefulWidget {
  const TaskCalendar({Key? key}) : super(key: key);

  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        focusedDay: DateTime.now(), 
        firstDay: DateTime(2012), 
        lastDay: DateTime.now().add(const Duration(days: 730)),
    );
  }
}
