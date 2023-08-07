import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/receipt.dart';
import 'package:tbws/providers/user_provider.dart';

class MyRecord extends StatelessWidget {
  const MyRecord({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context).userDetails!;
    return SingleChildScrollView(
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
          Receipt(
              receipt: '00000001',
              amount: '10,000',
              cnic: provider.userCNIC,
              collector: provider.userName,
              date: '20, Sep, 2023',
              house:
                  'House ${provider.userHouseNo}, ${provider.userStreet} Street',
              mobile: provider.userMobile,
              name: provider.userName,
              property: '${provider.houseArea}, ${provider.userHouseProperty}'),
        ],
      ),
    );
  }
}
