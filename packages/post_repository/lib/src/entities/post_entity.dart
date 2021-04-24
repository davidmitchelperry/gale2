// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  const PostEntity({
    this.id,
    required this.platform,
    required this.type,
    required this.sourceUrl,
    this.title,
    this.storageUrl,
    this.error,
  });

  final String? id;
  final String platform;
  final String type;
  final String sourceUrl;
  final String? title;
  final String? storageUrl;
  final String? error;

  @override
  List<Object> get props => [
        id ?? '',
        platform,
        type,
        sourceUrl,
        title ?? '',
        storageUrl ?? '',
        error ?? '',
      ];

  @override
  String toString() {
    return 'PostEntity { id: $id, platform: $platform, type: $type, sourceUrl: $sourceUrl, title: $title, storageUrl: $storageUrl, error: $error }';
  }

  Map<String, String> toMap() {
    return {
      'id': id ?? '',
      'platform': platform,
      'type': type,
      'sourceUrl': sourceUrl,
      'title': title ?? '',
      'storageUrl': storageUrl ?? '',
      'error': error ?? '',
    };
  }

  static PostEntity fromMap(Map<String, String> map) {
    return PostEntity(
      id: map['id'],
      platform: map['platform'] ?? '',
      type: map['type'] ?? '',
      sourceUrl: map['sourceUrl'] ?? '',
      title: map['title'] ?? '',
      storageUrl: map['storageUrl'] ?? '',
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
