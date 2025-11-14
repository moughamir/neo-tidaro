import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import '../admin/kyc_review_page.dart';
import '../bookings/bookings_page.dart';
// Pages
import '../dashboard/dashboard_page.dart';
import '../staff/staff_page.dart';
import '../admin/admin_bookings_page.dart';
import '../admin/admin_users_page.dart';

/// Main layout with navigation for TiDash
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const BookingsPage(),
    const StaffPage(),
    const KycReviewPage(),
    const AdminBookingsPage(),
    const AdminUsersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = Languist.of(context);
    return PageScaffold(
      body: Row(
        children: <Widget>[
          // Side navigation rail
          NavigationSidebar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            header: _buildUserProfile(context, l10n),
            footer: _buildLogoutButton(context, l10n),
            destinations: [
              NavigationDestinationInfo(
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: l10n.dashboard,
              ),
              NavigationDestinationInfo(
                icon: Icons.calendar_today_outlined,
                selectedIcon: Icons.calendar_today,
                label: l10n.bookings,
              ),
              NavigationDestinationInfo(
                icon: Icons.people_outline,
                selectedIcon: Icons.people,
                label: l10n.staff,
              ),
              NavigationDestinationInfo(
                icon: Icons.verified_user_outlined,
                selectedIcon: Icons.verified_user,
                label: l10n.dashboardNavigationKyc,
              ),
              NavigationDestinationInfo(
                icon: Icons.fact_check_outlined,
                selectedIcon: Icons.fact_check,
                label: l10n.dashboardNavigationBookings,
              ),
              NavigationDestinationInfo(
                icon: Icons.supervised_user_circle_outlined,
                selectedIcon: Icons.supervised_user_circle,
                label: l10n.dashboardNavigationUsers,
              ),
            ],
          ),
          // Main content
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, IntlLocalizations l10n) {
    return StoreConnector<AppState, User?>(
      converter: (store) => store.state.authState.user,
      builder: (context, user) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
                child: user?.avatarUrl == null
                    ? Text(user?.fullName?.substring(0, 1) ?? 'A')
                    : null,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.fullName ?? 'Admin',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    user?.role.name ?? 'Administrator',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context, IntlLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Button(
        label: l10n.logout,
        onPressed: () => _showLogoutDialog(context, l10n),
        type: ButtonType.secondary,
        icon: Icons.logout,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, IntlLocalizations l10n) {
    showGenericDialog(
      context,
      title: l10n.logout,
      content: Text(l10n.logoutConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        Button(
          label: l10n.logout,
          onPressed: () {
            Navigator.pop(context);
            StoreProvider.of<AppState>(context, listen: false)
                .dispatch(const SignOutAction());
          },
          type: ButtonType.danger,
        ),
      ],
    );
  }
}
