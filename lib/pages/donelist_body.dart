import 'package:deadline_planner/stateContainer.dart';
import 'package:flutter/material.dart';
import '../service/task.dart';
import '../service/taskTemplate.dart';
import 'form.dart';

class DoneBody extends StatefulWidget {
  const DoneBody({Key? key}) : super(key: key);

  @override
  State<DoneBody> createState() => _DoneBodyState();
}

class _DoneBodyState extends State<DoneBody> {

  //Use only for refresh page
  Future<bool> refresh() async{
    setState(() {});
    return true;
  }

  Widget _buildTitle (BuildContext context){
    if(ListContainer.of(context).doneList.isNotEmpty){
      return const SizedBox.shrink();
    }else {
      return const Text('No Finished Task');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Column(
        children: [
          _buildTitle(context),
          Expanded(
            child: ListView.builder(
                itemCount: ListContainer.of(context).doneList.length,
                itemBuilder: (BuildContext context, int index){
                  return TaskTemplate(
                    task: ListContainer.of(context).doneList[index],
                    editTask : () async{
                      Task thisTask = ListContainer.of(context).doneList[index] ;
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
                          ListContainer.of(context).updateList('done');
                        }
                      });
                    },
                    toggleSpecial :(){
                      ListContainer.of(context).doneList[index].toggleSpecialTask();
                      ListContainer.of(context).updateList('done');
                    },
                    completeTask: (){
                      ListContainer.of(context).doneList[index].completeTask();
                      //if task date is in the past
                      if(ListContainer.of(context).doneList[index].taskTime.compareTo(DateTime.now()) < 0){
                        ListContainer.of(context).pastList.add(ListContainer.of(context).doneList[index]);
                        setState(() {
                          ListContainer.of(context).updateList('past');
                        });
                      }else{
                        ListContainer.of(context).taskList.add(ListContainer.of(context).doneList[index]);
                        setState(() {
                          ListContainer.of(context).updateList('tasks');
                        });
                      }
                      ListContainer.of(context).doneList.remove(ListContainer.of(context).doneList[index]);
                      setState(() {
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
                                      ListContainer.of(context).doneList.remove(ListContainer.of(context).doneList[index]);
                                      ListContainer.of(context).updateList('done');
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
