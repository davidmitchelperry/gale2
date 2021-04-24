import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Post {
  Post({
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

  Post copyWith({
    String? id,
    String? platform,
    String? type,
    String? sourceUrl,
    String? title,
    String? storageUrl,
    String? error,
  }) {
    return Post(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      type: type ?? this.type,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      title: title ?? this.title,
      storageUrl: storageUrl ?? this.storageUrl,
      error: error ?? this.error,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      platform.hashCode ^
      type.hashCode ^
      sourceUrl.hashCode ^
      title.hashCode ^
      storageUrl.hashCode ^
      error.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          platform == other.platform &&
          type == other.type &&
          sourceUrl == other.sourceUrl &&
          title == other.title &&
          storageUrl == other.storageUrl &&
          error == other.error;

  @override
  String toString() {
    return 'Post{ id: $id, platform: $platform, type: $type, sourceUrl: $sourceUrl, title: $title, storageUrl: $storageUrl, error: $error }';
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      platform: platform,
      type: type,
      sourceUrl: sourceUrl,
      title: title,
      storageUrl: storageUrl,
      error: error,
    );
  }

  static Post fromEntity(PostEntity entity) {
    return Post(
      id: entity.id,
      platform: entity.platform,
      type: entity.type,
      sourceUrl: entity.sourceUrl,
      title: entity.title,
      storageUrl: entity.storageUrl,
      error: entity.error,
    );
  }
}
