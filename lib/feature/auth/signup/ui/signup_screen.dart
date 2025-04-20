import 'package:chat_app_with_ai/core/helpers/extensions.dart';
import 'package:chat_app_with_ai/feature/auth/login/ui/styles/login_styles.dart';
import 'package:chat_app_with_ai/feature/auth/signup/bloc/signup_bloc.dart';
import 'package:chat_app_with_ai/feature/auth/signup/ui/widgets/form_signup.dart';
import 'package:chat_app_with_ai/feature/auth/signup/ui/widgets/signup_header.dart';
import 'package:chat_app_with_ai/feature/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    bool signupRequired = false;

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          setState(() {
            signupRequired = true;
          });
        } else if (state is SignupSuccess) {
          setState(() {
            signupRequired = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is SignupError) {
          setState(() {
            signupRequired = false;
          });
          context.showErrorSnackBar(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: LoginStyles.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SignupHeader(),
                EmailAndPassword(signupRequired: signupRequired),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
