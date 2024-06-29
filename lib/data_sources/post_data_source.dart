import 'package:blog/models/post.dart';

abstract class PostDataSource {
  Future<List<Post>> readPosts({
    required int start,
    required int limit,
  });
}
