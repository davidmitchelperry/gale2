part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInit extends PostState {
  const PostInit();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostInit { }';
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostLoaded extends PostState {
  const PostLoaded();
}
