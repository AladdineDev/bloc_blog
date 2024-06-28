import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/exceptions/app_exception.dart';
import 'package:blog/models/post.dart';

class PostRepository {
  PostRepository({required this.remoteDataSource});

  final PostDataSource remoteDataSource;

  Future<List<Post>> readPosts({
    required int startIndex,
    required int limit,
  }) async {
    try {
      final posts = await remoteDataSource.readPosts(
        startIndex: startIndex,
        limit: limit,
      );
      return posts;
    } catch (e) {
      throw const LoadPostsException();
    }
  }
}
