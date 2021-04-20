import 'package:flutter/material.dart';

class AppBarOnStack extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const AppBarOnStack({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0,
      left: 20.0,
      right: 20.0,
      child: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headline1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            tooltip: 'Search',
            onPressed: onTap,
          ),
        ],
        // Add AppBar here only
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}
