import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.onPressed,
    required this.provider,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final SocialAuthProvider provider;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.onSurface,
          side: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _getProviderIcon(),
                  const SizedBox(width: 12),
                  Text(
                    'Continue with ${_getProviderName()}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _getProviderIcon() {
    switch (provider) {
      case SocialAuthProvider.github:
        return const Icon(Icons.code, size: 20);
      case SocialAuthProvider.google:
        return const Icon(Icons.g_mobiledata, size: 20);
      case SocialAuthProvider.apple:
        return const Icon(Icons.apple, size: 20);
    }
  }

  String _getProviderName() {
    switch (provider) {
      case SocialAuthProvider.github:
        return 'GitHub';
      case SocialAuthProvider.google:
        return 'Google';
      case SocialAuthProvider.apple:
        return 'Apple';
    }
  }
}

enum SocialAuthProvider {
  github,
  google,
  apple,
}
