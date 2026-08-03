import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentChildProvider = Provider<String>((ref) {
  // Placeholder: Replace with actual Hive box read when models are available
  return 'Child_1'; 
});

final unlockedUnitsProvider = Provider<List<String>>((ref) {
  // First 3 letters unlocked: أ, ب, ت
  return ['أ', 'ب', 'ت'];
});

final currentUnitProvider = Provider<String>((ref) {
  return 'أ';
});

final homeNavIndexProvider = StateProvider<int>((ref) => 0);
