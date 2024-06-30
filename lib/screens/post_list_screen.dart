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
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.fetchingPostList:
              return const Spinner();
            case PostStatus.fetchedPostListWithSuccess:
              if (state.posts.isEmpty) {
                return Center(
                  child: Text(
                    "No posts at the moment",
                    style: context.theme.textTheme.titleMedium,
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = state.posts[index];
                  return PostListItem(
                    post: post,
                    onTap: () => _onPostListItemTap(context, post: post),
                  );
                },
              );
            default:
              return Center(
                child: Retry(
                  errorMessage: state.error.message,
                  onPressed: () => context.postBloc.add(GetAllPosts()),
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        onPressed: () => _onPostAddButtonTap(context),
      ),
    );
  }

  void _onPostAddButtonTap(BuildContext context) {
    PostFormScreen.navigateTo(context);
  }

  void _onPostListItemTap(BuildContext context, {required Post post}) {
    PostDetailScreen.navigateTo(context, post: post);
  }
}
