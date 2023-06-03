import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyPage1 extends StatefulWidget {
  const MyPage1({super.key});
  @override
  MyPage1State createState() => MyPage1State();
}

class MyPage1State extends State<MyPage1> {
  String _scanBarcode = 'Unknown';
  String _email = "";
  String _password = "";

  void register() async {
    await Supabase.instance.client
        .from('userCreds')
        .insert({'username': _email, 'password': _password});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Register'),
            TextFormField(
              onChanged: (value) {
                _email = value;
              },
            ),
            TextFormField(
              onChanged: (value) {
                _password = value;
              },
            ),
            ElevatedButton(
              onPressed: register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
