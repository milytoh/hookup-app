import 'dart:ui';

import 'package:flutter/material.dart';
class MassageContainer extends StatelessWidget {
  MassageContainer({this.text, this.onPressed, this.secondText});
  final String text;
  final Function onPressed;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15,top: 30),
        width: 240,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize:16,
                  letterSpacing: 2,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 37),
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Text(
                      secondText,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        fontWeight: FontWeight.bold


                      ),
                    ),
                  ),
                )),
          ],
        )
    );
  }
}