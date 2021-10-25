
import 'dart:ui';
import 'package:hookup/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup/component/round_button.dart';
import 'package:hookup/component/reusable_widgets.dart';
import 'package:hookup/screens/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hookup/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hookup/screens/password_reset.dart';
import 'package:hookup/screens/welcome_screen.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'register';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  with TickerProviderStateMixin{
  final _auth = FirebaseAuth.instance;
  AnimationController controller;
  Animation animation;
  Animation colorAnimation;

  String email;
  String password;
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    //include controller animation
    controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
      //upperBound: 100,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    colorAnimation = ColorTween(begin: Colors.lightGreen[300], end: Colors.teal[200]).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F8FF),
      body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/hook.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 90),
                      color: Color(0xFF202971).withOpacity(0.2),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'welcome to',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize:23,
                                letterSpacing: 2,
                                color: Colors.yellowAccent,
                              ),
                              children: [
                                TextSpan(
                                  text: 'HookUp',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:30,
                                    letterSpacing: 2,
                                    color: Colors.yellowAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: animation.value * 150,
                  bottom: 100,
                  //left: 90,
                  right: 30,
                  child: Container(
                    //padding: EdgeInsets.only(top: 30, right: 20),
                    //margin: EdgeInsets.only(top: 1, right: 3,left: 200),
                    height: animation.value * 140,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 20.0,
                        ),
                      ],
                      color: Colors.white70
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                      RichText(
                      text: TextSpan(
                      text: 'Login to',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize:18,
                          letterSpacing: 2,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Continue...',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:20,
                              letterSpacing:1,
                              color: Colors.yellowAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                          SizedBox(height: 40),
                          TextField(
                            keyboardType:TextInputType.emailAddress ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: KInputTextFieldDecoration.copyWith(
                              hintText: 'Enter your Email',
                              prefixIcon: Icon(
                                  Icons.email,
                                color: Colors.purple[400],
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextField(
                            obscureText: true,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: KInputTextFieldDecoration.copyWith(
                              hintText: 'Enter your password',
                              prefixIcon: Icon(
                                  Icons.vpn_key_outlined,
                                color: Colors.purple[400],
                              ),
                            ),
                          ),
                          SizedBox(height: 25,),
                          MaterialButton(
                            padding: EdgeInsets.only(left: 120, right: 120),
                            color: Colors.deepPurple[400],
                            onPressed: () async{
                              setState(() {
                                _showSpinner = true;
                              });
                              try {
                                final user = await _auth
                                    .signInWithEmailAndPassword
                                  (email: email, password: password);
                                if (user != null) {
                                  Navigator.pushNamed(context, WelcomeScreen.id);
                                }
                                setState(() {
                                  _showSpinner = false;
                                });
                              }catch(e){
                                print(e);
                              }

                            },
                            child: Text(
                                "LogIn",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          MassageContainer(
                            text: "Don't have an Account?",
                            secondText: 'Sign Up',
                            onPressed: (){
                              Navigator.pushNamed(context, RegistrationPage.id );
                            },
                          ),
                          RaisedButton(onPressed: (){
                            Navigator.pushNamed(context, PassWordResetScreen.id );
                          }, child: Text(
                            'ResetPassWord',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ) ,
                ),
                Positioned(
                  top: animation.value*120,
                  right: 135,
                  child: Container(
                    height: 70,
                    width: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
                      backgroundImage: AssetImage('images/hook1.jpg'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



