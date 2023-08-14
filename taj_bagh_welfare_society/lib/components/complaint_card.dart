import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/components/functions.dart';
import 'package:taj_bagh_welfare_society/providers/user_provider.dart';
import 'package:taj_bagh_welfare_society/style.dart';

class ComplaintCard extends StatelessWidget {
  String name,
      cnic,
      mobile,
      street,
      houseNo,
      houseArea,
      houseProperty,
      complaint,
      dept;
  DateTime dateTime;
  ComplaintCard(
      {required this.name,
      required this.dateTime,
      required this.cnic,
      required this.complaint,
      required this.dept,
      required this.houseArea,
      required this.houseNo,
      required this.houseProperty,
      required this.mobile,
      required this.street,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (dept == 'Security')
          ? const Color.fromARGB(255, 250, 255, 194)
          : (dept == 'Garbage')
              ? const Color.fromARGB(255, 242, 208, 255)
              : (dept == 'Street Light')
                  ? const Color.fromARGB(255, 255, 213, 198)
                  : Style.themeUltraLight,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onLongPress: () {
          Functions.showComplDeleteAlertBox(context, dateTime);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dept,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.insert_link_rounded,
                              color: Colors.black),
                          const SizedBox(width: 5),
                          Text(
                            '$street $houseNo',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMEd().format(dateTime),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            DateFormat.jm().format(dateTime),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.person,
                              size: 16, color: Colors.black),
                          const SizedBox(width: 5),
                          FittedBox(
                            child: Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.doc_text_viewfinder,
                              size: 16, color: Colors.black),
                          const SizedBox(width: 5),
                          Text(
                            cnic,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.phone_fill,
                              size: 16, color: Colors.black),
                          const SizedBox(width: 5),
                          FittedBox(
                            child: Text(
                              mobile,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(
                              CupertinoIcons
                                  .rectangle_arrow_up_right_arrow_down_left,
                              size: 16,
                              color: Colors.black),
                          const SizedBox(width: 5),
                          Text(
                            houseArea,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '($houseProperty)',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Divider(
                  thickness: 2,
                  color: Style.themeDark,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    complaint,
                    style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.2,
                        wordSpacing: 1.2,
                        height: 1.3,
                        color: Colors.black87),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
