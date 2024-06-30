import 'package:blog/widgets/post_list_item.dart';
import 'package:flutter/material.dart';
import 'package:blog/models/post.dart';
import 'package:blog/screens/post_detail_screen.dart';

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
    PostDetailScreen.navigateTo(context, post: post);
  }
}
