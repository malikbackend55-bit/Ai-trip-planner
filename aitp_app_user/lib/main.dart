import 'package:provider/provider.dart';
import 'core/auth_provider.dart';
import 'core/trip_provider.dart';

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
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (_showSplash) {
      return const SplashView();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: authProvider.isAuthenticated 
        ? const MainNavigation() 
        : const LoginView(),
    );
  }
}
