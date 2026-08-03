/// Age groups for Faseeh Kids
/// Each group has different session durations, activity counts,
/// touch target sizes, and text scaling
enum AgeGroup {
  /// أطفال ما قبل المدرسة (3-5 سنوات)
  preschool3to5,

  /// المرحلة الناشئة (6-8 سنوات)
  emerging6to8,

  /// المرحلة المستقلة (9-10 سنوات)
  independent9to10;

  /// Human-readable Arabic label
  String get labelAr {
    switch (this) {
      case AgeGroup.preschool3to5:
        return 'ما قبل المدرسة (٣-٥)';
      case AgeGroup.emerging6to8:
        return 'المرحلة الناشئة (٦-٨)';
      case AgeGroup.independent9to10:
        return 'المرحلة المستقلة (٩-١٠)';
    }
  }

  /// Session duration in minutes
  int get sessionDurationMinutes {
    switch (this) {
      case AgeGroup.preschool3to5:
        return 10;
      case AgeGroup.emerging6to8:
        return 15;
      case AgeGroup.independent9to10:
        return 20;
    }
  }

  /// Number of activities per session
  int get activitiesPerSession {
    switch (this) {
      case AgeGroup.preschool3to5:
        return 3;
      case AgeGroup.emerging6to8:
        return 5;
      case AgeGroup.independent9to10:
        return 7;
    }
  }

  /// Minimum touch target size in logical pixels
  double get touchTargetSize {
    switch (this) {
      case AgeGroup.preschool3to5:
        return 64.0;
      case AgeGroup.emerging6to8:
        return 52.0;
      case AgeGroup.independent9to10:
        return 48.0;
    }
  }

  /// Font scale multiplier (1.0 = base)
  double get fontScale {
    switch (this) {
      case AgeGroup.preschool3to5:
        return 1.25;
      case AgeGroup.emerging6to8:
        return 1.1;
      case AgeGroup.independent9to10:
        return 1.0;
    }
  }

  /// Age range for display
  String get ageRange {
    switch (this) {
      case AgeGroup.preschool3to5:
        return '3-5';
      case AgeGroup.emerging6to8:
        return '6-8';
      case AgeGroup.independent9to10:
        return '9-10';
    }
  }

  /// Create from age value
  static AgeGroup fromAge(int age) {
    if (age <= 5) return AgeGroup.preschool3to5;
    if (age <= 8) return AgeGroup.emerging6to8;
    return AgeGroup.independent9to10;
  }
}
