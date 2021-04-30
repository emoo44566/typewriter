part of 'wordlist_bloc.dart';

abstract class WordlistEvent extends Equatable {
  const WordlistEvent();

  @override
  List<Object> get props => [];
}

class WordlistEventNextClicked extends WordlistEvent {
  const WordlistEventNextClicked();

  @override
  List<Object> get props => [];

  String toString() => "WordlistEventNextClicked";
}

class WordlistEventStartClicked extends WordlistEvent {
  final PackageModel packageModel;
  const WordlistEventStartClicked({required this.packageModel});

  @override
  List<Object> get props => [packageModel];

  String toString() => "WordlistEventStartClicked $packageModel";
}
// class WordlistEventTypewriter extends WordlistEvent {
//   const WordlistEventTypewriter();

//   @override
//   List<Object> get props => [];

//   String toString() => "WordlistEventTypewriter";
// }
