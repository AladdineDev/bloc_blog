part of 'post_bloc.dart';

enum PostStatus {
  creatingPost,
  createdPostWithSuccess,
  createPostFailed,
  fetchingPostList,
  fetchedPostListWithSuccess,
  fetchPostListFailed,
  fetchingPost,
  fetchedPostWithSuccess,
  fetchPostFailed,
  updatingPost,
  updatedPostWithSuccess,
  updatePostFailed,
}

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.fetchingPost,
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
