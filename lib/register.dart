import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});
  @override
  MyRegisterState createState() => MyRegisterState();
}

class MyRegisterState extends State<MyRegister> {
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
      appBar: AppBar(title: const Text('Page 1')),
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
