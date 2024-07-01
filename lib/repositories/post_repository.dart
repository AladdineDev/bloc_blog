import 'package:bloc_blog/data_sources/post_data_source.dart';
import 'package:bloc_blog/exceptions/app_exception.dart';
import 'package:bloc_blog/models/post.dart';

class PostRepository {
  PostRepository({required this.remoteDataSource});

  final PostDataSource remoteDataSource;

  Future<void> createPost({required Post post}) async {
    try {
      await remoteDataSource.createPost(post: post);
    } catch (e) {
      throw const CreatePostException();
    }
  }

  Stream<List<Post>> getPosts() {
    try {
      return remoteDataSource.getPosts();
    } catch (e) {
      throw const FetchPostListException();
    }
  }

  Stream<Post> getPost({required String postId}) {
    try {
      return remoteDataSource.getPost(postId: postId);
    } catch (e) {
      throw const FetchPostException();
    }
  }

  Future<void> updatePost({required Post post}) async {
    try {
      await remoteDataSource.updatePost(post: post);
    } catch (e) {
      throw const UpdatePostException();
    }
  }
}
