import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/dropdown.dart';
import 'package:tbws/components/my_autocomplete.dart';
import 'package:tbws/providers/google_signin_provider.dart';
import 'package:flutter/services.dart';
import '/components/my_button.dart';
import '/components/my_textfield.dart';
import 'home_page.dart';

enum AuthScreen { signIn, signUp }

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthScreen auth = AuthScreen.signIn;

  final cnicController = TextEditingController();

  final mobileController = TextEditingController();

  final houseAreaController = TextEditingController();

  final streetController = const TextEditingValue();

  final passwordController = TextEditingController();

  final fullnameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //final List<bool> houseArea = [false, false, false, false];

  List<String> houseNo = List.generate(70, (index) => (index + 1).toString());

  List<String> houseArea = [
    '7 OR less than 7 Marla',
    'Above than 7 AND less than 10 Marla',
    '10 OR above than 10 AND less than 1 Kanal',
    '1 Kanal OR above than 1 Kanal'
  ];

  void signUserIn() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }

  void signUserUp() {
    Navigator.pushReplacementNamed(context, Home.routeName);
  }

  void tootgleAuthScreen() {
    setState(() {
      if (auth == AuthScreen.signIn) {
        auth = AuthScreen.signUp;
      } else {
        auth = AuthScreen.signIn;
      }
      cnicController.clear();
      fullnameController.clear();
      mobileController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
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
                  (auth == AuthScreen.signIn)
                      ? 'Welcome back you\'ve been missed!'
                      : 'Get yourself register now!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: cnicController,
                  hintText: 'CNIC',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  maxLength: 13,
                  minLength: 13,
                  exactLength: 13,
                  check: (cnicController.text.isEmpty) ? false : true,
                ),
                const SizedBox(height: 10),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: fullnameController,
                            hintText: 'Full Name',
                            obscureText: false,
                            textInputType: TextInputType.name,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]')),
                            maxLength: 25,
                            minLength: 3,
                            exactLength: 200,
                            check: (fullnameController.text.isEmpty)
                                ? false
                                : true,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: mobileController,
                            hintText: 'Mobile',
                            obscureText: false,
                            textInputType: TextInputType.number,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                            maxLength: 11,
                            minLength: 11,
                            exactLength: 11,
                            check:
                                (mobileController.text.isEmpty) ? false : true,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyAutocomplete(
                            hintText: 'Street',
                            textInputType: TextInputType.text,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]')),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyDropdown(
                            hintText: 'Select House No',
                            list: houseNo,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyDropdown(
                            hintText: 'Select House Area',
                            list: houseArea,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                /*(auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Radio(
                                  value: houseArea[0],
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      houseArea[0] = true;
                                      houseArea[1] = false;
                                      houseArea[2] = false;
                                      houseArea[3] = false;
                                    });
                                  },
                                ),
                                Text('7 OR less than 7 Marla',
                                    style: TextStyle(
                                        fontWeight: (houseArea[0])
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Radio(
                                  value: houseArea[1],
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      houseArea[0] = false;
                                      houseArea[1] = true;
                                      houseArea[2] = false;
                                      houseArea[3] = false;
                                    });
                                  },
                                ),
                                Text('Above than 7 AND less than 10 Marla',
                                    style: TextStyle(
                                        fontWeight: (houseArea[1])
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Radio(
                                  value: houseArea[2],
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      houseArea[0] = false;
                                      houseArea[1] = false;
                                      houseArea[2] = true;
                                      houseArea[3] = false;
                                    });
                                  },
                                ),
                                Text(
                                    '10 OR above than 10 AND less than 1 Kanal',
                                    style: TextStyle(
                                        fontWeight: (houseArea[2])
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Radio(
                                  value: houseArea[3],
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      houseArea[0] = false;
                                      houseArea[1] = false;
                                      houseArea[2] = false;
                                      houseArea[3] = true;
                                    });
                                  },
                                ),
                                Text('1 Kanal OR above than 1 Kanal',
                                    style: TextStyle(
                                        fontWeight: (houseArea[3])
                                            ? FontWeight.bold
                                            : FontWeight.normal)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),*/
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  textInputType: TextInputType.text,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  maxLength: 20,
                  minLength: 6,
                  exactLength: 200,
                  check: (passwordController.text.isEmpty) ? false : true,
                ),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                            textInputType: TextInputType.text,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9]')),
                            maxLength: 20,
                            minLength: 6,
                            exactLength: 200,
                            check: (confirmPasswordController.text.isEmpty)
                                ? false
                                : true,
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
                  btnText: (auth == AuthScreen.signIn) ? 'Sign in' : 'Sign up',
                  onTap: (auth == AuthScreen.signIn)
                      ? () {
                          signUserIn();
                        }
                      : () {
                          signUserIn();
                        },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (auth == AuthScreen.signUp)
                          ? 'Already have account?'
                          : 'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: tootgleAuthScreen,
                      child: Text(
                        (auth == AuthScreen.signIn)
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
