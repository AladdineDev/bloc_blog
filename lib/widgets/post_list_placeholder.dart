import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class PostListPlaceholder extends StatelessWidget {
  const PostListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 80,
            color: context.colorScheme.tertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'No posts available',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some new posts to see them here.',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.tertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
