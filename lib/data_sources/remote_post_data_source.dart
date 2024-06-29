import 'package:blog/data_sources/post_data_source.dart';
import 'package:blog/models/post.dart';

class RemotePostDataSource extends PostDataSource {
  @override
  Future<List<Post>> readPosts({
    required int start,
    required int limit,
  }) async {
    //TODO: remove delay
    await Future.delayed(const Duration(milliseconds: 500));
    final posts = List.generate(100, (index) {
      return Post(
        id: '$index',
        title: 'Post $index',
        description: 'Description for Post $index',
      );
    });
    return posts.skip(start).take(limit).toList();
  }
}
