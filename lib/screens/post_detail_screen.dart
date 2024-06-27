import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  static const routePath = '/post-detail/:postId';

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
