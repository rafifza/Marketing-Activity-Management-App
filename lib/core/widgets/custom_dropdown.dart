import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/fonts/font_size.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 150,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      hint: Text(hint, style: const TextStyle(fontSize: FontSize.bodyText)),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                    style: const TextStyle(fontSize: FontSize.bodyText)),
              ))
          .toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}
