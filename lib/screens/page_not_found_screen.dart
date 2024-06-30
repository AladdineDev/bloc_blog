import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/widgets/error_message_text.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  static const routePath = '/not-found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 32),
            const ErrorMessageText(
              'Oops! The page you are looking for does not exist.',
            ),
          ],
        ),
      ),
    );
  }
}
