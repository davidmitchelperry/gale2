import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/post/post.dart';
import 'package:flutter_firebase_login/home/home.dart';
import 'package:flutter_firebase_login/instagram/instagram.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final instagramState =
        context.select((InstagramBloc bloc) => bloc.state); // INIT THE WEBVIEW
    late final List<String> mediasUrls;
    late final bool hasValidToken;
    if (instagramState is InstagramInit) {
      mediasUrls = [];
      hasValidToken = false;
    } else if (instagramState is InstagramLoading) {
      mediasUrls = [];
      hasValidToken = false;
    } else if (instagramState is InstagramLoaded) {
      mediasUrls = instagramState.mediaUrls;
      if (DateTime.now().isBefore(instagramState.tokenExpirationTime)) {
        hasValidToken = true;
      } else {
        hasValidToken = false;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photo),
            const SizedBox(height: 4.0),
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? '', style: textTheme.headline5),
            RaisedButton(
                key: const Key('RB_gotoInstagram'),
                child: const Text('Goto Instagram'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: const Color(0xFFFFD600),
                onPressed: () {
                  if (hasValidToken) {
                    Navigator.of(context).push<void>(
                      InstagramMediaView.route(),
                    );
                  } else {
                    Navigator.of(context).push<void>(
                      InstagramWebView.route(),
                    );
                  }
                }),
            Text(mediasUrls.toString()),
          ],
        ),
      ),
    );
  }
}
