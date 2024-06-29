part of 'post_bloc.dart';

sealed class PostEvent {}

final class GetAllPosts extends PostEvent {}

final class GetOnePost extends PostEvent {
  GetOnePost(this.postId);

  final String postId;
}

final class AddPost extends PostEvent {
  AddPost(this.post);

  final Post post;
}

final class UpdatePost extends PostEvent {
  UpdatePost(this.post);

  final Post post;
}
