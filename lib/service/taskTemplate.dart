import 'package:flutter/material.dart';
import 'task.dart';

class TaskTemplate extends StatefulWidget {
  final Task task;
  final VoidCallback delete;
  final VoidCallback completeTask;
  final VoidCallback toggleSpecial;
  final VoidCallback editTask;

  const TaskTemplate(
      {required this.task,
      required this.delete,
      required this.completeTask,
      required this.toggleSpecial,
      required this.editTask,
      super.key});

  @override
  State<TaskTemplate> createState() => _TaskTemplateState();
}

class _TaskTemplateState extends State<TaskTemplate> {
  Widget _buildTime(BuildContext context) {
    if (widget.task.taskTime.compareTo(DateTime.now()) > 0) {
      return Row(
        children: [
          Text(
            widget.task.getDate(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            width: 25.0,
          ),
          Text(
            widget.task.getTimeLeft(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    } else {
      return Text(
          widget.task.getDate(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 16.0,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.0,
          color: (widget.task.taskTime.compareTo(DateTime.now()) > 0)
              ? Theme.of(context).colorScheme.surfaceVariant
              : Theme.of(context).colorScheme.tertiary,
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
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.completeTask();
                                });
                              }),
                          Flexible(
                            child: Text(
                              widget.task.text,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      onPressed: () {
                        setState(() {
                          widget.toggleSpecial();
                        });
                      },
                      icon: (widget.task.special)
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_border_sharp),
                    )
                  ],
                ),
              ),
              //Due date
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 8.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                      child: _buildTime(context),
                    ),
                    //time left
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: widget.editTask,
                          icon: const Icon(Icons.edit_note_rounded),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: widget.delete,
                          icon: const Icon(Icons.delete_forever),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
