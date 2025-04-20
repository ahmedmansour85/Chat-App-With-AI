import 'package:chat_app_with_ai/app_view.dart';
import 'package:chat_app_with_ai/config/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SupabaseUserRepo(supabase: SupabaseConfig.client),
      child: const AppView(),
    );
  }
}
