import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tbws/pages/my_records_page.dart';
import 'package:tbws/pages/notifications_page.dart';
import 'package:tbws/pages/profile_dart.dart';

class Home extends StatefulWidget {
  static String routeName = '/home';

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  List<Widget> pages = [
    const MyRecord(),
    const Notifications(),
    Profile(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          color: const Color.fromRGBO(10, 10, 10, 1),
          child: GNav(
            gap: 5,
            padding: const EdgeInsets.all(15),
            backgroundColor: const Color.fromARGB(255, 10, 10, 10),
            color: Colors.white,
            activeColor: const Color.fromARGB(255, 10, 10, 10),
            tabBackgroundColor: const Color.fromARGB(255, 194, 255, 175),
            onTabChange: (i) {
              setState(() {
                pageIndex = i;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.receipt_long,
                text: 'My Records',
              ),
              GButton(
                icon: Icons.notifications_active_outlined,
                text: 'Notifications',
              ),
              GButton(
                icon: Icons.feedback_outlined,
                text: 'Complaints',
              ),
              GButton(
                icon: Icons.face_outlined,
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: pages[pageIndex],
      ),
    );
  }
}
