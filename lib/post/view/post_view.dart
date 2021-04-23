import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post_repository/post_repository.dart';
import 'package:flutter_firebase_login/post/post.dart';

class PostPage extends StatelessWidget {
  PostPage(this.post);
  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    var postRepo = context.select((PostBloc bloc) => bloc.postRepository);
    //final post = context.select((PostBloc bloc) => bloc) => bloc.state);
    late final List<String> mediasUrls;
    late final bool hasValidToken;

    print(post.sourceUrl);

    //context.read<PostBloc>()

    //var newWidget = CachedNetworkImage(
    //  imageUrl: post.sourceUrl,
    //  width: 100,
    //  height: 100,
    //);

    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    String? myTitle;

    var mytextbox = TextFormField(
      onChanged: (title) {
        myTitle = title;
      },
      decoration: InputDecoration(
        labelText: 'Set Title',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: (val) {
        if (val?.length == 0) {
          return "Email cannot be empty";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );

    var newWidget = Material(
        child: Center(
      child: Ink.image(
        image: CachedNetworkImageProvider(
          post.sourceUrl,
        ),
        fit: BoxFit.contain,
        height: 200,
        width: 200,
        child: InkWell(
          onTap: () {},
        ),
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
        actions: <Widget>[
          IconButton(
            key: const Key('postPage_logout_iconButton'),
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
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? '', style: textTheme.headline5),
            const SizedBox(height: 4.0),
            Text('title: ${myTitle ?? ''}'),
            const SizedBox(height: 4.0),
            mytextbox,
            //CircularProgressIndicator(),
            //Text('title: ${post.title ?? ''}'),
            const SizedBox(height: 4.0),
            newWidget,
            ElevatedButton.icon(
              label: const Text(
                'POST',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              icon: const Icon(FontAwesomeIcons.piedPiper, color: Colors.white),
              onPressed: () async {
                var p = post.copyWith(
                  title: myTitle,
                );
                postRepo.sendPostRequest(user.id, p);
                //postRepo.sendVerifiedRequest();
                //postRepo
                //var p = post.copyWith(
                //  title: myTitle,
                //);
                //await postRepo.createPost(user.id, p).then((Post p) {
                //  print('Posted: $p');
                //});
              },
            ),
            //CachedNetworkImage(
            //  imageUrl: post.sourceUrl,
            //  width: 100,
            //  height: 100,
            //),
            //Text(post.toString()),
          ],
        ),
      ),
    );
  }
}
