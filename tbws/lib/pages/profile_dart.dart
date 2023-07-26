import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
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
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'CNIC:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '35201-9892-753-7',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'Name:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Bilal Tariq',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'Mobile:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '03024813755',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'Street:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Sarooj',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'House Area:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '8 Marla',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'House Property:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Owner',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                'House No.:  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 194, 255, 175),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '3',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
