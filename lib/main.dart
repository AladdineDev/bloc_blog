import 'package:blog/bloc/post_bloc.dart';
import 'package:blog/data_sources/remote_post_data_source.dart';
import 'package:blog/extensions/build_context_extension.dart';
import 'package:blog/models/post.dart';
import 'package:blog/repositories/post_repository.dart';
import 'package:blog/screens/page_not_found_screen.dart';
import 'package:blog/screens/post_detail_screen.dart';
import 'package:blog/screens/post_form_screen.dart';
import 'package:blog/screens/post_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(
        remoteDataSource: RemotePostDataSource(),
      ),
      child: BlocProvider(
        create: (context) => PostBloc(
          postRepository: context.postRepository,
        )..add(GetAllPosts()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            PostListScreen.routePath: (context) => const PostListScreen(),
            PostFormScreen.routePath: (context) => const PostFormScreen(),
          },
          onGenerateRoute: (settings) {
            Widget screen = const PageNotFoundScreen();
            switch (settings.name) {
              case PostDetailScreen.routePath:
                final arguments = settings.arguments;
                if (arguments is Post) {
                  screen = PostDetailScreen(post: arguments);
                }
                break;
            }
            return MaterialPageRoute(
              builder: (context) => screen,
            );
          },
          theme: ThemeData(
            listTileTheme: const ListTileThemeData(
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              subtitleTextStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            cardTheme: CardTheme(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
