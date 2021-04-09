import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_repository/instagram_repository.dart';
import 'package:flutter_firebase_login/instagram/instagram.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstagramWebView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InstagramWebView());
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final instagramState =
        context.select((InstagramBloc bloc) => bloc.state); // INIT THE WEBVIEW
    return BlocListener<InstagramBloc, InstagramState>(
      listener: (context, state) {
        if (state is InstagramLoaded) {
          Navigator.of(context).pop();
        }
      },
      child: WebView(
        initialUrl: InstagramRepository.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: _controller.complete,
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) async {
          print('Page finished loading: $url');
          if (url.startsWith('https://www.davidmitchelperry.com/auth/')) {
            LoadInstagram(url);
            context.read<InstagramBloc>().add(LoadInstagram(url));
          }
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
