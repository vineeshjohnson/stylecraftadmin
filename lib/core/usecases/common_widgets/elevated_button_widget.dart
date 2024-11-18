import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.onTap,
    required this.buttonTxt,
    required this.backGroundColor,
    required this.textColor,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final VoidCallback onTap;
  final String buttonTxt;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          onTap();
        }
      },
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
