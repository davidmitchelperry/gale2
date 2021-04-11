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
    if (event is LoadInstagramAccessToken) {
    } else if (event is LoadInstagramMedia) {
      yield* _mapLoadInstagramMediaToState(event);
    } else if (event is LoadInstagramMediaComplete) {
      yield* _mapLoadInstagramMediaCompleteToState(event);
    } else if (event is LoadInstagramAccessToken) {
      yield* _mapLoadInstagramAccessTokenToState(event);
    }
  }

  Stream<InstagramState> _mapLoadInstagramAccessTokenToState(
      LoadInstagramAccessToken event) async* {}

  Stream<InstagramState> _mapLoadInstagramMediaToState(
      LoadInstagramMedia event) async* {
    yield InstagramLoading(event.url);
    List<String> mediasUrls = [];
    instagramRepository.setAuthorizationCode(event.url);
    await instagramRepository.getTokenAndUserID().then((isDone) async {
      if (isDone) {
        await instagramRepository.getUserProfile().then((isDone) async {
          await instagramRepository.getAllMedias().then((mds) async {
            //var medias = mds;
            for (var media in mds) {
              //print(media.url);
              mediasUrls.add(media.url ?? '');
            }
            add(LoadInstagramMediaComplete(
              event.url,
              mediasUrls,
              instagramRepository.accessTokenExpirationTime!,
            ));
          });
        });
      }
    });
  }

  Stream<InstagramState> _mapLoadInstagramMediaCompleteToState(
      LoadInstagramMediaComplete event) async* {
    yield InstagramLoaded(
      event.url,
      event.mediasUrls,
      event.tokenExpirationTime,
    );
  }
}
