import 'package:bloc_blog/models/post.dart';

abstract class PostDataSource {
  Future<void> createPost({required Post post});
  Stream<List<Post>> getPosts();
  Stream<Post> getPost({required String postId});
  Future<void> updatePost({required Post post});
}
