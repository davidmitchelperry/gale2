// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    this.id,
    this.error,
  });

  final String? id;
  final String? error;

  @override
  List<Object> get props => [
        id ?? '',
        error ?? '',
      ];

  @override
  String toString() {
    return 'Profile { id: $id, error: $error }';
  }

  Map<String, String> toMap() {
    return {
      'id': id ?? '',
      'error': error ?? '',
    };
  }

  static ProfileEntity fromMap(Map<String, String> map) {
    return ProfileEntity(
      id: map['id'] ?? '',
      error: map['error'] ?? '',
    );
  }

  //static PostEntity fromSnapshot(DocumentSnapshot snap) {
  //  // `snap` is a snapshot for the collection, thus we must index it
  //  return PostEntity(
  //    id: snap.data()?['id'] as String,
  //    platform: snap.data()?['platform'] as String,
  //    type: snap.data()?['type'] as String,
  //    sourceUrl: snap.data()?['sourceUrl'] as String,
  //    title: snap.data()?['title'] as String,
  //    storageUrl: snap.data()?['storageUrl'] as String,
  //  );
  //}
}
