import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final int maxLength;
  final int exactLength;
  final int minLength;
  final TextInputType textInputType;
  final FilteringTextInputFormatter filteringTextInputFormatter;
  bool check = false;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.maxLength,
    required this.exactLength,
    required this.minLength,
    required this.textInputType,
    required this.filteringTextInputFormatter,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        keyboardType: widget.textInputType,
        inputFormatters: [widget.filteringTextInputFormatter],
        onChanged: (text) {
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
        },
        controller: widget.controller,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            counterText: '',
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: (!widget.check)
                ? null
                : const Icon(Icons.check, color: Colors.green)),
      ),
    );
  }
}
