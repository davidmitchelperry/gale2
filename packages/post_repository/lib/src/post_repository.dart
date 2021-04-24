import 'dart:async';
import 'package:post_repository/post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/src/models/models.dart';

abstract class PostRepository {
  //Future<Post> createPost(String userid, Post post);
  Future<Map<String, String>> sendAuthorizedRequest(
      Object body, String subUrl, List<String> responseKeys);

  Future<Post> sendCreatePostRequest(String userid, Post post);

  Future<Profile> sendCreateProfileRequest(String userid);

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
