
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hookup/screens/chat_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        title: Center(child: Text("HOOKUP For Fun ",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.pink[50],
          letterSpacing: 2
        ),)),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/hook.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            bottom: 40,
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    width: 380,
                    child: Text("Hi computers, welcome to CmP 19  chat group",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[50]
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Text("Join group now,", style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreen
                    ),),
                  ),
                  FlatButton(onPressed:(){
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                    child: Text('join chat',
                      style: TextStyle(
                        color: Colors.yellowAccent
                      ),
                    ),
                    color: Colors.deepPurple[400],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




