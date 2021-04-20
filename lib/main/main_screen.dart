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
          IndexedStack(
              index: context.watch<MainBloc>().state.selectedT,
              children: [
                TypePage(),
              ]),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: BottomNavyBar(
              // backgroundColor: Color.fromRGBO(100, 10, 100, .8),
              selectedIndex: context.watch<MainBloc>().state.selectedT,
              showElevation: true, // use this to remove appBar's elevation
              onItemSelected: (index) => {
                context
                    .read<MainBloc>()
                    .add(MainSelectTClicked(seletedT: index))
              },
              items: [
                BottomNavyBarItem(
                  icon: Icon(CupertinoIcons.calendar_today),
                  title: Text('Calendar',
                      style: Theme.of(context).textTheme.headline6),
                  activeColor: Color.fromRGBO(10, 10, 10, 1),
                  inactiveColor: Color.fromRGBO(10, 10, 10, .4),
                ),
                BottomNavyBarItem(
                  icon: Icon(CupertinoIcons.paperplane),
                  title: Text('Note',
                      style: Theme.of(context).textTheme.headline6),
                  activeColor: Color.fromRGBO(10, 10, 10, 1),
                  inactiveColor: Color.fromRGBO(10, 10, 10, .4),
                ),
                BottomNavyBarItem(
                  icon: Icon(CupertinoIcons.alarm),
                  title: Text('Alarm',
                      style: Theme.of(context).textTheme.headline6),
                  activeColor: Color.fromRGBO(10, 10, 10, 1),
                  inactiveColor: Color.fromRGBO(10, 10, 10, .4),
                ),
                BottomNavyBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  title: Text('Settings',
                      style: Theme.of(context).textTheme.headline6),
                  activeColor: Color.fromRGBO(10, 10, 10, 1),
                  inactiveColor: Color.fromRGBO(10, 10, 10, .4),
                ),
                 BottomNavyBarItem(
                  icon: Icon(CupertinoIcons.keyboard),
                  title: Text('Type',
                      style: Theme.of(context).textTheme.headline6),
                  activeColor: Color.fromRGBO(10, 10, 10, 1),
                  inactiveColor: Color.fromRGBO(10, 10, 10, .4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
