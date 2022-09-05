import 'package:flutter/material.dart';
import 'task.dart';

class TaskTemplate extends StatefulWidget {
  final Task task;
  final VoidCallback delete;
  final VoidCallback completeTask;
  const TaskTemplate({required this.task, required this.delete,required this.completeTask, super.key});

  @override
  State<TaskTemplate> createState() => _TaskTemplateState();
}

class _TaskTemplateState extends State<TaskTemplate> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 16.0,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 3.0, 3.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Checkbox(
                      value: widget.task.completed,
                      onChanged: (bool? value){
                        setState((){
                          widget.completeTask();
                        });
                      }
                  ),
                  Flexible(
                    child: Text(
                      widget.task.text,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight:FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                   const SizedBox(width: 10.0,),
                ],
                ),
              ),
              //Due date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.task.getDate(),
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  //time left
                  Text(
                    widget.task.getTimeLeft(),
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.delete,
                    icon: const Icon(Icons.delete_forever),
                    color: Colors.indigo,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
