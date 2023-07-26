import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAutocomplete extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final FilteringTextInputFormatter filteringTextInputFormatter;

  MyAutocomplete({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.filteringTextInputFormatter,
  });

  @override
  State<MyAutocomplete> createState() => _MyAutocompleteState();
}

class _MyAutocompleteState extends State<MyAutocomplete> {
  List<String> streets = [
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

  String text = '';
  bool streetExist = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return streets.where(
          (String street) {
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
              suffixIcon: (streetExist)
                  ? const Icon(Icons.check, color: Colors.green)
                  : null),
        );
      }),
    );
  }
}
