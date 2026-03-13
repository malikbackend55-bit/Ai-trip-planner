import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'core/dashboard_provider.dart';
import 'core/theme.dart';
import 'widgets/dashboard_layout.dart';
import 'features/dashboard/overview_view.dart';
import 'features/dashboard/trips_view.dart';
import 'features/dashboard/users_view.dart';
import 'features/analytics/analytics_view.dart';
import 'features/settings/settings_view.dart';

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

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AitpDashboardApp extends StatelessWidget {
  const AitpDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/overview',
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            final String location = state.matchedLocation;
            int selectedIndex = 0;
            String pageTitle = 'Dashboard Overview';

            if (location == '/overview') {
              selectedIndex = 0;
              pageTitle = 'Dashboard Overview';
            } else if (location == '/trips') {
              selectedIndex = 1;
              pageTitle = 'Trip Management';
            } else if (location == '/users') {
              selectedIndex = 2;
              pageTitle = 'User Management';
            } else if (location == '/analytics') {
              selectedIndex = 3;
              pageTitle = 'Advanced Analytics';
            } else if (location == '/settings') {
              selectedIndex = 4;
              pageTitle = 'System Settings';
            }

            return DashboardLayout(
              selectedIndex: selectedIndex,
              pageTitle: pageTitle,
              onIndexChanged: (index) {
                switch (index) {
                  case 0:
                    context.go('/overview');
                    break;
                  case 1:
                    context.go('/trips');
                    break;
                  case 2:
                    context.go('/users');
                    break;
                  case 3:
                    context.go('/analytics');
                    break;
                  case 4:
                    context.go('/settings');
                    break;
                }
              },
              content: child,
            );
          },
          routes: [
            GoRoute(
              path: '/overview',
              builder: (context, state) => const OverviewView(),
            ),
            GoRoute(
              path: '/trips',
              builder: (context, state) => const TripsView(),
            ),
            GoRoute(
              path: '/users',
              builder: (context, state) => const UsersView(),
            ),
            GoRoute(
              path: '/analytics',
              builder: (context, state) => const AnalyticsView(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsView(),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'AITP Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dashTheme,
      routerConfig: router,
    );
  }
}
