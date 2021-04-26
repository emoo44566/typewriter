import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:typewriter/wordlist/wordlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MWordShow extends StatefulWidget {
  final String word;
  final VoidCallback onNextPressed;

  const MWordShow({Key? key, required this.word, required this.onNextPressed})
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
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    // animation = Tween<double>(begin: 0, end: 100).animate(controller)
    //   ..addStatusListener((state) => print('$state'));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        print("status $status");
        if (status == AnimationStatus.completed) {
          //controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //controller.forward();
        }
      });

    // controller.forward();
    //
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<WordlistBloc>().state;
    if (state is WordlistStateShow) controller.forward();

    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(6),
        // ),
        child: StaggerAnimation(
            controller: controller,
            word: widget.word,
            onNextPressed: () {
              controller.reverse();
              widget.onNextPressed();
              // Future.delayed(
              //     Duration(seconds: 0, milliseconds: 500), () => widget.onNextPressed());
              // widget.onNextPressed();
            },
            height: MediaQuery.of(context).size.height),

        // AnimatedLogo(
        //     animation: animation,
        //     word: widget.word,
        //     onNextPressed: () {
        //       controller.reverse();
        //       widget.onNextPressed();
        //       // Future.delayed(
        //       //     Duration(seconds: 0, milliseconds: 500), () => widget.onNextPressed());
        //       // widget.onNextPressed();
        //     },
        //     height: MediaQuery.of(context).size.height),
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation(
      {Key? key,
      required this.controller,
      required this.word,
      required this.onNextPressed,
      required this.height})
      : backgroundYPosition = Tween<double>(begin: -height, end: 0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.easeInCubic,
            ),
          ),
        ),
        scale1Tween = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.200,
              0.600,
              curve: Curves.ease,
            ),
          ),
        ),
        buttonYPositionTween = Tween<double>(
          begin: height,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        padding = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 16.0),
          end: const EdgeInsets.only(bottom: 75.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.250,
              0.375,
              curve: Curves.ease,
            ),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(4.0),
          end: BorderRadius.circular(75.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.375,
              0.500,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.red,
          end: Colors.blue,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.500,
              0.750,
              curve: Curves.ease,
            ),
          ),
        ),

        // ... Other tween definitions ...

        super(key: key);

  final AnimationController controller;
  final String word;
  final VoidCallback onNextPressed;
  final double height;
  final Animation<double> scale1Tween;
  final Animation<double> buttonYPositionTween;
  final Animation<double> backgroundYPosition;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius> borderRadius;
  final Animation<Color?> color;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Stack(children: [
      SizedBox.expand(
        child: Transform.translate(
          offset: Offset(0, backgroundYPosition.value),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(222, 80, 195, 1),
            ),
          ),
        ),
      ),
      SizedBox.expand(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Transform.scale(
          scale: scale1Tween.value,
          child: Text(word, style: Theme.of(context).textTheme.headline4),
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
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
