import 'dart:async';

import 'package:flutter/material.dart';
import 'package:typewriter/type/views/m_cursor.dart';

import 'on_key_pressed.dart';

class MText extends StatefulWidget {
  final String text;
  final double fontSize;
  final OnKeyPressed onKeyPressed;

  const MText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.onKeyPressed})
      : super(key: key);

  @override
  _MTextState createState() => _MTextState();
}

class _MTextState extends State<MText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            widget.text,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: widget.fontSize),
          ),
          MCursor(height: widget.fontSize)
        ]),
      ),
    );
  }

  void _createMessage(BuildContext context, String body) {
    var a = _createOverlayEntry(context, body);
    Overlay.of(context)?.insert(a);
    Future.delayed(const Duration(milliseconds: 12000), () {
      a.remove();
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context, String body) {
    // RenderBox? renderBox = context.findRenderObject();
    // var size = renderBox ?? renderBox?.size;
    // var offset = renderBox ?? renderBox?.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        // left: 30, //offset.dx,
        // right: 30,
        top: MediaQuery.of(context).size.height * .2 -
            100, // offset.dy + size.height + 5.0,
        width: 6, // size.width,
        height: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
          ),
        ),
      ),
    );
  }
}
