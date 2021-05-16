import 'dart:convert';
import 'dart:ffi';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

class VotingPair {
  VotingPair({
    this.id,
    this.post1Id,
    this.post2Id,
    this.vote,
  });

  final String? id;
  final String? post1Id;
  final String? post2Id;
  final String? vote;
}

@immutable
class ContentBlock {
  ContentBlock({
    this.id,
    this.votingPairsMap,
    this.categories,
    this.errorCode,
    this.errorMsg,
  });

  final String? id;
  final Map<String, VotingPair>? votingPairsMap;
  final List<String>? categories;
  final String? errorCode;
  final String? errorMsg;

  ContentBlock copyWith({
    String? id,
    Map<String, VotingPair>? votingPairsMap,
    List<String>? categories,
    String? errorCode,
    String? errorMsg,
  }) {
    return ContentBlock(
      id: id ?? this.id,
      votingPairsMap: votingPairsMap ?? this.votingPairsMap,
      categories: categories ?? this.categories,
      errorCode: errorCode ?? this.errorCode,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      votingPairsMap.hashCode ^
      categories.hashCode ^
      errorCode.hashCode ^
      errorMsg.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentBlock &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          votingPairsMap == other.votingPairsMap &&
          categories == other.categories &&
          errorMsg == other.errorMsg &&
          errorCode == other.errorCode;

  @override
  String toString() {
    return 'ContentBlock{ id: $id, errorCode: $errorCode, errorMsg: $errorMsg, }';
  }

  ContentBlockEntity toEntity() {
    return ContentBlockEntity(
      id: id,
      votingPairsMap: json.encode(votingPairsMap),
      categories: categories?.join(',') ?? '',
      errorCode: errorCode,
      errorMsg: errorMsg,
    );
  }

  static ContentBlock fromEntity(ContentBlockEntity entity) {
    // TODO: Get vpm as Map<String, dynamic> using decode
    // TODO: Use the map to build Map<String, VotingPairs>
    dynamic vpm = json.decode(entity.votingPairsMap ?? '');
    var vpList = vpm['value'] as List<dynamic>;
    var result = <String, VotingPair>{};

    for (var vp in vpList) {
      var nvp = VotingPair(
        id: vp[1]['id'].toString(),
        post1Id: vp[1]['post1Id'].toString(),
        post2Id: vp[1]['post2Id'].toString(),
        vote: vp[1]['vote'].toString(),
      );
      result[nvp.id ?? ''] = nvp;
    }

    //print((vpm['value'] as List<dynamic>).length);
    //print(vpm['value'][0][1]['id']);
    //print(vpm['value'][0][1]['post1Id']);
    //print(vpm['value'][0][1]['post2Id']);
    //print(vpm['value'][0][1]['vote']);

    return ContentBlock(
      id: entity.id,
      votingPairsMap: result,
      categories: entity.categories?.split(','),
      errorCode: entity.errorCode,
      errorMsg: entity.errorMsg,
    );
  }
}
