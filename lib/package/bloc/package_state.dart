part of "package_bloc.dart";

abstract class PackageState extends Equatable {
  final List<PackageModel> packageModelList;

  const PackageState({required this.packageModelList});

  @override
  List<Object> get props => [packageModelList];

   @override
  String toString() => '(list: $packageModelList)';
}

class PackageStateInitial extends PackageState {
  PackageStateInitial({required packageModelList}) : super(packageModelList: packageModelList);

  @override
  String toString() =>
      "PackageStateInitial" + super.toString();
}

class PackageStateLoading extends PackageState {
  PackageStateLoading(List<PackageModel> packageModelList)
      : super(packageModelList: packageModelList);
       @override
  String toString() => "PackageStateLoading" + super.toString();

}

class PackageStateListReady extends PackageState {
  PackageStateListReady(List<PackageModel> packageModelList)
      : super(packageModelList: packageModelList);
       @override
  String toString() => "PackageStateListReady" + super.toString();
}
