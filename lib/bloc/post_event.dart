part of 'post_bloc.dart';

sealed class PostEvent {}

final class FetchPost extends PostEvent {}

final class AddPost extends PostEvent {
  AddPost(this.post);

  final Post post;
}

final class EditPost extends PostEvent {
  EditPost(this.post);

  final Post post;
}
