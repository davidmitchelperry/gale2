import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Profile {
  Profile({
    this.id,
    this.error,
  });
  final String? id;
  final String? error;
  Profile copyWith({
    String? id,
    String? error,
  }) {
    return Profile(
      id: id ?? this.id,
      error: error ?? this.error,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          error == other.error;

  @override
  String toString() {
    return 'Profile{ id: $id, error: $error }';
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      error: error,
    );
  }

  static Profile fromEntity(ProfileEntity entity) {
    return Profile(
      id: entity.id,
      error: entity.error,
    );
  }
}
