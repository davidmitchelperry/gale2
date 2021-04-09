import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_login/instagram/bloc/bloc.dart';
//import 'package:gale/instagram/instagram.dart';

import 'package:instagram_repository/instagram_repository.dart';

part 'instagram_event.dart';

part 'instagram_state.dart';

class InstagramBloc extends Bloc<InstagramEvent, InstagramState> {
  InstagramBloc({
    required InstagramRepository instagramRepository,
  })   : assert(instagramRepository != null),
        instagramRepository = instagramRepository,
        super(InstagramInit());
  final InstagramRepository instagramRepository;

  @override
  Stream<InstagramState> mapEventToState(InstagramEvent event) async* {
    if (event is LoadInstagram) {
      yield* _mapLoadInstagramToState(event);
    } else if (event is InstagramLoadComplete) {
      yield* _mapInstagramLoadCompleteToState(event);
    }
  }

  Stream<InstagramState> _mapLoadInstagramToState(LoadInstagram event) async* {
    yield InstagramLoading(event.url);
    instagramRepository.setAuthorizationCode(event.url);
    await instagramRepository.getTokenAndUserID().then((isDone) async {
      //print("ACCESS TOKEN: " + (instagram.accessToken ?? "null"));
      List<String> mediasUrls = [];
      if (isDone) {
        await instagramRepository.getUserProfile().then((isDone) async {
          await instagramRepository.getAllMedias().then((mds) async {
            //var medias = mds;
            for (var media in mds) {
              //print(media.url);
              mediasUrls.add(media.url ?? '');
            }
            add(InstagramLoadComplete(event.url, mediasUrls));
          });
        });
      }
    });
  }

  Stream<InstagramState> _mapInstagramLoadCompleteToState(
      InstagramLoadComplete event) async* {
    yield InstagramLoaded(event.url, event.mediasUrls);
  }
}
