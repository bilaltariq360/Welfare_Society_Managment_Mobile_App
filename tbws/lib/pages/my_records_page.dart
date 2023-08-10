import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/dropdown.dart';
import 'package:tbws/components/receipt.dart';
import 'package:tbws/providers/user_provider.dart';
import 'package:tbws/style.dart';

class MyRecord extends StatefulWidget {
  MyRecord({super.key});

  static String receiptMonth = 'All';

  @override
  State<MyRecord> createState() => _MyRecordState();
}

class _MyRecordState extends State<MyRecord> {
  List<String> filterMonth = ['All'];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    for (var i = 0; i < provider.receiptData.length; i++) {
      if (!filterMonth
          .contains(DateFormat.yMMM().format(provider.receiptData[i].date))) {
        setState(() {
          filterMonth
              .add(DateFormat.yMMM().format(provider.receiptData[i].date));
        });
      }
    }
    List<ReceiptData> receipts = [];
    if (MyRecord.receiptMonth == 'All') {
      receipts = provider.receiptData;
    } else {
      receipts = provider.receiptData
          .where((receipt) =>
              DateFormat.yMMM().format(receipt.date) == MyRecord.receiptMonth)
          .toList();
    }

    provider.checkConnection();
    return (!provider.connected)
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.wifi_slash,
                  color: Colors.grey,
                  size: 100,
                ),
                SizedBox(height: 25),
                Text(
                  'No internet connection!',
                  style: TextStyle(
                      color: Colors.grey,
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
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
                                'My Records',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.clearReceipts();
                                  provider.loadReceipts();
                                },
                                icon: const Icon(CupertinoIcons.refresh),
                                color: Colors.white,
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    MyDropdown(
                        hintText: 'Filter Month',
                        list: filterMonth,
                        prefixIcon: CupertinoIcons.calendar_today),
                    (receipts.isEmpty)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2),
                              Icon(
                                CupertinoIcons.doc_text_search,
                                color: Colors.grey,
                                size: 100,
                              ),
                              SizedBox(height: 30),
                              Text(
                                'No record found',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
                              ),
                            ],
                          )
                        : const SizedBox(height: 15),
                    ...receipts.map((receipt) {
                      return Receipt(
                          receipt: receipt.receiptNumber,
                          amount: receipt.amount,
                          cnic: provider.userDetails!.userCNIC,
                          collector: receipt.collector,
                          date: DateFormat.yMMMEd().format(receipt.date),
                          time: DateFormat.jms().format(receipt.date),
                          house:
                              'House ${provider.userDetails!.userHouseNo}, ${provider.userDetails!.userStreet} Street',
                          mobile: provider.userDetails!.userMobile,
                          name: provider.userDetails!.userName,
                          property:
                              '${provider.userDetails!.houseArea}, ${provider.userDetails!.userHouseProperty}');
                    })
                  ],
                ),
              );
  }
}
