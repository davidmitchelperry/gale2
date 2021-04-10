part of 'instagram_bloc.dart';

abstract class InstagramEvent extends Equatable {
  const InstagramEvent();
  @override
  List<Object> get props => [];
}

class LoadInstagramAccessToken extends InstagramEvent {
  const LoadInstagramAccessToken();
  @override
  List<Object> get props => [];
}

class LoadInstagramMedia extends InstagramEvent {
  const LoadInstagramMedia(this.url);
  final String url;
  @override
  List<Object> get props => [url];
}

class LoadInstagramMediaComplete extends InstagramEvent {
  const LoadInstagramMediaComplete(
    this.url,
    this.mediasUrls,
    this.tokenExpirationTime,
  );
  final String url;
  final List<String> mediasUrls;
  final DateTime tokenExpirationTime;
  @override
  List<Object> get props => [url, mediasUrls];
}
