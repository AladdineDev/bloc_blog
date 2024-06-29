import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  static const routePath = '/post-detail/:$postIdPathParameter';
  static const postIdPathParameter = 'postId';

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
