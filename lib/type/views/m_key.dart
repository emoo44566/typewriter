import 'package:flutter/material.dart';

import 'on_key_pressed.dart';

class MKey extends StatelessWidget {
  final String label;
  final OnKeyPressed onKeyPressed;
  final double width;
  final double height;
  final double padding;
  final bool isUpperCase;

  const MKey(
      {Key? key,
      required this.label,
      required this.onKeyPressed,
      required this.width,
      required this.height,
      required this.padding,
      required this.isUpperCase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: GestureDetector(
        onTap: () {
          onKeyPressed(isUpperCase ? label.toUpperCase() : label.toLowerCase());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    (isUpperCase) ? label.toUpperCase() : label.toLowerCase(),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white70, fontSize: height * .36),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
