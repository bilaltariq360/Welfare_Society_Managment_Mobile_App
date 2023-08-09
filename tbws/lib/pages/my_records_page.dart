import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/receipt.dart';
import 'package:tbws/providers/user_provider.dart';

class MyRecord extends StatelessWidget {
  MyRecord({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 15),
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
                'My Records',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          ...provider.receiptData.map((receipt) {
            return Receipt(
                receipt: '00000001',
                amount: receipt.amount,
                cnic: provider.userDetails!.userCNIC,
                collector: receipt.collector,
                date: DateFormat.yMMMEd().format(receipt.date),
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
