import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../style.dart';

class Functions extends StatelessWidget {
  static bool deletingNoti = false;
  Functions({super.key});

  static sendNotification(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    bool sendProgress = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Style.themeDark,
            title: Text(
              'Message',
              style: TextStyle(color: Style.themeLight),
            ),
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Style.themeFade),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Style.themeFade),
                        ),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'Write Message',
                        hintStyle: TextStyle(color: Style.themeFade),
                      ),
                      style: TextStyle(color: Style.themeLight),
                      maxLines: 20,
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: (sendProgress)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (sendProgress)
                    Row(
                      children: [
                        CircularProgressIndicator(
                          color: Style.themeLight,
                        ),
                        const SizedBox(width: 15),
                        Text('Sending...',
                            style: TextStyle(color: Style.themeLight)),
                      ],
                    )
                  else if (!sendProgress)
                    TextButton(
                      child: Row(
                        children: [
                          Icon(Icons.close, color: Style.themeFade),
                          const SizedBox(width: 3),
                          Text('Cancel',
                              style: TextStyle(color: Style.themeFade)),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  if (!sendProgress)
                    TextButton(
                      child: Row(
                        children: [
                          Icon(Icons.send, color: Style.themeFade),
                          const SizedBox(width: 3),
                          Text('Send',
                              style: TextStyle(color: Style.themeFade)),
                        ],
                      ),
                      onPressed: () {
                        if (controller.text.isEmpty) return;
                        setState(() {
                          sendProgress = true;
                        });
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
                            setState(() {
                              sendProgress = true;
                            });
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
        });
      },
    );
  }

  static Future<void> showNotiDeleteAlertBox(
      BuildContext context, DateTime dateTime) async {
    bool deletingInProgress = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Style.themeDark,
              title: Row(
                children: [
                  Text(
                    'Warning',
                    style: TextStyle(color: Style.themeUltraLight),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    color: Colors.red[500],
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Delete this message for everyone?',
                      style: TextStyle(color: Style.themeUltraLight),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                if (deletingInProgress)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularProgressIndicator(
                        color: Style.themeLight,
                      ),
                      const SizedBox(width: 15),
                      Text('Deleting...',
                          style: TextStyle(color: Style.themeLight)),
                    ],
                  )
                else if (!deletingInProgress)
                  TextButton(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Style.themeLight),
                    ),
                    onPressed: () async {
                      setState(() {
                        deletingInProgress = true;
                      });

                      String deleteId = '';
                      var url =
                          'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/notifications.json';

                      http.get(Uri.parse(url)).then((response) {
                        final extractedData =
                            json.decode(response.body) as Map<String, dynamic>;
                        extractedData.forEach((fireBaseId, userData) {
                          if (userData['Date'] == dateTime.toString()) {
                            deleteId = fireBaseId;
                          }
                        });
                      }).then((value) {
                        Provider.of<UserProvider>(context, listen: false)
                            .notifications
                            .removeWhere((element) => element.date == dateTime);
                        url =
                            'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/notifications/$deleteId.json';
                        http.delete(Uri.parse(url));
                        deletingNoti = false;
                        setState(() {
                          deletingInProgress = false;
                        });
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                if (!deletingInProgress)
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Style.themeLight),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<void> showComplDeleteAlertBox(
      BuildContext context, DateTime dateTime) async {
    bool deletingInProgress = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Style.themeDark,
              title: Row(
                children: [
                  Text(
                    'Warning',
                    style: TextStyle(color: Style.themeUltraLight),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    color: Colors.red[500],
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Delete this complaint?',
                      style: TextStyle(color: Style.themeUltraLight),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                if (deletingInProgress)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularProgressIndicator(
                        color: Style.themeLight,
                      ),
                      const SizedBox(width: 15),
                      Text('Deleting...',
                          style: TextStyle(color: Style.themeLight)),
                    ],
                  )
                else if (!deletingInProgress)
                  TextButton(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Style.themeLight),
                    ),
                    onPressed: () async {
                      setState(() {
                        deletingInProgress = true;
                      });

                      String deleteId = '';
                      var url =
                          'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/complaints.json';

                      http.get(Uri.parse(url)).then((response) {
                        final extractedData =
                            json.decode(response.body) as Map<String, dynamic>;
                        extractedData.forEach((fireBaseId, userData) {
                          if (userData['Date'] == dateTime.toString()) {
                            deleteId = fireBaseId;
                          }
                        });
                      }).then((value) {
                        Provider.of<UserProvider>(context, listen: false)
                            .complaints
                            .removeWhere(
                                (element) => element.dateTime == dateTime);
                        url =
                            'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/complaints/$deleteId.json';
                        http.delete(Uri.parse(url));
                        deletingNoti = false;
                        setState(() {
                          deletingInProgress = false;
                        });
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                if (!deletingInProgress)
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Style.themeLight),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
