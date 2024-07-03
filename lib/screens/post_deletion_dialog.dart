import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:bloc_blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDeletionDialog extends StatelessWidget {
  const PostDeletionDialog({
    super.key,
    required this.postId,
  });

  final PostId postId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return switch (state.status) {
          PostStatus.progressDeletingPost => const AlertDialog.adaptive(
              actionsAlignment: MainAxisAlignment.center,
              title: Text(
                "Deletion in progress",
                textAlign: TextAlign.center,
              ),
              content: Padding(
                padding: EdgeInsets.all(24),
                child: Spinner.medium(),
              ),
            ),
          _ => AlertDialog.adaptive(
              actionsAlignment: MainAxisAlignment.center,
              title: const Text(
                "Confirm Deletion",
                textAlign: TextAlign.center,
              ),
              content: const Text(
                "Are you sure you want to delete this post?",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: context.pop,
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => _onDeleteConfirmationButtonPressed(context),
                  child: const Text("Delete"),
                ),
              ],
            )
        };
      },
    );
  }

  _onDeleteConfirmationButtonPressed(BuildContext context) {
    context.postBloc.add(DeletePost(postId));
  }
}
