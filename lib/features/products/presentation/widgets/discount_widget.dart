import 'package:flutter/material.dart';

class DiscountDropdownField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String? Function(int?)? validator;

  const DiscountDropdownField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value:
          int.tryParse(controller.text), // Initialize with controller's value
      items: List.generate(11, (index) {
        final value = index * 10; // Generate multiples of 10
        return DropdownMenuItem(
          value: value,
          child: Text('$value%'),
        );
      }),
      onChanged: (value) {
        if (value != null) {
          controller.text = value.toString();
          print(controller.text);
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
    );
  }
}
