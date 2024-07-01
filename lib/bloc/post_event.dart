part of 'post_bloc.dart';

sealed class PostEvent {}

final class GetAllPosts extends PostEvent {}

final class GetOnePost extends PostEvent {
  GetOnePost(this.postId);

  final PostId postId;
}

final class CreatePost extends PostEvent {
  CreatePost(this.post);

  final Post post;
}

final class UpdatePost extends PostEvent {
  UpdatePost(this.post);

  final Post post;
}
