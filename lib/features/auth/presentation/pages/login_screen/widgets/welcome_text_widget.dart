import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:flutter/material.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome Admin",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'NewAmsterdam',
          ),
          textAlign: TextAlign.center,
        ),
        kheight20,
        Text('Login As Admin')
      ],
    );
  }
}
