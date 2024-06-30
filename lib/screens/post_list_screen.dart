import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/models/post.dart';
import 'package:blog/screens/post_form_screen.dart';
import 'package:blog/widgets/post_list_view.dart';
import 'package:blog/widgets/retry.dart';
import 'package:blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  static const routePath = '/';

  static void navigateTo(BuildContext context) {
    context.pushNamed(routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return switch (state.status) {
            PostStatus.fetchingPostList => const Spinner.medium(),
            PostStatus.fetchPostListFailed => Retry(
                errorMessage: state.error.message,
                onPressed: () => context.postBloc.add(GetAllPosts()),
              ),
            _ => _buildListView(context, posts: (state.posts)),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.post_add),
        label: const Text("New post"),
        onPressed: () => _onPostAddButtonTap(context),
      ),
    );
  }

  Widget _buildListView(BuildContext context, {required List<Post> posts}) {
    if (posts.isEmpty) {
      return Center(
        child: Text(
          "No posts at the moment",
          style: context.theme.textTheme.titleMedium,
        ),
      );
    }
    return PostListView(posts: posts);
  }

  void _onPostAddButtonTap(BuildContext context) {
    PostFormScreen.navigateTo(context);
  }
}
