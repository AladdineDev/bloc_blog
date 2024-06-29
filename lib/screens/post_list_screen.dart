import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/widgets/error_message_text.dart';
import 'package:blog/widgets/post_list_item.dart';
import 'package:blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  static const routePath = '/posts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Spinner();
            case PostStatus.error:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ErrorMessageText(state.error.message),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => context.postBloc.add(FetchPost()),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                  ),
                ],
              );
            case PostStatus.success:
              if (state.posts.isEmpty) {
                return const Center(
                  child: Text("No posts at the moment"),
                );
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = state.posts[index];
                  return PostListItem(post: post);
                },
              );
          }
        },
      ),
    );
  }
}
