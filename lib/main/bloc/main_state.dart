part of "main_bloc.dart";

class MainState extends Equatable {
  final int selectedT;
  
  const MainState(
      {required this.selectedT});

  @override
  List<Object> get props => [selectedT];

  @override
  String toString() => '{ I: $selectedT }';

}
