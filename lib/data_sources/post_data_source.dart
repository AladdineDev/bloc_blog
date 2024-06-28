import 'package:blog/models/post.dart';

abstract class PostDataSource {
  Future<List<Post>> readPosts(
    int startIndex,
    int limit,
  );
}