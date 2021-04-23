import 'package:flutter/cupertino.dart';
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
  List<Widget> _getTextList() {
    var _styleNormal = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: widget.fontSize,
          color: Colors.black.withAlpha(230),
        );
    var _styleCorrect = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: widget.fontSize,
          color: Color.fromRGBO(80, 80, 80, 1), //fromRGBO(3, 187, 89, 1),
        );
    var _styleWrong = Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: widget.fontSize,
          color: Color.fromRGBO(209, 17, 65, 1),
        );

    final List fixedList =
        Iterable<int>.generate(widget.goalText.length).toList();

    return fixedList.map((e) {
      // print(e);
      var char = widget.goalText[e];
      if (e >= widget.text.length) {
        if (e == widget.text.length)
          return _getCharColumn(char, _styleNormal, true);
        else
          return _getCharColumn(char, _styleNormal, false);
      } else if (widget.goalText[e] == widget.text[e])
        return _getCharColumn(char, _styleCorrect, false);
      else
        return _getCharColumn(char, _styleWrong, false);
    }).toList();
  }

  Widget _getCharColumn(String char, TextStyle? style, bool isCurrent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Transform.translate(
        //   offset: Offset(0, widget.fontSize * .2),
        //   child: Transform.scale(
        //     scale: 1.6,
        //     child: Icon(CupertinoIcons.arrowtriangle_down_fill,
        //         color: (isCurrent) ? Colors.black : Colors.transparent),
        //   ),
        // ),
        Text(char, style: style),
        Transform.translate(
          offset: Offset(0, widget.fontSize * -.2),
          child: Transform.scale(
              scale: 1.6,
              child: Icon(CupertinoIcons.chevron_up, 
                  color: (isCurrent) ? Colors.black : Colors.transparent)),
        ),
        // Transform.translate(
        //   offset: Offset(0, widget.fontSize * -.2),
        //   child: Transform.scale(
        //       scale: 1.6,
        //       child: Icon(CupertinoIcons.arrow_uturn_down_square,
        //           color: (isCurrent) ? Colors.black : Colors.transparent)),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _getTextList(),
        ),
      ),
    );
  }
}
