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
  }

  final PostRepository postRepository;

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.creatingPost));
    try {
      final post = event.post;
      await postRepository.createPost(post: post);
      emit(
        state.copyWith(status: PostStatus.createdPostWithSuccess),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.createPostFailed,
          error: const UnknownException(),
        ),
      );
    }
  }

  void _onGetAllPosts(
    GetAllPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(status: PostStatus.fetchingPostList));
    try {
      final postsStream = postRepository.getPosts();
      return emit.forEach(
        postsStream,
        onData: (data) {
          return state.copyWith(
            status: PostStatus.fetchedPostListWithSuccess,
            posts: data,
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.fetchPostListFailed,
          error: const UnknownException(),
        ),
      );
    }
  }

  Stream<void> _onGetOnePost(GetOnePost event, Emitter<PostState> emit) async* {
    emit(state.copyWith(status: PostStatus.fetchingPost));
    try {
      final postId = event.postId;
      postRepository.getPost(postId: postId).listen((post) {
        emit(
          state.copyWith(
            status: PostStatus.fetchedPostWithSuccess,
            post: post,
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.fetchPostFailed,
          error: const UnknownException(),
        ),
      );
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.updatingPost));
    try {
      final post = event.post;
      await postRepository.updatePost(post: post);
      emit(
        state.copyWith(
          status: PostStatus.updatedPostWithSuccess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.updatePostFailed,
          error: const UnknownException(),
        ),
      );
    }
  }
}
