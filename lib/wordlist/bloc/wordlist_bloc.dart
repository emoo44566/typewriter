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
      if (state is WordlistStateInitial) {
        yield WordlistStateShow(
            currentWord: await repository.getWord(0),
            wordIndex: 0,
            wordCount: state.wordCount);
      } else if (state is WordlistStateShow) {
        yield WordlistStateTypewriter(
            currentWord: state.currentWord,
            wordIndex: state.wordIndex,
            wordCount: state.wordCount);
      } else if (state is WordlistStateTypewriter) {
        yield WordlistStateShow(
            currentWord: await repository.getWord(state.wordIndex + 1),
            wordIndex: state.wordIndex + 1,
            wordCount: state.wordCount);
      }

      // yield* _mapWordlistSelectTClickedsToState(event);
    }
  }

  // Stream<WordlistState> _mapWordlistSelectTClickedsToState(
  //     WordlistEventNextWordShowed event) async* {
  //   // yield WordlistStateNext(selectedT: event.seletedT);
  // }
}
