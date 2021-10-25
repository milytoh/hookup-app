import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  void splash() async{
    await Future.delayed(Duration(seconds: 3),() {});
    Navigator.pushReplacementNamed(context,LoginPage.id );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 90,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo1.png'),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'HookUp',
                style: TextStyle(
                  // fontSize: 2,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

