part of 'post_bloc.dart';

enum PostStatus {
  loading,
  success,
  error,
}

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.loading,
    this.posts = const [],
    this.error = const UnknownException(),
  });

  final PostStatus status;
  final List<Post> posts;
  final AppException error;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    AppException? error,
  }) {
    return PostState(
      status: status ?? this.status,
      error: error ?? this.error,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [status, posts, error];
}
