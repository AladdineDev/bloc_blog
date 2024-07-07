part of 'post_bloc.dart';

enum PostStatus {
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
    this.status = PostStatus.progressFetchingPostList,
    this.post,
    this.posts = const [],
    this.error = const UnknownException(),
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final Post? post;
  final List<Post> posts;
  final AppException error;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    Post? post,
    List<Post>? posts,
    AppException? error,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      error: error ?? this.error,
      post: post ?? this.post,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, post, posts, error, hasReachedMax];
}
