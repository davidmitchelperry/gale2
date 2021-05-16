import 'package:equatable/equatable.dart';

class ContentBlockEntity extends Equatable {
  const ContentBlockEntity({
    this.id,
    this.votingPairsMap,
    this.categories,
    this.errorCode,
    this.errorMsg,
  });

  final String? id;
  final String? votingPairsMap;
  final String? categories;
  final String? errorCode;
  final String? errorMsg;

  @override
  List<Object> get props => [
        id ?? '',
        votingPairsMap ?? '',
        categories ?? '',
        errorCode ?? '',
        errorMsg ?? '',
      ];

  @override
  String toString() {
    return 'ContentBlockEntity { id: $id, votingPairsMap:$votingPairsMap, categories:$categories, errorCode: $errorCode, errorMsg: $errorMsg }';
  }

  Map<String, String> toMap() {
    return {
      'id': id ?? '',
      'votingPairsMap': votingPairsMap ?? '',
      'categories': categories ?? '',
      'errorCode': errorCode ?? '',
      'errorMsg': errorMsg ?? '',
    };
  }

  static ContentBlockEntity fromMap(Map<String, String> map) {
    return ContentBlockEntity(
      id: map['id'],
      votingPairsMap: map['votingPairsMap'] ?? '',
      categories: map['categories'] ?? '',
      errorCode: map['errorCode'] ?? '',
      errorMsg: map['errorMsg'] ?? '',
    );
  }

//static ContentBlockEntity fromSnapshot(DocumentSnapshot snap) {
//  // `snap` is a snapshot for the collection, thus we must index it
//  return ContentBlockEntity(
//    id: snap.data()?['id'] as String,
//    platform: snap.data()?['platform'] as String,
//    type: snap.data()?['type'] as String,
//    sourceUrl: snap.data()?['sourceUrl'] as String,
//    title: snap.data()?['title'] as String,
//    storageUrl: snap.data()?['storageUrl'] as String,
//  );
//}
}
