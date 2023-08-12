import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/pages/collect_fund.dart';
import 'package:tbws/providers/user_provider.dart';
import 'pages/login_page.dart';

import './pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          Home.routeName: (context) => Home(),
          CollectFund.routeName: (context) => CollectFund(),
        },
      ),
    );
  }
}
