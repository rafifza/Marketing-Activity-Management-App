import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool disabled;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.disabled = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: !disabled,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(left: 12), // Add left padding
          child: Text(label),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12), // Rounded border when not focused
          borderSide: BorderSide(color: Colors.grey), // Border color
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Colors.grey), // Keeps border visible
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(20), // Rounded border when focused
          borderSide: BorderSide(
              color: Colors.grey, width: 2), // Border color when focused
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Padding inside the field
      ),
    );
  }
}
