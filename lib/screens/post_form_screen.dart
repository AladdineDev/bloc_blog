import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/widgets/post_form.dart';
import 'package:flutter/material.dart';
import 'package:bloc_blog/models/post.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key, this.post});

  final Post? post;

  static const routePath = '/post-form';

  static void navigateTo(BuildContext context, {Post? post}) {
    context.pushNamed(routePath, arguments: post);
  }

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      appBar: AppBar(
        title: Text(post == null ? "New post" : "Edit post"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: PostForm(post: post),
      ),
    );
  }
}
