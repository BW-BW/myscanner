import 'package:flutter/material.dart';
import 'package:myscanner/global/global.dart';

class MyPage2 extends StatefulWidget {
  const MyPage2({super.key});
  @override
  MyPage2State createState() => MyPage2State();
}

class MyPage2State extends State<MyPage2> {
  int _counter = 0;
  final String _currentPassword = currentPasswordGlobal;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_currentPassword',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
