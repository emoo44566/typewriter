import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewriter/core/bloc_utils.dart';
import 'package:typewriter/data/wordlist_repository.dart';
import 'package:typewriter/package/package.dart';

part 'wordlist_event.dart';
part 'wordlist_state.dart';

class WordlistBloc extends Bloc<WordlistEvent, WordlistState> {
  final WordlistRepository repository;

  WordlistBloc({required this.repository})
      : super(WordlistStateInitial(
            packageModel: PackageModel(0, "title", "description", 10)));

  @override
  void onTransition(Transition<WordlistEvent, WordlistState> transition) {
    BlocUtils.printTransition(transition);
    super.onTransition(transition);
  }

  @override
  Stream<WordlistState> mapEventToState(
    WordlistEvent event,
  ) async* {
    if (event is WordlistEventStartClicked) {
      if (state is WordlistStateInitial) {
        yield WordlistStateShow(
            packageModel: event.packageModel,
            currentWord: await repository.getWord(event.packageModel.id, 0),
            wordIndex: 0);
      }
    }
    if (event is WordlistEventNextClicked) {
      switch (state.runtimeType) {
        case WordlistStateInitial:
          yield WordlistStateShow(
              packageModel: state.packageModel,
              currentWord: await repository.getWord(state.packageModel.id, 0),
              wordIndex: 0);
          break;
        case WordlistStateShow:
          yield WordlistStateTypewriter(
              packageModel: state.packageModel,
              currentWord: state.currentWord,
              wordIndex: state.wordIndex);
          break;
        case WordlistStateTypewriter:
          if (state.wordIndex + 1 == state.packageModel.wordCount)
            yield WordlistStateFinish(
                packageModel: state.packageModel,
                currentWord: const MapEntry<String, String>('', ''),
                wordIndex: state.wordIndex);
          else
            yield WordlistStateShow(
                packageModel: state.packageModel,
                currentWord: await repository.getWord(
                    state.packageModel.id, state.wordIndex + 1),
                wordIndex: state.wordIndex + 1);
          break;
        case WordlistStateFinish:
          yield WordlistStateInitial(packageModel: state.packageModel);
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
