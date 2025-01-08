import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentaion/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';

void main() async{
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseAnonKey, 
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}

