import 'package:flutter/material.dart';

import 'm_key.dart';
import 'on_key_pressed.dart';

class MKeyboard extends StatefulWidget {
  final double width;
  final OnKeyPressed onKeyPressed;

  MKeyboard({required this.width, required this.onKeyPressed});

  @override
  _MKeyboardState createState() => _MKeyboardState();
}

class _MKeyboardState extends State<MKeyboard> {
  bool isUpperCase = true;

  _onKeyPressed(String key) {
    print(key);
    if (key.toLowerCase() == "shift") {
      setState(() {
        isUpperCase = !isUpperCase;
      });
    } else {
      widget.onKeyPressed(key);
    }
  }

  _getKeyWidget(String label, double height, double widthFactor) {
    return MKey(
      label: label,
      onKeyPressed: _onKeyPressed,
      width: height * widthFactor,
      height: height,
      isUpperCase: isUpperCase,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (widget.width - 40) / 13;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: itemWidth * 6,
          decoration: BoxDecoration(
            color: Color.fromRGBO(220, 220, 220, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Q",
                  "W",
                  "E",
                  "R",
                  "T",
                  "Y",
                  "U",
                  "I",
                  "O",
                  "P",
                ].map<Widget>((s) {
                  return _getKeyWidget(s, itemWidth, 1);
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "A",
                  "S",
                  "D",
                  "F",
                  "G",
                  "H",
                  "J",
                  "K",
                  "L",
                ].map<Widget>((s) {
                  return _getKeyWidget(s, itemWidth, 1);
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Z",
                      "X",
                      "C",
                      "V",
                      "B",
                      "N",
                      "M",
                    ].map<Widget>((s) {
                      return _getKeyWidget(s, itemWidth, 1);
                    }).toList()
                      ..add(_getKeyWidget("<-", itemWidth, 1.6))
                      ..insert(0, _getKeyWidget("shift", itemWidth, 1.6))),
              ),
              Padding(
                padding: EdgeInsets.only(left: itemWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getKeyWidget(" ", itemWidth, 5),
                    _getKeyWidget(".", itemWidth, 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
