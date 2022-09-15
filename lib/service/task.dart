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
  bool completed;
  @HiveField(3)
  bool special;

  Task({required this.text, required this.taskTime, this.completed = false, this.special = false});

  String getDate() {
    //don't display year if the task's year is this year.
    if(taskTime.year == DateTime.now().year){
      return '${DateFormat.Md().format(taskTime)} ${DateFormat.jm().format(taskTime)}';
    }else {
      return '${DateFormat.yMd().format(taskTime)} ${DateFormat.jm().format(
          taskTime)}';
    }
  }

  String getTimeLeft(){
    Duration remainTime = taskTime.difference(DateTime.now());
    return '${remainTime.inDays}d ${remainTime.inHours.remainder(24)}h ${remainTime.inMinutes.remainder(60)}m';
  }

  void completeTask(){
    completed = !completed;
  }

  void toggleSpecialTask(){
    special = !special;
  }
}

