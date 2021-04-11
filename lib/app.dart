import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_firebase_login/instagram/bloc/bloc.dart';
import 'package:instagram_repository/instagram_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/home/home.dart';
import 'package:flutter_firebase_login/login/login.dart';
import 'package:flutter_firebase_login/splash/splash.dart';
import 'package:flutter_firebase_login/theme.dart';
import 'package:post_repository/post_repository.dart';
import 'package:flutter_firebase_login/post/post.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.instagramRepository,
    required this.postRepository,
  })   : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final InstagramRepository instagramRepository;
  final PostRepository postRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: instagramRepository,
        ),
        RepositoryProvider.value(
          value: postRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                  )),
          BlocProvider<InstagramBloc>(
              create: (_) => InstagramBloc(
                    instagramRepository: instagramRepository,
                  )),
          BlocProvider<PostBloc>(
              create: (_) => PostBloc(
                    postRepository: postRepository,
                  )),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator?.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator?.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
