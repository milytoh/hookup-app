import 'package:flutter/material.dart';
import 'package:hookup/screens/chat_screen.dart';
import 'package:hookup/screens/email_verification.dart';
import 'package:hookup/screens/flash_screen.dart';
import 'package:hookup/screens/login_screen.dart';
import 'package:hookup/screens/registration_page.dart';
import 'package:hookup/screens/welcome_screen.dart';
import 'package:hookup/screens/login_page.dart';
import 'package:hookup/screens/password_reset.dart';

void main() {
  runApp(HookUpApp());
}

class HookUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.red,
      ),
      initialRoute:LoginPage.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationPage.id: (context) => RegistrationPage(),
        ChatScreen.id : (context) => ChatScreen(),
        //LoadingScreen.id : (context) => LoadingScreen(),
        LoginPage.id: (context) => LoginPage(),
        SplashScreen.id: (context) => SplashScreen(),
        VerificationScreen.id: (context) => VerificationScreen(),
        PassWordResetScreen.id: (context) => PassWordResetScreen(),
      },
    );
  }
}
