import 'package:flutter/material.dart';
import 'package:taj_bagh_welfare_society/pages/my_records_page.dart';
import 'package:taj_bagh_welfare_society/style.dart';

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
          prefixIcon: Icon(widget.prefixIcon, color: Style.themeFade),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.themeUltraLight),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Style.themeUltraLight),
            borderRadius: BorderRadius.circular(5),
          ),
          enabled: false,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.themeUltraLight),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        dropdownColor: Style.themeDark,
        hint: _dropDownValue == null
            ? const Text('Dropdown')
            : Text(
                _dropDownValue,
                style: TextStyle(color: Style.themeFade, fontSize: 16),
              ),
        isExpanded: true,
        iconSize: 25.0,
        iconDisabledColor: Style.themeFade,
        iconEnabledColor: Style.themeFade,
        items: widget.list.map(
          (val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style: TextStyle(color: Style.themeLight),
              ),
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
              } else if (widget.hintText == 'All Records') {
                setState(() {
                  MyRecord.receiptMonth = val;
                });
              }
            },
          );
        },
      ),
    );
  }
}
