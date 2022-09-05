import 'package:deadline_planner/stateContainer.dart';
import 'package:flutter/material.dart';
import '../service/taskTemplate.dart';

class TodoBody extends StatefulWidget {
  const TodoBody({Key? key}) : super(key: key);

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {

  Widget _buildTitle (BuildContext context){
    if(ListContainer.of(context).taskList.isNotEmpty){
      return const SizedBox.shrink();
    }else {
      return const Text('Add Task to Begin');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(context),
        Expanded(
          child: ListView.builder(
              itemCount: ListContainer.of(context).taskList.length,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: [
                    TaskTemplate(
                      task: ListContainer.of(context).taskList[index],
                      completeTask: (){
                        ListContainer.of(context).taskList[index].completeTask();
                        ListContainer.of(context).doneList.add(ListContainer.of(context).taskList[index]);
                        ListContainer.of(context).taskList.remove(ListContainer.of(context).taskList[index]);
                        setState(() {
                          ListContainer.of(context).updateList('tasks');
                          ListContainer.of(context).updateList('done');
                        });
                      },
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
                                    child : const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                      setState(() {
                                        ListContainer.of(context).taskList.remove(ListContainer.of(context).taskList[index]);
                                        ListContainer.of(context).updateList('tasks');
                                      });
                                    },
                                    child : const Text('Confirm'),
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
    );
  }
}
