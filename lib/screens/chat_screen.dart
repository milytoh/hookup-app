
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hookup/constant.dart';
import 'package:hookup/component/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final massageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String massage;
  var email;

  //to get current user email
  void getCurrentUser() async{
    final user = await _auth.currentUser();
    if(user != null){
      loggedInUser = user;
      print(loggedInUser.email);
      email = loggedInUser.email;
    }
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  //method to get streamData from firebase
  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close,color:Colors.yellowAccent,),
              onPressed: () {
                 _auth.signOut();
                 Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat cmp 19 group', style: TextStyle(
          color: Colors.yellowAccent,
        ),
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MassagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: massageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        massage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: IconButton(icon: Icon(Icons.send_outlined,
                      size: 35,
                      color: Colors.deepPurple[400],
                    ),
                        onPressed: () async{
                              massageTextController.clear();
                              await _fireStore.collection('massages').add({
                                'text': massage,
                                'sender': email,
                                'timestamp': FieldValue.serverTimestamp(),
                              });
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MassagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:  _fireStore.collection('massages').orderBy('timestamp',descending: true).snapshots() ,
        builder: (context, snapshot){
          final massages = snapshot.data.documents;
          List<MassageBank> massageWidgets = [];
          if (snapshot.hasData) {
            for (var massage in massages) {
              final massageText = massage.data['text'];
              final massageSender = massage.data['sender'];
              final currentUser = loggedInUser.email;

              final massageWidget = MassageBank
                (massage:massageText, sender: massageSender,
                isMe: massageSender == currentUser,
                //my: readTimestamp(massageTime),
              );
              massageWidgets.add(massageWidget);
            }
          }
          return Expanded(
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              children: massageWidgets,
            ),
          );
        });
  }
}


class MassageBank extends StatelessWidget {
  MassageBank({this.massage, this.sender, this.isMe, this.my});
  final String massage;
  final String sender;
  final bool isMe;
  final Function my;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,
            style: TextStyle(
              fontSize: 15,
              color: isMe ? Colors.yellow: Colors.deepPurple[400],
            ),
          ),
          Material(
            elevation: 7.0,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(23.0):Radius.circular(0),
              bottomLeft: Radius.circular(23.0),
              bottomRight: Radius.circular(23.0),
              topRight: isMe?Radius.circular(0): Radius.circular(23.0),
            ),
            color:  isMe? Colors.deepPurple[400] : Colors.white70,//Color(0xffD4AF37),
            child:Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$massage',
                    style: TextStyle(
                      fontSize: 16,
                      color: isMe ?Colors.white : Colors.deepPurple[400],
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
