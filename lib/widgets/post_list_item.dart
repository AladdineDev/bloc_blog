import 'package:blog/models/post.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title ?? "No title"),
      subtitle: Text(post.description ?? "No description"),
    );
  }
}
