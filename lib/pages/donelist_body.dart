import 'package:deadline_planner/stateContainer.dart';
import 'package:flutter/material.dart';
import '../service/taskTemplate.dart';

class DoneBody extends StatefulWidget {
  const DoneBody({Key? key}) : super(key: key);

  @override
  State<DoneBody> createState() => _DoneBodyState();
}

class _DoneBodyState extends State<DoneBody> {

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
    return Column(
      children: [
        _buildTitle(context),
        Expanded(
          child: ListView.builder(
              itemCount: ListContainer.of(context).doneList.length,
              itemBuilder: (BuildContext context, int index){
                return Row(
                  children: [
                    TaskTemplate(
                      task: ListContainer.of(context).doneList[index],
                      completeTask: (){
                        ListContainer.of(context).doneList[index].completeTask();
                        ListContainer.of(context).taskList.add(ListContainer.of(context).doneList[index]);
                        ListContainer.of(context).doneList.remove(ListContainer.of(context).doneList[index]);
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
                                        ListContainer.of(context).doneList.remove(ListContainer.of(context).doneList[index]);
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
