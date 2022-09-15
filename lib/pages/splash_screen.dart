import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadSplash extends StatefulWidget {
  const LoadSplash({Key? key}) : super(key: key);

  @override
  State<LoadSplash> createState() => _LoadSplashState();
}

class _LoadSplashState extends State<LoadSplash> {

  @override
  void initState() {
    super.initState();
    _redirectHome();
  }

  void _redirectHome() async{
    await Future.delayed(const Duration(milliseconds: 1500),(){});
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.surface,
        child: SpinKitFadingCube(
          color: Theme.of(context).colorScheme.onSurface,
          size: 80.0,
        ),
      ),
    );
  }
}
