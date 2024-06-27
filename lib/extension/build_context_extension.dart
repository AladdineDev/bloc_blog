import 'package:flutter/material.dart';

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
