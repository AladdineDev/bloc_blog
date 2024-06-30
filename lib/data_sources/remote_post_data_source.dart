import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/models/post.dart';

class RemotePostDataSource extends PostDataSource {
  @override
  Future<void> createPost({required Post post}) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> readPosts() async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    final posts = List.generate(100, (index) {
      return Post(
        id: '$index',
        title: 'Post $index',
        description: 'Description for Post $index',
      );
    });
    return posts;
  }

  @override
  Future<Post> readPost({required String postId}) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost({required Post post}) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    throw UnimplementedError();
  }
}
