import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/models/post.dart';
import 'package:blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostFormScreen extends StatelessWidget {
  const PostFormScreen({super.key});

  static const routePath = '/post-form';

  static void navigateTo(BuildContext context) {
    context.pushNamed(routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New note'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: PostForm(),
      ),
    );
  }
}

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _descriptionController,
            maxLines: 10,
            maxLength: 500,
            buildCounter: (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) {
              return Text(
                "$currentLength/$maxLength",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: currentLength == maxLength
                      ? context.colorScheme.error
                      : null,
                ),
              );
            },
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 20),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state.status == PostStatus.createdPostWithSuccess) {
                _showSnackBar(context, 'New post successfully created!');
                context.pop();
              } else if (state.status == PostStatus.createPostFailed) {
                _showSnackBar(context, state.error.message);
              }
            },
            builder: (context, state) {
              return switch (state.status) {
                PostStatus.creatingPost => const ElevatedButton(
                    onPressed: null,
                    child: Spinner(),
                  ),
                _ => ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text('Submit'),
                  )
              };
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    final post = Post(
      id: "51",
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.postBloc.add(CreatePost(post));
  }
}
