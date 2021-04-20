import 'package:flutter/material.dart';

import 'views.dart';

class MTypeWriter extends StatefulWidget {
  MTypeWriter();

  @override
  _MTypeWriterState createState() => _MTypeWriterState();
}

class _MTypeWriterState extends State<MTypeWriter> {
  String currentText = '';
  Size deviceSize = Size(0, 0);
  final TextEditingController _controller = TextEditingController();

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
    _controller.text = currentText;

    // this changes cursor position
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
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
                child: Text(
                  currentText,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: deviceSize.height * .08,
                      ),
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
