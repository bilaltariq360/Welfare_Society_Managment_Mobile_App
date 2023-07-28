import 'package:flutter/material.dart';
import 'package:tbws/components/dropdown.dart';
import 'package:tbws/components/my_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/components/my_button.dart';
import '/components/my_textfield.dart';

enum AuthScreen { signIn, signUp }

class LoginPage extends StatefulWidget {
  static String? passwordForConfirmPassword;

  static bool houseNoSelected = false;

  static bool houseAreaSelected = false;

  static bool housePropertySelected = false;

  static String streetController = '';

  static String houseNoController = '';

  static String houseAreaController = '';

  static String housePropertyController = '';

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errMsg = '';

  AuthScreen auth = AuthScreen.signIn;

  final cnicController = TextEditingController();

  final mobileController = TextEditingController();

  final houseAreaController = TextEditingController();

  final passwordController = TextEditingController();

  final fullnameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  List<String> houseNo = List.generate(70, (index) => (index + 1).toString());

  List<String> houseArea = [
    '1 Marla',
    '2 Marla',
    '3 Marla',
    '4 Marla',
    '5 Marla',
    '6 Marla',
    '7 Marla',
    '8 Marla',
    '9 Marla',
    '10 Marla',
    '11 Marla',
    '12 Marla',
    '13 Marla',
    '14 Marla',
    '15 Marla',
    '16 Marla',
    '17 Marla',
    '18 Marla',
    '19 Marla',
    '20 Marla (1 Kanal)',
    'Above than 20 Marla (1 Kanal)'
  ];

  List<String> houseProperty = ['Owner', 'Rental'];

  bool passwordValidator() {
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    RegExp numberRegex = RegExp(r'[0-9]');

    return passwordController.text.length >= 6 &&
        lowerCaseRegex.hasMatch(passwordController.text) &&
        numberRegex.hasMatch(passwordController.text);
  }

  bool confirmPasswordMatch() {
    return passwordController.text == confirmPasswordController.text;
  }

  bool signupAuthentication() {
    bool streetMatch = false;
    bool returningValue = true;

    for (var street in MyAutocomplete.streets) {
      if (street.toLowerCase() == LoginPage.streetController.toLowerCase()) {
        streetMatch = true;
      }
    }

    if (cnicController.text.length != 13) {
      setState(() {
        errMsg = 'Enter valid CNIC!';
      });
      returningValue = !returningValue;
    } else if (fullnameController.text.length < 3) {
      setState(() {
        errMsg = 'Enter valid name!';
      });
      returningValue = !returningValue;
    } else if (mobileController.text.length != 11) {
      setState(() {
        errMsg = 'Enter valid mobile number!';
      });
      returningValue = !returningValue;
    } else if (!streetMatch) {
      setState(() {
        errMsg = 'Select valid street!';
      });
      returningValue = !returningValue;
    } else if (!LoginPage.houseNoSelected) {
      setState(() {
        errMsg = 'Select House No!';
      });
      returningValue = !returningValue;
    } else if (!LoginPage.houseAreaSelected) {
      setState(() {
        errMsg = 'Select House Area!';
      });
      returningValue = !returningValue;
    } else if (!LoginPage.housePropertySelected) {
      setState(() {
        errMsg = 'Select House Property!';
      });
      returningValue = !returningValue;
    } else if (!passwordValidator()) {
      if (passwordController.text.isEmpty) {
        setState(() {
          errMsg = 'Enter valid password!';
        });
      } else {
        setState(() {
          errMsg =
              'Your password should be at least 6 characters and has a combination of both lowercase letters and numbers!';
        });
      }
      returningValue = !returningValue;
    } else if (!confirmPasswordMatch()) {
      setState(() {
        errMsg = 'Password did\'nt match!';
      });
      returningValue = !returningValue;
    }

    if (returningValue) {
      MyAutocomplete.streetController = '';
      setState(() {
        errMsg = '';
      });
      return true;
    }

    return false;
  }

  void signUserIn() {
    //Navigator.pushReplacementNamed(context, Home.routeName);
    setState(() {
      errMsg = 'No record found!';
    });
  }

