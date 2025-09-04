import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui_kit/src/localization/app_localizations.dart';

class GlassyCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurAmount;
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;
  final String? title;
  final String? subtitle;

  const GlassyCard({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.blurAmount = 5.0,
    this.backgroundColor = Colors.white,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor.withValues(alpha: 0.3),
              width: borderWidth,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null && context.mounted)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                    top: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).helloUser(title!),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (subtitle != null && context.mounted)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context).helloUser(subtitle!),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              Padding(padding: const EdgeInsets.all(12.0), child: child),
            ],
          ),
        ),
      ),
    );
  }
}
