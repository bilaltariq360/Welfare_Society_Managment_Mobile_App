import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/my_button.dart';
import 'package:tbws/style.dart';

import '../providers/user_provider.dart';
import 'login_page.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<UserProvider>(context, listen: false).userDetails!;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 80),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset('lib/images/clipboard.png'),
              Padding(
                padding: EdgeInsets.only(
                    top: 50, left: MediaQuery.of(context).size.width * 0.2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        Text(
                          provider.userName,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.doc_text_viewfinder),
                        const SizedBox(width: 10),
                        Text(
                          provider.userCNIC,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.phone_fill),
                        const SizedBox(width: 10),
                        Text(
                          provider.userMobile,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.add_road),
                        const SizedBox(width: 10),
                        Text(
                          '${provider.userStreet} street',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.number),
                        const SizedBox(width: 10),
                        Text(
                          'House No. ${provider.userHouseNo}',
                          style: const TextStyle(fontSize: 16),
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
                          provider.houseArea,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.house),
                        const SizedBox(width: 10),
                        Text(
                          provider.userHouseProperty,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          MyButton(
              btnText: 'Logout',
              backgroudColor: Style.themeLight,
              foregroudColor: Colors.black,
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              }),
        ],
      ),
    );
  }
}
