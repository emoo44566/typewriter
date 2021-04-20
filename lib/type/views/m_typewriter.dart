import 'package:flutter/material.dart';

import 'views.dart';

class MTypeWriter extends StatefulWidget {
  final double width;

  MTypeWriter({required this.width});

  @override
  _MTypeWriterState createState() => _MTypeWriterState();
}

class _MTypeWriterState extends State<MTypeWriter> {
  String currentText = '';

  _onKeyPressed(String key) {
    //print(key);
    setState(() {
      if (key == "<-") {
        if (currentText.length > 0)
          currentText = currentText.substring(0, currentText.length - 1);
      } else {
        currentText += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (widget.width - 40) / 13;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(200, 200, 200, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          ),
          child: SizedBox(
            height: 140,
            child: Center(
              child: Text(
                currentText,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 400,
        // child:
        MKeyboard(
          width: widget.width,
          onKeyPressed: _onKeyPressed,
        ),
        // ),
      ],
    );
  }
}
