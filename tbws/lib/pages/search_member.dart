import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/my_button.dart';
import 'package:tbws/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:tbws/style.dart';

import '../components/my_textfield.dart';
import 'collect_fund.dart';

class SearchMember extends StatefulWidget {
  SearchMember({super.key});

  @override
  State<SearchMember> createState() => _SearchMemberState();
}

class _SearchMemberState extends State<SearchMember> {
  TextEditingController userController = TextEditingController();

  bool memberFound = false;
  bool searchLoading = false;
  int membersFoundIndex = 0;
  List<List<String>> members = [];
  String errMessage = '';
  String cnic = '',
      name = '',
      mobile = '',
      street = '',
      houseNo = '',
      houseArea = '',
      houseProperty = '';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 100),
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
                    const SizedBox(height: 30),
                    (searchLoading)
                        ? CircularProgressIndicator(
                            color: Style.themeLight,
                          )
                        : MyButton(
                            btnText: 'Search Member',
                            onTap: () async {
                              setState(() {
                                errMessage = '';
                                memberFound = false;
                                searchLoading = true;
                                membersFoundIndex = 0;
                                members.clear();
                              });
                              var url =
                                  'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/user_registration.json';

                              http.get(Uri.parse(url)).then((response) {
                                final extractedData = json.decode(response.body)
                                    as Map<String, dynamic>;
                                String memberMatch = '';
                                extractedData.forEach((fireBaseId, userData) {
                                  memberMatch = userData['CNIC'] +
                                      userData['Full Name'].toLowerCase() +
                                      userData['Mobile'] +
                                      userData['Street'].toLowerCase() +
                                      userData['House Property'].toLowerCase();
                                  if (memberMatch.contains(
                                      userController.text.toLowerCase())) {
                                    members.add([
                                      userData['CNIC'],
                                      userData['Full Name'],
                                      userData['Mobile'],
                                      userData['Street'],
                                      userData['House Area'],
                                      userData['House Property'],
                                      userData['House No']
                                    ]);
                                    setState(() {
                                      memberFound = true;
                                      membersFoundIndex++;
                                    });
                                  }
                                  memberMatch = '';
                                });
                              }).then((value) {
                                userController.clear();
                                setState(() {
                                  searchLoading = false;
                                  if (!memberFound) {
                                    errMessage = 'No record found!';
                                  }
                                });
                              });
                            },
                            backgroudColor: Style.themeLight,
                            foregroudColor: Colors.black,
                          ),
                  ],
                ),
                (memberFound)
                    ? Column(
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
                          ...members.map((member) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, CollectFund.routeName,
                                      arguments: member);
                                },
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
                                          Icon(
                                              CupertinoIcons
                                                  .doc_text_viewfinder,
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
                          }),
                        ],
                      )
                    : (errMessage.isNotEmpty)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.15),
                              Icon(
                                CupertinoIcons.doc_text_search,
                                color: Style.themeFade,
                                size: 100,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                errMessage,
                                style: TextStyle(
                                    color: Style.themeFade, fontSize: 25),
                              ),
                            ],
                          )
                        : const SizedBox(height: 0),
              ],
            ),
          );
  }
}
