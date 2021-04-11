import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_login/app.dart';
import 'package:flutter_firebase_login/simple_bloc_observer.dart';
import 'package:instagram_repository/instagram_repository.dart';
import 'package:post_repository/post_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    instagramRepository: InstagramRepository(),
    postRepository: FirebasePostRepository(),
  ));
}
