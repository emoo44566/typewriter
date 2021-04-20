import 'package:flutter/material.dart';
import 'package:typewriter/main/views/app_bar_stack.dart';

import 'views/views.dart';

class TypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Background(),
          SizedBox.expand(
            child: Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
                child: MTypeWriter(width: 500)),
          ),
          AppBarOnStack(title: "Type"),
        ],
      ),
    );
  }
}
