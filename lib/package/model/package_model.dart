import 'package:equatable/equatable.dart';

class PackageModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final int wordCount;

  PackageModel(this.id, this.title, this.description, this.wordCount);

  @override
  String toString() {
    return "($id, $title, $description, $wordCount)";
  }

  @override
  List<Object> get props => [id, title, description, wordCount];
}
