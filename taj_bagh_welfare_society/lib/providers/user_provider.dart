import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/user.dart';

class Compl {
  final String name;
  final DateTime dateTime;
  final String complaint;
  final String cnic;
  final String dept;
  final String houseArea;
  final String houseNo;
  final String houseProperty;
  final String mobile;
  final String street;

  Compl(
      {required this.name,
      required this.dateTime,
      required this.complaint,
      required this.cnic,
      required this.dept,
      required this.houseArea,
      required this.houseNo,
      required this.houseProperty,
      required this.mobile,
      required this.street});
}

class Noti {
  final DateTime date;
  final String sender;
  final String message;

  Noti({required this.date, required this.message, required this.sender});
}

class ReceiptData {
  final String receiptNumber;
  final String collector;
  final DateTime date;
  final String amount;

  ReceiptData(
      {required this.collector,
      required this.amount,
      required this.date,
      required this.receiptNumber});
}

class UserProvider extends ChangeNotifier {
  User? userDetails;
  List<Noti> notifications = [];
  List<ReceiptData> receiptData = [];
  List<Compl> complaints = [];
  bool notiLoading = false;
  bool receiptLoading = false;
  bool complLoading = false;

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
    notiLoading = true;
    notifyListeners();
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/notifications.json';

    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        notiLoading = false;
        notifyListeners();
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, noti) {
        notifications.insert(
            0,
            Noti(
                sender: noti['Sender'],
                date: DateTime.parse(noti['Date']),
                message: noti['Message']));
      });
      notiLoading = false;
      notifyListeners();
    });
  }

  void clearNotifications() {
    notifications.clear();
  }

  Future<void> loadReceipts() async {
    String receiptNumber = '-1';
    receiptLoading = true;
    notifyListeners();
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/${DateFormat.yMMM().format(DateTime.now()).replaceAll(' ', '')}/${userDetails!.userStreet}${userDetails!.userHouseNo.replaceAll(' ', '')}.json';
    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        receiptLoading = false;
        notifyListeners();
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, receipt) {
        receiptData.insert(
            0,
            ReceiptData(
                receiptNumber: receipt['Receipt Number'],
                collector: receipt['Collector'],
                amount: receipt['Amount'],
                date: DateTime.parse(receipt['Date'])));
      });
      receiptLoading = false;
      notifyListeners();
    });
  }

  void clearReceipts() {
    receiptData.clear();
  }

  bool connected = false;

  Future<void> checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.wifi &&
        connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.ethernet) {
      connected = false;
    } else {
      connected = true;
    }
    notifyListeners();
  }

  void loadComplaints() {
    complLoading = true;
    notifyListeners();
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/complaints.json';

    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        complLoading = false;
        notifyListeners();
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, compl) {
        complaints.insert(
            0,
            Compl(
                name: compl['Full Name'],
                dateTime: DateTime.parse(compl['Date']),
                complaint: compl['Complaint'],
                cnic: compl['CNIC'],
                dept: compl['Complaint Department'],
                houseArea: compl['House Area'],
                houseNo: compl['House No'],
                houseProperty: compl['House Property'],
                mobile: compl['Mobile'],
                street: compl['Street']));
      });
      complLoading = false;
      notifyListeners();
    });
  }

  void clearComplaints() {
    complaints.clear();
  }
}
