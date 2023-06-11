import 'package:flutter/material.dart';

class PageUser extends StatefulWidget {
  const PageUser({super.key});

  @override
  PageUserState createState() => PageUserState();
}

class PageUserState extends State<PageUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User')),
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
