import 'package:deadline_planner/stateContainer.dart';
import 'package:flutter/material.dart';
import '../service/taskTemplate.dart';

class PastBody extends StatefulWidget {
  const PastBody({Key? key}) : super(key: key);

  @override
  State<PastBody> createState() => _PastBodyState();
}

class _PastBodyState extends State<PastBody> {

  //Use only for refresh the body
  Future<bool> refresh() async{
    setState(() {});
    return true;
  }

  Widget _buildTitle (BuildContext context){
    if(ListContainer.of(context).pastList.isNotEmpty){
      return const SizedBox.shrink();
    }else {
      return const Text('No Past Due Task');
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
                itemCount: ListContainer.of(context).pastList.length,
                itemBuilder: (BuildContext context, int index){
                  return Row(
                    children: [
                      TaskTemplate(
                        task: ListContainer.of(context).pastList[index],
                        editTask:(){
                          //Past task not editable.
                        },
                        toggleSpecial :(){
                          ListContainer.of(context).pastList[index].toggleSpecialTask();
                          ListContainer.of(context).updateList('past');
                        },
                        completeTask: (){
                          ListContainer.of(context).pastList[index].completeTask();
                          ListContainer.of(context).doneList.add(ListContainer.of(context).pastList[index]);
                          ListContainer.of(context).pastList.remove(ListContainer.of(context).pastList[index]);
                          setState(() {
                            ListContainer.of(context).updateList('past');
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
                                          ListContainer.of(context).pastList.remove(ListContainer.of(context).pastList[index]);
                                          ListContainer.of(context).updateList('past');
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
