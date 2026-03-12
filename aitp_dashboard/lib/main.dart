import 'package:provider/provider.dart';
import 'core/dashboard_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: const AitpDashboardApp(),
    ),
  );
}

class AitpDashboardApp extends StatelessWidget {
  const AitpDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AITP Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dashTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _views = [
    const OverviewView(),
    const TripsView(),
    const UsersView(),
    const AnalyticsView(),
    const SettingsView(),
  ];

  final List<String> _pageTitles = [
    'Dashboard Overview',
    'Trip Management',
    'User Management',
    'Advanced Analytics',
    'System Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      selectedIndex: _selectedIndex,
      pageTitle: _pageTitles[_selectedIndex],
      onIndexChanged: (index) {
        setState(() => _selectedIndex = index);
      },
      content: _views[_selectedIndex],
    );
  }
}
