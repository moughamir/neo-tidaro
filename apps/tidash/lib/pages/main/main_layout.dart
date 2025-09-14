import 'package:flutter/material.dart';
import 'package:languist/languist.dart';

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
}
