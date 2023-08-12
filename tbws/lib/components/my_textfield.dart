import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:tbws/style.dart';

import '../pages/login_page.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  final int maxLength;
  final int exactLength;
  final int minLength;
  final IconData prefixIcon;
  final TextInputType textInputType;
  final FilteringTextInputFormatter filteringTextInputFormatter;
  bool check;
  bool hideCheckMark;

  MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.maxLength,
      required this.exactLength,
      required this.minLength,
      required this.textInputType,
      required this.filteringTextInputFormatter,
      required this.check,
      required this.prefixIcon,
      required this.hideCheckMark});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool passwordValidator(String password) {
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    RegExp numberRegex = RegExp(r'[0-9]');

    return password.length >= 6 &&
        lowerCaseRegex.hasMatch(password) &&
        numberRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        keyboardType: widget.textInputType,
        inputFormatters: [widget.filteringTextInputFormatter],
        onChanged: (widget.hideCheckMark)
            ? null
            : (text) {
                if (widget.hintText == 'Password') {
                  LoginPage.passwordForConfirmPassword = text;
                  if (passwordValidator(text)) {
                    setState(() {
                      widget.check = true;
                    });
                  } else {
                    setState(() {
                      widget.check = false;
                    });
                  }
                } else if (widget.hintText == 'Confirm Password') {
                  if (text == LoginPage.passwordForConfirmPassword &&
                      text.isNotEmpty) {
                    setState(() {
                      widget.check = true;
                    });
                  } else {
                    setState(() {
                      widget.check = false;
                    });
                  }
                } else {
                  if ((text.length >= widget.minLength &&
                          text.length <= widget.maxLength) ||
                      text.length == widget.exactLength) {
                    setState(() {
                      widget.check = true;
                    });
                  } else {
                    setState(() {
                      widget.check = false;
                    });
                  }
                }
              },
        controller: widget.controller,
        cursorColor: Style.themeLight,
        style: TextStyle(color: Style.themeLight),
        obscureText: widget.obscureText,
        maxLength: (widget.hideCheckMark) ? 50 : widget.maxLength,
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.themeUltraLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.themeUltraLight),
          ),
          fillColor: Colors.transparent,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Style.themeFade),
          prefixIcon: Icon(widget.prefixIcon, color: Style.themeFade),
          suffixIcon: (widget.hintText == 'Password' ||
                  widget.hintText == 'Confirm Password')
              ? SizedBox(
                  width: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon((widget.check) ? Icons.check : null,
                          color: Style.themeUltraLight),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.hintText == 'Password' ||
                                widget.hintText == 'Confirm Password') {
                              widget.obscureText = !widget.obscureText;
                            }
                          });
                        },
                        icon: Icon(
                          (widget.obscureText &&
                                  (widget.hintText == 'Password' ||
                                      widget.hintText == 'Confirm Password'))
                              ? CupertinoIcons.eye_slash_fill
                              : ((widget.hintText == 'Password' ||
                                      widget.hintText == 'Confirm Password')
                                  ? CupertinoIcons.eye_fill
                                  : null),
                          color: Style.themeFade,
                        ),
                      ),
                    ],
                  ),
                )
              : Icon(
                  (widget.check && !widget.hideCheckMark) ? Icons.check : null,
                  color: Style.themeUltraLight),
        ),
      ),
    );
  }
}
