import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/exceptions/app_exception.dart';
import 'package:blog/models/post.dart';

class PostRepository {
  PostRepository({required this.remoteDataSource});

  final PostDataSource remoteDataSource;

  Future<List<Post>> readPosts() async {
    try {
      final posts = await remoteDataSource.readPosts();
      return posts;
    } catch (e) {
      throw const LoadPostsException();
    }
  }
}
