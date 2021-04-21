import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewriter/core/bloc_utils.dart';
import 'package:typewriter/data/wordlist_repository.dart';

part 'wordlist_event.dart';
part 'wordlist_state.dart';

class WordlistBloc extends Bloc<WordlistEvent, WordlistState> {
  final WordlistRepository repository;

  WordlistBloc({required this.repository})
      : super(WordlistStateInitial(wordCount: repository.getWordCount()));

  @override
  void onTransition(Transition<WordlistEvent, WordlistState> transition) {
    BlocUtils.printTransition(transition);
    super.onTransition(transition);
  }

  @override
  Stream<WordlistState> mapEventToState(
    WordlistEvent event,
  ) async* {
    if (event is WordlistEventNextClicked) {
      switch (state.runtimeType) {
        case WordlistStateInitial:
          yield WordlistStateShow(
              currentWord: await repository.getWord(0),
              wordIndex: 0,
              wordCount: state.wordCount);
          break;
        case WordlistStateShow:
          yield WordlistStateTypewriter(
              currentWord: state.currentWord,
              wordIndex: state.wordIndex,
              wordCount: state.wordCount);
          break;
        case WordlistStateTypewriter:
          if (state.wordIndex + 1 == state.wordCount)
            yield WordlistStateFinish(
                currentWord: '',
                wordIndex: state.wordIndex,
                wordCount: state.wordCount);
          else
            yield WordlistStateShow(
                currentWord: await repository.getWord(state.wordIndex + 1),
                wordIndex: state.wordIndex + 1,
                wordCount: state.wordCount);
          break;
        case WordlistStateFinish:
          yield WordlistStateInitial(wordCount: repository.getWordCount());
          break;
      }

      // yield* _mapWordlistSelectTClickedsToState(event);
    }
  }

  // Stream<WordlistState> _mapWordlistSelectTClickedsToState(
  //     WordlistEventNextWordShowed event) async* {
  //   // yield WordlistStateNext(selectedT: event.seletedT);
  // }
}
