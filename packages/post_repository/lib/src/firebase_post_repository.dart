import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_repository/post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'entities/entities.dart';
import 'package:http/http.dart' as http;

class FirebasePostRepository implements PostRepository {
  FirebasePostRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _profileCollection = FirebaseFirestore.instance.collection('profiles');

  void sendPostRequest(String userid, Post post) async {
    await _firebaseAuth.currentUser?.getIdToken().then((idToken) async {
      var headers = {'Authorization': 'Bearer ' + idToken};
      final response = await http.post(
        Uri.parse('http://192.168.1.190:8080/post/'),
        headers: headers,
        body: post.toEntity().toJson(),
      );
      print(response.body);
      //dynamic payload = json.decode(response.body);
      //accessToken = payload['access_token'].toString();
      //userID = payload['user_id'].toString();
    });
    //return AuthInfoResponse(accessToken, userID);
  }

  void sendVerifiedRequest() async {
    await _firebaseAuth.currentUser?.getIdToken().then((idToken) async {
      var headers = {'Authorization': 'Bearer ' + idToken};
      final response = await http.get(
          Uri.parse('https://gale-648cf.uc.r.appspot.com/firebase/'),
          headers: headers);
      print(response.body);
    });
    //final dynamic mediasList = json.decode(responseMedia.body);
  }

  @override
  Future<Post> createPost(String userid, Post post) async {
    late Post result;
    await _profileCollection
        .doc(userid)
        .collection('posts')
        .add(post.toEntity().toJson())
        .then((docRef) {
      result = post.copyWith(id: docRef.id);
    });

    return result;
    //return Post.fromEntity(PostEntity.fromSnapshot(await postResult.get()));
  }
}
