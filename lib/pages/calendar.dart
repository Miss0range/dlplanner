import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:deadline_planner/stateContainer.dart';

import '../service/event.dart';
import '../service/task.dart';

class TaskCalendar extends StatefulWidget {
  const TaskCalendar({Key? key}) : super(key: key);

  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);//Date only. No hour no min
  Map<DateTime, List<Event>> selectedTodoEvents = {};
  Map<DateTime, List<Event>> selectedDoneEvents = {};
  Map<DateTime, List<Event>> selectedPastEvents = {};



  List<Event> getEventsFromDateAndList(
      Map<DateTime, List<Event>> selectedEvents, DateTime date) {
    return selectedEvents[date] ?? [];
  }

  List<Event> getEventsFromDate(DateTime date) {
    //concatenate event lists of this date.
    return [
      ...(selectedTodoEvents[date] ?? []),
      ...(selectedDoneEvents[date] ?? []),
      ...(selectedPastEvents[date] ?? [])
    ];
  }

  Event taskToEvent(Task task) {
    return Event(title: task.text, time: DateFormat.jm().format(task.taskTime));
  }

  void addTaskFromList(
      Map<DateTime, List<Event>> selectedEvents, List<Task> tList) {
    tList.forEach((task) {
      DateTime date = DateTime.utc(
          task.taskTime.year, task.taskTime.month, task.taskTime.day);
      if (selectedEvents[date] == null) {
        selectedEvents[date] = [];
      }
      //selectedEvents[date] is ensured not null.
      selectedEvents[date]!.add(taskToEvent(task));
    });
  }

  void initList() {
    addTaskFromList(selectedTodoEvents, ListContainer.of(context).taskList);
    addTaskFromList(selectedDoneEvents, ListContainer.of(context).doneList);
    addTaskFromList(selectedPastEvents, ListContainer.of(context).pastList);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initList();
  }

  @override
  void dispose(){
    selectedDoneEvents.clear();
    selectedPastEvents.clear();
    selectedTodoEvents.clear();
    super.dispose();
  }

  //build widget function
  Widget _buildTodoTitle() {
    if ((selectedTodoEvents[selectedDay]??[]).isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
        child: Text(
          'Todo',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }
  }

  Widget _buildFinishTitle() {
    if ((selectedDoneEvents[selectedDay]??[]).isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
        child: Text(
          'Finished',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }
  }

  Widget _buildPastTitle() {
    if ((selectedPastEvents[selectedDay]??[]).isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
        child: Text(
          'Past Due',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            //Calendar setting
            focusedDay: focusedDay,
            firstDay: DateTime(2022).toUtc(),
            lastDay: DateTime.now().add(const Duration(days: 730)),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat tempFormat) {
              setState(() {
                format = tempFormat;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            //On date selected.
            onDaySelected: (DateTime tempSelectedDay, DateTime tempFocusedDay) {
              setState(() {
                selectedDay = tempSelectedDay;
                focusedDay = tempFocusedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },

            eventLoader: getEventsFromDate,
            //Styling calendar
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: true,
              formatButtonShowsNext: true,
              formatButtonDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onTertiary,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w900,
              ),
            ),

            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inverseSurface,
                shape: BoxShape.circle,
              ),
            ),
          ),
          _buildTodoTitle(),
          ...getEventsFromDateAndList(selectedTodoEvents, selectedDay)
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      tileColor: Theme.of(context).colorScheme.primaryContainer,
                      title: Text(
                        e.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        e.time,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  )),
          _buildFinishTitle(),
          ...getEventsFromDateAndList(selectedDoneEvents, selectedDay)
              .map((e) => Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      tileColor: Theme.of(context).colorScheme.surfaceVariant,
                      title: Text(
                        e.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        e.time,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  )),
          _buildPastTitle(),
          ...getEventsFromDateAndList(selectedPastEvents, selectedDay)
              .map((e) => Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      tileColor: Theme.of(context).colorScheme.tertiary,
                      title: Text(
                        e.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        e.time,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  )),
          const SizedBox(height: 60.0,), //prevent last card being blocked by bottom navigation bar.
        ],
      ),
    );
  }
}
