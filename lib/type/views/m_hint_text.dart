import 'dart:async';

import 'package:flutter/material.dart';

import 'on_key_pressed.dart';

class MHintText extends StatefulWidget {
  final String text;
  final String goalText;
  final double fontSize;
  final OnKeyPressed onKeyPressed;

  const MHintText(
      {Key? key,
      required this.text,
      required this.goalText,
      required this.fontSize,
      required this.onKeyPressed})
      : super(key: key);

  @override
  _MTextState createState() => _MTextState();
}

class _MTextState extends State<MHintText> {
  late Timer timer;
  bool showCurser = false;

  @override
  void initState() {
    super.initState();
    // _createMessage(context, "body");
    print("initState");

    timer = Timer.periodic(Duration(milliseconds: 6000), (Timer t) {
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

  List<Widget> _getTextList() {
    var _styleNormal = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: widget.fontSize,
          color: Colors.black,
        );
    var _styleCorrect = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: widget.fontSize,
          color: Colors.green,
        );
    var _styleWrong = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: widget.fontSize,
          color: Colors.red,
        );

    print("--------- _getTextSpanList");
    final List fixedList =
        Iterable<int>.generate(widget.goalText.length).toList();

    return fixedList.map((e) {
      print(e);
      if (e >= widget.text.length)
        return Text(widget.goalText[e], style: _styleNormal);
      else if (widget.goalText[e] == widget.text[e])
        return Text(widget.goalText[e], style: _styleCorrect);
      else
        return Text(widget.goalText[e], style: _styleWrong);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Text(
          //   widget.text,
          //   style: Theme.of(context)
          //       .textTheme
          //       .headline6
          //       ?.copyWith(fontSize: widget.fontSize),
          // ),
          //

          Row(
            children: _getTextList(),
          ),

          // RichText(
          //   text: TextSpan(
          //     text: 's',
          //     style: Theme.of(context).textTheme.headline6?.copyWith(
          //           fontSize: widget.fontSize,
          //           color: Colors.blue,
          //         ),
          //     children: [
          //       TextSpan(text: "ha "),
          //     ],

          //     //  _getTextSpanList(),
          //   ),
          // ),
          SizedBox(
            width: 2,
            height: widget.fontSize,
            child: Container(
              decoration: BoxDecoration(
                color: showCurser ? Colors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
