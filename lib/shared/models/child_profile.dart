import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_profile.freezed.dart';
part 'child_profile.g.dart';

/// Represents a child's profile in the app.
/// Each child has a separate profile with their own progress.
@freezed
class ChildProfile with _$ChildProfile {
  const factory ChildProfile({
    /// Unique identifier (UUID) for this child profile.
    required String id,

    /// Child's display name (chosen by parent).
    required String name,

    /// Index of the selected avatar (0-based).
    required int avatarIndex,

    /// Age group string: 'preschool3to5', 'emerging6to8', or 'independent9to10'.
    required String ageGroup,

    /// When the profile was created.
    required DateTime createdAt,

    /// Currently active unit ID (e.g., 'unit_01_alif').
    required String currentUnit,

    /// Total experience points earned across all activities.
    @Default(0) int totalXP,

    /// Timestamp of last sync to Firestore (null = never synced).
    DateTime? lastSyncedAt,
  }) = _ChildProfile;

  factory ChildProfile.fromJson(Map<String, dynamic> json) =>
      _$ChildProfileFromJson(json);
}
