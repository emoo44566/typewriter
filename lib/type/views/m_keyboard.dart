import 'dart:math';

import 'package:flutter/material.dart';
import 'package:typewriter/main/main.dart';
import 'package:typewriter/type/key_labels.dart';

import 'm_key.dart';
import 'on_key_pressed.dart';

class MKeyboard extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final OnKeyPressed onKeyPressed;

  MKeyboard(
      {required this.width,
      required this.height,
      required this.backgroundColor,
      required this.onKeyPressed});

  @override
  _MKeyboardState createState() => _MKeyboardState();
}

class _MKeyboardState extends State<MKeyboard> {
  bool isUpperCase = false;
  double keyHeight = 10;
  double keyPadding = 2;
  var row1 = "QWERTYUIOP".split('');
  var row2 = "ASDFGHJKL".split('');
  var row3 = "ZXCVBNM".split('');

  _onKeyPressed(String key) {
    print(key);
    if (key == KeyLabels.SHIFT) {
      setState(() {
        isUpperCase = !isUpperCase;
      });
    } else {
      widget.onKeyPressed(key);
    }
  }

  _getKeyWidget(String label, double widthFactor) {
    return MKey(
      label: label,
      onKeyPressed: _onKeyPressed,
      width: keyHeight * widthFactor,
      height: keyHeight,
      padding: keyPadding,
      isUpperCase: isUpperCase,
    );
  }

  @override
  Widget build(BuildContext context) {
    keyHeight = min(widget.height / 5, widget.width / 12);
    var bigKeyWidthFactor = 1.5 + 1 * keyPadding / keyHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,  //Color.fromRGBO(240, 228, 228, 1),
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(6),
            //     bottomRight: Radius.circular(6)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row1.map<Widget>((s) {
                  return _getKeyWidget(s, 1);
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row2.map<Widget>((s) {
                  return _getKeyWidget(s, 1);
                }).toList(),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row3.map<Widget>((s) {
                    return _getKeyWidget(s, 1);
                  }).toList()
                    ..insert(
                        0, _getKeyWidget(KeyLabels.SHIFT, bigKeyWidthFactor))
                    ..add(
                        _getKeyWidget(KeyLabels.BACKSPACE, bigKeyWidthFactor))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getKeyWidget(",", 1),
                  _getKeyWidget(" ", 5 + 8 * keyPadding / keyHeight),
                  _getKeyWidget(".", 1),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
