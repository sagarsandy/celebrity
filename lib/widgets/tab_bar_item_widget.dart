import 'package:flutter/material.dart';

class TabBarItemWidget extends StatelessWidget {
  final String title;

  TabBarItemWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
