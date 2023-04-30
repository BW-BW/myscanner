import 'package:flutter/material.dart';
import 'package:myscanner/register.dart';
import 'package:myscanner/userpages/usermain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hdjtokqgbkxfbgvvrbvw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhkanRva3FnYmt4ZmJndnZyYnZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI4Mzk5OTIsImV4cCI6MTk5ODQxNTk5Mn0.J5zMy7DRe4CmRd5p31iOcxITF_3TEcmMT3qdAPhavwY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //'/': (context) => MyLogin(),
        '/user': (context) => const MyHomePage(),
        '/register': (context) => const MyRegister()
      },
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyLogin(),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});
  @override
  MyLoginState createState() => MyLoginState();
}

class MyLoginState extends State<MyLogin> {
  String _email = "";
  String _password = "";

  void register() async {
    await Supabase.instance.client
        .from('userCreds')
        .insert({'username': _email, 'password': _password});
  }

  void login() async {
    final data = await Supabase.instance.client
        .from('userCreds')
        .select('username, password')
        .eq('username', _email)
        .eq('password', _password);

    if (data.isEmpty) {
      print('data not found');
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil("/register", (route) => false);
    } else {
      print(data);
      //throw a new screen here
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil("/user", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login'),
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
              onPressed: login,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyRegister()),
                );
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
