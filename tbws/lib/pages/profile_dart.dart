import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/my_button.dart';

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
          const SizedBox(height: 15),
          const Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.manage_accounts,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                'My Profile',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 15),
              const Text(
                'CNIC:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.userCNIC,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              const Text(
                'Name:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.userName,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              const Text(
                'Mobile:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.userMobile,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              const Text(
                'Street:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.userStreet,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              const Text(
                'House Area:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.houseArea,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              const Text(
                'House Property:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.userHouseProperty,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              const Text(
                'House No.:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.userHouseNo,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 80),
          MyButton(
            btnText: 'Logout',
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
            icon: Icons.logout_outlined,
            backgroudColor: const Color.fromARGB(255, 194, 255, 175),
            foregroudColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
