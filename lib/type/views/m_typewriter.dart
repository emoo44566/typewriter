import 'package:flutter/material.dart';
import 'package:typewriter/type/key_labels.dart';
import 'package:typewriter/wordlist/wordlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views.dart';

class MTypeWriter extends StatefulWidget {
  MTypeWriter();

  @override
  _MTypeWriterState createState() => _MTypeWriterState();
}

class _MTypeWriterState extends State<MTypeWriter> {
  String currentText = '';
  Size deviceSize = Size(0, 0);
  String goalText = '';

  _onKeyPressed(String key) {
    //print(key);

    setState(() {
      if (key == KeyLabels.BACKSPACE) {
        if (currentText.length > 0)
          currentText = currentText.substring(0, currentText.length - 1);
      } else {
        if (currentText.length < goalText.length) {
          currentText += key;
          if (currentText == goalText)
            context.read<WordlistBloc>().add(WordlistEventNextClicked());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    var state = context.watch<WordlistBloc>().state;
    goalText = state.currentWord;
    if (state is WordlistStateShow)
      setState(() {
        currentText = '';
      });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(222, 195, 195, 1), //(200, 200, 200, 1),
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          ),
          child: SizedBox(
            height: deviceSize.height * .34,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30,
                  right: deviceSize.width * .3,
                  left: deviceSize.width * .3),
              child: Center(
                child: MHintText(
                  text: currentText,
                  goalText: goalText,
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
