import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/auth/splash_view.dart';
import 'features/auth/login_view.dart';
import 'features/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Trip Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Initializer(),
    );
  }
}

class Initializer extends StatefulWidget {
  const Initializer({super.key});

  @override
  State<Initializer> createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  void _startApp() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() => _showSplash = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: _showSplash 
        ? const SplashView() 
        : const LoginView(),
    );
  }
}
