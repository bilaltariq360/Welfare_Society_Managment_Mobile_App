import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/notification_card.dart';
import '../providers/user_provider.dart';
import '../style.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return (provider.loading)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Style.themeLight),
                const SizedBox(height: 25),
                const Text(
                  'Loading...',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          )
        : Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Icons.receipt_long,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'My Records',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.clearNotifications();
                            provider.loadNotifications();
                          },
                          icon: const Icon(CupertinoIcons.refresh),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
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
