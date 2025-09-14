import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardViewModel>(
      converter: (store) => DashboardViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: viewModel.signOut,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome card
                KuiCard.glass(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getRoleIcon(viewModel.userRole),
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back!',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  Text(
                                    viewModel.userEmail,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getRoleDisplayName(viewModel.userRole),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Role-based content
                _buildRoleBasedContent(context, viewModel.userRole),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getRoleIcon(PlatformUserRole role) {
    switch (role) {
      case PlatformUserRole.clientConsumer:
        return Icons.home;
      case PlatformUserRole.clientProfessional:
        return Icons.work;
      case PlatformUserRole.admin:
        return Icons.admin_panel_settings;
      case PlatformUserRole.moderator:
        return Icons.supervisor_account;
      case PlatformUserRole.superAdmin:
        return Icons.security;
    }
  }

  String _getRoleDisplayName(PlatformUserRole role) {
    switch (role) {
      case PlatformUserRole.clientConsumer:
        return 'Customer';
      case PlatformUserRole.clientProfessional:
        return 'Service Provider';
      case PlatformUserRole.admin:
        return 'Administrator';
      case PlatformUserRole.moderator:
        return 'Moderator';
      case PlatformUserRole.superAdmin:
        return 'Super Administrator';
    }
  }

  Widget _buildRoleBasedContent(BuildContext context, PlatformUserRole role) {
    switch (role) {
      case PlatformUserRole.clientConsumer:
        return _buildCustomerContent(context);
      case PlatformUserRole.clientProfessional:
        return _buildProviderContent(context);
      case PlatformUserRole.admin:
      case PlatformUserRole.moderator:
      case PlatformUserRole.superAdmin:
        return _buildAdminContent(context);
    }
  }

  Widget _buildCustomerContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Dashboard',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context,
          'Book a Service',
          'Find and book housekeeping services',
          Icons.cleaning_services,
          Colors.blue,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Book service feature - Coming soon!')),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionCard(
          context,
          'My Bookings',
          'View your scheduled and past services',
          Icons.calendar_today,
          Colors.green,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('My bookings feature - Coming soon!')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProviderContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Provider Dashboard',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context,
          'Available Jobs',
          'Browse and bid on available jobs',
          Icons.work_outline,
          Colors.orange,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Available jobs feature - Coming soon!')),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionCard(
          context,
          'My Profile',
          'Manage your professional profile and ratings',
          Icons.person_outline,
          Colors.purple,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Provider profile feature - Coming soon!')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAdminContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin Dashboard',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context,
          'User Management',
          'Manage users and permissions',
          Icons.people,
          Colors.red,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User management feature - Coming soon!')),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionCard(
          context,
          'System Analytics',
          'View platform metrics and reports',
          Icons.analytics,
          Colors.teal,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Analytics feature - Coming soon!')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardViewModel {
  final String userEmail;
  final PlatformUserRole userRole;
  final VoidCallback signOut;

  const DashboardViewModel({
    required this.userEmail,
    required this.userRole,
    required this.signOut,
  });

  static DashboardViewModel fromStore(Store<AppState> store) {
    final user = store.state.authState.data.fold(
      () => null,
      (user) => user,
    );

    return DashboardViewModel(
      userEmail: user?.email.value ?? 'Unknown',
      userRole: user?.role ?? PlatformUserRole.clientConsumer,
      signOut: () => store.dispatch(const SignOutAction()),
    );
  }
}
