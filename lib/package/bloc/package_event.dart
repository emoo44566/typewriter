part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class PackageEventNextClicked extends PackageEvent {
  const PackageEventNextClicked();

  @override
  List<Object> get props => [];

  String toString() => "PackageEventNextClicked";
}

// class PackageEventTypewriter extends PackageEvent {
//   const PackageEventTypewriter();

//   @override
//   List<Object> get props => [];

//   String toString() => "PackageEventTypewriter";
// }
