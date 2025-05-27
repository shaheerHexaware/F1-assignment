import 'package:f1_app/helpers/app_messages.dart';
import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String? message;
  final GestureTapCallback onRetryTap;

  const ErrorComponent({super.key, this.message, required this.onRetryTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: ${message ?? AppMessages.genericErrorMessage}',
            textAlign: TextAlign.center,
            style: TextStyle(color: theme.colorScheme.error),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetryTap,
            child: const Text(AppMessages.retry),
          ),
        ],
      ),
    );
  }
}
