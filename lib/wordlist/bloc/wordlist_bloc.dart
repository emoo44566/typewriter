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
            packageModel: PackageModel(0, "title", "description", 10))) {
    on<WordlistEventStartClicked>((event, emit) async => {
          if (state is WordlistStateInitial)
            {
              emit(WordlistStateShow(
                  packageModel: event.packageModel,
                  currentWord:
                      await repository.getWord(event.packageModel.id, 0),
                  wordIndex: 0))
            }
        });

    on<WordlistEventNextClicked>((event, emit) async => {
          if (state is WordlistStateInitial)
            emit(WordlistStateShow(
                packageModel: state.packageModel,
                currentWord: await repository.getWord(state.packageModel.id, 0),
                wordIndex: 0))
          else if (state is WordlistStateShow)
            emit(WordlistStateTypewriter(
                packageModel: state.packageModel,
                currentWord: state.currentWord,
                wordIndex: state.wordIndex))
          else if (state is WordlistStateTypewriter)
            if (state.wordIndex + 1 == state.packageModel.wordCount)
              emit(WordlistStateFinish(
                  packageModel: state.packageModel,
                  currentWord: const MapEntry<String, String>('', ''),
                  wordIndex: state.wordIndex))
            else
              emit(WordlistStateShow(
                  packageModel: state.packageModel,
                  currentWord: await repository.getWord(
                      state.packageModel.id, state.wordIndex + 1),
                  wordIndex: state.wordIndex + 1))
          else if (state is WordlistStateFinish)
            emit(WordlistStateInitial(packageModel: state.packageModel))
        });
  }

  @override
  void onTransition(Transition<WordlistEvent, WordlistState> transition) {
    BlocUtils.printTransition(transition);
    super.onTransition(transition);
  }

}
