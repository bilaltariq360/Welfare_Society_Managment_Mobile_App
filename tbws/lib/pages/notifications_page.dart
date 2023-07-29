import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/notification_card.dart';
import '../providers/user_provider.dart';

class Noti {
  final DateTime date;
  final String sender;
  final String message;

  Noti({required this.date, required this.message, required this.sender});
}

class Notifications extends StatelessWidget {
  Notifications({super.key});

  List<Noti> notifications = [];

  void loadNotifications() {
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/notifications.json';

    http.get(Uri.parse(url)).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, noti) {
        notifications.add(Noti(
            sender: noti['Sender'],
            date: DateTime.now(),
            message: noti['Message']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadNotifications();
    var provider =
        Provider.of<UserProvider>(context, listen: false).getUserDetails!;
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
          child: ListView(children: [
            ...notifications.map((notification) {
              return NotificationCard(
                  name: notification.sender,
                  dateTime: notification.date,
                  message: notification.message);
            }),
          ]),
        ),
      ],
    );
  }
}
