import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'service/task.dart';
import 'service/taskTemplate.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Box box = Hive.box('listBox');

  List<Task> taskList = [];

  void updateStorage(){
    if(taskList.isEmpty){
      box.delete('tasks');
    }else {
      box.put('tasks', taskList);
    }
  }

  Widget _buildTitle (BuildContext context){
    if(taskList.isNotEmpty){
      return const SizedBox.shrink();
    }else {
      return const Text('Add New Task to Begin');
    }
  }

  @override
  void initState(){
    super.initState();
    taskList = box.get('tasks').cast<Task>()?? [] ;
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
      body: Column(
        children: [
          _buildTitle(context),
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: [
                    TaskTemplate(
                        task: taskList[index],
                        delete: (){
                          showDialog(
                              context: context,
                              barrierDismissible: false,//user must tap button!
                              builder:(BuildContext context){
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text('Alert'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child : Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                        setState(() {
                                          taskList.remove(taskList[index]);
                                          updateStorage();
                                        });
                                      },
                                      child : Text('Confirm'),
                                    ),
                                  ],
                                );
                              }
                          );

                        },
                    )
                  ],
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          dynamic task = await Navigator.pushNamed(context, '/form');
          if(task!=null){
            Task tempTask = Task(text: task['taskName'], taskTime: task['taskTime']);
            setState(() {
              taskList.add(tempTask);
              updateStorage();
            });
          }
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ) ,
    );
  }
}
