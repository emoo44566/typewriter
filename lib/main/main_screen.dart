import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:typewriter/type/type_page.dart';

import 'bloc/main_bloc.dart';
import 'views/views.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          TypePage(),
          // IndexedStack(
          //     index: context.watch<MainBloc>().state.selectedT,
          //     children: [
          //       TypePage(),
          //     ]),
        ],
      ),
    );
  }
}
