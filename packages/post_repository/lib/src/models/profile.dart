import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Profile {
  Profile({
    this.id,
  });
  final String? id;
  Profile copyWith({
    String? id,
  }) {
    return Profile(
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile && runtimeType == other.runtimeType && id == other.id;

  @override
  String toString() {
    return 'Profile{ id: $id }';
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
    );
  }

  static Profile fromEntity(ProfileEntity entity) {
    return Profile(
      id: entity.id,
    );
  }
}
