import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:hookup/screens/login_page.dart';

class VerificationScreen extends StatefulWidget {
  static const String id = 'verification';
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Timer _timer;

  // void get(){
  //   print(_user.email);
  // }

  @override
  void initState() {
    getVerify();
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void getVerify() async{
    _user = await _auth.currentUser();
    _user.sendEmailVerification();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });

  }

  void checkEmailVerified() async{
    _user = await _auth.currentUser();
    _user.reload();
    if(_user.isEmailVerified){
      _timer.cancel();
      Navigator.pushNamed(context, LoginPage.id );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Center(
        child: Container(
          child: RichText(
            text: TextSpan(
            text: 'An Email has been sent to',
        style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize:23,
        letterSpacing: 2,
        color: Colors.black,
        ),
              children: [
                TextSpan(
                  text: 'ur email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:30,
                    letterSpacing: 2,
                    color: Colors.greenAccent,
                  ),
                ),
            TextSpan(
                text: 'please Verify',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize:23,
                  letterSpacing: 2,
                  color: Colors.black,
                ),
            ),
              ]
          ),

        ),
      ),
      ),
    );
  }
}
