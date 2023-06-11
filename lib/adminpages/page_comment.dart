import 'package:flutter/material.dart';

class PageComment extends StatefulWidget {
  const PageComment({super.key});

  @override
  PageCommentState createState() => PageCommentState();
}

class PageCommentState extends State<PageComment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Scan'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start Barcode scan'),
            ),
            Text(
              'Scan result: ',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
