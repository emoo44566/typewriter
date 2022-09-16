import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:typewriter/package/model/package_model.dart';

import '../package.dart';

typedef void OnPackageTap(PackageModel model);

class PackageItem extends StatelessWidget {
  final PackageModel packageModel;
  final OnPackageTap onTap;

  const PackageItem({Key? key, required this.packageModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(packageModel),
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, .3),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color.fromRGBO(24, 24, 24, 1)),
        ),
        child: SizedBox(
          height: 96,
          width: 280,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(24, 24, 24,
                            1), // packageModel.colorModel.getColor(),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6))),
                    child: SizedBox(
                      width: 32,
                      height: 96,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                packageModel.id.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: Colors.white70),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            packageModel.title,
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            packageModel.description,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            packageModel.wordCount.toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
