import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taj_bagh_welfare_society/style.dart';

import '../pages/login_page.dart';

class MyAutocomplete extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final FilteringTextInputFormatter filteringTextInputFormatter;
  final IconData prefixIcon;
  static String streetController = '';

  MyAutocomplete({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.filteringTextInputFormatter,
    required this.prefixIcon,
  });

  static List<String> streets = [
    'New Canal Park',
    'Jamun',
    'Chanmbaili',
    'Channar',
    'Ghulab',
    'Champa',
    'Beri',
    'Ammbi',
    'Ambar',
    'Baylla',
    'Ghuncha',
    'Sitara',
    'Paras',
    'Sarmad',
    'Marjan',
    'Shajar Rah',
    'Kanwal Rah',
    'Motia',
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
    'Hina',
    'Hassan Block',
    'Gulshan Rah Ext'
  ];

  @override
  State<MyAutocomplete> createState() => _MyAutocompleteState();
}

class _MyAutocompleteState extends State<MyAutocomplete> {
  bool check = false;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<String> getFilteredStreets(String query) {
    // Implement your filtering logic here.
    return MyAutocomplete.streets.where((street) {
      return street.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Style.themeLight),
            keyboardType: widget.textInputType,
            inputFormatters: [widget.filteringTextInputFormatter],
            controller: _textEditingController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.prefixIcon, color: Style.themeFade),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Style.themeUltraLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Style.themeUltraLight),
              ),
              fillColor: Colors.transparent,
              filled: true,
              hintText: 'Street',
              hintStyle: TextStyle(color: Style.themeFade),
              suffixIcon: (check)
                  ? Icon(Icons.check, color: Style.themeUltraLight)
                  : null,
            ),
            onChanged: (value) {
              bool found = false;
              setState(() {
                for (var street in MyAutocomplete.streets) {
                  if (street.toLowerCase() == value.toLowerCase()) {
                    check = true;
                    found = true;
                  }
                }

                if (!found) {
                  check = false;
                }
              });
            },
          ),
          if (_focusNode.hasFocus && _textEditingController.text.isNotEmpty)
            SizedBox(
              height: (double.parse(
                              getFilteredStreets(_textEditingController.text)
                                  .length
                                  .toString()) *
                          56 >
                      500)
                  ? 280
                  : double.parse(getFilteredStreets(_textEditingController.text)
                          .length
                          .toString()) *
                      56,
              child: Material(
                elevation: 4,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      getFilteredStreets(_textEditingController.text).length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option =
                        getFilteredStreets(_textEditingController.text)[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _textEditingController.text = option;
                          LoginPage.streetController = option;
                          _focusNode.unfocus();
                          check = true;
                        });
                      },
                      child: ListTile(
                        tileColor: Style.themeDark,
                        textColor: Style.themeLight,
                        title: Text(option),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
