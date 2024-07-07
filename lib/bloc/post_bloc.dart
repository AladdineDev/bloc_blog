import 'package:bloc_blog/exceptions/app_exception.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:bloc_blog/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<CreatePost>(_onCreatePost);
    on<GetAllPosts>(_onGetAllPosts);
    on<GetOnePost>(_onGetOnePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  final PostRepository postRepository;

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressCreatingPost));
    try {
      final post = event.post;
      await postRepository.createPost(post: post);
      emit(
        state.copyWith(status: PostStatus.successCreatingPost),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorCreatingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorCreatingPost,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onGetAllPosts(
    GetAllPosts event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    if (state.posts.length < event.limit) {
      emit(state.copyWith(hasReachedMax: true));
    }
    try {
      final postsStream = postRepository.getPosts(limit: event.limit);
      return emit.forEach(postsStream, onData: (posts) {
        return state.copyWith(
          status: PostStatus.successFetchingPostList,
          posts: posts,
          hasReachedMax: false,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingPostList,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingPostList,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onGetOnePost(GetOnePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressFetchingPost));
    try {
      final postId = event.postId;
      final postStream = postRepository.getPost(postId: postId);
      return emit.forEach(postStream, onData: (post) {
        if (post == null) {
          return state.copyWith(
            status: PostStatus.successDeletingPost,
            post: null,
          );
        }
        return state.copyWith(
          status: PostStatus.successFetchingPost,
          post: post,
        );
      });
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorFetchingPost,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressUpdatingPost));
    try {
      final post = event.post;
      await postRepository.updatePost(post: post);
      emit(
        state.copyWith(
          status: PostStatus.successUpdatingPost,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorUpdatingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorUpdatingPost,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.progressDeletingPost));
    try {
      final postId = event.postId;
      await postRepository.deletePost(postId: postId);
      emit(
        state.copyWith(
          status: PostStatus.successDeletingPost,
          post: null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorDeletingPost,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.errorDeletingPost,
          error: const UnknownException(),
        ),
      );
    }
  }
}
