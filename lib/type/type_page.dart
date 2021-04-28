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
  late WordlistState state;

  Future _speak(String w) async {
    var result = await flutterTts.speak(w);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  @override
  Widget build(BuildContext context) {
    state = context.watch<WordlistBloc>().state;
    return SizedBox.expand(
      child: Stack(children: _getStackChildren()),
    );
  }

  List<Widget> _getStackChildren() {
    switch (state.runtimeType) {
      case WordlistStateInitial:
        return <Widget>[childInitial()];
      case WordlistStateShow:
        _speak(state.currentWord);
        if (state.wordIndex == 0)
          return <Widget>[childInitial(), childWordShow()];
        else
          return <Widget>[childTypeWriter(), childWordShow()];
      case WordlistStateTypewriter:
        return <Widget>[childTypeWriter(), childWordShow()];
    }
    return <Widget>[childInitial()];
  }

  Widget childInitial() {
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

  Widget childWordShow() {
    return SizedBox.expand(
        child: MWordShow(
      key: Key("lsdkfjlsdfsl"),
      word: state.currentWord,
      onNextPressed: () =>
          context.read<WordlistBloc>().add(WordlistEventNextClicked()),
    ));
  }

  Widget childTypeWriter() {
    return SizedBox.expand(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: MTypeWriter(goalText: state.currentWord,)),
    );
  }

  Widget childFinish() {
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
