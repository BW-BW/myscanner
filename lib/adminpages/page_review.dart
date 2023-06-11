import 'package:flutter/material.dart';

class PageReview extends StatefulWidget {
  const PageReview({super.key});

  @override
  PageReviewState createState() => PageReviewState();
}

class PageReviewState extends State<PageReview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
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
