import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/pages/collect_fund.dart';
import 'package:taj_bagh_welfare_society/providers/user_provider.dart';
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
