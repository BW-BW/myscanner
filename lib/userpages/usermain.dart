import 'package:flutter/material.dart';
import 'page_account.dart';
import 'page_search.dart';
import 'page_history.dart';
import 'page_scan.dart';

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
    const MyPage4(),
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
              icon: Icon(Icons.youtube_searched_for),
              label: 'Search',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew),
              label: 'History',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.wifi_tethering),
              label: 'Scan',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'MyAccount',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(255, 2, 125, 31),
        selectedItemColor: const Color.fromARGB(255, 189, 166, 15),
        onTap: _onItemTapped,
      ),
    );
  }
}
