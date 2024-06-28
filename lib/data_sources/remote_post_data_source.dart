import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/models/post.dart';

class RemotePostDataSource extends PostDataSource {
  @override
  Future<List<Post>> readPosts(
    int startIndex,
    int limit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    final posts = List.generate(100, (index) {
      return Post(
        id: '$index',
        title: 'Post $index',
        description: 'Description for Post $index',
      );
    });
    return posts.skip(startIndex).take(limit).toList();
  }
}
