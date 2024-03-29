import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:taj_bagh_welfare_society/components/dropdown.dart';
import 'package:taj_bagh_welfare_society/components/my_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:taj_bagh_welfare_society/style.dart';
import 'dart:convert';
import '../providers/user_provider.dart';
import '/components/my_button.dart';
import '/components/my_textfield.dart';
import 'home_page.dart';

enum AuthScreen { signIn, signUp }

class LoginPage extends StatefulWidget {
  static String routeName = '/signin';

  static String? passwordForConfirmPassword;

  bool loading = false;

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

  String succMsg = '';

  bool duplicateUser = false;

  AuthScreen auth = AuthScreen.signIn;

  final cnicController = TextEditingController();

  final mobileController = TextEditingController();

  final houseAreaController = TextEditingController();

  final passwordController = TextEditingController();

  final fullnameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  List<String> houseNo = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 70; i++) {
      houseNo.add('$i    ( A )');
      houseNo.add('$i    ( B )');
    }
  }

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
    'Above 20 Marla (1 Kanal)'
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

    widget.loading = false;
    return false;
  }

  void signUserIn() async {
    setState(() {
      errMsg = '';
      widget.loading = true;
    });
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.wifi &&
        connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.ethernet) {
      setState(() {
        errMsg = 'No internet connection!\nTry agian later';
      });
      Future.delayed(const Duration(seconds: 2)).then((_) {
        setState(() {
          errMsg = '';
          widget.loading = false;
        });
      });
      return;
    }
    bool found = false;
    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/user_registration.json';
    http.get(Uri.parse(url));

    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((fireBaseId, userData) {
      if (userData['Mobile'] == mobileController.text &&
          userData['Password'] == passwordController.text) {
        Provider.of<UserProvider>(context, listen: false).setUserDetail(
            userData['CNIC'],
            userData['Full Name'],
            userData['Mobile'],
            userData['Street'],
            userData['House Area'],
            userData['House Property'],
            userData['House No'],
            userData['Password'],
            userData['Admin']);
        found = true;
      }
    });

    if (!found) {
      setState(() {
        errMsg = 'No record found!\nRegister yourself first';
        widget.loading = false;
      });
    } else {
      setState(() {
        widget.loading = false;
        clearControllerData();
      });
      Navigator.pushNamed(context, Home.routeName);
    }
  }

  void signUserUp() {
    setState(() {
      errMsg = '';
      widget.loading = true;
    });

    var url =
        'https://tbws-app-fba9e-default-rtdb.asia-southeast1.firebasedatabase.app/user_registration.json';

    http.get(Uri.parse(url)).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((fireBaseId, userData) {
        if (userData['CNIC'] == cnicController.text ||
            userData['Mobile'] == mobileController.text ||
            (userData['Street'] == LoginPage.streetController &&
                userData['House No'] == LoginPage.houseNoController)) {
          duplicateUser = true;
        }
      });
    }).then((_) {
      if (duplicateUser) {
        setState(() {
          widget.loading = false;
          errMsg = 'User already exists with the same credentials';
        });
        duplicateUser = false;
      } else if (signupAuthentication()) {
        http
            .post(Uri.parse(url),
                body: json.encode({
                  'CNIC': cnicController.text,
                  'Full Name': fullnameController.text,
                  'Mobile': mobileController.text,
                  'Street': LoginPage.streetController,
                  'House No': LoginPage.houseNoController,
                  'House Area': LoginPage.houseAreaController,
                  'House Property': LoginPage.housePropertyController,
                  'Password': passwordController.text,
                  'Admin': false,
                }))
            .then((response) {
          setState(() {
            succMsg = 'Registered successfully!';
            Future.delayed(const Duration(milliseconds: 1500)).then((_) {
              widget.loading = false;
              tootgleAuthScreen();
            });
          });
        });
      }
    });
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
    succMsg = '';
  }

  void tootgleAuthScreen() {
    setState(() {
      if (auth == AuthScreen.signIn) {
        auth = AuthScreen.signUp;
      } else {
        auth = AuthScreen.signIn;
      }
      clearControllerData();
      widget.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.themeDark,
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
                Image.asset('lib/images/logo.png', width: 200),
                const SizedBox(height: 50),
                Text(
                  (auth == AuthScreen.signIn)
                      ? 'Welcome back you\'ve been missed!'
                      : 'Get yourself register now!',
                  style: TextStyle(
                    color: Style.themeFade,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                (auth == AuthScreen.signUp)
                    ? Column(
                        children: [
                          MyTextField(
                            controller: cnicController,
                            hintText: 'CNIC',
                            obscureText: false,
                            prefixIcon: CupertinoIcons.doc_text_viewfinder,
                            textInputType: TextInputType.number,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                            maxLength: 13,
                            minLength: 13,
                            exactLength: 13,
                            check: (cnicController.text.isNotEmpty &&
                                    cnicController.text.length == 13)
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
                MyTextField(
                  controller: mobileController,
                  hintText: (auth == AuthScreen.signIn)
                      ? 'Mobile'
                      : 'Mobile (Whatsapp)',
                  obscureText: false,
                  prefixIcon: CupertinoIcons.phone_fill,
                  textInputType: TextInputType.number,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  maxLength: 11,
                  minLength: 11,
                  exactLength: 11,
                  check: (mobileController.text.isNotEmpty &&
                          mobileController.text.length == 11)
                      ? true
                      : false,
                  hideCheckMark: (auth == AuthScreen.signIn) ? true : false,
                ),
                const SizedBox(height: 10),
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
                          const SizedBox(height: 1),
                          Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Style.themeFade,
                              border: Border.all(color: Style.themeLight),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_rounded,
                                  color: Colors.yellow.shade500,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Note: If your house No is neither in (A) nor in (B) category then select (A) category.',
                                    style:
                                        TextStyle(color: Colors.grey.shade300),
                                  ),
                                ),
                              ],
                            ),
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
                                  style: TextStyle(color: Style.themeFade),
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
                                color: Colors.red.shade900),
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
                    : (widget.loading && succMsg.isEmpty)
                        ? Column(children: [
                            CircularProgressIndicator(
                              color: Style.themeLight,
                            ),
                            const SizedBox(height: 15),
                          ])
                        : (widget.loading && succMsg.isNotEmpty)
                            ? Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 25),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green),
                                    child: Text(
                                      succMsg,
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
                (!widget.loading)
                    ? MyButton(
                        btnText:
                            (auth == AuthScreen.signIn) ? 'Sign in' : 'Sign up',
                        onTap: (auth == AuthScreen.signIn)
                            ? () {
                                signUserIn();
                              }
                            : () {
                                signUserUp();
                              },
                        backgroudColor: Style.themeLight,
                        foregroudColor: Style.themeDark,
                      )
                    : const SizedBox(),
                const SizedBox(height: 50),
                (!widget.loading)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (auth == AuthScreen.signUp)
                                ? 'Already have account?'
                                : 'Not a member?',
                            style: TextStyle(color: Style.themeFade),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: tootgleAuthScreen,
                            child: Text(
                              (auth == AuthScreen.signIn)
                                  ? 'Register now'
                                  : 'Sign in',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 82, 177, 255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
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
