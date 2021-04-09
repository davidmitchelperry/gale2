part of 'instagram_bloc.dart';

abstract class InstagramEvent extends Equatable {
  const InstagramEvent();

  @override
  List<Object> get props => [];
}

//class CreateProfile extends ProfileEvent {
//  final Profile profile;
//  final AuthInfo user;
//
//  const CreateProfile(this.profile, this.user);
//
//  @override
//  List<Object> get props => [profile];
//
//  @override
//  String toString() =>
//      'CreateProfile { firstName: $profile.firstName, lastName: $profile.lastName }';
//}
//
//class UpdateProfile extends ProfileEvent {
//  final Profile profile;
//  final AuthInfo user;
//
//  const UpdateProfile(this.profile, this.user);
//
//  @override
//  List<Object> get props => [profile];
//
//  @override
//  String toString() =>
//      'UpdateProfile { firstName: $profile.firstName, lastName: $profile.lastName }';
//}
//
//class LoadProfile extends ProfileEvent {
//  final String userid;
//
//  const LoadProfile(this.userid);
//
//  @override
//  List<Object> get props => [userid];
//
//  @override
//  String toString() => 'ReadProfile { userid: $userid }';
//}
//
//class LoadProfileComplete extends ProfileEvent {
//  final String userid;
//  final Profile profile;
//
//  const LoadProfileComplete(this.userid, this.profile);
//
//  @override
//  List<Object> get props => [userid, profile];
//
//  @override
//  String toString() =>
//      'ReadProfileComplete { userid: $userid, profile: $profile }';
//}

//class DeleteProfile extends ProfileEvent {
//  final  todo;
//
//  const DeleteTodo(this.todo);
//
//  @override
//  List<Object> get props => [todo];
//
//  @override
//  String toString() => 'DeleteTodo { todo: $todo }';
//}
