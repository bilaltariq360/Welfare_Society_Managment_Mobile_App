import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receipt extends StatelessWidget {
  String receipt, collector, amount, date, cnic, name, mobile, house, property;
  Receipt(
      {required this.receipt,
      required this.amount,
      required this.cnic,
      required this.collector,
      required this.date,
      required this.house,
      required this.mobile,
      required this.name,
      required this.property,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Stack(
        children: [
          Image.asset('lib/images/receipt.png'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Receipt: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      receipt,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Collector: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      collector,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey.shade500,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rs. ',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.red.shade800),
                    ),
                    Text(
                      amount,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.red.shade800),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade500,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(CupertinoIcons.doc_text_viewfinder, size: 20),
                    SizedBox(width: 10),
                    Text(
                      cnic,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    Icon(Icons.person_2_outlined, size: 20),
                    SizedBox(width: 10),
                    Text(
                      name,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.phone, size: 20),
                    SizedBox(width: 10),
                    Text(
                      mobile,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.house, size: 20),
                    SizedBox(width: 10),
                    Text(
                      house,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.doc_person, size: 20),
                    SizedBox(width: 10),
                    Text(
                      property,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
