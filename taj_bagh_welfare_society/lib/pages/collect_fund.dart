import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/components/my_button.dart';
import 'package:taj_bagh_welfare_society/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:taj_bagh_welfare_society/style.dart';

import '../components/my_textfield.dart';

class CollectFund extends StatefulWidget {
  static String routeName = '/collect-fund';

  CollectFund({super.key});

  @override
  State<CollectFund> createState() => _CollectFundState();
}

class _CollectFundState extends State<CollectFund> {
  TextEditingController amountController = TextEditingController();

  bool fundCollected = false;
  bool collectLoading = false;
  String errMessage = '';

  @override
  Widget build(BuildContext context) {
    final List<String> args =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    var provider = Provider.of<UserProvider>(context);
    provider.checkConnection();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.themeDark,
        elevation: 0,
      ),
      backgroundColor: Style.themeDark,
      body: (!provider.connected)
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
                  (!fundCollected)
                      ? Column(
                          children: [
                            const SizedBox(height: 50),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                                          args[1],
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
                                          args[0],
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
                                          args[2],
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
                                          '${args[3]} street',
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
                                          'House No. ${args[6]}',
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
                                          args[5],
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
                                          args[4],
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
                            const SizedBox(height: 50),
                            MyTextField(
                              controller: amountController,
                              hintText: 'Amount',
                              obscureText: false,
                              prefixIcon: CupertinoIcons.money_dollar,
                              textInputType: TextInputType.number,
                              filteringTextInputFormatter:
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                              maxLength: 0,
                              minLength: 0,
                              exactLength: 0,
                              check: false,
                              hideCheckMark: true,
                            ),
                            const SizedBox(height: 30),
                            (errMessage.isNotEmpty && !collectLoading)
                                ? Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.red.shade900),
                                        child: Text(
                                          errMessage,
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
                                : const SizedBox(height: 0),
                            (collectLoading)
                                ? CircularProgressIndicator(
                                    color: Style.themeLight,
                                  )
                                : (!collectLoading)
                                    ? MyButton(
                                        btnText: 'Collect',
                                        onTap: () async {
                                          setState(() {
                                            errMessage = '';
                                          });
                                          if (amountController.text.isEmpty ||
                                              amountController.text == ' ' ||
                                              amountController.text == '  ') {
                                            setState(() {
                                              errMessage =
                                                  'Enter Valid Amount!';
                                            });
                                            return;
                                          }
                                          int receiptNumber = -1;
                                          String nonDefaultList = '';
                                          DateTime dateTime = DateTime.now();

                                          setState(() {
                                            collectLoading = true;
                                          });

                                          var url =
                                              'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts.json';
                                          http
                                              .get(Uri.parse(url))
                                              .then((response) {
                                            receiptNumber = int.parse(json
                                                    .decode(response.body)[
                                                'setting']['Receipt Number']);
                                            nonDefaultList =
                                                json.decode(response.body)[
                                                        'paidMembers']
                                                    ['Non Default List'];
                                            receiptNumber += 1;
                                            nonDefaultList += '(' +
                                                DateFormat.yMMM()
                                                    .format(dateTime) +
                                                args[3] +
                                                args[6].replaceAll(' ', '') +
                                                ')';
                                          }).then((_) {
                                            url =
                                                'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/${DateFormat.yMMM().format(DateTime.now()).replaceAll(' ', '')}/${args[3]}${args[6].replaceAll(' ', '')}.json';

                                            http
                                                .post(Uri.parse(url),
                                                    body: json.encode({
                                                      'Date':
                                                          dateTime.toString(),
                                                      'Collector': provider
                                                          .userDetails!
                                                          .userName,
                                                      'Amount':
                                                          amountController.text,
                                                      'Receipt Number':
                                                          receiptNumber
                                                              .toString(),
                                                    }))
                                                .then((_) {
                                              url =
                                                  'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/setting.json';

                                              http.patch(Uri.parse(url),
                                                  body: json.encode({
                                                    'Receipt Number':
                                                        receiptNumber
                                                            .toString(),
                                                  }));
                                            }).then((value) {
                                              url =
                                                  'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/receipts/paidMembers.json';

                                              http.patch(Uri.parse(url),
                                                  body: json.encode({
                                                    'Non Default List':
                                                        nonDefaultList,
                                                  }));
                                            }).then((value) {
                                              amountController.clear();
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .clearReceipts();
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .loadReceipts();
                                              setState(() {
                                                collectLoading = false;
                                                fundCollected = true;
                                              });
                                              Future.delayed(const Duration(
                                                      seconds: 2))
                                                  .then((_) {
                                                setState(() {
                                                  fundCollected = false;
                                                });
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          });
                                        },
                                        backgroudColor: Style.themeLight,
                                        foregroudColor: Style.themeDark,
                                        icon: Icons.send,
                                      )
                                    : const SizedBox(height: 0),
                            const SizedBox(height: 100),
                          ],
                        )
                      : (fundCollected)
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23),
                                  Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Style.themeLight,
                                    size: 150,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'Fund collected successfully!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Style.themeLight,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                ],
              ),
            ),
    );
  }
}
