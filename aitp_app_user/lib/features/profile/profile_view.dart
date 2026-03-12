import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/auth_provider.dart';
import '../../core/trip_provider.dart';
import '../../core/theme.dart';
import '../auth/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);
    final user = authProvider.user;
    final tripCount = tripProvider.trips.length;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(user),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildStats(tripCount),
                  const SizedBox(height: 24),
                  _buildMenuSection('Preferences', [
                    _MenuItem(icon: '🎯', title: 'Interests & Hobbies'),
                    _MenuItem(icon: '💰', title: 'Default Budget'),
                    _MenuItem(icon: '🥗', title: 'Dietary Preferences'),
                  ]),
                  const SizedBox(height: 16),
                  _buildMenuSection('Settings', [
                    _MenuItem(icon: '🔔', title: 'Notifications', trailing: const _Toggle(isOn: true)),
                    _MenuItem(icon: '🌙', title: 'Dark Mode', trailing: const _Toggle(isOn: false)),
                    _MenuItem(icon: '🌐', title: 'Language'),
                    _MenuItem(icon: '🔒', title: 'Privacy & Security'),
                  ]),
                  const SizedBox(height: 24),
                  _buildLogoutButton(context, authProvider),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(dynamic user) {
    final name = user?['name'] ?? 'Traveler';
    final email = user?['email'] ?? 'No email';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.g800, AppColors.g700],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.g400, AppColors.g600]),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withOpacity(0.3), width: 4),
              boxShadow: [
                 BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8)),
              ],
            ),
            child: const Center(child: Text('👤', style: TextStyle(fontSize: 40))),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.fraunces(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(fontSize: 12, color: AppColors.g300),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(int tripCount) {
    return Row(
      children: [
        _StatCard(num: tripCount.toString(), label: 'Trips'),
        const SizedBox(width: 8),
        _StatCard(num: '1', label: 'Countries'),
        const SizedBox(width: 8),
        _StatCard(num: '💎', label: 'Premium'),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: AppColors.gray400,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthProvider auth) {
    return GestureDetector(
      onTap: () async {
        await auth.logout();
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginView()),
            (route) => false,
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: const Text(
          '🚪 Logout',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String num;
  final String label;
  const _StatCard({required this.num, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
             BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Text(
              num,
              style: GoogleFonts.fraunces(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.g700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.gray400),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? trailing;
  const _MenuItem({required this.icon, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 24, child: Text(icon, style: const TextStyle(fontSize: 18))),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gray700)),
          const Spacer(),
          trailing ?? const Icon(Icons.chevron_right, color: AppColors.gray200, size: 20),
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final bool isOn;
  const _Toggle({required this.isOn});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 20,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isOn ? AppColors.g500 : AppColors.gray200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
