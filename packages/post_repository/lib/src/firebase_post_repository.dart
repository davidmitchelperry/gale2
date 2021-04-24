import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:http/http.dart' as http;
import 'package:post_repository/post_repository.dart';
import 'package:post_repository/src/models/profile.dart';

class FirebasePostRepository implements PostRepository {
  FirebasePostRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _profileCollection = FirebaseFirestore.instance.collection('profiles');

  @override
  Future<Map<String, String>> sendAuthorizedRequest(
    Object toPost,
    String subUrl,
    List<String> responseKeys,
  ) async {
    // Get the user's id token
    var postResponse =
        await _firebaseAuth.currentUser?.getIdToken().then((idToken) async {
      // attach token to the header
      var headers = {'Authorization': 'Bearer ' + idToken};
      if (!subUrl.endsWith('/')) {
        subUrl += '/';
      }
      // Send Post request
      final response = await http.post(
        Uri.parse('http://192.168.1.190:8080/$subUrl'),
        headers: headers,
        body: toPost,
      );
      return response;
    });
    // TODO: This likely needs to be in a try/catch?
    // Decode the response body and build result
    dynamic postObj = json.decode(postResponse?.body ?? '');
    var postResult = <String, String>{};
    for (var key in responseKeys) {
      postResult[key] = postObj[key].toString();
    }
    return postResult;
  }

  @override
  Future<Profile> sendCreateProfileRequest(String userid) async {
    var profile = Profile(
      id: userid,
    );
    var response = await sendAuthorizedRequest(
      profile.toEntity().toMap(),
      'createProfile',
      ['userid'],
    );
    var result = Profile.fromEntity(ProfileEntity.fromMap(response));
    return result;
  }

  @override
  Future<Post> sendCreatePostRequest(String userid, Post post) async {
    var responseKeys = <String>[
      'id',
      'platform',
      'type',
      'sourceUrl',
      'title',
      'storageUrl',
    ];
    var response = await sendAuthorizedRequest(
      post.toEntity().toMap(),
      'post',
      responseKeys,
    );
    var result = Post.fromEntity(PostEntity.fromMap(response));
    print(result);
    return result;
  }

//@override
//Future<Post> createPost(String userid, Post post) async {
//  late Post result;
//  await _profileCollection
//      .doc(userid)
//      .collection('posts')
//      .add(post.toEntity().toJson())
//      .then((docRef) {
//    result = post.copyWith(id: docRef.id);
//  });

//  return result;
//  //return Post.fromEntity(PostEntity.fromSnapshot(await postResult.get()));
//}
}
