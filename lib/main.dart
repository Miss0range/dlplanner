
import 'package:deadline_planner/pages/intro.dart';
import 'package:deadline_planner/pages/splash_screen.dart';
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

  //use this or flutter clean.Prefer flutter clean.
  //await Hive.deleteBoxFromDisk('listBox');

  var box = await Hive.openBox('listBox');

  //Check if user has see intro
  bool intro = true;
  intro = box.get('intro')?? intro ;

  runApp(ListContainer(
    listBox: box,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: intro ? '/intro' :'/splash',
      routes: {
        '/': (context) => const Home(),
        '/form': (context) => AddForm(taskCombTime: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day)),
        '/splash':(context) => const LoadSplash(),
        '/intro':(context) => const IntroPage(),
      },
    ),
  ));
}