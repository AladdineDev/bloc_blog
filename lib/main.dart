import 'package:blog/screens/post_detail_screen.dart';
import 'package:blog/screens/post_form_screen.dart';
import 'package:blog/screens/post_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: PostListScreen.routePath,
  routes: [
    GoRoute(
      path: PostListScreen.routePath,
      builder: (context, state) => const PostListScreen(),
    ),
    GoRoute(
      path: PostFormScreen.routePath,
      builder: (context, state) => const PostFormScreen(),
    ),
    GoRoute(
      path: PostDetailScreen.routePath,
      builder: (context, state) {
        final postId = state.pathParameters['postId']!;
        return PostDetailScreen(postId: postId);
      },
    ),
  ],
);
