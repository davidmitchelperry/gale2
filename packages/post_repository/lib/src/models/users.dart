import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Users {
  final List<String> chatIds;

  Users({required this.chatIds});

  Users copyWith({List<String>? chatIds}) {
    return Users(
      chatIds: chatIds ?? this.chatIds,
    );
  }

  @override
  int get hashCode => chatIds.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Users &&
          runtimeType == other.runtimeType &&
          chatIds == other.chatIds;

  @override
  String toString() {
    return 'Profile{chatIds: $chatIds}';
  }

  UsersEntity toEntity() {
    return UsersEntity(chatIds);
  }

  static Users fromEntity(UsersEntity entity) {
    return Users(
      chatIds: entity.chatIds,
    );
  }
}
