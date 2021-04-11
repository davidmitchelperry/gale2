import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_repository/post_repository.dart';
import 'entities/entities.dart';

class FirebasePostRepository implements PostRepository {
  final _profileCollection = FirebaseFirestore.instance.collection('profiles');
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
