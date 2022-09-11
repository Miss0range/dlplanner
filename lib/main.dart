
import 'package:deadline_planner/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/form.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'service/task.dart';
import 'stateContainer.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(TaskAdapter());
  await Hive.initFlutter(dir.path);

  //await Hive.deleteBoxFromDisk('listBox');

  var box = await Hive.openBox('listBox');

  runApp(ListContainer(
    listBox: box,
    child: MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/form': (context) => AddForm(taskCombTime: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day)),
      },
    ),
  ));
}