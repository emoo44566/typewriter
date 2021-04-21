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
          //
          //
          SizedBox.expand(
              child: (state is WordlistStateTypewriter)
                  ? IgnorePointer(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: _getW()),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 250, 198, 1), //("#FFFDD0"),
                      ),
                      child: _getW())),

          //   Positioned(
          //       top: 10,
          //       left: 10,
          //       right: 10,
          //       bottom: 10,
          //       child: Container(
          //         decoration: BoxDecoration(color: Colors.red.withAlpha(50)),
          //         child: Center(
          //             child: (state is WordlistStateInitial)
          //                 ? IconButton(
          //                     iconSize: 60,
          //                     icon: Icon(CupertinoIcons.play_fill),
          //                     onPressed: () {
          //                       context
          //                           .read<WordlistBloc>()
          //                           .add(WordlistEventNextClicked());
          //                     })
          //                 : (state is WordlistStateShow)
          //                     ?
          //                     :
          //       )),
        ],
      ),
    );
  }

  Widget _getW() {
    return BlocBuilder<WordlistBloc, WordlistState>(builder: (context, state) {
      switch (state.runtimeType) {
        case WordlistStateInitial:
          return IconButton(
              iconSize: 120,
              icon: Icon(CupertinoIcons.play_fill),
              onPressed: () {
                context.read<WordlistBloc>().add(WordlistEventNextClicked());
              });

        case WordlistStateShow:
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(state.currentWord,
                style: Theme.of(context).textTheme.headline4),
            SizedBox(
              height: 30,
            ),
            Text("${state.wordIndex + 1} of ${state.wordCount}",
                style: Theme.of(context).textTheme.headline6),
            SizedBox(
              height: 60,
            ),
            IconButton(
                iconSize: 120,
                icon: Icon(CupertinoIcons.arrow_right),
                onPressed: () {
                  context.read<WordlistBloc>().add(WordlistEventNextClicked());
                }),
          ]);

        case WordlistStateTypewriter:
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                ),
                Text(state.currentWord,
                    style: Theme.of(context).textTheme.headline3),
                SizedBox(
                  width: 30,
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
