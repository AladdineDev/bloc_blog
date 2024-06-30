import 'dart:math';

import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/exceptions/app_exception.dart';
import 'package:blog/models/post.dart';

class RemotePostDataSource extends PostDataSource {
  RemotePostDataSource() {
    _generatePosts(50);
  }

  final List<Post> _posts = [];

  void _generatePosts([int length = 20]) {
    final random = Random();
    for (int i = 0; i < length; i++) {
      final post = Post(
        id: '$i',
        title: 'Post $i',
        description: 'Bla bla, Blablabla bla.' * (random.nextInt(10) + 1),
      );
      _posts.add(post);
    }
  }

  @override
  Future<void> createPost({required Post post}) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      _posts.add(post);
    } catch (e) {
      throw const CreatePostException();
    }
  }

  @override
  Future<List<Post>> getPosts() async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _posts;
    } catch (e) {
      throw const FetchPostsException();
    }
  }

  @override
  Future<Post> getPost({required String postId}) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _posts.firstWhere((post) => post.id == postId);
    } catch (e) {
      throw const FetchPostException();
    }
  }

  @override
  Future<void> updatePost({required Post post}) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final index = _posts.indexWhere((p) => p.id == post.id);
      _posts[index] = post;
    } catch (e) {
      throw const UpdatePostException();
    }
  }
}
