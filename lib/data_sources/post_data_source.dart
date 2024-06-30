import 'package:blog/models/post.dart';

abstract class PostDataSource {
  Future<void> createPost({required Post post});
  Future<List<Post>> readPosts();
  Future<Post> readPost({required String postId});
  Future<void> updatePost({required Post post});
}
