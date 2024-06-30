import 'package:bloc_blog/widgets/error_message_text.dart';
import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  const Retry({
    super.key,
    this.errorMessage,
    required this.onPressed,
    this.alignment = Alignment.center,
  });

  final String? errorMessage;
  final VoidCallback onPressed;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final errorMessage = this.errorMessage;
    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (errorMessage != null) ...[
            ErrorMessageText(errorMessage),
            const SizedBox(height: 32),
          ],
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
