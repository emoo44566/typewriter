import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewriter/core/bloc_utils.dart';
import 'package:typewriter/data/wordlist_repository.dart';
import 'package:typewriter/package/model/package_model.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final WordlistRepository repository;

  PackageBloc({required this.repository})
      : super(PackageStateInitial(packageModelList: repository.getPackageModelList()));

  @override
  void onTransition(Transition<PackageEvent, PackageState> transition) {
    BlocUtils.printTransition(transition);
    super.onTransition(transition);
  }

  @override
  Stream<PackageState> mapEventToState(
    PackageEvent event,
  ) async* {
    // if (event is PackageEventNextClicked) {
    //   switch (state.runtimeType) {
    //     case PackageStateInitial:
    //       yield PackageStateShow(
    //           currentWord: await repository.getWord(0),
    //           wordIndex: 0,
    //           wordCount: state.wordCount);
    //   }

      // yield* _mapPackageSelectTClickedsToState(event);
    }
  }

  // Stream<PackageState> _mapPackageSelectTClickedsToState(
  //     PackageEventNextWordShowed event) async* {
  //   // yield PackageStateNext(selectedT: event.seletedT);
  // }

