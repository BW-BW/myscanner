import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.5),
      body: Center(
          child: Image.asset(
        "assets/loading.gif",
        height: 220.0,
        width: 220.0,
      )),
    );
  }
}
