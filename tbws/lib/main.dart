import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './pages/notifications_page.dart';
import 'pages/login_page.dart';
import 'package:provider/provider.dart';
import './providers/google_signin_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          Home.routeName: (context) => Home(),
        },
      ),
    );
  }
}
