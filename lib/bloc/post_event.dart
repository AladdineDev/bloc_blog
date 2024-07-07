part of 'post_bloc.dart';

sealed class PostEvent {}

final class GetOnePost extends PostEvent {
  GetOnePost(this.postId);

  final PostId postId;
}

final class GetAllPosts extends PostEvent {
  GetAllPosts({this.limit = 20});

  final int limit;
}

final class CreatePost extends PostEvent {
  CreatePost(this.post);

  final Post post;
}

final class UpdatePost extends PostEvent {
  UpdatePost(this.post);

  final Post post;
}

class DeletePost extends PostEvent {
  DeletePost(this.postId);
  final PostId postId;
}
