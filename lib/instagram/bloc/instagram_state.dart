part of 'instagram_bloc.dart';

abstract class InstagramState extends Equatable {
  final String helloWorld;

  const InstagramState(this.helloWorld);

  @override
  List<Object> get props => [];
}

class InstagramInit extends InstagramState {
  final String helloWorld;

  const InstagramInit(this.helloWorld) : super(helloWorld);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'InstagramInit { }';
}

class InstagramAtConsentScreen extends InstagramState {
  final String helloWorld;

  const InstagramAtConsentScreen(this.helloWorld) : super(helloWorld);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'InstagramInit { }';
}

class InstagramLoading extends InstagramState {
  final String helloWorld;

  const InstagramLoading(this.helloWorld) : super(helloWorld);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'InstagramLoading {}';
}

class InstagramLoaded extends InstagramState {
  final String helloWorld;

  const InstagramLoaded(this.helloWorld) : super(helloWorld);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'InstagramLoaded {}';
}
