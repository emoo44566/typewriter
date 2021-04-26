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
      child: Stack(children: _getStackChildren()
          // [
          // Background(),

          // AppBarOnStack(title: "Type"),

          // SizedBox.expand(
          //     child: IgnorePointer(
          //   ignoring: (state is WordlistStateTypewriter),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: (state is WordlistStateTypewriter)
          //           ? Colors.transparent
          //           : Color.fromRGBO(222, 195, 195, 1),
          //     ),
          //     child: AnimatedSwitcher(
          //         duration: Duration(seconds: 2), child: _getW()),
          //   ),
          // )),

          // MWordShow(word: "word", onNextPressed: () {})
          // ],
          ),
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
          child: MTypeWriter()),
    );
  }

  Widget _getW() {
    print("_getW");
    return BlocBuilder<WordlistBloc, WordlistState>(builder: (context, state) {
      switch (state.runtimeType) {
        case WordlistStateInitial:
          return Center(
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
          );

        case WordlistStateShow:
          _speak(state.currentWord);
          return MWordShow(
              word: state.currentWord,
              onNextPressed: () =>
                  context.read<WordlistBloc>().add(WordlistEventNextClicked()));

        // return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //   Text(state.currentWord,
        //       style: Theme.of(context).textTheme.headline4),
        //   SizedBox(
        //     height: 30,
        //   ),
        //   Text("${state.wordIndex + 1} of ${state.wordCount}",
        //       style: Theme.of(context).textTheme.headline6),
        //   SizedBox(
        //     height: 60,
        //   ),
        //   IconButton(
        //       iconSize: 120,
        //       icon: Icon(CupertinoIcons.arrow_right),
        //       onPressed: () {
        //         context.read<WordlistBloc>().add(WordlistEventNextClicked());
        //       }),
        // ]);

        case WordlistStateTypewriter:
          _speak(state.currentWord);
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                ),
                Text("${state.wordIndex + 1} of ${state.wordCount}",
                    style: Theme.of(context).textTheme.headline6)
              ],
            ),
          );

        case WordlistStateFinish:
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
      return Text("state");
    });
  }
}
