import 'package:finalprojectadmin/core/errors/common_msg.dart';
import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/functions/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/core/usecases/common_widgets/snack_bar.dart';
import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/bloc/auth_bloc.dart';
import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/widgets/welcome_text_widget.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        if (current is AuthenticationErrorState) {
          return true;
        } else {
          return true;
        }
      },
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const BottomNavigationBars()));
          snackBar(context, successReturn(1));
        } else if (state is AuthenticationErrorState) {
          snackBar(context, errorReturn(1));
        }
      },
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeTextWidget(),
                  kheight20,
                  loginFields(emailController, passwordController),
                  loginButton(
                      context, _formKey, emailController, passwordController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
