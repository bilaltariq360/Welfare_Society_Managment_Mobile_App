import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/providers/google_signin_provider.dart';
import '/components/my_button.dart';
import '/components/my_textfield.dart';
import 'home_page.dart';

enum AuthScreen { SignIn, SignUp }

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthScreen auth = AuthScreen.SignIn;

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final fullnameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void signUserIn() {}
  void signUserUp() {}

  void tootgleAuthScreen() {
    setState(() {
      if (auth == AuthScreen.SignIn) {
        auth = AuthScreen.SignUp;
      } else {
        auth = AuthScreen.SignIn;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text(
                  (auth == AuthScreen.SignIn)
                      ? 'Welcome back you\'ve been missed!'
                      : 'Get yourself register now!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: 'CNIC',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: fullnameController,
                            hintText: 'Full Name',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: fullnameController,
                            hintText: 'Mobile',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: fullnameController,
                            hintText: 'Street',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: fullnameController,
                            hintText: 'House Area',
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 25),
                MyButton(
                  btnText: (auth == AuthScreen.SignIn) ? 'Sign in' : 'Sign up',
                  onTap: (auth == AuthScreen.SignIn)
                      ? () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                          signUserIn();
                        }
                      : () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                          signUserIn();
                        },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (auth == AuthScreen.SignUp)
                          ? 'Already have account?'
                          : 'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: tootgleAuthScreen,
                      child: Text(
                        (auth == AuthScreen.SignIn)
                            ? 'Register now'
                            : 'Sign in',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> streets = [
    'New Canal Park',
    'Jamun',
    'Chanmbaili',
    'Channar',
    'Ghulab',
    'Champa Gali',
    'Beri Galli',
    'Ammbi',
    'Ambar',
    'Baylla',
    'Ghuncha',
    'Sitara',
    'Paras Gali',
    'Sarmad Gali',
    'Marjan',
    'Shajar Raha',
    'Kanwal Rah',
    'Motia Gali',
    'Nargis',
    'Gainda',
    'Safaida',
    'Sagwan',
    'Zafran',
    'Sukh Chain',
    'Samman',
    'Shaheen',
    'Saba',
    'Koel',
    'Sarooj',
    'Zoofa',
    'Zaitoon',
    'Enjeer',
    'Samar Rah',
    'Sumbal Rah Main',
    'Marwa',
    'Yasmeen',
    'Kewrah',
    'Falsa',
    'Sanobar',
    'Kanir',
    'Saroo',
    'Shabnam',
    'Mahak',
    'Gulshan Rah',
    'Kiran',
    'Khushbo',
    'Gulnar',
    'Hina Gali',
    'Hassan Block',
    'Gulshan Rah Ext'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchStreet = [];

    for (var street in streets) {
      if (street.toLowerCase().contains(query.toLowerCase())) {
        matchStreet.add(street);
      }
    }

    return ListView.builder(
      itemCount: matchStreet.length,
      itemBuilder: (context, index) {
        var result = matchStreet[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchStreet = [];

    for (var street in streets) {
      if (street.toLowerCase().contains(query.toLowerCase())) {
        matchStreet.add(street);
      }
    }

    return ListView.builder(
      itemCount: matchStreet.length,
      itemBuilder: (context, index) {
        var result = matchStreet[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
