import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'widgets/dashboard_layout.dart';
import 'features/dashboard/overview_view.dart';
import 'features/dashboard/trips_view.dart';

void main() {
  runApp(const AitpDashboardApp());
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
    const _PlaceholderView(title: 'User Management', icon: '👥'),
    const _PlaceholderView(title: 'Advanced Analytics', icon: '📈'),
    const _PlaceholderView(title: 'System Settings', icon: '⚙️'),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      selectedIndex: _selectedIndex,
      onIndexChanged: (index) {
        setState(() => _selectedIndex = index);
      },
      content: _views[_selectedIndex],
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final String title;
  final String icon;
  const _PlaceholderView({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 24),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const Text('Detailed management view coming soon...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
