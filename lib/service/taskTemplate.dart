import 'package:flutter/material.dart';
import 'task.dart';

class TaskTemplate extends StatefulWidget {
  final Task task;
  final VoidCallback delete;
  const TaskTemplate({required this.task, required this.delete, super.key});

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
          elevation: 0.0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                child: Row(
                  children: [
                  Checkbox(
                      value: widget.task.completed,
                      onChanged: (bool? value){
                        setState((){
                          widget.task.completed = value!;
                        });
                      }
                  ),
                  Text(
                    widget.task.text,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontWeight:FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
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
