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

  var box = await Hive.openBox('listBox');


  runApp(ListContainer(
    listBox: box,
    child: MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.light,
          ),
          fontFamily: 'Lato',
        useMaterial3: true
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
            brightness: Brightness.dark,
          ),
          fontFamily: 'Lato',
          useMaterial3: true
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/form': (context) => AddForm(),
      },
    ),
  ));
}