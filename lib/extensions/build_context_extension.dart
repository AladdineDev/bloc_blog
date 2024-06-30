import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;
}

extension TextExtension on BuildContext {
  TextTheme get textTheme => theme.textTheme;
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
  PostBloc get postBloc => read<PostBloc>();
  PostRepository get postRepository => read<PostRepository>();
}
