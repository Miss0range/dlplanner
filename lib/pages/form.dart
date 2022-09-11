import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddForm extends StatefulWidget {
  String taskName;
  DateTime taskCombTime;
  bool edit;


  AddForm({this.taskName = '',required this.taskCombTime, this.edit = false, Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

  String dateString = 'mm/dd/yy';
  String timeString = '00:00';

  late DateTime taskDate ;
  late TimeOfDay taskTime ;

  @override
  void initState(){
    super.initState();
      taskDate = DateTime(widget.taskCombTime.year,widget.taskCombTime.month, widget.taskCombTime.day);
      taskTime = TimeOfDay(hour: widget.taskCombTime.hour, minute: widget.taskCombTime.minute);
      if(widget.edit){
        dateString = DateFormat.yMd().format(taskDate);
        timeString = '${taskTime.hour.toString().padLeft(2,'0')} : ${taskTime.minute.toString().padLeft(2,'0')} ';
      }
  }

  TextStyle labelStyle = const TextStyle(
    fontSize: 20.0,
  );

  ButtonStyle setBtnStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontFamily: 'Lato',
      fontSize: 16.0,
    ),
  );

  ButtonStyle submitBtnStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 20.0,
    ),
  );

  Widget _buildTextInput(BuildContext context){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Name',
            style: labelStyle,
          ),
          TextFormField(
            initialValue: widget.taskName,
            validator: (val){
              if(val == null || val.isEmpty){
                return 'Task Name can\'t be empty';
              }else if(val.length > 255){
                return 'Task Name too long.';
              }else {
                widget.taskName = val;
              }
            },

          ),
          const SizedBox(height: 20.0,),
        ],
      )
    );
  }
  Widget _buildDateInput(BuildContext context){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Text Due Date',
            style: labelStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              dateString,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
          ElevatedButton(
            style: setBtnStyle,
            onPressed: () async{
              DateTime? tempTime = await showDatePicker(
                context: context,
                initialDate: taskDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 730)),
              );
              taskDate = tempTime ?? taskDate;
              //update date on form
              if(tempTime != null) {
                setState(() {
                  dateString = DateFormat.yMd().format(taskDate);
                });
              }
            },
            child: const Text('Set Due Date'),
          ),
          const SizedBox(height: 20.0,),
        ],
      ),
    );
  }
  Widget _buildTimeInput(BuildContext context){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Due Time',
            style: labelStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              timeString,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              TimeOfDay initTime = taskTime;
              // if(taskDate.year == DateTime.now().year && taskDate.month == DateTime.now().month && taskDate.day == DateTime.now().day){
              //   initTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
              // }
              TimeOfDay? tempTime = await showTimePicker(
                context: context,
                initialTime: initTime,
              );
              taskTime = tempTime ?? taskTime;
              if( tempTime!=null ){
                setState(() {
                  timeString = taskTime.format(context);
                });
              }
            },
            child: Text('Set Due Time'),
            style: setBtnStyle,
          ),
          const SizedBox(height: 30.0,),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add new task',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInput(context),
              _buildDateInput(context),
              _buildTimeInput(context),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      DateTime combTime = DateTime(taskDate.year,taskDate.month,taskDate.day,taskTime.hour,taskTime.minute);
                      if(combTime.difference(DateTime.now()).isNegative){
                        String dtError = '';
                        if(taskDate.difference(DateTime.now()).isNegative){
                          dtError = 'date';
                        }else{
                          dtError = 'time';
                        }
                        dynamic formErrorSnackBar= SnackBar(
                          content: Text(
                            'Please select a future $dtError.',
                            style: TextStyle(
                              color: Colors.red[600],
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(formErrorSnackBar);
                      }else {
                        Navigator.of(context).pop({
                          'taskName': widget.taskName,
                          'taskTime': combTime,
                        });
                      }
                    }
                  },
                  style: submitBtnStyle,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

