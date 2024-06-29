import 'package:blog/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class PostFormScreen extends StatelessWidget {
  const PostFormScreen({super.key});

  static const routePath = '/post-form';

  static void navigateTo(BuildContext context) {
    context.pushNamed(routePath);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("PostFormScreen"),
      ),
    );
  }
}
