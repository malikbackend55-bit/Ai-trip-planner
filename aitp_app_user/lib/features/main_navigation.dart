import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '../core/theme.dart';
import 'home/home_view.dart';
import 'explore/explore_view.dart';
import 'trips/my_trips_view.dart';
import 'chat/chat_view.dart';
import 'profile/profile_view.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomeView(),
    const ExploreView(),
    const MyTripsView(),
    const ChatView(),
    const ProfileView(),
  ];

  void switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, 'Home', '🏠'),
                _buildNavItem(1, 'Explore', '🔍'),
                _buildNavItem(2, 'My Trips', '✈️'),
                _buildNavItem(3, 'AI Chat', '🤖'),
                _buildNavItem(4, 'Profile', '👤'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String icon) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isActive ? 1.2 : 1.0,
            child: Text(
              icon,
              style: TextStyle(
                fontSize: 22,
                shadows: isActive 
                  ? [Shadow(color: AppColors.g500.withValues(alpha: 0.5), blurRadius: 4)]
                  : null,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isActive ? AppColors.g600 : AppColors.gray400,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 1),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.g500,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
