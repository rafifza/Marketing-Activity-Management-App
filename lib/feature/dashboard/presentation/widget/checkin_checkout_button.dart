import 'package:flutter/material.dart';
import 'package:mam/core/colors/app_color.dart';

class CheckInCheckOutButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double height;

  const CheckInCheckOutButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 126,
    this.height = 30,
    this.backgroundColor = AppColor.backgroundMiniNavbarIconActive,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
