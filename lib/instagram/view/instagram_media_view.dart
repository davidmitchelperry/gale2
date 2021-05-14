import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/instagram/instagram.dart';
import 'package:flutter_firebase_login/post/post.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:post_repository/post_repository.dart';

class InstagramMediaView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InstagramMediaView());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final instagramState =
        context.select((InstagramBloc bloc) => bloc.state); // INIT THE WEBVIEW
    late final List<String> mediasUrls;
    if (instagramState is InstagramInit) {
      mediasUrls = [];
    } else if (instagramState is InstagramLoading) {
      mediasUrls = [];
    } else if (instagramState is InstagramLoaded) {
      mediasUrls = instagramState.mediaUrls;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Media View'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body:
          BlocBuilder<InstagramBloc, InstagramState>(builder: (context, state) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: mediasUrls.length,
            itemBuilder: (BuildContext ctx, index) {
              late Widget newWidget;
              if (instagramState is InstagramInit) {
                newWidget = const CircularProgressIndicator();
              } else if (instagramState is InstagramLoaded) {
                newWidget = Material(
                    child: Center(
                  child: Ink.image(
                    image: CachedNetworkImageProvider(
                      mediasUrls[index],
                    ),
                    fit: BoxFit.contain,
                    child: InkWell(
                      onTap: () {
                        var p = Post(
                          platform: 'instagram',
                          type: 'picture',
                          sourceUrl: mediasUrls[index],
                          categories: "cat1,cat3",
                        );
                        Navigator.of(context).push<Post>(MaterialPageRoute(
                          builder: (context) => PostPage(p),
                        ));
                      },
                    ),
                  ),
                ));
              } else if (instagramState is InstagramLoading) {
                newWidget = const CircularProgressIndicator();
              }
              return newWidget;
            });
      }),
    );
  }
}
