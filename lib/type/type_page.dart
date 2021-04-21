import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewriter/wordlist/wordlist.dart';

import 'views/views.dart';

class TypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<WordlistBloc>().state;
    return SizedBox.expand(
      child: Stack(
        children: [
          // Background(),
          SizedBox.expand(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: MTypeWriter()),
          ),
          // AppBarOnStack(title: "Type"),
          //

          Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.red.withAlpha(50)),
                child: Center(
                    child: (state is WordlistStateInitial)
                        ? IconButton(
                            iconSize: 60,
                            icon: Icon(CupertinoIcons.play_fill),
                            onPressed: () {
                              context
                                  .read<WordlistBloc>()
                                  .add(WordlistEventNextClicked());
                            })
                        : (state is WordlistStateShow)
                            ? Row(children: [
                                Text(state.currentWord,
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                IconButton(
                                    iconSize: 60,
                                    icon: Icon(
                                        CupertinoIcons.arrow_clockwise_circle),
                                    onPressed: () {
                                      context
                                          .read<WordlistBloc>()
                                          .add(WordlistEventNextClicked());
                                    }),
                              ])
                            : Row(
                                children: [
                                  Text("Typewriter",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(state.currentWord,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                      "${state.wordIndex} of ${state.wordCount}",
                                      style:
                                          Theme.of(context).textTheme.headline4)
                                ],
                              )),
              )),
        ],
      ),
    );
  }
}
