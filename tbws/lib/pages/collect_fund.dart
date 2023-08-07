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

class CollectFund extends StatefulWidget {
  CollectFund({super.key});

  @override
  State<CollectFund> createState() => _CollectFundState();
}

class _CollectFundState extends State<CollectFund> {
  TextEditingController userController = TextEditingController();
  bool memberFound = false;
  bool loading = false;
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
    var provider = Provider.of<UserProvider>(context).userDetails!;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
            ),
            MyTextField(
              controller: userController,
              hintText: 'Mobile',
              obscureText: false,
              prefixIcon: CupertinoIcons.phone_fill,
              textInputType: TextInputType.number,
              filteringTextInputFormatter:
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              maxLength: 11,
              minLength: 11,
              exactLength: 11,
              check: (userController.text.isNotEmpty &&
                      userController.text.length == 11)
                  ? true
                  : false,
              hideCheckMark: false,
            ),
            const SizedBox(height: 30),
            (loading)
                ? CircularProgressIndicator(
                    color: Style.themeLight,
                  )
                : MyButton(
                    btnText: 'Search Member',
                    onTap: () async {
                      setState(() {
                        errMessage = '';
                        memberFound = false;
                        loading = true;
                      });
                      var url =
                          'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/user_registration.json';

                      http.get(Uri.parse(url)).then((response) {
                        final extractedData =
                            json.decode(response.body) as Map<String, dynamic>;
                        extractedData.forEach((fireBaseId, userData) {
                          if (userData['Mobile'] == userController.text) {
                            cnic = userData['CNIC'];
                            name = userData['Full Name'];
                            mobile = userData['Mobile'];
                            street = userData['Street'];
                            houseArea = userData['House Area'];
                            houseProperty = userData['House Property'];
                            houseNo = userData['House No'];
                            setState(() {
                              memberFound = true;
                            });
                          }
                        });
                      }).then((value) {
                        setState(() {
                          loading = false;
                          if (!memberFound) {
                            errMessage = 'No record found!';
                          }
                        });
                      });
                    },
                    backgroudColor: Style.themeLight,
                    foregroudColor: Colors.black,
                    icon: Icons.search,
                  ),
            (memberFound)
                ? Column(
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    'Member Details',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(width: 10),
                                  Text(
                                    name,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(
                                      CupertinoIcons.doc_text_viewfinder),
                                  const SizedBox(width: 10),
                                  Text(
                                    cnic,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.phone_fill),
                                  const SizedBox(width: 10),
                                  Text(
                                    mobile,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(Icons.add_road),
                                  const SizedBox(width: 10),
                                  Text(
                                    '$street street',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.number),
                                  const SizedBox(width: 10),
                                  Text(
                                    'House No. $houseNo',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(CupertinoIcons
                                      .rectangle_arrow_up_right_arrow_down_left),
                                  const SizedBox(width: 10),
                                  Text(
                                    houseArea,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.house),
                                  const SizedBox(width: 10),
                                  Text(
                                    houseProperty,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : (errMessage.isNotEmpty)
                    ? Column(
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            errMessage,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.grey),
                          ),
                        ],
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
