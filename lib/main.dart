import 'package:flutter/material.dart';
import 'package:hookup/screens/chat_screen.dart';
import 'package:hookup/screens/login_screen.dart';
import 'package:hookup/screens/registration_screen.dart';
import 'package:hookup/screens/welcome_screen.dart';

void main() {
  runApp(HookUpApp());
}

class HookUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.blueGrey,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),


      },
    );
  }
}
