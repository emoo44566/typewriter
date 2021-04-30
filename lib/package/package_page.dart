import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import "package:collection/collection.dart";

import 'package.dart';

class PackagePage extends StatelessWidget {
  final OnPackageTap onPackageTap;

  const PackagePage({Key? key, required this.onPackageTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Background(),
      Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        child: Center(
            child: Column(children: [
          Expanded(
              child: PackageList(
            onPackageTap: onPackageTap,
          ))
        ])),
      ),

      // AppBarOnStack(
      //     title: "Package",
      //     onTap: () => AddPackageBottomSheet.showModalBottomSheetM(context),
      //     )
    ]);
  }
}

class PackageList extends StatelessWidget {
  final OnPackageTap onPackageTap;

  const PackageList({Key? key, required this.onPackageTap}) : super(key: key);

  List<Widget> _getAllPackageItems(BuildContext context) {
    var list = context
        .watch<PackageBloc>()
        .state
        .packageModelList; //.sortedBy((element) => element.id);
    // var groups = groupBy(list, (PackageModel obj) => obj.date.toYearMonthString());
    // print("---- " + groups.toString());

    // return groups.keys.map<Widget>((key) {
    //   print(key);
    //   print(groups[key]);
    //   return PackageItemGroup(
    //       title: key, packageModelList: groups[key]!, onTap: () {});
    // }).toList();
    //

    return list
        .map<Widget>((e) => PackageItem(packageModel: e, onTap: onPackageTap))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 36, left: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getAllPackageItems(context),
        ),
      ),
    );
  }
}
