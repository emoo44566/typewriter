import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:typewriter/wordlist/wordlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class MWordShow extends StatefulWidget {
  final String word;
  final Color backgroundColor;
  final VoidCallback onNextPressed;

  const MWordShow(
      {Key? key,
      required this.word,
      required this.backgroundColor,
      required this.onNextPressed})
      : super(key: key);

  @override
  _MWordShowState createState() => _MWordShowState();
}

class _MWordShowState extends State<MWordShow>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();

    print("_MWordShowState init");

    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this)
          ..addStatusListener((status) {
            print("status in $status");
          })
          ..addListener(() {
            // print(controller.value);
            if ((.5 - controller.value < .03) && (controller.value < .5)) {
              print("${controller.value} Stop");
              controller.stop();
            }
          });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<WordlistBloc>().state;
    if (state is WordlistStateShow) {
      print("WordlistStateShow");

      controller.forward(from: 0);
      print("WordlistStateShow");
    }

    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
          child: StaggerAnimation(
        controller: controller,
        word: widget.word,
        onNextPressed: () {
          // controller.reverse();
          widget.onNextPressed();
          controller.forward(from: .51);
        },
        height: MediaQuery.of(context).size.height,
        backgroundColor: widget.backgroundColor,
      )),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation(
      {Key? key,
      required this.controller,
      required this.word,
      required this.onNextPressed,
      required this.height,
      required this.backgroundColor})
      : backgroundYPosition = _animate(controller, [
          _getTween(-height, 0, 10),
          _getConstantTween(0, 60),
          _getTween(0, -height, 10),
          _getConstantTween(-height, 20),
        ]),
        wordScaleTween = _animate(
          controller,
          [
            _getConstantTween(0, 10),
            _getTween(0, 1, 10),
            _getConstantTween(1, 30),
            _getTween(1, 0, 10),
            _getConstantTween(0, 30),
          ],
        ),
        buttonYPositionTween = _animate(
          controller,
          [
            _getConstantTween(height, 30),
            _getTween(height, 0, 9),
            _getConstantTween(0, 13),
            _getTween(0, height, 8),
            _getConstantTween(height, 40),
          ],
        ),
        super(key: key);

  final AnimationController controller;
  final String word;
  final VoidCallback onNextPressed;
  final double height;
  final Color backgroundColor;

  final Animation<double> backgroundYPosition;
  final Animation<double> wordScaleTween;
  final Animation<double> buttonYPositionTween;

  static _getTween(double b, double e, double w) => TweenSequenceItem<double>(
        tween: Tween<double>(begin: b, end: e)
            .chain(CurveTween(curve: Curves.ease)),
        weight: w,
      );

  static _getConstantTween(double v, double w) => TweenSequenceItem<double>(
        tween: ConstantTween<double>(v).chain(CurveTween(curve: Curves.ease)),
        weight: w,
      );

  static _animate(AnimationController c, List<TweenSequenceItem<double>> l) =>
      TweenSequence<double>(l).animate(
        CurvedAnimation(
          parent: c,
          curve: Interval(
            0,
            1,
            curve: Curves.linear,
          ),
        ),
      );

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Stack(children: [
      SizedBox.expand(
        child: Transform.translate(
          offset: Offset(0, backgroundYPosition.value),
          // isEnter
          //     ? backgroundYPosition.value
          //     : backgroundYPositionOut.value),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor, //Color.fromRGBO(222, 80, 195, 1),
            ),
          ),
        ),
      ),
      SizedBox.expand(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Transform.scale(
          scale: wordScaleTween.value, //   < .3 ? .5 : 1,
          child: Text(word,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(fontSize: height * .08)),
        ),
        SizedBox(
          height: 100, // _sizeTween.evaluate(animation),
        ),
        Transform.scale(
            scale: 1, //scale1Tween.value,
            child: Transform.translate(
              offset: Offset(0, buttonYPositionTween.value),
              child: IconButton(
                  iconSize: 64, //_sizeTween.evaluate(animation),
                  icon: Icon(CupertinoIcons.arrow_right),
                  onPressed: () {
                    onNextPressed();
                  }),
            ))
      ])),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // wordScaleTween.addListener(() {
    //   print(
    //       "value scale: ${controller.value.toStringAsFixed(2)} ${wordScaleTween.value.toStringAsFixed(2)}");
    // });
    return AnimatedBuilder(
        builder: _buildAnimation, animation: controller.view);
  }
}
