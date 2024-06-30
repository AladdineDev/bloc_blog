import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/models/post.dart';
import 'package:blog/screens/post_form_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              post.title ?? 'No title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              post.description ?? 'No description',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.edit_outlined),
        label: const Text("Edit post"),
        onPressed: () => _onPostEditButtonTap(context),
      ),
    );
  }

  void _onPostEditButtonTap(BuildContext context) {
    context.pushNamed(PostFormScreen.routePath, arguments: post);
  }
}
