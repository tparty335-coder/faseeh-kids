import os
import re

def main():
    screens_dir = 'lib/features/onboarding/screens'
    
    # 1. name_input_screen.dart
    name_file = os.path.join(screens_dir, 'name_input_screen.dart')
    with open(name_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Replace Spacer() with Expanded and wrap TextFormField in SingleChildScrollView logic
    # Actually, wrapping the whole Column in SingleChildScrollView is better
    content = content.replace('child: Column(', 'child: SingleChildScrollView(\n              child: Column(')
    content = content.replace('const Spacer(),', 'const SizedBox(height: 60),')
    content = content.replace('height: 56,', 'height: 64,')
    content = content.replace('style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),', 'style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),')
    # Close SingleChildScrollView
    content = content.replace('                ],\n              ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}', '                ],\n              ),\n            ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}')
    with open(name_file, 'w', encoding='utf-8') as f:
        f.write(content)


    # 2. age_selection_screen.dart
    age_file = os.path.join(screens_dir, 'age_selection_screen.dart')
    with open(age_file, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace('fontSize: 32,', 'fontSize: 40,')
    content = content.replace('fontSize: 16,', 'fontSize: 20,')
    content = content.replace('fontSize: 20,', 'fontSize: 24,')
    content = content.replace('height: 56,', 'height: 64,')
    content = content.replace('style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),', 'style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),')
    content = content.replace('child: Column(', 'child: SingleChildScrollView(\n              child: Column(')
    content = content.replace('const Spacer(),', 'const SizedBox(height: 40),')
    content = content.replace('                ],\n              ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}', '                ],\n              ),\n            ),\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}')
    with open(age_file, 'w', encoding='utf-8') as f:
        f.write(content)


    # 3. avatar_selection_screen.dart
    avatar_file = os.path.join(screens_dir, 'avatar_selection_screen.dart')
    with open(avatar_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Replace Icon data with String emojis
    old_avatars = """  static const List<_AvatarOption> _avatars = [
    _AvatarOption(icon: Icons.pets, label: 'صقر', color: Colors.amber),
    _AvatarOption(icon: Icons.shield, label: 'أسد', color: Colors.orange),
    _AvatarOption(icon: Icons.terrain, label: 'جمل', color: Colors.brown),
    _AvatarOption(icon: Icons.face, label: 'فصيح', color: Colors.blue),
    _AvatarOption(icon: Icons.eco, label: 'أرنب', color: Colors.green),
    _AvatarOption(icon: Icons.local_fire_department, label: 'ثعلب', color: Colors.deepOrange),
    _AvatarOption(icon: Icons.spa, label: 'دب', color: Colors.teal),
    _AvatarOption(icon: Icons.auto_awesome, label: 'فراشة', color: Colors.purple),
    _AvatarOption(icon: Icons.star, label: 'نجمة', color: Colors.yellow),
  ];"""
    
    new_avatars = """  static const List<_AvatarOption> _avatars = [
    _AvatarOption(emoji: '🦅', label: 'صقر', color: Colors.amber),
    _AvatarOption(emoji: '🦁', label: 'أسد', color: Colors.orange),
    _AvatarOption(emoji: '🐪', label: 'جمل', color: Colors.brown),
    _AvatarOption(emoji: '👦', label: 'بطل', color: Colors.blue),
    _AvatarOption(emoji: '🐰', label: 'أرنب', color: Colors.green),
    _AvatarOption(emoji: '🦊', label: 'ثعلب', color: Colors.deepOrange),
    _AvatarOption(emoji: '🐻', label: 'دب', color: Colors.teal),
    _AvatarOption(emoji: '🦋', label: 'فراشة', color: Colors.purple),
    _AvatarOption(emoji: '⭐', label: 'نجمة', color: Colors.yellow),
  ];"""
    
    content = content.replace(old_avatars, new_avatars)
    content = content.replace('final IconData icon;', 'final String emoji;')
    content = content.replace('const _AvatarOption({required this.icon, required this.label, required this.color});', 'const _AvatarOption({required this.emoji, required this.label, required this.color});')
    
    # Replace the Icon widget with Text widget for emojis
    content = content.replace('Icon(avatar.icon, size: 28, color: avatar.color)', 'Text(avatar.emoji, style: const TextStyle(fontSize: 28))')
    
    # Fonts and buttons
    content = content.replace('fontSize: 32,', 'fontSize: 40,')
    content = content.replace('fontSize: 14,', 'fontSize: 18,')
    content = content.replace('height: 56,', 'height: 64,')
    content = content.replace('style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),', 'style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),')
    with open(avatar_file, 'w', encoding='utf-8') as f:
        f.write(content)

    # 4. onboarding_screen.dart
    onboarding_file = os.path.join(screens_dir, 'onboarding_screen.dart')
    with open(onboarding_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace('height: 56,', 'height: 64,')
    content = content.replace('style: const TextStyle(\n                        fontSize: 20,\n                        fontWeight: FontWeight.w700,\n                      ),', 'style: const TextStyle(\n                        fontSize: 22,\n                        fontWeight: FontWeight.w700,\n                        height: 1.2,\n                      ),')
    content = content.replace('fontSize: 28,', 'fontSize: 36,')
    content = content.replace('fontSize: 16,', 'fontSize: 22,')
    content = content.replace('clamp(140.0, 220.0)', 'clamp(180.0, 320.0)')
    with open(onboarding_file, 'w', encoding='utf-8') as f:
        f.write(content)
        
if __name__ == '__main__':
    main()
