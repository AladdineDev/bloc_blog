import 'package:blog/extensions/build_context_extension.dart';
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
    final borderRadius = BorderRadius.circular(12);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          //TODO: implement this method
        },
        child: ListTile(
          title: Text(
            post.title ?? "No title",
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              post.description ?? "No description",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
