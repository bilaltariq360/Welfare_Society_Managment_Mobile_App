import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class MyDropdown extends StatefulWidget {
  final String hintText;
  final List<String> list;
  final IconData prefixIcon;

  MyDropdown(
      {required this.hintText, required this.list, required this.prefixIcon});
  @override
  State<StatefulWidget> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    String _dropDownValue = widget.hintText;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon, color: Colors.grey[500]),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          enabled: false,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
        dropdownColor: Colors.grey.shade300,
        hint: _dropDownValue == null
            ? const Text('Dropdown')
            : Text(
                _dropDownValue,
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
        isExpanded: true,
        iconSize: 25.0,
        style: const TextStyle(color: Colors.black),
        items: widget.list.map(
          (val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          },
        ).toList(),
        onChanged: (val) {
          setState(
            () {
              _dropDownValue = val!;
              if (widget.hintText == 'Select House No') {
                LoginPage.houseNoSelected = true;
                LoginPage.houseNoController = val;
              } else if (widget.hintText == 'Select House Area') {
                LoginPage.houseAreaSelected = true;
                LoginPage.houseAreaController = val;
              } else if (widget.hintText == 'Select House Property') {
                LoginPage.housePropertySelected = true;
                LoginPage.housePropertyController = val;
              }
            },
          );
        },
      ),
    );
  }
}
