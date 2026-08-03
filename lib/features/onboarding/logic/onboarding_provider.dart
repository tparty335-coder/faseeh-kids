import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/shared/models/child_profile.dart';

/// Onboarding state
class OnboardingState {
  final AgeGroup? ageGroup;
  final int? avatarIndex;
  final String? childName;
  final String? startingUnit;
  final bool isComplete;

  const OnboardingState({
    this.ageGroup,
    this.avatarIndex,
    this.childName,
    this.startingUnit,
    this.isComplete = false,
  });

  OnboardingState copyWith({
    AgeGroup? ageGroup,
    int? avatarIndex,
    String? childName,
    String? startingUnit,
    bool? isComplete,
  }) {
    return OnboardingState(
      ageGroup: ageGroup ?? this.ageGroup,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      childName: childName ?? this.childName,
      startingUnit: startingUnit ?? this.startingUnit,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

/// Onboarding state notifier — manages the full onboarding flow
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void setAgeGroup(AgeGroup ageGroup) {
    state = state.copyWith(ageGroup: ageGroup);
  }

  void setAvatar(int index) {
    state = state.copyWith(avatarIndex: index);
  }

  void setChildName(String name) {
    state = state.copyWith(childName: name);
  }

  void setStartingUnit(String unit) {
    state = state.copyWith(startingUnit: unit);
  }

  /// Create child profile in Hive and mark onboarding as complete
  /// P4-T013
  Future<ChildProfile> completeOnboarding() async {
    final profile = ChildProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: state.childName ?? 'طفل',
      avatarIndex: state.avatarIndex ?? 0,
      ageGroup: state.ageGroup?.name ?? AgeGroup.preschool3to5.name,
      createdAt: DateTime.now(),
      currentUnit: state.startingUnit ?? 'unit_01_alif',
      totalXP: 0,
    );

    // Save to Hive
    final box = Hive.box(AppConstants.childProfileBox);
    await box.put(profile.id, profile);

    state = state.copyWith(isComplete: true);
    return profile;
  }

  void reset() {
    state = const OnboardingState();
  }
}

/// Riverpod provider for onboarding
final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});
