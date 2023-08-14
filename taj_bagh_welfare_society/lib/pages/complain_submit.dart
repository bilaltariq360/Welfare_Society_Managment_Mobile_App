import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/components/dropdown.dart';
import 'package:taj_bagh_welfare_society/components/my_button.dart';
import 'package:taj_bagh_welfare_society/components/my_textfield.dart';
import 'package:taj_bagh_welfare_society/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../style.dart';

class ComplainSubmit extends StatefulWidget {
  ComplainSubmit({super.key});

  static String complaintDept = '';

  @override
  State<ComplainSubmit> createState() => _ComplainSubmitState();
}

class _ComplainSubmitState extends State<ComplainSubmit> {
  TextEditingController compController = TextEditingController();

  List<String> dept = ['Security', 'Garbage', 'Street Light'];

  bool sendProgress = false;

  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    provider.checkConnection();
    return (!provider.connected)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.wifi_slash,
                  color: Style.themeFade,
                  size: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  'No internet connection!',
                  style: TextStyle(
                      color: Style.themeFade,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
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
                            'Submit Complaint',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 15),
                  child: Text(
                    'Deparment',
                    style: TextStyle(
                      color: Style.themeUltraLight,
                      fontSize: 20,
                    ),
                  ),
                ),
                MyDropdown(
                    hintText: 'Select Department',
                    list: dept,
                    prefixIcon: Icons.dehaze_rounded),
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 15, top: 30),
                  child: Text(
                    'Complaint / Suggesstion',
                    style: TextStyle(
                      color: Style.themeUltraLight,
                      fontSize: 20,
                    ),
                  ),
                ),
                MyTextField(
                  controller: compController,
                  hintText: 'Write Complaint / Suggesstion',
                  obscureText: false,
                  maxLength: 500,
                  exactLength: 500,
                  minLength: 500,
                  textInputType: TextInputType.text,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  check: false,
                  prefixIcon: Icons.message,
                  hideCheckMark: true,
                  multiline: 10,
                ),
                const SizedBox(height: 50),
                (sendProgress)
                    ? Center(
                        child:
                            CircularProgressIndicator(color: Style.themeLight),
                      )
                    : (errMsg.isNotEmpty)
                        ? Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red.shade900),
                                child: Text(
                                  errMsg,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          )
                        : const SizedBox(),
                (!sendProgress)
                    ? MyButton(
                        btnText: 'Submit',
                        onTap: () {
                          setState(() {
                            errMsg = '';
                          });
                          if (ComplainSubmit.complaintDept.isEmpty) {
                            setState(() {
                              errMsg = 'Select complaint department!';
                            });
                            return;
                          } else if (compController.text.isEmpty) {
                            setState(() {
                              errMsg = 'Complaint / Suggestion feild is empty!';
                            });
                            return;
                          }
                          setState(() {
                            sendProgress = true;
                          });
                          var url =
                              'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/complaints.json';
                          http
                              .post(Uri.parse(url),
                                  body: json.encode({
                                    'CNIC': provider.userDetails!.userCNIC,
                                    'Full Name': provider.userDetails!.userName,
                                    'Mobile': provider.userDetails!.userMobile,
                                    'Street': provider.userDetails!.userStreet,
                                    'House No':
                                        provider.userDetails!.userHouseNo,
                                    'House Area':
                                        provider.userDetails!.houseArea,
                                    'House Property':
                                        provider.userDetails!.userHouseProperty,
                                    'Complaint': compController.text,
                                    'Complaint Department':
                                        ComplainSubmit.complaintDept,
                                    'Date': DateTime.now().toString(),
                                  }))
                              .then((value) {
                            setState(() {
                              compController.clear();
                              ComplainSubmit.complaintDept = '';
                              errMsg = '';
                              sendProgress = false;
                            });
                            provider.clearComplaints();
                            provider.loadComplaints();
                          });
                        },
                        icon: Icons.send,
                        foregroudColor: Style.themeDark,
                        backgroudColor: Style.themeLight,
                      )
                    : const SizedBox(),
                const SizedBox(height: 50),
              ],
            ),
          );
  }
}
