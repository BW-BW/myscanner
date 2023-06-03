import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PageFound extends StatefulWidget {
  //const PageFound({super.key});

  final VoidCallback onPagePopped;
  const PageFound({Key? key, required this.onPagePopped}) : super(key: key);

  @override
  PageFoundState createState() => PageFoundState();
}

class PageFoundState extends State<PageFound> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final modalRoute = ModalRoute.of(context);
      if (modalRoute != null) {
        modalRoute.addScopedWillPopCallback(() {
          widget.onPagePopped();
          return Future.value(
              true); // Return true to allow the page to be popped
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Page 2'),
            Text(
              'Scan result: corrext starbucks',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
