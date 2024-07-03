import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:bloc_blog/screens/page_not_found_screen.dart';
import 'package:bloc_blog/screens/post_deletion_dialog.dart';
import 'package:bloc_blog/screens/post_form_screen.dart';
import 'package:bloc_blog/widgets/retry.dart';
import 'package:bloc_blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  final PostId postId;

  static const routePath = '/post-detail';

  static void navigateTo(BuildContext context, {required PostId postId}) {
    context.pushNamed(routePath, arguments: postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) => _onDeletedPost(context),
      listenWhen: (previous, current) {
        return current.status == PostStatus.successDeletingPost;
      },
      builder: (context, state) {
        final post = state.post;
        return switch (state.status) {
          PostStatus.progressFetchingPost => Scaffold(
              appBar: _buildAppBar(),
              body: const Spinner.medium(),
            ),
          PostStatus.errorFetchingPost => Scaffold(
              appBar: _buildAppBar(),
              body: Retry(
                errorMessage: state.error.message,
                onPressed: () => context.postBloc.add(GetOnePost(postId)),
              ),
            ),
          _ => Scaffold(
              appBar: _buildAppBar(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      post?.title ?? 'No title',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post?.description ?? 'No description',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    heroTag: null,
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text("Edit post"),
                    onPressed: () => _onPostEditButtonTap(context, post: post),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton.extended(
                    heroTag: null,
                    icon: const Icon(Icons.delete_forever_outlined),
                    label: const Text("Delete post"),
                    onPressed: () => _onDeleteButtonPressed(context),
                  ),
                ],
              ),
            )
        };
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Post Detail'),
    );
  }

  void _onPostEditButtonTap(BuildContext context, {required Post? post}) {
    if (post == null) return PageNotFoundScreen.navigateTo(context);
    PostFormScreen.navigateTo(context, post: post);
  }

  void _onDeleteButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PostDeletionDialog(postId: postId),
    );
  }

  void _onDeletedPost(BuildContext context) {
    if (ModalRoute.of(context)?.isActive == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "The post has been deleted",
          ),
        ),
      );
      Navigator.popUntil(context, (route) {
        return ModalRoute.of(context)?.isActive != true;
      });
    }
  }
}
