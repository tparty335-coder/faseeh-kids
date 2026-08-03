class Story {
  final String id;
  final String title;
  final List<String> pages;
  final int difficultyLevel;

  const Story({
    required this.id,
    required this.title,
    required this.pages,
    required this.difficultyLevel,
  });
}

final List<Story> storiesData = [
  const Story(
    id: 'story_1',
    title: 'الأرنب والسلحفاة',
    difficultyLevel: 1,
    pages: [
      'في غابة جميلة، كان هناك أرنب سريع وسلحفاة بطيئة.',
      'تحدى الأرنب السلحفاة في سباق، وكان واثقاً من الفوز.',
      'نام الأرنب في منتصف الطريق، بينما استمرت السلحفاة في المشي.',
      'فازت السلحفاة بالسباق بفضل مثابرتها وعدم استسلامها.',
    ],
  ),
  const Story(
    id: 'story_2',
    title: 'الصقر فصيح يتعلم',
    difficultyLevel: 2,
    pages: [
      'كان الصقر فصيح يحب أن يطير عالياً في السماء.',
      'في يوم من الأيام، التقى ببومة حكيمة في الغابة.',
      'علمت البومة فصيح الحروف الأبجدية وكلمات جديدة.',
      'أصبح فصيح صقراً ذكياً ومحباً للقراءة.',
    ],
  ),
  const Story(
    id: 'story_3',
    title: 'واحة الحروف',
    difficultyLevel: 1,
    pages: [
      'في وسط الصحراء، توجد واحة سحرية مليئة بالحروف.',
      'كل حرف له شجرة خاصة به، وثمار لذيذة.',
      'يأتي الأطفال لجمع الحروف وتكوين كلمات جميلة.',
      'في واحة الحروف، التعلم دائماً ممتع ومفيد.',
    ],
  ),
];
