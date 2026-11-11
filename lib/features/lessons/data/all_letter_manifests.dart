import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/taa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/thaa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/jeem_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/ha_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/kha_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dal_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dhaal_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/raa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/zaay_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/seen_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/sheen_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/saad_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/daad_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/taa_t_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/dhaa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/ayn_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/ghayn_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/faa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/qaaf_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/kaaf_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/laam_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/meem_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/noon_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/haa_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/waaw_manifest.dart';
import 'package:faseeh_kids/features/lessons/data/manifests/yaa_manifest.dart';

/// السجل المركزي الموحّد لجميع مانيفستات الحروف المعتمدة على البيانات (ت → ي)
final List<LetterUnitManifest> allCurriculumManifests = <LetterUnitManifest>[
  taaManifest,
  thaaManifest,
  jeemManifest,
  haManifest,
  khaManifest,
  dalManifest,
  dhaalManifest,
  raaManifest,
  zaayManifest,
  seenManifest,
  sheenManifest,
  saadManifest,
  daadManifest,
  taaTManifest,
  dhaaManifest,
  aynManifest,
  ghaynManifest,
  faaManifest,
  qaafManifest,
  kaafManifest,
  laamManifest,
  meemManifest,
  noonManifest,
  haaManifest,
  waawManifest,
  yaaManifest,
];

/// خريطة الوصول السريع بالرمز العربي للحرف (مع دعم 'هـ' كبديل لـ 'ه')
final Map<String, LetterUnitManifest> manifestByLetter = {
  for (final m in allCurriculumManifests) m.letter: m,
  if (allCurriculumManifests.any((m) => m.letter == 'ه' || m.letter == 'هـ'))
    'هـ': allCurriculumManifests.firstWhere((m) => m.letter == 'ه' || m.letter == 'هـ'),
};

LetterUnitManifest? findManifestForLetter(String letterChar) {
  if (letterChar == 'هـ') return manifestByLetter['ه'] ?? manifestByLetter['هـ'];
  return manifestByLetter[letterChar];
}
