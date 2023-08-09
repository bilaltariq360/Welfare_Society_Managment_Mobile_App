import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/receipt.dart';
import 'package:tbws/providers/user_provider.dart';
import 'package:tbws/style.dart';

class MyRecord extends StatelessWidget {
  MyRecord({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return (provider.loading)
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
                ...provider.receiptData.map((receipt) {
                  return Receipt(
                      receipt: '00000001',
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
