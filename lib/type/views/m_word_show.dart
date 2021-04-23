import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
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

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: AnimatedLogo(
            animation: animation,
            word: widget.word,
            onNextPressed: () {
              controller.reverse();
              widget.onNextPressed();
            },
            height: MediaQuery.of(context).size.height),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final String word;
  final VoidCallback onNextPressed;
  final double height;
  // Make the Tweens static because they don't change.
  // static final _opacityTween =
  //     Tween<double>(begin: height * -1, end: 0);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  AnimatedLogo(
      {Key? key,
      required Animation<double> animation,
      required this.word,
      required this.onNextPressed,
      required this.height})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    var _downTween = Tween<double>(begin: height * -1, end: height);
    return Center(
      child: Transform.translate(
        offset: Offset(
            0,
            _downTween.evaluate(animation) > 0
                ? 0
                : _downTween.evaluate(animation)),
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(222, 195, 195, 1),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Transform.scale(
                scale: _downTween.evaluate(animation) < 0
                    ? 0
                    : _downTween.evaluate(animation) / height,
                child: Text(word, style: Theme.of(context).textTheme.headline4),
              ),
              SizedBox(
                height: 100, // _sizeTween.evaluate(animation),
              ),
              Transform.translate(
                offset: Offset(
                  0,
                  _downTween.evaluate(animation) < 0
                      ? _downTween.evaluate(animation) * -1 - height
                      : (height - _downTween.evaluate(animation)),
                ),
                child: IconButton(
                    iconSize: 64, //_sizeTween.evaluate(animation),
                    icon: Icon(CupertinoIcons.arrow_right),
                    onPressed: () {
                      onNextPressed();
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
