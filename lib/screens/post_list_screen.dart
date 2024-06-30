import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/models/post.dart';
import 'package:blog/screens/post_detail_screen.dart';
import 'package:blog/screens/post_form_screen.dart';
import 'package:blog/widgets/post_list_item.dart';
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
        title: const Text('My notes'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return switch (state.status) {
            PostStatus.fetchingPostList => const Spinner(),
            PostStatus.fetchPostListFailed => Retry(
                errorMessage: state.error.message,
                onPressed: () => context.postBloc.add(GetAllPosts()),
              ),
            _ => _buildListView(context, posts: (state.posts)),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
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
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return PostListItem(
          post: post,
          onTap: () => _onPostListItemTap(context, post: post),
        );
      },
    );
  }

  void _onPostAddButtonTap(BuildContext context) {
    PostFormScreen.navigateTo(context);
  }

  void _onPostListItemTap(BuildContext context, {required Post post}) {
    PostDetailScreen.navigateTo(context, post: post);
  }
}
