import 'package:typewriter/package/package.dart';

class WordlistRepository {
  List<String> _wordList = [
    "book",
    "word",
    "door",
    "window",
    "water",
    "bread",
    "floor",
    "carpet",
    "speak"
  ];

  List<List<String>> _packageWordList = [
    "ABCDEF".split(''),
    "GHIJKL".split(''),
    "MNOPQRS".split(''),
    "TUVWXYZ".split(''),
    ["food", "bread", "water", "drink"],
    ["white", "blue", "red", "green", "yellow"],
  ];

  Future<String> getWord(int packageId, int index) async {
    // Read from DB or make network request etc...
    return Future.delayed(
      Duration(milliseconds: 2),
      () => _packageWordList[packageId][index],
    );
  }

  getWordCount() {
    return _wordList.length;
  }

  List<PackageModel> getPackageModelList() {
    return [
      PackageModel(0, "Alphabet1", "from A to F", _packageWordList[0].length),
      PackageModel(1, "Alphabet2", "from G to L", _packageWordList[1].length),
      PackageModel(2, "Alphabet3", "from M to S", _packageWordList[2].length),
      PackageModel(3, "Alphabet4", "from T to Z", _packageWordList[3].length),
      PackageModel(4, "Food", "food and drink", _packageWordList[4].length),
      PackageModel(5, "Color", "different colors", _packageWordList[5].length),
    ];
  }

  // Future<bool> addNote(NoteModel noteModel) async {
  //   _noteList.add(noteModel);
  //   return Future.value(true);
  // }
}
