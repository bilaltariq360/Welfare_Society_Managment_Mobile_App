import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/components/functions.dart';
import 'package:taj_bagh_welfare_society/providers/user_provider.dart';
import 'package:taj_bagh_welfare_society/style.dart';

class NotificationCard extends StatelessWidget {
  String name;
  DateTime dateTime;
  String message;
  NotificationCard(
      {required this.name,
      required this.dateTime,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    bool isDeveloper = name == 'Developer' || name == 'Bilal Tariq';
    return Card(
      color: (isDeveloper) ? Colors.orange.shade200 : Style.themeUltraLight,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onLongPress: () {
          if (isDeveloper &&
              Provider.of<UserProvider>(context, listen: false)
                      .userDetails!
                      .userCNIC !=
                  '3520198927537') return;
          Functions.showAlertBox(context, dateTime);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          (isDeveloper)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CircleAvatar(
                                    radius: 18,
                                    child: Image.network(
                                        'https://avatars.githubusercontent.com/u/67186564?v=4'),
                                  ),
                                )
                              : const Icon(Icons.insert_link_rounded,
                                  color: Colors.black),
                          (isDeveloper)
                              ? const SizedBox(width: 10)
                              : const SizedBox(width: 5),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMEd().format(dateTime),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            DateFormat.jm().format(dateTime),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    message,
                    style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.2,
                        wordSpacing: 1.2,
                        height: 1.3,
                        color: Colors.black87),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
