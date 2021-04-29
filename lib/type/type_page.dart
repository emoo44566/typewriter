import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewriter/wordlist/wordlist.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'views/views.dart';

class TypePage extends StatefulWidget {
  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  FlutterTts flutterTts = FlutterTts();

  Future _speak(String w) async {
    var result = await flutterTts.speak(w);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordlistBloc, WordlistState>(builder: (context, state) {
      print("blocbuilder /...");
      return SizedBox.expand(
        child: Stack(children: _getStackChildren(state)),
      );
    });
  }

  List<Widget> _getStackChildren(WordlistState state) {
    switch (state.runtimeType) {
      case WordlistStateInitial:
        return <Widget>[_childInitial()];
      case WordlistStateShow:
        _speak(state.currentWord);
        if (state.wordIndex == 0)
          return <Widget>[
            _childTypeWriter(state),
            _childInitial(),
            _childWordShow(state)
          ];
        else
          return <Widget>[_childTypeWriter(state), _childWordShow(state)];
      case WordlistStateTypewriter:
        return <Widget>[_childTypeWriter(state), _childWordShow(state)];
    }
    return <Widget>[_childInitial()];
  }

  Widget _childInitial() {
    return SizedBox.expand(
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(222, 195, 195, 1),
            ),
            child: Center(
              child: IconButton(
                  iconSize: 120,
                  icon: Icon(CupertinoIcons.play_fill),
                  onPressed: () {
                    Future.delayed(
                        Duration(seconds: 0),
                        () => context
                            .read<WordlistBloc>()
                            .add(WordlistEventNextClicked()));
                    // context.read<WordlistBloc>().add(WordlistEventNextClicked());
                  }),
            )));
  }

  Widget _childWordShow(WordlistState state) {
    return SizedBox.expand(
        child: MWordShow(
      key: Key("lsdkfjlsdfsl"),
      word: state.currentWord,
      backgroundColor: _getStateColor(state),
      onNextPressed: () =>
          context.read<WordlistBloc>().add(WordlistEventNextClicked()),
    ));
  }

  Widget _childTypeWriter(WordlistState state) {
    return SizedBox.expand(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: MTypeWriter(
            goalText: state.currentWord,
            backgroundColor: _getStateColor(state),
          )),
    );
  }

  Color _getStateColor(WordlistState state) {
    if (state.wordIndex % 2 == 0)
      return Color.fromRGBO(222, 195, 195, 1);
    else
      return Color.fromRGBO(216, 226, 220, 1); //(199, 240, 225, 1);
  }

  Widget _childFinish() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Finish", style: Theme.of(context).textTheme.headline4),
      SizedBox(
        height: 60,
      ),
      IconButton(
          iconSize: 120,
          icon: Icon(CupertinoIcons.refresh_thick),
          onPressed: () {
            context.read<WordlistBloc>().add(WordlistEventNextClicked());
          }),
    ]);
  }
}
