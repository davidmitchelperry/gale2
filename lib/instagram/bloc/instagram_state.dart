part of 'instagram_bloc.dart';

abstract class InstagramState extends Equatable {
  const InstagramState();

  @override
  List<Object> get props => [];
}

class InstagramInit extends InstagramState {
  const InstagramInit();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'InstagramInit { }';
}

class InstagramLoading extends InstagramState {
  const InstagramLoading(this.url);
  final String url;
  @override
  List<Object> get props => [url];

  @override
  String toString() => 'InstagramLoading { url: $url }';
}

class InstagramLoaded extends InstagramState {
  const InstagramLoaded(
    this.url,
    this.mediaUrls,
  );

  final String url;
  final List<String> mediaUrls;

  @override
  List<Object> get props => [url, mediaUrls];

  @override
  String toString() => 'InstagramLoaded { url: $url, mediaUrls: $mediaUrls }';
}
