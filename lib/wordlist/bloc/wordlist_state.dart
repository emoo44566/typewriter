part of "wordlist_bloc.dart";

abstract class WordlistState extends Equatable {
  final PackageModel packageModel;
  final String currentWord;
  final int wordIndex;

  const WordlistState(
      {required this.packageModel, this.currentWord = "", this.wordIndex = -1});

  @override
  List<Object> get props => [packageModel, currentWord];
}

class WordlistStateInitial extends WordlistState {
  WordlistStateInitial({required packageModel})
      : super(packageModel: packageModel);

  @override
  String toString() => 'WordlistStateInitial ($packageModel, $currentWord)';
}

class WordlistStateShow extends WordlistState {
  WordlistStateShow(
      {required packageModel,
      required currentWord,
      required wordIndex})
      : super(
            packageModel: packageModel,
            currentWord: currentWord,
            wordIndex: wordIndex);

  @override
  String toString() =>
      'WordlistStateShow ($packageModel, $currentWord, $wordIndex)';
}

class WordlistStateTypewriter extends WordlistState {
  WordlistStateTypewriter(
      {required packageModel,
      required currentWord,
      required wordIndex})
      : super(
            packageModel: packageModel,
            currentWord: currentWord,
            wordIndex: wordIndex);

  @override
  String toString() =>
      'WordlistStateTypewriter ($packageModel, $currentWord, $wordIndex)';
}

class WordlistStateFinish extends WordlistState {
  WordlistStateFinish(
      {required packageModel,
      required currentWord,
      required wordIndex})
      : super(
            packageModel: packageModel,
            currentWord: currentWord,
            wordIndex: wordIndex);

  @override
  String toString() =>
      'WordlistStateFinish ($packageModel, $currentWord, $wordIndex)';
}
