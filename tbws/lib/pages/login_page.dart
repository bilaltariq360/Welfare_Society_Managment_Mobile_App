import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbws/components/my_autocomplete.dart';
import 'package:tbws/providers/google_signin_provider.dart';
import 'package:flutter/services.dart';
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

  final cnicController = TextEditingController();

  final mobileController = TextEditingController();

  final houseAreaController = TextEditingController();

  final streetController = const TextEditingValue();

  final passwordController = TextEditingController();

  final fullnameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final List<bool> houseArea = [false, false, false, false];

  String dropdownValue = 'Select';

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
                  controller: cnicController,
                  hintText: 'CNIC',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  maxLength: 13,
                  minLength: 13,
                  exactLength: 13,
                ),
                const SizedBox(height: 10),
                (auth == AuthScreen.SignUp)
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
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
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
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          MyAutocomplete(
                            hintText: 'Street',
                            textInputType: TextInputType.phone,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]')),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
                    ? DropdownButton<String>(
                        // Step 3.
                        value: dropdownValue,
                        // Step 4.
                        items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 30),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      )
                    : const SizedBox(),
                (auth == AuthScreen.SignUp)
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
                    : const SizedBox(),
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
                ),
                (auth == AuthScreen.SignUp)
                    ? Column(
                        children: [
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                            textInputType: TextInputType.phone,
                            filteringTextInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-5]')),
                            maxLength: 20,
                            minLength: 6,
                            exactLength: 200,
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
