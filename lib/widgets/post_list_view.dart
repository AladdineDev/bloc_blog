import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:bloc_blog/screens/page_not_found_screen.dart';
import 'package:bloc_blog/screens/post_detail_screen.dart';
import 'package:bloc_blog/widgets/post_list_placeholder.dart';
import 'package:bloc_blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  final _scrollController = ScrollController();
  static const _pageSize = 20;
  int _fetchLimit = _pageSize;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final posts = context.postBloc.state.posts;
    if (_isBottom && posts.length >= _fetchLimit) {
      _fetchLimit += _pageSize;
      context.postBloc.add(GetAllPosts(limit: _fetchLimit));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.posts.isEmpty) return const PostListPlaceholder();
        return Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.posts.length < _fetchLimit
                ? state.posts.length
                : state.posts.length + 1,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              if (index >= state.posts.length) {
                return const ListTile(
                  title: Spinner.medium(),
                );
              }
              return Card(
                child: InkWell(
                  onTap: () {
                    _onPostListItemTap(context, post: state.posts[index]);
                  },
                  child: ListTile(
                    title: Text(
                      state.posts[index].title ?? "No title",
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        state.posts[index].description ?? "No description",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
