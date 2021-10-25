
import 'package:flutter/material.dart';
import 'package:hookup/constant.dart';
import 'package:hookup/screens/chat_screen.dart';
import 'package:hookup/component/reusable_widgets.dart';
import 'package:hookup/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hookup/screens/email_verification.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>  with TickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  Animation colorAnimation;

  String email;
  String password;
  final _auth = FirebaseAuth.instance;
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
    colorAnimation = ColorTween(begin: Colors.purple, end: Colors.white70).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/hook.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: animation.value *120,
                  //left: 90,
                  right:  30,
                  child: Container(
                    //padding: EdgeInsets.only(top: 30, right: 20),
                    //margin: EdgeInsets.only(top: 1, right: 3,left: 200),
                    height:  450,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 20.0,
                          ),
                        ],
                        color: colorAnimation.value,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Sing Up Here To',
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
                              try{
                                final newUser = await _auth.createUserWithEmailAndPassword
                                  (email: email, password: password);
                                if(newUser != null){
                                  setState(() {
                                    _showSpinner = false;
                                  });
                                  Navigator.pushNamed(context, VerificationScreen.id );
                                }
                              }catch(e){
                                print(e);
                              }

                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          MassageContainer(
                            text: "Already  have an Account?",
                            secondText: 'Sign In',
                            onPressed: (){
                              Navigator.pushNamed(context, LoginPage.id);

                            },
                          ),

                        ],
                      ),
                    ),
                  ) ,
                ),
                Positioned(
                  top: 100,
                  right: 135,
                  child: Container(
                    height: animation.value *70,
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
  