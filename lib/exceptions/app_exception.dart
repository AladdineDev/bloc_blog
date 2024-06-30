sealed class AppException implements Exception {
  const AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

class UnknownException extends AppException {
  const UnknownException()
      : super(
          'unknown-exception',
          'Oops, something went wrong',
        );
}

class CreatePostException extends AppException {
  const CreatePostException()
      : super(
          'create-post-exception',
          'Post publication has failed',
        );
}

class FetchPostListException extends AppException {
  const FetchPostListException()
      : super(
          'fetch-posts-exception',
          'Unable to load posts',
        );
}

class FetchPostException extends AppException {
  const FetchPostException()
      : super(
          'fetch-post-exception',
          'Unable to load this post',
        );
}

class UpdatePostException extends AppException {
  const UpdatePostException()
      : super(
          'update-post-exception',
          'Post update has failed',
        );
}
