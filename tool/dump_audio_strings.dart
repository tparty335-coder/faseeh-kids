import 'dart:convert';
import 'dart:io';

import '../lib/data/curriculum_level1_data.dart';

void main() {
  final Map<String, String> audioMap = {};

  // Add diagnostic and hardcoded strings
  audioMap['welcome_greeting'] = "مرحباً بكَ يا صديقي! سأكون مرشدك في واحات التعلم";
  audioMap['map_intro'] = "خريطة المراحل الست. سنبدأ بالمرحلة الأولى: الأصوات القصيرة الفتحة والكسرة والضمة";
  audioMap['diag_q1_instruction'] = "استمع جيداً — أيّ من هذه الكلمات تبدأ بصوت الألف المفتوحة؟";
  audioMap['diag_q2_instruction'] = "ما هو الصوت المضبوط بالفتحة في بداية كلمة أَسَدٌ؟";
  audioMap['diag_q3_instruction'] = "استمع للكلمة إِبِلٌ — ما الحركة في الحرف الأول؟";
  audioMap['diag_q4_instruction'] = "هل يمكن نطق الحرف الساكن وحده في أوّل الكلمة؟";
  audioMap['diag_q5_instruction'] = "دمج المقطعين أَ و كَلَ ينتج كلمة جديدة — ما هي؟";
  audioMap['word_arnab'] = "أَرْنَبٌ";
  audioMap['word_baqara'] = "بَقَرَةٌ";
  audioMap['word_timsah'] = "تِمْسَاحٌ";
  audioMap['word_asad'] = "أَسَدٌ";
  audioMap['word_ibil'] = "إِبِلٌ";
  audioMap['word_akala'] = "أَكَلَ";
  audioMap['word_saala'] = "سَأَلَ";
  audioMap['word_qaraa'] = "قَرَأَ";
  audioMap['answer_fatha'] = "أَ بالفتحة";
  audioMap['answer_kasra'] = "إِ بالكسرة";
  audioMap['answer_damma'] = "أُ بالضمة";
  audioMap['answer_yes'] = "نعم";
  audioMap['answer_no_sukun'] = "لا، يسبقه حرف متحرك";
  audioMap['vowel_fatha'] = "الفتحة";
  audioMap['vowel_kasra'] = "الكسرة";
  audioMap['vowel_damma'] = "الضمة";
  audioMap['correct'] = "ممتاز! إجابة صحيحة";
  audioMap['wrong'] = "حاول مرة أخرى";
  audioMap['session_complete'] = "أحسنت! لقد أتممت الجلسة بنجاح";
  audioMap['streak_milestone'] = "رائع! أنت في سلسلة نجاحات متتالية";
  audioMap['shadda_basic_title'] = "الشدة ّ — أساسي";
  audioMap['shadda_basic_words'] = "قِطّة • حَبّة • بَطّة";
  audioMap['shadda_prof_title'] = "الشدة ّ — مهن";
  audioMap['shadda_prof_words'] = "فَتّاح • كَذّاب • نَجّار";
  audioMap['shadda_comp_title'] = "الشدة ّ — مركب";
  audioMap['shadda_comp_words'] = "مُعَلِّم • سَيّارَة • ثَلّاجَة";
  audioMap['tanwin_f_title'] = "تنوين الفتح ًـ";
  audioMap['tanwin_f_words'] = "بَيْتًا • قَلْبًا • وَرْدًا";
  audioMap['tanwin_k_title'] = "تنوين الكسر ٍـ";
  audioMap['tanwin_k_words'] = "بَيْتٍ • قَلْبٍ • رَجُلٍ";
  audioMap['tanwin_d_title'] = "تنوين الضم ٌـ";
  audioMap['tanwin_d_words'] = "بَيْتٌ • قَلْبٌ • رَجُلٌ";


  final List<String> letters = ['أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي'];
  final Map<String, String> names = {
    'أ': 'alif', 'ب': 'baa', 'ت': 'taa', 'ث': 'tha', 'ج': 'jeem', 'ح': 'haa', 'خ': 'kha', 'د': 'dal', 'ذ': 'dhal', 'ر': 'ra', 'ز': 'za', 'س': 'seen', 'ش': 'sheen', 'ص': 'sad', 'ض': 'dad', 'ط': 'ta2', 'ظ': 'dha2', 'ع': 'ain', 'غ': 'ghain', 'ف': 'fa', 'ق': 'qaf', 'ك': 'kaf', 'ل': 'lam', 'م': 'mim', 'ن': 'nun', 'ه': 'ha', 'و': 'waw', 'ي': 'ya'
  };

  for (var letterStr in letters) {
    var letterData = Level1CurriculumRepository.getLetterData(letterStr);
    final String engName = names[letterStr]!;

    // Letter intro
    audioMap['${engName}_intro'] = "حرف ال${letterData.letterName}، أصواته القصيرة: ${letterData.fathaLesson.letterSound}، ${letterData.kasraLesson.letterSound}، ${letterData.dammaLesson.letterSound}";
    
    // Vowels
    audioMap['${engName}_fatha_rule'] = letterData.fathaLesson.phoneticRule;
    audioMap['${engName}_fatha_sound'] = letterData.fathaLesson.letterSound;
    audioMap['${engName}_kasra_rule'] = letterData.kasraLesson.phoneticRule;
    audioMap['${engName}_kasra_sound'] = letterData.kasraLesson.letterSound;
    audioMap['${engName}_damma_rule'] = letterData.dammaLesson.phoneticRule;
    audioMap['${engName}_damma_sound'] = letterData.dammaLesson.letterSound;

    // Examples
    for (var i = 0; i < letterData.fathaLesson.examples.length; i++) {
       var ex = letterData.fathaLesson.examples[i];
       audioMap['${engName}_fatha_ex_$i'] = ex.word;
    }
    for (var i = 0; i < letterData.kasraLesson.examples.length; i++) {
       var ex = letterData.kasraLesson.examples[i];
       audioMap['${engName}_kasra_ex_$i'] = ex.word;
    }
    for (var i = 0; i < letterData.dammaLesson.examples.length; i++) {
       var ex = letterData.dammaLesson.examples[i];
       audioMap['${engName}_damma_ex_$i'] = ex.word;
    }

    // Syllables
    for (var i = 0; i < letterData.syllableDrills.length; i++) {
       var chunk = letterData.syllableDrills[i];
       audioMap['${engName}_syllable_${i}_p1'] = chunk.part1;
       audioMap['${engName}_syllable_${i}_p2'] = chunk.part2;
       audioMap['${engName}_syllable_${i}_full'] = chunk.ttsAudioText;
    }
  }

  // Restore alif/baa hand-written intros because they are special
  audioMap['alif_intro'] = "حرف الألف، أصعب الحروف وأعظمها. له ثلاثة أصوات: الفتحة أَ، والكسرة إِ، والضمة أُ";
  audioMap['baa_intro'] = "حرف الباء، حرف ساكن تضع فيه شفتيك معاً ثم تفتحهما";

  final file = File('tool/audio_strings.json');
  file.writeAsStringSync(jsonEncode(audioMap));
  
  print('Successfully dumped \${audioMap.length} audio strings.');
}
