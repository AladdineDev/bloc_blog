import 'package:blog/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ErrorMessageText extends StatelessWidget {
  const ErrorMessageText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.titleMedium?.copyWith(
          color: context.colorScheme.error,
        ),
      ),
    );
  }
}
