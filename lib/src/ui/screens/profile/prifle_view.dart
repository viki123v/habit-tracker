import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/shared/home_bottom_navbar.dart';
import 'package:habit_tracker/src/ui/core/shared/user_avatar.dart';
import 'package:habit_tracker/src/ui/core/theme/color_palette.dart';
import 'package:habit_tracker/src/ui/core/theme/spacings.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/screens/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: const HomeBottomNavbar(name: ScreenNames.Profile),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(Spacings.spacious),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProfileHeader(viewModel: viewModel),
                  SizedBox(height: Spacings.section),
                  _BalanceCard(points: viewModel.user?.points ?? 0),
                  SizedBox(height: Spacings.section),
                  const Text(
                    "Inventory",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Spacings.tight),
                  _SettingsRow(
                    icon: Icons.inventory_2_outlined,
                    title: "My Items",
                    subtitle: "View your items",
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push("/inventory"),
                  ),
                  SizedBox(height: Spacings.section),
                  const Text(
                    "App Settings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Spacings.tight),
                  _SettingsRow(
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    subtitle: "Daily reminders & weekly reports",
                    trailing: Switch(
                      value: viewModel.notificationsEnabled,
                      onChanged: viewModel.toggleNotifications,
                    ),
                  ),
                  SizedBox(height: Spacings.section),
                  _SettingsRow(
                    icon: Icons.logout,
                    title: "Log out",
                    color: ColorPalette.danger,
                    trailing: Icon(
                      Icons.chevron_right,
                      color: ColorPalette.danger,
                    ),
                    onTap: () async {
                      await viewModel.logout();
                      if (context.mounted) context.go('/');
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.viewModel});

  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    final user = viewModel.user;

    return Column(
      children: [
        Stack(
          children: [
            UserAvatar(imagePath: user?.imageName, size: 90),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: viewModel.pickProfilePicture,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: ColorPalette.primary,
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Spacings.tight),
        Text(
          [user?.name, user?.surname]
              .where((part) => part != null && part.isNotEmpty)
              .join(' '),
        ).heading(),
        Text("Level ${viewModel.level}").caption(),
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: ColorPalette.primary.withAlpha((255 * 0.1).round()),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Spacings.comfortable,
        vertical: Spacings.cozy,
      ),
      child: Row(
        children: [
          Icon(Icons.monetization_on_outlined, color: ColorPalette.primary),
          SizedBox(width: Spacings.tight),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Balance",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "$points Points",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.push("/marketplace"),
            child: const Text("Shop Now"),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.color,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final rowColor = color ?? ColorPalette.primary;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: rowColor),
        title: Text(title, style: TextStyle(color: color)),
        subtitle: subtitle != null ? Text(subtitle!).caption() : null,
        trailing: trailing,
      ),
    );
  }
}
