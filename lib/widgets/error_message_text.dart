import 'package:blog/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ErrorMessageText extends StatelessWidget {
  const ErrorMessageText(
    this.data, {
    super.key,
    this.textStyle,
    this.alignment = Alignment.center,
  });

  final String data;
  final TextStyle? textStyle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final textColor = context.colorScheme.error;
    final textStyle = this.textStyle ?? context.theme.textTheme.titleMedium;
    return Align(
      alignment: alignment,
      child: Text(
        data,
        textAlign: TextAlign.center,
        style: textStyle?.copyWith(color: textColor),
      ),
    );
  }
}
