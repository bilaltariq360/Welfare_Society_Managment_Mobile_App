import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/components/dropdown.dart';
import 'package:taj_bagh_welfare_society/providers/user_provider.dart';
import 'package:taj_bagh_welfare_society/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/my_textfield.dart';
import 'my_records_page.dart';

class DefaultMember extends StatefulWidget {
  DefaultMember({super.key});

  @override
  State<DefaultMember> createState() => _DefaultMemberState();
}

class _DefaultMemberState extends State<DefaultMember> {
  int membersFoundIndex = 0;

  TextEditingController userController = TextEditingController();

  @override
  void initState() {
    super.initState();

    List<String> filterMonth = [];

    List<Map<String, dynamic>> members = [];

    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(2023, 1); // Starting from August 2023

    while (startDate.isBefore(currentDate)) {
      String formattedDate = DateFormat.yMMM().format(startDate);
      filterMonth.add(formattedDate);
      startDate = DateTime(startDate.year, startDate.month + 1);
    }

    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/user_registration.json';

    http.get(Uri.parse(url)).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, userData) {
        members.add({
          'CNIC': userData['CNIC'],
          'Full Name': userData['Full Name'],
          'Mobile': userData['Mobile'],
          'Street': userData['Street'],
          'House Area': userData['House Area'],
          'House Property': userData['House Property'],
          'House No': userData['House No'],
          'Default Months': filterMonth,
        });
      });
    }).then((value) async {
      for (var i = 0; i < members.length; i++) {
        for (var j = 0; j < filterMonth.length; j++) {
          var url =
              'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/${filterMonth[j]}/${members[i]['Street']}_${members[i]['House No']}.json';
          try {
            final response = await http.get(Uri.parse(url));
            final extractedData =
                json.decode(response.body) as Map<String, dynamic>;
            extractedData.forEach((fireBaseId, receipt) {
              print(receipt['Collector']);
            });
            print(response.statusCode);
            if (response.statusCode == 200) {
              print('Entered');
              print(url);
              members[i]['Default Months'].remove(filterMonth[j]);
            }
          } catch (e) {}
        }
        print(members[i]['Default Months']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    List<ReceiptData> receipts = [];
    if (MyRecord.receiptMonth == 'All Records') {
      receipts = provider.receiptData;
    } else {
      receipts = provider.receiptData
          .where((receipt) =>
              DateFormat.yMMM().format(receipt.date) == MyRecord.receiptMonth)
          .toList();
    }

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
        : (provider.loading)
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
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(
                              Icons.receipt_long,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Default Members',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MyDropdown(
                        hintText: 'All Records',
                        list: [],
                        prefixIcon: CupertinoIcons.calendar_today),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.79,
                          child: MyTextField(
                            controller: userController,
                            hintText: 'Search Member',
                            obscureText: false,
                            prefixIcon: CupertinoIcons.search,
                            textInputType: TextInputType.text,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-z 0-9 A-Z]')),
                            maxLength: 20,
                            minLength: 20,
                            exactLength: 20,
                            check: false,
                            hideCheckMark: false,
                            rowButton: true,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.068,
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Style.themeLight,
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: Style.themeDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          'Members found: $membersFoundIndex',
                          style: TextStyle(
                              color: Style.themeLight,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        /*...members[0].map((member) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                height: 350,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Style.themeUltraLight,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          'Member Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      children: [
                                        Icon(Icons.person,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          member[1],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.doc_text_viewfinder,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          member[0],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.phone_fill,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          member[2],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(Icons.add_road,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${member[3]} street',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.number,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          'House No. ${member[6]}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(
                                            CupertinoIcons
                                                .rectangle_arrow_up_right_arrow_down_left,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          member[4],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(CupertinoIcons.house,
                                            color: Style.themeDark),
                                        const SizedBox(width: 10),
                                        Text(
                                          member[5],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Style.themeDark),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),*/
                      ],
                    )
                  ],
                ),
              );
  }
}
