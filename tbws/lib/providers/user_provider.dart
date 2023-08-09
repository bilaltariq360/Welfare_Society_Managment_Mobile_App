import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class Noti {
  final DateTime date;
  final String sender;
  final String message;

  Noti({required this.date, required this.message, required this.sender});
}

class ReceiptData {
  final String collector;
  final DateTime date;
  final String amount;

  ReceiptData(
      {required this.collector, required this.amount, required this.date});
}

class UserProvider extends ChangeNotifier {
  User? userDetails;
  List<Noti> notifications = [];
  List<ReceiptData> receiptData = [];

  void setUserDetail(
      String userCNIC,
      String userName,
      String userMobile,
      String userStreet,
      String houseArea,
      String userHouseProperty,
      String userHouseNo,
      String password,
      bool isAdmin) {
    userDetails = User(
        userCNIC: userCNIC,
        userName: userName,
        userMobile: userMobile,
        userStreet: userStreet,
        houseArea: houseArea,
        userHouseProperty: userHouseProperty,
        userHouseNo: userHouseNo,
        password: password,
        isAdmin: isAdmin);
  }

  void loadNotifications() {
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/notifications.json';

    http.get(Uri.parse(url)).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, noti) {
        notifications.insert(
            0,
            Noti(
                sender: noti['Sender'],
                date: DateTime.parse(noti['Date']),
                message: noti['Message']));
      });
      notifyListeners();
    });
  }

  void clearNotifications() {
    notifications.clear();
  }

  void loadReceipts() {
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/${userDetails!.userMobile}.json';

    http.get(Uri.parse(url)).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, receipt) {
        receiptData.insert(
            0,
            ReceiptData(
                collector: receipt['Collector'],
                amount: receipt['Amount'],
                date: DateTime.parse(receipt['Date'])));
      });
      notifyListeners();
    });
  }

  void clearReceipts() {
    receiptData.clear();
  }
}
