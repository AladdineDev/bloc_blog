part of 'post_bloc.dart';

enum PostStatus {
  initial,
  progressCreatingPost,
  successCreatingPost,
  errorCreatingPost,
  progressFetchingPostList,
  successFetchingPostList,
  errorFetchingPostList,
  progressFetchingPost,
  successFetchingPost,
  errorFetchingPost,
  progressUpdatingPost,
  successUpdatingPost,
  errorUpdatingPost,
  progressDeletingPost,
  successDeletingPost,
  errorDeletingPost,
}

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.post,
    this.error = const UnknownException(),
  });

  final PostStatus status;
  final List<Post> posts;
  final Post? post;
  final AppException error;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    Post? post,
    AppException? error,
  }) {
    return PostState(
      status: status ?? this.status,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      post: post ?? this.post,
    );
  }

  @override
  List<Object?> get props => [status, posts, post, error];
}
