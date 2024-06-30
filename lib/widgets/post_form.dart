import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key, this.post});

  final Post? post;

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _submitted = false;

  @override
  void initState() {
    final post = widget.post;
    _titleController.text = post?.title ?? '';
    _descriptionController.text = post?.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final autovalidateMode = _submitted
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            autovalidateMode: autovalidateMode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: _isNotEmptyFieldValidator,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _descriptionController,
            autovalidateMode: autovalidateMode,
            keyboardType: TextInputType.text,
            maxLines: 10,
            maxLength: 300,
            buildCounter: _buildCounter,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            validator: _isNotEmptyFieldValidator,
          ),
          const SizedBox(height: 20),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              switch (state.status) {
                case PostStatus.createdPostWithSuccess:
                  _showSnackBar(context, 'New post created!');
                  return context.pop();
                case PostStatus.updatedPostWithSuccess:
                  _showSnackBar(context, 'Post updated!');
                  return context.pop();
                case PostStatus.createPostFailed:
                case PostStatus.updatePostFailed:
                  return _showSnackBar(context, state.error.message);
                default:
              }
            },
            builder: (context, state) {
              return switch (state.status) {
                PostStatus.creatingPost ||
                PostStatus.updatingPost =>
                  const ElevatedButton(
                    onPressed: null,
                    child: Spinner.small(),
                  ),
                _ => ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: Text(post == null ? 'Submit' : 'Save'),
                  )
              };
            },
          ),
        ],
      ),
    );
  }

  Widget? _buildCounter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) {
    return Text(
      "$currentLength/$maxLength",
      style: context.textTheme.bodyMedium?.copyWith(
        color: currentLength == maxLength ? context.colorScheme.error : null,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final post = widget.post;
      if (post == null) {
        final post = Post(
          id: null,
          title: _titleController.text,
          description: _descriptionController.text,
        );
        return context.postBloc.add(CreatePost(post));
      }
      final updatedPost = post.copyWith(
        id: post.id,
        title: _titleController.text,
        description: _descriptionController.text,
      );
      return context.postBloc.add(UpdatePost(updatedPost));
    }
  }

  String? _isNotEmptyFieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }
}
