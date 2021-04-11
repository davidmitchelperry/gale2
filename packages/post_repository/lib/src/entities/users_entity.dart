// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UsersEntity extends Equatable {
  final List<String> chatIds;

  const UsersEntity(this.chatIds);

  @override
  List<Object> get props => [chatIds];

  @override
  String toString() {
    return 'UsersEntity { chatIds: $chatIds }';
  }

  static UsersEntity fromSnapshot(DocumentSnapshot snap) {
    List<String> chatIds = [];
    // Parse results from Snapshot
    for (String id in snap.data()?['chatIds']) {
      chatIds.add(id);
    }
    return UsersEntity(
      chatIds,
    );
  }
}
