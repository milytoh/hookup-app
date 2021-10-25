
import 'package:flutter/material.dart';
import 'package:hookup/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PassWordResetScreen extends StatefulWidget {
  static const String id = 'passWord_reset';

  @override
  _PassWordResetScreenState createState() => _PassWordResetScreenState();
}

class _PassWordResetScreenState extends State<PassWordResetScreen> {
  final _auth = FirebaseAuth.instance;
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('RestPassWord'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  TextField(
              keyboardType:TextInputType.emailAddress,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                    onChanged: (value) {
                      _email =  value;
                    },
                    decoration: KInputTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.purple[600],
                      ),
                    ),
                  ),
                  MaterialButton(
                    elevation: 21,
                    padding: EdgeInsets.only(left: 120, right: 120),
                    color: Colors.deepPurple[300],
                    onPressed: () {
                      _auth.sendPasswordResetEmail(email: _email);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "send Request",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
