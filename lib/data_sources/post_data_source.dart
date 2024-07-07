import 'package:bloc_blog/models/post.dart';

abstract class PostDataSource {
  Future<void> createPost({required Post post});
  Stream<List<Post>> getPosts({required int limit});
  Stream<Post?> getPost({required PostId postId});
  Future<void> updatePost({required Post post});
  Future<void> deletePost({required PostId postId});
}
