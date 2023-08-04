import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/notification_card.dart';
import '../providers/user_provider.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Column(
      children: [
        const SizedBox(height: 15),
        const Row(
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Notifications',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: Consumer(
            builder: (BuildContext context, value, Widget? child) =>
                ListView(children: [
              ...provider.notifications.map((notification) {
                return NotificationCard(
                    name: notification.sender,
                    dateTime: notification.date,
                    message: notification.message);
              }),
            ]),
          ),
        ),
      ],
    );
  }
}
