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

  static var alphabetName =
      "اِی بی سی دی ای اِف جی اِچ آی جِی کِی اِل اِم اِن اُ پی کیو آر اِس تی یو وی دَبِلیو ایکس وای زِد"
          .split(' ');
  static var alphabetStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
  static var list = new List<int>.generate(26, (i) => i);
  static Map<String, String> alphabetUC = {
    // for (var item in alphabetStr.split('')) '$item': 'حرف 10 الفبا شکل بزرگ '
    for (var i in list) '${alphabetStr[i]}': '${alphabetName[i]}'
  };

  static Map<String, String> alphabetLC = {
    for (var i in list) '${alphabetStr[i].toLowerCase()}': '${alphabetName[i]}'
  };

  static Map<String, String> food1 = {
    'food': 'غذا',
    'bread': 'نان',
    'butter': 'کره',
    'cheese': 'پنیر',
    'knife': 'چاقو',
    'spoon': 'قاشق',
  };

  List<Map<String, String>> _packageWordList = [
    alphabetUC,
    alphabetLC,
    food1,
    // ["white", "blue", "red", "green", "yellow"],
  ];

  Future<MapEntry<String, String>> getWord(int packageId, int index) async {
    // Read from DB or make network request etc...
    return Future.delayed(
      Duration(milliseconds: 2),
      () => _packageWordList[packageId].entries.elementAt(index),
    );
  }

  getWordCount() {
    return _wordList.length;
  }

  List<PackageModel> getPackageModelList() {
    return [
      PackageModel(0, "Alphabet UpperCase", "حروف الفبا شکل بزرگ",
          _packageWordList[0].length),
      PackageModel(1, "Alphabet LowerCase", "حروف الفبا شکل کوچک",
          _packageWordList[1].length),
      PackageModel(2, "Food", "غذا", _packageWordList[2].length),
      // PackageModel(3, "Color", "different colors", _packageWordList[3].length),
    ];
  }

  // Future<bool> addNote(NoteModel noteModel) async {
  //   _noteList.add(noteModel);
  //   return Future.value(true);
  // }
}
