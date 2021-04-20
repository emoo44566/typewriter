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
                decoration: BoxDecoration(
                  color: Colors.black,
                ),                
                child: MTypeWriter()),
          ),
          // AppBarOnStack(title: "Type"),
        ],
      ),
    );
  }
}
