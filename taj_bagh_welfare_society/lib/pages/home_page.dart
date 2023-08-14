import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/pages/complaints_page.dart';
import 'package:taj_bagh_welfare_society/pages/search_member.dart';
import 'package:taj_bagh_welfare_society/pages/my_records_page.dart';
import 'package:taj_bagh_welfare_society/pages/notifications_page.dart';
import 'package:taj_bagh_welfare_society/pages/profile_dart.dart';
import 'package:taj_bagh_welfare_society/pages/default_member.dart';

import '../components/functions.dart';
import '../providers/user_provider.dart';
import '../style.dart';
import 'complain_submit.dart';

class Home extends StatefulWidget {
  static String routeName = '/home';

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool initialNotificationLoad = false;
  bool initialReceiptsLoad = false;
  bool initialComplaintsLoad = false;

  int pageIndex = 0;

  List<Widget> pages = [
    MyRecord(),
    const Notifications(),
    SearchMember(),
    ComplainSubmit(),
    const Complaints(),
    DefaultMember(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    if (!initialReceiptsLoad) {
      Provider.of<UserProvider>(context, listen: false).clearReceipts();
      Provider.of<UserProvider>(context, listen: false).loadReceipts();
      initialReceiptsLoad = true;
    }
    if (!initialNotificationLoad) {
      Provider.of<UserProvider>(context, listen: false).clearNotifications();
      Provider.of<UserProvider>(context, listen: false).loadNotifications();
      initialNotificationLoad = true;
    }
    if (!initialComplaintsLoad) {
      Provider.of<UserProvider>(context, listen: false).clearComplaints();
      Provider.of<UserProvider>(context, listen: false).loadComplaints();
      initialComplaintsLoad = true;
    }
    return SafeArea(
      child: Scaffold(
        floatingActionButton: (provider.connected &&
                provider.userDetails!.isAdmin &&
                pageIndex == 1)
            ? FloatingActionButton(
                onPressed: () {
                  Functions.sendNotification(context);
                },
                backgroundColor: Style.themeLight,
                child: Icon(
                  Icons.post_add,
                  color: Style.themeDark,
                ),
              )
            : null,
        backgroundColor: Style.themeDark,
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            color: Style.themeDark,
            child: GNav(
              gap: 5,
              padding: const EdgeInsets.all(15),
              backgroundColor: Style.themeDark,
              color: Style.themeLight,
              activeColor: Style.themeDark,
              tabBackgroundColor: Style.themeLight,
              onTabChange: (i) {
                setState(() {
                  pageIndex = i;
                });
              },
              tabs: [
                const GButton(
                  icon: Icons.receipt_long,
                  text: 'My Records',
                ),
                const GButton(
                  icon: Icons.notifications_active_outlined,
                  text: 'Notifications',
                ),
                if (provider.userDetails!.isAdmin)
                  const GButton(
                    icon: Icons.confirmation_num_outlined,
                    text: 'Collect Fund',
                  ),
                const GButton(
                  icon: Icons.edit_document,
                  text: 'Write Complaint',
                ),
                if (provider.userDetails!.isAdmin)
                  const GButton(
                    icon: Icons.comment_sharp,
                    text: 'Complaint',
                  ),
                if (provider.userDetails!.isAdmin)
                  const GButton(
                    icon: Icons.disabled_by_default_rounded,
                    text: 'Default Members',
                  ),
                const GButton(
                  icon: Icons.face_outlined,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
        body: pages[pageIndex],
      ),
    );
  }
}
