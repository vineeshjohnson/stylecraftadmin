import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    required this.onTap,
    required this.buttonTxt,
    required this.backGroundColor,
    required this.textColor,
  });

  final VoidCallback onTap;
  final String buttonTxt;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: backGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Text(
          buttonTxt,
          style: TextStyle(
            fontSize: 18.0,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
