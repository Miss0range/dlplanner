import 'package:deadline_planner/service/task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class _InheritatedStateContainer extends InheritedWidget {
  final _ListContainerState data;

  _InheritatedStateContainer({
    Key? key,
    required this.data,
    required Widget child,
  }): super(key:key, child:child);

  @override
  bool updateShouldNotify(_InheritatedStateContainer oldWidget) => true;

}

class ListContainer extends StatefulWidget {
  final Widget child;
  final Box listBox;


  const ListContainer({Key? key, required this.child, required this.listBox}) : super(key: key);


  static _ListContainerState of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<_InheritatedStateContainer>() as _InheritatedStateContainer).data;
  }


  @override
  State<ListContainer> createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
  List<Task> taskList = [];
  List<Task> doneList = [];
  List<Task> pastList = [];
  late Box box;

  void updateList(String name){
    switch(name){
      case 'tasks': {
        setState(() {
          taskList.sort((a,b){
            return a.taskTime.compareTo(b.taskTime);
          });
        });
        widget.listBox.put(name,taskList);
      }
      break;
      case 'done': {
        setState(() {
          doneList.sort((a,b){
            return a.taskTime.compareTo(b.taskTime);
          });
        });
        widget.listBox.put(name,doneList);
      }
      break;
      case 'past': {
        setState(() {
          pastList.sort((a,b){
            return a.taskTime.compareTo(b.taskTime);
          });
        });
        widget.listBox.put(name,pastList);
      }
      break;
      default: {}
      break;
    }
  }

  //move past due task to pastList from taskList only (do not affect items in done list)
  void checkPastTask(){
    //check for unfinished & past due task
    taskList.forEach((task) {
      //if task date is before now
      if(task.taskTime.compareTo(DateTime.now()) < 0){
        //add past due task to pastList
        pastList.add(task);
      }
    });
    //remove past due task from taskList
    taskList.removeWhere((task) => (task.taskTime.compareTo(DateTime.now()) < 0 ));
  }

  @override
  void initState() {
    super.initState();
    taskList = (widget.listBox.get('tasks')?? []).cast<Task>();
    doneList = (widget.listBox.get('done')?? []).cast<Task>();
    pastList = (widget.listBox.get('past')?? []).cast<Task>();
    box = widget.listBox;

    //Remove past due task from taskList
    checkPastTask();
    widget.listBox.put('tasks',taskList);
    //Remove expired task from taskList
    pastList.removeWhere((task) => ( !task.special && (task.taskTime.add(const Duration(days:30)).compareTo(DateTime.now()) < 0 )) );
    doneList.removeWhere((task) => ( !task.special && (task.taskTime.add(const Duration(days:30)).compareTo(DateTime.now()) < 0 )) );
    widget.listBox.put('past',pastList);
  }

  @override
  void dispose() {
    taskList.clear();
    doneList.clear();
    pastList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritatedStateContainer(
        data: this,
        child: widget.child);
  }
}
