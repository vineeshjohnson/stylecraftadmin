import 'package:finalprojectadmin/core/usecases/common_widgets/elevated_button_widget.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/text_form_field.dart';
import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

CommonButton loginButton(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return CommonButton(
    formKey: formKey,
    onTap: () {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(LoginEvent(
            adminid: emailController.text, password: passwordController.text));
      }
    },
    buttonTxt: 'Login',
    backGroundColor: Colors.black,
    textColor: Colors.white,
  );
}

Widget loginFields(TextEditingController emailController,
    TextEditingController passwordController) {
  return Column(
    children: [
      Textformfields(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          } else {
            return null;
          }
        },
        controller: emailController,
        icon: const Icon(Icons.email),
        labeltext: 'Email',
      ),
      kheight20,
      Textformfields(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else {
            return null;
          }
        },
        controller: passwordController,
        icon: const Icon(Icons.text_fields_rounded),
        labeltext: 'Password',
      ),
      kheight30,
    ],
  );
}
