import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/dashboard_provider.dart';
import '../../core/theme.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  ConsumerState<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> with SingleTickerProviderStateMixin {
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardProvider).refresh();
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(dashboardProvider);

    return FadeTransition(
      opacity: _anim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('User Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              ElevatedButton.icon(
                onPressed: () {
                  _showCreateAdminDialog(context, ref);
                },
                icon: const Icon(Icons.person_add, size: 18),
                label: const Text('Add Admin'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(160, 45), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildUserStatsRow(provider),
          const SizedBox(height: 24),
          _buildSearchBar(provider),
          const SizedBox(height: 16),
          _buildUsersTable(provider),
        ],
      ),
    );
  }

  Widget _buildUserStatsRow(DashboardProvider provider) {
    final totalUsers = provider.users.length.toString();
    final premiumCount = provider.premiumUserCount.toString();
    final activeCount = provider.activeUserCount.toString();
    final adminCount = provider.adminUserCount.toString();

    return Row(
      children: [
        _buildMiniStat('Total Users', totalUsers, Icons.people, AppColors.primary),
        const SizedBox(width: 16),
        _buildMiniStat('Premium', premiumCount, Icons.star, AppColors.accent),
        const SizedBox(width: 16),
        _buildMiniStat('Active', activeCount, Icons.trending_up, AppColors.success),
        const SizedBox(width: 16),
        _buildMiniStat('Admins', adminCount, Icons.admin_panel_settings, AppColors.error),
      ],
    );
  }

  Widget _buildMiniStat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDim)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(DashboardProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => ref.read(dashboardProvider).setUserSearchQuery(value),
              decoration: const InputDecoration(
                icon: Icon(Icons.search, color: AppColors.textDim, size: 20),
                hintText: 'Search users by name or email...',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14, color: AppColors.textDim),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _buildRoleChip('All', provider.userFilter == 'All'),
          _buildRoleChip('Admin', provider.userFilter == 'Admin'),
          _buildRoleChip('Premium', provider.userFilter == 'Premium'),
          _buildRoleChip('User', provider.userFilter == 'User'),
        ],
      ),
    );
  }

  Widget _buildRoleChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppColors.textDim)),
        selected: isSelected,
        onSelected: (_) => ref.read(dashboardProvider).setUserFilter(label),
        selectedColor: AppColors.primary,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border)),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildUsersTable(DashboardProvider provider) {
    final users = provider.filteredUsers;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: provider.isLoading 
        ? const Padding(
            padding: EdgeInsets.all(64.0),
            child: Center(child: CircularProgressIndicator()),
          )
        : users.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: Text('No users match your filters.', style: TextStyle(color: AppColors.textDim))),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 56,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                horizontalMargin: 24,
                columnSpacing: 20,
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain, fontSize: 13),
                columns: const [
                  DataColumn(label: Text('User')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Joined')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: users.map((u) => _buildUserRow(u)).toList(),
              ),
            ),
    );
  }

  DataRow _buildUserRow(dynamic user) {
    final name = user['name'] ?? 'Unknown';
    final email = user['email'] ?? 'No email';
    final role = user['role']?.toString().toUpperCase() ?? 'USER';
    final joined = user['created_at']?.toString().split('T').first ?? 'N/A';

    return DataRow(cells: [
      DataCell(Row(children: [
        CircleAvatar(radius: 14, backgroundColor: AppColors.primary.withValues(alpha: 0.15), child: Text(name[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary))),
        const SizedBox(width: 10),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ])),
      DataCell(Text(email, style: const TextStyle(fontSize: 12, color: AppColors.textDim))),
      DataCell(_buildRoleBadge(role)),
      DataCell(Text(joined, style: const TextStyle(fontSize: 12, color: AppColors.textDim))),
      DataCell(Row(children: [
        IconButton(icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textDim), onPressed: () {
          _showEditRoleDialog(context, ref, user);
        }),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Delete User'),
                content: Text('Are you sure you want to delete $name?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
            if (confirm == true) {
              final id = user['id'];
              if (id != null) {
                final success = await ref.read(dashboardProvider).deleteUser(id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(success ? 'User deleted' : 'Failed to delete user')),
                  );
                }
              }
            }
          },
        ),
      ])),
    ]);
  }

  Widget _buildRoleBadge(String role) {
    Color color;
    switch (role) {
      case 'ADMIN': color = AppColors.error; break;
      case 'PREMIUM': color = AppColors.accent; break;
      default: color = AppColors.textDim;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Text(role, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  void _showCreateAdminDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Admin User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full Name')),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email Address')),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.isEmpty || emailCtrl.text.isEmpty || passCtrl.text.isEmpty) return;
              final success = await ref.read(dashboardProvider).createAdmin(nameCtrl.text, emailCtrl.text, passCtrl.text);
              if (mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Admin created' : 'Failed to create admin')));
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditRoleDialog(BuildContext context, WidgetRef ref, dynamic user) {
    final currentRole = (user['role']?.toString().toLowerCase() == 'admin') ? 'admin' : 'user';
    String selectedRole = currentRole;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Edit Role for ${user['name']}'),
            content: DropdownButtonFormField<String>(
              value: selectedRole,
              items: const [
                DropdownMenuItem(value: 'user', child: Text('User')),
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => selectedRole = val);
              },
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () async {
                  if (selectedRole == currentRole) {
                    Navigator.pop(ctx);
                    return;
                  }
                  final success = await ref.read(dashboardProvider).updateUserRole(user['id'], selectedRole);
                  if (mounted) {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Role updated' : 'Failed to update role')));
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        }
      ),
    );
  }
}
