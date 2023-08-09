import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../style.dart';

class Functions extends StatelessWidget {
  const Functions({super.key});

  static sendNotification(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Style.themeLight,
          title: const Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 350,
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: controller,
                    maxLength: 500,
                    decoration: InputDecoration(
                      counterText: '',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Write Message',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    maxLines: 20,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.close, color: Style.themeDark),
                      const SizedBox(width: 3),
                      Text('Cancel', style: TextStyle(color: Style.themeDark)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.send, color: Style.themeDark),
                      const SizedBox(width: 3),
                      Text('Send', style: TextStyle(color: Style.themeDark)),
                    ],
                  ),
                  onPressed: () {
                    if (Provider.of<UserProvider>(context, listen: false)
                        .connected) {
                      var url =
                          'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/notifications.json';
                      http
                          .post(Uri.parse(url),
                              body: json.encode({
                                'Sender': Provider.of<UserProvider>(context,
                                        listen: false)
                                    .userDetails!
                                    .userName,
                                'Date': DateTime.now().toString(),
                                'Message': controller.text,
                              }))
                          .then((value) {
                        Navigator.of(context).pop();
                        Provider.of<UserProvider>(context, listen: false)
                            .clearNotifications();
                        Provider.of<UserProvider>(context, listen: false)
                            .loadNotifications();
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
