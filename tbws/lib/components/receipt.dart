import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receipt extends StatelessWidget {
  String receipt,
      collector,
      amount,
      date,
      time,
      cnic,
      name,
      mobile,
      house,
      property;
  Receipt(
      {required this.receipt,
      required this.amount,
      required this.cnic,
      required this.collector,
      required this.date,
      required this.time,
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
                    const Text(
                      'Receipt: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      receipt,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Collector: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      collector,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(CupertinoIcons.doc_text_viewfinder, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      cnic,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    const Icon(Icons.person_2_outlined, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.phone, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      mobile,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.house, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      house,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.doc_person, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      property,
                      style: const TextStyle(fontSize: 14),
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
