import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required PostRepository postRepository,
  })   : assert(postRepository != null),
        postRepository = postRepository,
        super(PostInit());
  final PostRepository postRepository;

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    //if (event is LoadInstagramAccessToken) {
    //} else if (event is LoadInstagramMedia) {
    //  yield* _mapLoadInstagramMediaToState(event);
    //} else if (event is LoadInstagramMediaComplete) {
    //  yield* _mapLoadInstagramMediaCompleteToState(event);
    //} else if (event is LoadInstagramAccessToken) {
    //  yield* _mapLoadInstagramAccessTokenToState(event);
    //}
  }
}
