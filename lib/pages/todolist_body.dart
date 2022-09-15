import 'package:deadline_planner/pages/form.dart';
import 'package:deadline_planner/stateContainer.dart';
import 'package:flutter/material.dart';
import '../service/task.dart';
import '../service/taskTemplate.dart';

class TodoBody extends StatefulWidget {
  const TodoBody({Key? key}) : super(key: key);

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {

  //use only for refresh body
  Future<bool> refresh() async{
    setState(() {
      ListContainer.of(context).checkPastTask();
      ListContainer.of(context).updateList('task');
      ListContainer.of(context).updateList('past');
    });
    return true;
  }


  Widget _buildHint (BuildContext context){
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
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          _buildHint(context),
          Expanded(
            child: ListView.builder(
                itemCount: ListContainer.of(context).taskList.length,
                itemBuilder: (BuildContext context, int index){
                  return TaskTemplate(
                    task: ListContainer.of(context).taskList[index],
                    editTask : () async{
                      Task thisTask = ListContainer.of(context).taskList[index] ;
                      dynamic modifiedTask = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddForm(taskCombTime: thisTask.taskTime, taskName: thisTask.text, edit: true),
                        ),
                      );
                      setState(() {
                        if(modifiedTask != null) {
                          thisTask.text = modifiedTask['taskName'];
                          thisTask.taskTime = modifiedTask['taskTime'];
                          ListContainer.of(context).updateList('tasks');
                        }
                      });
                    },
                    toggleSpecial :(){
                      ListContainer.of(context).taskList[index].toggleSpecialTask();
                      ListContainer.of(context).updateList('tasks');
                    },
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
                              content: const Text('This task will be permanently deleted'),
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
                  );
                },
              physics: const AlwaysScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
      onRefresh: (){
       return refresh();
     },
    );
  }
}
