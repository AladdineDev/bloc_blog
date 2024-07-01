import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/screens/page_not_found_screen.dart';
import 'package:bloc_blog/widgets/post_list_item.dart';
import 'package:flutter/material.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:bloc_blog/screens/post_detail_screen.dart';

class PostListView extends StatelessWidget {
  const PostListView({super.key, required this.posts});

  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
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

  void _onPostListItemTap(BuildContext context, {required Post post}) {
    final postId = post.id;
    if (postId == null) return PageNotFoundScreen.navigateTo(context);
    context.postBloc.add(GetOnePost(postId));
    PostDetailScreen.navigateTo(context, postId: postId);
  }
}
