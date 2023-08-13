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

  List<String> filterMonth = ['All Records'];

  List<Map<String, dynamic>> members = [];

  TextEditingController userController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });

    MyRecord.receiptMonth = 'All Records';

    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(2023, 4);

    while (startDate.isBefore(currentDate)) {
      String formattedDate = DateFormat.yMMM().format(startDate);
      filterMonth.insert(1, formattedDate);
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
          'Default Months': [],
        });
      });
    }).then((value) {
      url =
          'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/paidMembers.json';

      http.get(Uri.parse(url)).then((response) {
        String nonDefaultMembers =
            json.decode(response.body)['Non Default List'];
        for (var i = 0; i < members.length; i++) {
          bool memberFound = false;
          for (var j = 1; j < filterMonth.length; j++) {
            if (!nonDefaultMembers.contains(
                '(${filterMonth[j]}${members[i]['Street']}${members[i]['House No'].replaceAll(' ', '')})')) {
              members[i]['Default Months'].add(filterMonth[j]);
              if (!memberFound) {
                membersFoundIndex++;
                memberFound = true;
              }
            }
          }
        }
        setState(() {
          loading = false;
        });
      });
    });
  }

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
        : (loading)
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
                        list: filterMonth,
                        prefixIcon: CupertinoIcons.calendar_today),
                    const SizedBox(height: 25),
                    MyTextField(
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
                    ),
                    (membersFoundIndex == 0)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2),
                              Icon(
                                CupertinoIcons.doc_text_search,
                                color: Style.themeFade,
                                size: 100,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'No record found',
                                style: TextStyle(
                                    color: Style.themeFade, fontSize: 25),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const SizedBox(height: 50),
                              const SizedBox(height: 10),
                              ...members.map((member) {
                                return (member['Default Months']
                                            .contains(MyRecord.receiptMonth) ||
                                        member['Full Name']
                                            .toLowerCase()
                                            .contains(userController.text
                                                .toLowerCase()))
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            height: ((member['Default Months']
                                                            .length -
                                                        1) *
                                                    38.0 +
                                                350),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Style.themeUltraLight,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Style.themeDark),
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
                                                      member['Full Name'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    Icon(
                                                        CupertinoIcons
                                                            .doc_text_viewfinder,
                                                        color: Style.themeDark),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      member['CNIC'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    Icon(
                                                        CupertinoIcons
                                                            .phone_fill,
                                                        color: Style.themeDark),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      member['Mobile'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
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
                                                      '${member['Street']} street',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
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
                                                      'House No. ${member['House No']}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
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
                                                      member['House Area'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
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
                                                      member['House Property'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Style.themeDark),
                                                    ),
                                                  ],
                                                ),
                                                ...member['Default Months']
                                                    .map((month) {
                                                  return (month !=
                                                          'All Records')
                                                      ? Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '$month',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Style
                                                                      .themeDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox();
                                                })
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              }),
                            ],
                          )
                  ],
                ),
              );
  }
}
