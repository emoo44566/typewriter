import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:typewriter/type/key_labels.dart';

import 'on_key_pressed.dart';

class MCursor extends StatefulWidget {
  final double height;
  const MCursor({Key? key, required this.height}) : super(key: key);

  @override
  _MCursorState createState() => _MCursorState();
}

class _MCursorState extends State<MCursor> {
  late Timer timer;
  bool showCurser = false;

  @override
  void initState() {
    super.initState();
    // _createMessage(context, "body");
    print("initState");

    timer = Timer.periodic(Duration(milliseconds: 600), (Timer t) {
      setState(() {
        showCurser =
            !showCurser; // this is cause of _getTextList call every 600 ms
      });
    });
  }

  
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2,
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          color: showCurser ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
