import 'package:flutter/material.dart';
import 'task.dart';

class TaskTemplate extends StatefulWidget {
  final Task task;
  final VoidCallback delete;
  final VoidCallback completeTask;
  final VoidCallback toggleSpecial;
  final VoidCallback editTask;
  const TaskTemplate({required this.task, required this.delete,required this.completeTask, required this.toggleSpecial, required this.editTask, super.key});

  @override
  State<TaskTemplate> createState() => _TaskTemplateState();
}

class _TaskTemplateState extends State<TaskTemplate> {

  Widget _buildTime(BuildContext context){
    if(widget.task.taskTime.compareTo(DateTime.now()) > 0){
      return Row(
        children: [
          Text(
            widget.task.getDate(),
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 30.0,),
          Text(
            widget.task.getTimeLeft(),
            style: TextStyle(
              color: Colors.red[700],
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }else{
      return Text(
          widget.task.getDate(),
          style: const TextStyle(
          color: Colors.indigo,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        )
      );
    }
  }
  
  Widget _buildActionBar(BuildContext context){
    if(widget.task.taskTime.compareTo(DateTime.now()) > 0){
      return Row(
        children: [
          IconButton(
            onPressed: widget.editTask,
            icon: const Icon(Icons.edit_note_rounded),
            color: Colors.indigo,
          ),
          IconButton(
            onPressed: widget.delete,
            icon: const Icon(Icons.delete_forever),
            color: Colors.indigo,
          ),
        ],
      );
    }else{
      return Row(
        children: [
          IconButton(
            onPressed: widget.delete,
            icon: const Icon(Icons.delete_forever),
            color: Colors.indigo,
          ),
        ],
      );
    }

  }


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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
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
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                          setState(() {
                            widget.toggleSpecial();
                          });
                        },
                        icon: (widget.task.special) ? const Icon(Icons.star) : const Icon(Icons.star_border_outlined),
                    )
                ],
                ),
              ),
              //Due date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                    child:_buildTime(context),
                  ),
                  //time left
                  _buildActionBar(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
