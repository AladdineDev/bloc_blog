import 'package:blog/models/post.dart';

abstract class PostDataSource {
  Future<void> createPost({required Post post});
  Future<List<Post>> getPosts();
  Future<Post> getPost({required String postId});
  Future<void> updatePost({required Post post});
}
