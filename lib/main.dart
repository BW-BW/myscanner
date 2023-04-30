import 'package:flutter/material.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//void main() => runApp(const MyApp());

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
      title: 'Flutter Scaffold Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> pageszz = <Widget>[
    const MyPage1(),
    const MyPage2(),
    const MyPage3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageszz[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Scan Barcode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Count',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
