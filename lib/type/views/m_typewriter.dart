import 'package:flutter/material.dart';

import 'm_text.dart';
import 'views.dart';

class MTypeWriter extends StatefulWidget {
  MTypeWriter();

  @override
  _MTypeWriterState createState() => _MTypeWriterState();
}

class _MTypeWriterState extends State<MTypeWriter> {
  String currentText = '';
  Size deviceSize = Size(0, 0);

  _onKeyPressed(String key) {
    //print(key);
    setState(() {
      if (key == "<-") {
        if (currentText.length > 0)
          currentText = currentText.substring(0, currentText.length - 1);
      } else {
        if (currentText.length < 15) currentText += key;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(200, 200, 200, 1),
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          ),
          child: SizedBox(
            height: deviceSize.height * .34,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: MText(
                  text: currentText,
                  fontSize: deviceSize.height * .08,
                  onKeyPressed: (String key) {},
                ),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 400,
        // child:
        MKeyboard(
          width: deviceSize.width,
          height: deviceSize.height * .66,
          onKeyPressed: _onKeyPressed,
        ),
        // ),
      ],
    );
  }
}