  void signUserUp() async {
    if (signupAuthentication()) {
      var url =
          'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/user_registration.json';
      http.post(Uri.parse(url),
          body: json.encode({
            'CNIC': cnicController.text,
            'Full Name': fullnameController.text,
            'Mobile': mobileController.text,
            'Street': LoginPage.streetController,
            'House No': LoginPage.houseNoController,
            'House Area': LoginPage.houseAreaController,
            'House Property': LoginPage.housePropertyController,
            'Password': passwordController.text
          }));

      setState(() {
        clearControllerData();
        auth = AuthScreen.signIn;
      });
    }
  }

  void clearControllerData() {
    cnicController.clear();
    fullnameController.clear();
    mobileController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    LoginPage.houseNoSelected = false;
    LoginPage.houseAreaSelected = false;
    LoginPage.housePropertySelected = false;
    LoginPage.streetController = '';
    LoginPage.houseNoController = '';
    LoginPage.houseAreaController = '';
    LoginPage.housePropertyController = '';
    errMsg = '';
  }

  void tootgleAuthScreen() {
    setState(() {
      if (auth == AuthScreen.signIn) {
        auth = AuthScreen.signUp;
      } else {
        auth = AuthScreen.signIn;
      }
      clearControllerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: (auth == AuthScreen.signIn)
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
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
                  prefixIcon: CupertinoIcons.doc_text_viewfinder,
                  textInputType: TextInputType.number,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  maxLength: 13,
                  minLength: 13,
                  exactLength: 13,
                  check: (cnicController.text.isNotEmpty &&
                          cnicController.text.length == 13)
                      ? true
                      : false,
                  hideCheckMark: (auth == AuthScreen.signIn) ? true : false,
                ),
                const SizedBox(height: 10),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: fullnameController,
                            hintText: 'Full Name',
                            obscureText: false,
                            prefixIcon: Icons.text_fields_rounded,
                            textInputType: TextInputType.name,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z ]')),
                            maxLength: 25,
                            minLength: 3,
                            exactLength: 200,
                            check: (fullnameController.text.isNotEmpty &&
                                    fullnameController.text.length >= 3)
                                ? true
                                : false,
                            hideCheckMark: false,
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
                            hintText: 'Mobile (Whatsapp)',
                            obscureText: false,
                            prefixIcon: CupertinoIcons.phone_fill,
                            textInputType: TextInputType.number,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                            maxLength: 11,
                            minLength: 11,
                            exactLength: 11,
                            check: (mobileController.text.isNotEmpty &&
                                    mobileController.text.length == 11)
                                ? true
                                : false,
                            hideCheckMark: false,
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
                            prefixIcon: Icons.add_road,
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
                            prefixIcon: CupertinoIcons.number,
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
                            prefixIcon: CupertinoIcons
                                .rectangle_arrow_up_right_arrow_down_left,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyDropdown(
                            hintText: 'Select House Property',
                            list: houseProperty,
                            prefixIcon: CupertinoIcons.house,
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: CupertinoIcons.padlock,
                  textInputType: TextInputType.text,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  maxLength: 20,
                  minLength: 6,
                  exactLength: 200,
                  check: (passwordController.text.isNotEmpty &&
                          passwordValidator() &&
                          auth == AuthScreen.signUp)
                      ? true
                      : false,
                  hideCheckMark: (auth == AuthScreen.signIn) ? true : false,
                ),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                            prefixIcon: CupertinoIcons.padlock,
                            textInputType: TextInputType.text,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z0-9]')),
                            maxLength: 20,
                            minLength: 6,
                            exactLength: 200,
                            check: (confirmPasswordController.text.isNotEmpty &&
                                    confirmPasswordMatch())
                                ? true
                                : false,
                            hideCheckMark: false,
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
                (errMsg != '')
                    ? Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red),
                            child: Text(
                              errMsg,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      )
                    : const SizedBox(),
                MyButton(
                  btnText: (auth == AuthScreen.signIn) ? 'Sign in' : 'Sign up',
                  onTap: (auth == AuthScreen.signIn)
                      ? () {
                          signUserIn();
                        }
                      : () {
                          signUserUp();
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
