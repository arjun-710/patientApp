import 'package:flutter/material.dart';

class CustomAutoComplete extends StatelessWidget {
  const CustomAutoComplete({
    Key? key,
    required this.medOptions,
    required this.hintText,
    required this.onSelect,
  }) : super(key: key);

  final List<String> medOptions;
  final String hintText;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return medOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: .75),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black, width: 0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            hintText: hintText,
            fillColor: const Color(0xffF5F6FA),
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
            print('You just typed a new entry  $value');
          },
        );
      },
      onSelected: (String selection) {
        onSelect(selection);
        debugPrint('You just selected $selection');
      },
    );
  }
}
