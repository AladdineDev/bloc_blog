import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/screens/post_form_screen.dart';
import 'package:blog/widgets/error_message_text.dart';
import 'package:blog/widgets/post_list_item.dart';
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
            case PostStatus.fetchingPost:
              return const Spinner();
            case PostStatus.fetchedPostWithSuccess:
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
                  return PostListItem(post: post);
                },
              );
            default:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ErrorMessageText(state.error.message),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => context.postBloc.add(GetAllPosts()),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                  ),
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        onPressed: () => _onFloatingActionButtonTap(context),
      ),
    );
  }

  void _onFloatingActionButtonTap(BuildContext context) {
    PostFormScreen.navigateTo(context);
  }
}
