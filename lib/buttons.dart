import 'package:flutter/cupertino.dart';

class CustomeButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback? onTap;

  const CustomeButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
