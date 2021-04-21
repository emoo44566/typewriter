class WordlistRepository {
  List<String> _wordList = ["book", "word", "door", "window", "water"];

  Future<String> getWord(int index) async {
    // Read from DB or make network request etc...
    return Future.delayed(
      Duration(milliseconds: 2),
      () => _wordList[index],
    );
  }

  getWordCount() {
    return _wordList.length;
  }

  // Future<bool> addNote(NoteModel noteModel) async {
  //   _noteList.add(noteModel);
  //   return Future.value(true);
  // }
}
