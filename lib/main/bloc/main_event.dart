part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}


class MainSelectTClicked extends MainEvent {
  final int seletedT;

  const MainSelectTClicked({required this.seletedT});

  @override
  List<Object> get props => [seletedT];

  String toString() => "MainSelectTClicked $seletedT";

}

