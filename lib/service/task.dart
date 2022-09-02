import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'task.g.dart';

@HiveType(typeId: 0, adapterName: 'TaskAdapter')
class Task{
  @HiveField(0)
  String text;
  @HiveField(1)
  DateTime taskTime;
  @HiveField(2)
  bool completed = false;

  Task({required this.text, required this.taskTime});

  String getDate() {
    if(taskTime.year == DateTime.now().year){
      return '${DateFormat.Md().format(taskTime)} ${DateFormat.jm().format(taskTime)}';
    }else {
      return '${DateFormat.yMd().format(taskTime)} ${DateFormat.jm().format(
          taskTime)}';
    }
  }

  String getTimeLeft(){
    Duration remainTime = taskTime.difference(DateTime.now());
    return '${remainTime.inHours}h ${remainTime.inMinutes.remainder(60)}m';
  }

  void completeTask(){
    completed = true;
  }

}

