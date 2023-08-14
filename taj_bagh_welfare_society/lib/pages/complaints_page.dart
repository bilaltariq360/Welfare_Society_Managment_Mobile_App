import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/complaint_card.dart';
import '../components/notification_card.dart';
import '../providers/user_provider.dart';
import '../style.dart';

class Complaints extends StatelessWidget {
  const Complaints({super.key});

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
        : (provider.complLoading)
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
            : Column(
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
                              Icons.comment_sharp,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Complaints',
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
                                provider.clearComplaints();
                                provider.loadComplaints();
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
                  (provider.complaints.isEmpty)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2),
                            Icon(
                              CupertinoIcons.doc_text_search,
                              color: Style.themeFade,
                              size: 100,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'No complaints found',
                              style: TextStyle(
                                  color: Style.themeFade, fontSize: 25),
                            ),
                          ],
                        )
                      : Expanded(
                          child: Consumer(
                            builder:
                                (BuildContext context, value, Widget? child) =>
                                    ListView(children: [
                              ...provider.complaints.map((complaint) {
                                return ComplaintCard(
                                  name: complaint.name,
                                  dateTime: complaint.dateTime,
                                  complaint: complaint.complaint,
                                  cnic: complaint.cnic,
                                  dept: complaint.dept,
                                  houseArea: complaint.houseArea,
                                  houseNo: complaint.houseNo,
                                  houseProperty: complaint.houseProperty,
                                  mobile: complaint.mobile,
                                  street: '${complaint.street} street',
                                );
                              }),
                            ]),
                          ),
                        ),
                ],
              );
  }
}
