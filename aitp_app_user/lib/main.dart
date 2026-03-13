import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'core/auth_provider.dart';
import 'core/trip_provider.dart';
import 'core/theme.dart';
import 'features/auth/splash_view.dart';
import 'features/main_navigation.dart';
import 'features/auth/login_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/splash',
      refreshListenable: context.read<AuthProvider>(),
      redirect: (context, state) {
        final authProvider = context.read<AuthProvider>();
        final isLoggingIn = state.matchedLocation == '/login';
        final isSplash = state.matchedLocation == '/splash';

        if (isSplash) return null; // Let splash handle itself or timer

        if (!authProvider.isAuthenticated) {
          return isLoggingIn ? null : '/login';
        }

        if (isLoggingIn) {
          return '/home';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const MainNavigation(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI Trip Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.isAuthenticated) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}
