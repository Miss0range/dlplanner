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


  void updateList(String name){
    switch(name){
      case 'tasks': {
        widget.listBox.put(name,taskList);
        taskList.sort((a,b){
          return a.taskTime.compareTo(b.taskTime);
        });
      }
      break;
      case 'done': {
        widget.listBox.put(name,doneList);
        doneList.sort((a,b){
          return a.taskTime.compareTo(b.taskTime);
        });
      }
      break;
      default: {}
      break;
    }
  }


  @override
  void initState() {
    taskList = (widget.listBox.get('tasks')?? []).cast<Task>();
    doneList = (widget.listBox.get('done')?? []).cast<Task>();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritatedStateContainer(
        data: this,
        child: widget.child);
  }
}
