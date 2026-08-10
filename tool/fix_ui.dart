import 'dart:io';

void main() {
  final screensDir = 'lib/features/onboarding/screens';

  // 1. name_input_screen.dart
  var nameFile = File('$screensDir/name_input_screen.dart');
  var content = nameFile.readAsStringSync();
  content = content.replaceAll('child: Column(', 'child: SingleChildScrollView(\n              child: Column(');
  content = content.replaceAll('const Spacer(),', 'const SizedBox(height: 60),');
  content = content.replaceAll('height: 56,', 'height: 64,');
  content = content.replaceAll('style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),', 'style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),');
  content = content.replaceAll(
      '                ],\n              ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}',
      '                ],\n              ),\n            ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}');
  nameFile.writeAsStringSync(content);

  // 2. age_selection_screen.dart
  var ageFile = File('$screensDir/age_selection_screen.dart');
  content = ageFile.readAsStringSync();
  content = content.replaceAll('fontSize: 32,', 'fontSize: 40,');
  content = content.replaceAll('fontSize: 16,', 'fontSize: 20,');
  content = content.replaceAll('fontSize: 20,', 'fontSize: 24,');
  content = content.replaceAll('height: 56,', 'height: 64,');
  content = content.replaceAll('style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),', 'style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),');
  content = content.replaceAll('child: Column(', 'child: SingleChildScrollView(\n              child: Column(');
  content = content.replaceAll('const Spacer(),', 'const SizedBox(height: 40),');
  content = content.replaceAll(
      '                ],\n              ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}',
      '                ],\n              ),\n            ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}');
  ageFile.writeAsStringSync(content);

  // 3. avatar_selection_screen.dart
  var avatarFile = File('$screensDir/avatar_selection_screen.dart');
  content = avatarFile.readAsStringSync();
  
  var oldAvatars = '''  static const List<_AvatarOption> _avatars = [
    _AvatarOption(icon: Icons.pets, label: 'صقر', color: Colors.amber),
    _AvatarOption(icon: Icons.shield, label: 'أسد', color: Colors.orange),
    _AvatarOption(icon: Icons.terrain, label: 'جمل', color: Colors.brown),
    _AvatarOption(icon: Icons.face, label: 'فصيح', color: Colors.blue),
    _AvatarOption(icon: Icons.eco, label: 'أرنب', color: Colors.green),
    _AvatarOption(icon: Icons.local_fire_department, label: 'ثعلب', color: Colors.deepOrange),
    _AvatarOption(icon: Icons.spa, label: 'دب', color: Colors.teal),
    _AvatarOption(icon: Icons.auto_awesome, label: 'فراشة', color: Colors.purple),
    _AvatarOption(icon: Icons.star, label: 'نجمة', color: Colors.yellow),
  ];''';
  
  var newAvatars = '''  static const List<_AvatarOption> _avatars = [
    _AvatarOption(emoji: '🦅', label: 'صقر', color: Colors.amber),
    _AvatarOption(emoji: '🦁', label: 'أسد', color: Colors.orange),
    _AvatarOption(emoji: '🐪', label: 'جمل', color: Colors.brown),
    _AvatarOption(emoji: '👦', label: 'بطل', color: Colors.blue),
    _AvatarOption(emoji: '🐰', label: 'أرنب', color: Colors.green),
    _AvatarOption(emoji: '🦊', label: 'ثعلب', color: Colors.deepOrange),
    _AvatarOption(emoji: '🐻', label: 'دب', color: Colors.teal),
    _AvatarOption(emoji: '🦋', label: 'فراشة', color: Colors.purple),
    _AvatarOption(emoji: '⭐', label: 'نجمة', color: Colors.yellow),
  ];''';
  
  content = content.replaceAll(oldAvatars, newAvatars);
  content = content.replaceAll('final IconData icon;', 'final String emoji;');
  content = content.replaceAll('const _AvatarOption({required this.icon, required this.label, required this.color});', 'const _AvatarOption({required this.emoji, required this.label, required this.color});');
  content = content.replaceAll('Icon(avatar.icon, size: 28, color: avatar.color)', 'Text(avatar.emoji, style: const TextStyle(fontSize: 28))');
  content = content.replaceAll('fontSize: 32,', 'fontSize: 40,');
  content = content.replaceAll('fontSize: 14,', 'fontSize: 18,');
  content = content.replaceAll('height: 56,', 'height: 64,');
  content = content.replaceAll('style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),', 'style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),');
  avatarFile.writeAsStringSync(content);

  // 4. onboarding_screen.dart
  var onboardingFile = File('$screensDir/onboarding_screen.dart');
  content = onboardingFile.readAsStringSync();
  content = content.replaceAll('height: 56,', 'height: 64,');
  content = content.replaceAll('style: const TextStyle(\n                        fontSize: 20,\n                        fontWeight: FontWeight.w700,\n                      ),', 'style: const TextStyle(\n                        fontSize: 22,\n                        fontWeight: FontWeight.w700,\n                        height: 1.2,\n                      ),');
  content = content.replaceAll('fontSize: 28,', 'fontSize: 36,');
  content = content.replaceAll('fontSize: 16,', 'fontSize: 22,');
  content = content.replaceAll('clamp(140.0, 220.0)', 'clamp(180.0, 320.0)');
  onboardingFile.writeAsStringSync(content);

  // 5. placement_test_screen.dart
  var placementFile = File('$screensDir/placement_test_screen.dart');
  content = placementFile.readAsStringSync();
  content = content.replaceAll('height: 56,', 'height: 64,');
  content = content.replaceAll('style: const TextStyle(\n                        fontSize: 20,\n                        fontWeight: FontWeight.w700,\n                      ),', 'style: const TextStyle(\n                        fontSize: 22,\n                        fontWeight: FontWeight.w700,\n                        height: 1.2,\n                      ),');
  placementFile.writeAsStringSync(content);
}
