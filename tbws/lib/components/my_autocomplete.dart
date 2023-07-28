import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            keyboardType: widget.textInputType,
            inputFormatters: [widget.filteringTextInputFormatter],
            controller: _textEditingController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.prefixIcon, color: Colors.grey[500]),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: 'Street',
              hintStyle: TextStyle(color: Colors.grey[500]),
              suffixIcon:
                  (check) ? const Icon(Icons.check, color: Colors.green) : null,
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
                        tileColor: Colors.grey[300],
                        textColor: Colors.grey[600],
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
