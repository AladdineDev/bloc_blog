import 'package:blog/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension NavigatorExtension on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigator.pushNamed(routeName, arguments: arguments);
  }

  void pop() {
    if (_navigator.canPop()) _navigator.pop();
  }
}

extension BlocExtension on BuildContext {
  PostRepository get postRepository => read<PostRepository>();
}
