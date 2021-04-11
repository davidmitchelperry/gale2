part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

//class LoadPostAccessToken extends PostEvent {
//  const LoadPostAccessToken();
//  @override
//  List<Object> get props => [];
//}
//
//class LoadPostMedia extends PostEvent {
//  const LoadPostMedia(this.url);
//  final String url;
//  @override
//  List<Object> get props => [url];
//}
//
//class LoadPostMediaComplete extends PostEvent {
//  const LoadPostMediaComplete(
//    this.url,
//    this.mediasUrls,
//    this.tokenExpirationTime,
//  );
//  final String url;
//  final List<String> mediasUrls;
//  final DateTime tokenExpirationTime;
//  @override
//  List<Object> get props => [url, mediasUrls];
//}
