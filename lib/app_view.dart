import 'package:chat_app_with_ai/config/supabase_config.dart';
import 'package:chat_app_with_ai/core/helpers/auth_local_storge.dart';
import 'package:chat_app_with_ai/feature/auth/login/bloc/signin_bloc.dart';
import 'package:chat_app_with_ai/feature/auth/login/ui/login_screen.dart';
import 'package:chat_app_with_ai/feature/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  Future<Widget> _getInitialScreen() async {
    final authStorage = AuthLocalStorage();
    final isLoggedIn = await authStorage.isLoggedIn();
    if (isLoggedIn) {
      return const HomeScreen();
    } else {
      return BlocProvider(
        create:
            (context) => SigninBloc(
              userRepo: SupabaseUserRepo(supabase: SupabaseConfig.client),
            ),
        child: const LoginScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        home: FutureBuilder<Widget>(
          future: _getInitialScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              return snapshot.data!;
            }
          },
        ),
      ),
    );
  }
}
