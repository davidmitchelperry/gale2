import 'dart:async';
import 'package:post_repository/post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/src/models/models.dart';

abstract class PostRepository {
  Future<Post> createPost(String userid, Post post);
  void sendVerifiedRequest();

  void sendPostRequest(String userid, Post post) {}

  //Stream<Users> users(String userid);

  //Stream<MessageHistory> getChatStream(String myUserId, String theirUserId);

  //Future<void> sendMessage(
  //    String myUserId, String theirUserId, Message message);

  //Stream<Users>

  //Future<void> createNewProfile(Profile profile, User userid);

  //Future<void> updateProfile(Profile profile, User userid);

  //Future<Profile> readProfile(String userid);

//Stream<List<Profile>> friendsList(); Just a thought... Maybe make a friends list repo
}
