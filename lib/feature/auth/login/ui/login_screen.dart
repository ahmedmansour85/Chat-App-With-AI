import 'package:chat_app_with_ai/feature/auth/login/bloc/signin_bloc.dart';
import 'package:chat_app_with_ai/feature/auth/login/ui/styles/login_styles.dart';
import 'package:chat_app_with_ai/feature/auth/login/ui/widgets/email_and_password.dart';
import 'package:chat_app_with_ai/feature/auth/login/ui/widgets/login_header.dart';
import 'package:chat_app_with_ai/feature/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool signInRequired = false;

    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state is SigninLoading) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SigninSuccess) {
          setState(() {
            signInRequired = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is SigninError) {
          setState(() {
            signInRequired = false;
          });
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
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const LoginHeader(),
                ),
                SlideTransition(
                  position: _slideAnimation,
                  child: EmailAndPassword(signinrequred: signInRequired),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
