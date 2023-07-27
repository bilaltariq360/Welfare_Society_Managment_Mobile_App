import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          bool found = false;
          for (var street in MyAutocomplete.streets) {
            if (street.toLowerCase() == textEditingValue.text.toLowerCase()) {
              setState(() {
                check = true;
                found = true;
              });
            }
          }
          if (!found) {
            setState(() {
              check = false;
            });
          }
        }
        return MyAutocomplete.streets.where(
          (String street) {
            MyAutocomplete.streetController = textEditingValue.text;
            return street
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          },
        );
      }, fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          keyboardType: widget.textInputType,
          inputFormatters: [widget.filteringTextInputFormatter],
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
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
              suffixIcon: (check)
                  ? const Icon(Icons.check, color: Colors.green)
                  : null),
        );
      }),
    );
  }
}
