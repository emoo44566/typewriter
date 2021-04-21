part of "wordlist_bloc.dart";

abstract class WordlistState extends Equatable {
  final String currentWord;
  final int wordIndex;
  final int wordCount;

  const WordlistState(
      {this.currentWord = "", this.wordIndex = -1, required this.wordCount});

  @override
  List<Object> get props => [currentWord, wordIndex, wordCount];
}

class WordlistStateInitial extends WordlistState {
  WordlistStateInitial({required wordCount}) : super(wordCount: wordCount);

  @override
  String toString() =>
      'WordlistStateInitial ($currentWord, $wordIndex, $wordCount)';
}

class WordlistStateShow extends WordlistState {
  WordlistStateShow(
      {required currentWord, required wordIndex, required wordCount})
      : super(
            currentWord: currentWord,
            wordIndex: wordIndex,
            wordCount: wordCount);

  @override
  String toString() =>
      'WordlistStateShow ($currentWord, $wordIndex, $wordCount)';
}

class WordlistStateTypewriter extends WordlistState {
  WordlistStateTypewriter(
      {required currentWord, required wordIndex, required wordCount})
      : super(
            currentWord: currentWord,
            wordIndex: wordIndex,
            wordCount: wordCount);

  @override
  String toString() =>
      'WordlistStateTypewriter ($currentWord, $wordIndex, $wordCount)';
}

class WordlistStateFinish extends WordlistState {
  WordlistStateFinish(
      {required currentWord, required wordIndex, required wordCount})
      : super(
            currentWord: currentWord,
            wordIndex: wordIndex,
            wordCount: wordCount);

  @override
  String toString() =>
      'WordlistStateFinish ($currentWord, $wordIndex, $wordCount)';
}
