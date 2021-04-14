import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/login/cubit/login_cubit.dart';
import 'package:flutter_firebase_login/login/login.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TwitterLoginWebView extends StatelessWidget {
  TwitterLoginWebView(this.authorizationPage);

  final String authorizationPage;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: authorizationPage,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: _controller.complete,
      navigationDelegate: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
        if (url.startsWith('https://www.davidmitchelperry.com/auth/')) {
          final queryParameters = Uri.parse(url).queryParameters;
          final oauthToken = queryParameters['oauth_token'];
          final oauthVerifier = queryParameters['oauth_verifier'];
          //Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false)
          Navigator.of(context).pop<TwitterUserInfo>(
              TwitterUserInfo(oauthToken ?? '', oauthVerifier ?? ''));
        }
      },
      gestureNavigationEnabled: true,
    );
  }
}
