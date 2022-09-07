import 'package:deadline_planner/pages/calendar.dart';
import 'package:deadline_planner/pages/donelist_body.dart';
import 'package:deadline_planner/pages/pastlist_body.dart';
import 'package:deadline_planner/pages/todolist_body.dart';
import 'package:deadline_planner/stateContainer.dart';
import 'package:flutter/material.dart';
import '../service/task.dart';
import 'todolist_body.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  List<Widget> bodyWidgets = [const TodoBody(),const DoneBody(), const PastBody(), const TaskCalendar()];

  //change nav bar index
  void onNavTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: const Text(
           'To Do List',
           style: TextStyle(
             fontSize: 24.0,
             fontWeight: FontWeight.w500,
           ),
         ),
         // leading: Text(
         //   DateFormat.MMMd().format(DateTime.now()),
         // ),
       ),
      body: bodyWidgets[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          dynamic task = await Navigator.pushNamed(context, '/form');
          if(task!=null){
            Task tempTask = Task(text: task['taskName'], taskTime: task['taskTime']);
            if(!mounted) return;
              ListContainer.of(context).taskList.add(tempTask);
              ListContainer.of(context).updateList('tasks');
          }
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: 'Todo',
            backgroundColor: Colors.indigo[50],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Done',
            backgroundColor: Colors.indigo[50],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late),
            label: 'Past Due',
            backgroundColor: Colors.indigo[50],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
            backgroundColor: Colors.indigo[50],
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onNavTapped,
        selectedItemColor: Colors.indigo[500],
      ),
    );
  }
}
