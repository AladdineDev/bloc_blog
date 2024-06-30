import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/exceptions/app_exception.dart';
import 'package:blog/models/post.dart';

class PostRepository {
  PostRepository({required this.remoteDataSource});

  final PostDataSource remoteDataSource;

  Future<void> createPost({required post}) async {
    try {
      await remoteDataSource.createPost(post: post);
    } catch (e) {
      throw const UpdatePostException();
    }
  }

  Future<List<Post>> readPosts() async {
    try {
      final posts = await remoteDataSource.readPosts();
      return posts;
    } catch (e) {
      throw const ReadPostsException();
    }
  }

  Future<Post> readPost({required postId}) async {
    try {
      return await remoteDataSource.readPost(postId: postId);
    } catch (e) {
      throw const ReadPostsException();
    }
  }

  Future<void> updatePost({required post}) async {
    try {
      await remoteDataSource.updatePost(post: post);
    } catch (e) {
      throw const UpdatePostException();
    }
  }
}
