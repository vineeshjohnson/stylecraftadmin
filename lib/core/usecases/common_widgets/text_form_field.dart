import 'package:flutter/material.dart';

class Textformfields extends StatelessWidget {
  const Textformfields(
      {super.key,
      this.controller,
      required this.icon,
      required this.labeltext,
      this.validator,
      this.enabled});

  final TextEditingController? controller;
  final Icon icon;
  final String labeltext;
  final String? Function(String?)? validator;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: icon,
      ),
      validator: validator,
    );
  }
}
