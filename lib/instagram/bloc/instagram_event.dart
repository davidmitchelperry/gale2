part of 'instagram_bloc.dart';

abstract class InstagramEvent extends Equatable {
  const InstagramEvent();
  @override
  List<Object> get props => [];
}

class LoadInstagram extends InstagramEvent {
  const LoadInstagram(this.url);
  final String url;
  @override
  List<Object> get props => [url];
}

class InstagramLoadComplete extends InstagramEvent {
  const InstagramLoadComplete(this.url, this.mediasUrls);
  final String url;
  final List<String> mediasUrls;
  @override
  List<Object> get props => [url, mediasUrls];
}
