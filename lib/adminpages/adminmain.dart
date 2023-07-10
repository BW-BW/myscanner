import 'package:flutter/material.dart';
import 'package:myscanner/adminpages/page_comment.dart';
import 'package:myscanner/adminpages/page_database.dart';
import 'package:myscanner/adminpages/page_review.dart';
import 'package:myscanner/adminpages/page_user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  static List<Widget> pageszz = <Widget>[
    const PageDatabase(),
    const PageReview(),
    const PageUser(),
    const PageComment(),
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
              icon: Icon(Icons.data_object),
              label: 'Database',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              label: 'Reviews',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Users',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'Comments',
              backgroundColor: Color.fromARGB(255, 2, 1, 0)),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(159, 55, 224, 204),
        selectedItemColor: const Color(0xff3a57e8),
        onTap: _onItemTapped,
      ),
    );
  }
}
