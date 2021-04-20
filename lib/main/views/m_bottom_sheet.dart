import 'package:flutter/material.dart';

class MBottomSheet extends StatelessWidget {
  final String title;
  final Widget body;
  final String buttonText;
  final VoidCallback? buttonOnPressed;
  const MBottomSheet(
      {Key? key,
      required this.title,
      required this.body,
      required this.buttonText,
      required this.buttonOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Expanded(child: body),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Color(0xFFff1E48),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  onPressed: buttonOnPressed)
            ]),
      ),
    );
  }
}
