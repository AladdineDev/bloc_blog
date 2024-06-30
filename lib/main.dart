import 'package:bloc_blog/bloc/post_bloc.dart';
import 'package:bloc_blog/data_sources/remote_post_data_source.dart';
import 'package:bloc_blog/extensions/build_context_extension.dart';
import 'package:bloc_blog/firebase_options.dart';
import 'package:bloc_blog/models/post.dart';
import 'package:bloc_blog/repositories/post_repository.dart';
import 'package:bloc_blog/screens/page_not_found_screen.dart';
import 'package:bloc_blog/screens/post_detail_screen.dart';
import 'package:bloc_blog/screens/post_form_screen.dart';
import 'package:bloc_blog/screens/post_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
              case PostFormScreen.routePath:
                final arguments = settings.arguments;
                if (arguments is Post?) {
                  screen = PostFormScreen(post: arguments);
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
