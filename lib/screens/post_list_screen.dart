import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/screens/post_form_screen.dart';
import 'package:bloc_blog/widgets/post_list_view.dart';
import 'package:bloc_blog/widgets/retry.dart';
import 'package:bloc_blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  static const routePath = '/';

  static void navigateTo(BuildContext context) {
    context.pushNamed(routePath);
  }

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return switch (state.status) {
            PostStatus.progressFetchingPostList => const Center(
                child: Spinner.medium(),
              ),
            PostStatus.errorFetchingPostList => Retry(
                errorMessage: state.error.message,
                onPressed: () => context.postBloc.add(GetAllPosts()),
              ),
            _ => const PostListView(),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'from-add-to-delete',
        icon: const Icon(Icons.post_add),
        label: const Text("New post"),
        onPressed: () => _onPostAddButtonTap(context),
      ),
    );
  }

  void _onPostAddButtonTap(BuildContext context) {
    PostFormScreen.navigateTo(context);
  }
}
