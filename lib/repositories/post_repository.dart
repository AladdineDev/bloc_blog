import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/exceptions/app_exception.dart';
import 'package:blog/models/post.dart';

class PostRepository {
  PostRepository({required this.remoteDataSource});

  final PostDataSource remoteDataSource;

  Future<List<Post>> readPosts({
    int start = 0,
    int limit = 20,
  }) async {
    try {
      final posts = await remoteDataSource.readPosts(
        start: start,
        limit: limit,
      );
      return posts;
    } catch (e) {
      throw const LoadPostsException();
    }
  }
}
