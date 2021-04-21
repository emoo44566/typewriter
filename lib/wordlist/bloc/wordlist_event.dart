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

// class WordlistEventTypewriter extends WordlistEvent {
//   const WordlistEventTypewriter();

//   @override
//   List<Object> get props => [];

//   String toString() => "WordlistEventTypewriter";
// }
