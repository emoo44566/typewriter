import 'package:flutter/material.dart';
import 'package:typewriter/type/key_labels.dart';
import 'package:typewriter/wordlist/wordlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views.dart';

class MTypeWriter extends StatefulWidget {
  final String goalText;
  final Color backgroundColor;
  MTypeWriter({required this.goalText, required this.backgroundColor});

  @override
  _MTypeWriterState createState() => _MTypeWriterState();
}

class _MTypeWriterState extends State<MTypeWriter> {
  String currentText = '';
  Size deviceSize = Size(0, 0);
  String goalText = '';
  Color backgroundColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    print("initState --");
  }

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
    print("build ...");

    var state = context.watch<WordlistBloc>().state;

    Future.delayed(Duration(milliseconds: 1800), () {
      print("build ... //");
      goalText = state.currentWord;
      if ((state is WordlistStateShow) && (currentText != ''))
        setState(() {
          currentText = '';
          backgroundColor = widget.backgroundColor;
        });
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
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
        MKeyboard(
          width: deviceSize.width,
          height: deviceSize.height * .66,
          backgroundColor: widget.backgroundColor.withOpacity(.6),
          onKeyPressed: _onKeyPressed,
        ),
      ],
    );
  }
}
