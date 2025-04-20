import 'package:bloc/bloc.dart';
import 'package:chat_app_with_ai/app.dart';
import 'package:chat_app_with_ai/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://grgcmmaqlawwzzexbzjo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyZ2NtbWFxbGF3d3p6ZXhiempvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwODkzMzUsImV4cCI6MjA2MDY2NTMzNX0.fXHI20ZmxYtYJJyZtrVrFOqE9l4QFMwDYPjcJi6Dp8A',
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const App());
}
