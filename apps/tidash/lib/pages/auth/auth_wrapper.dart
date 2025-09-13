import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../main/main_layout.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthWrapperViewModel>(
      converter: (Store<AppState> store) =>
          AuthWrapperViewModel.fromStore(store),
      builder: (BuildContext context, AuthWrapperViewModel viewModel) {
        if (viewModel.isAuthenticated) {
          // User is authenticated, show main layout
          return const MainLayout();
        } else {
          // User is not authenticated, show login
          return const LoginPage();
        }
      },
    );
  }
}

class AuthWrapperViewModel {

  factory AuthWrapperViewModel.fromStore(Store<AppState> store) {
    return AuthWrapperViewModel(
      isAuthenticated: store.state.authState.isAuthenticated,
      user: store.state.authState.data.fold(() => null, (User user) => user),
    );
  }
  const AuthWrapperViewModel({
    required this.isAuthenticated,
    required this.user,
  });

  final bool isAuthenticated;
  final User? user;
}
