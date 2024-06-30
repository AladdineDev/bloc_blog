import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/models/post.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.post,
  });

  final Post post;

  static const routePath = '/post-detail';

  static void navigateTo(BuildContext context, {required Post post}) {
    context.pushNamed(routePath, arguments: post);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("PostDetailScreen"),
      ),
    );
  }
}
