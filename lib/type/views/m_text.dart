import 'dart:async';

import 'package:flutter/material.dart';

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
  late Timer timer;
  bool showCurser = false;

  @override
  void initState() {
    super.initState();
    // _createMessage(context, "body");

    timer = Timer.periodic(Duration(milliseconds: 600), (Timer t) {
      setState(() {
        showCurser = !showCurser;
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          widget.onKeyPressed("d");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.withAlpha(30),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              widget.text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontSize: widget.fontSize),
            ),
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
