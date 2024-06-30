import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({
    super.key,
    this.appBarTitle = const Text('New post'),
  });

  final Widget appBarTitle;

  static const routePath = '/post-form';

  static void navigateTo(BuildContext context) {
    context.pushNamed(routePath);
  }

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final autovalidateMode = _submitted
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled;
    return Scaffold(
      appBar: AppBar(
        title: widget.appBarTitle,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                autovalidateMode: autovalidateMode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                onChanged: (text) => setState(() => _title = text),
                validator: _isNotEmptyValidator,
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: autovalidateMode,
                keyboardType: TextInputType.text,
                maxLines: 10,
                maxLength: 300,
                buildCounter: buildCounter,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (text) => setState(() => _description = text),
                validator: _isNotEmptyValidator,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget? buildCounter(
    context, {
    required currentLength,
    required isFocused,
    required maxLength,
  }) {
    return Text(
      "$currentLength/$maxLength",
      style: context.textTheme.bodyMedium?.copyWith(
        color: currentLength == maxLength ? context.colorScheme.error : null,
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
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final post = Post(
        id: '50',
        title: _title,
        description: _description,
      );
      context.postBloc.add(CreatePost(post));
    }
  }

  String? _isNotEmptyValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }
}
