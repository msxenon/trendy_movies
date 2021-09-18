import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate_annotations/flutter_translate_annotations.dart';

part 'keys.g.dart';

@TranslateKeysOptions(
    path: 'assets/i18n', caseStyle: CaseStyle.titleCase, separator: "_")
class _$Keys // ignore: unused_element
{}

extension KeysExts on String {
  String get trans => translate(this);
  String transArgs(Map<String, dynamic> args) => translate(this, args: args);
  String transPlural(int num) => translatePlural(this, num);
}
