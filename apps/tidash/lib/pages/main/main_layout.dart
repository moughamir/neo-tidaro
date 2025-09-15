import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';

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
    final ThemeData theme = Theme.of(context);
    final l10n = Languist.of(context);
    return Scaffold(
      body: Row(
        children: <Widget>[
          // Side navigation rail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: theme.colorScheme.surface,
            leading: _buildUserProfile(context, theme, l10n),
            trailing: _buildLogoutButton(context, theme, l10n),
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: const Icon(Icons.dashboard_outlined),
                selectedIcon: const Icon(Icons.dashboard),
                label: Text(l10n.dashboard),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.calendar_today_outlined),
                selectedIcon: const Icon(Icons.calendar_today),
                label: Text(l10n.bookings),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.people_outline),
                selectedIcon: const Icon(Icons.people),
                label: Text(l10n.staff),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.verified_user_outlined),
                selectedIcon: const Icon(Icons.verified_user),
                label: Text(l10n.dashboardNavigationKyc),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.fact_check_outlined),
                selectedIcon: const Icon(Icons.fact_check),
                label: Text(l10n.dashboardNavigationBookings),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.supervised_user_circle_outlined),
                selectedIcon: const Icon(Icons.supervised_user_circle),
                label: Text(l10n.dashboardNavigationUsers),
              ),
            ],
          ),
          // Vertical divider
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
          // Main content
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, ThemeData theme, IntlLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              Icons.person,
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Admin',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ThemeData theme, IntlLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: IconButton(
        onPressed: () => _showLogoutDialog(context, l10n),
        icon: Icon(
          Icons.logout,
          color: theme.colorScheme.error,
        ),
        tooltip: l10n.logout,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, IntlLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              StoreProvider.of<AppState>(context, listen: false)
                  .dispatch(const SignOutAction());
            },
            child: Text(
              l10n.logout,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
