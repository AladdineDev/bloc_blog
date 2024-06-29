import 'package:blog/exceptions/app_exception.dart';
import 'package:blog/models/post.dart';
import 'package:blog/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<GetAllPosts>(_onGetAllPosts);
  }

  final PostRepository postRepository;

  Future<void> _onGetAllPosts(
      GetAllPosts event, Emitter<PostState> emit) async {
    emit(
      state.copyWith(
        status: PostStatus.loading,
      ),
    );
    try {
      final posts = await postRepository.readPosts();
      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: posts,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.error,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostStatus.error,
          error: const UnknownException(),
        ),
      );
    }
  }
}
