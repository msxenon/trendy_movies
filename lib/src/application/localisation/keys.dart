import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate_annotations/flutter_translate_annotations.dart';

/// @nodoc for you
part 'keys.g.dart';

/// @nodoc for you
@TranslateKeysOptions(
  path: 'assets/i18n',
  caseStyle: CaseStyle.titleCase,
)

/// @nodoc for you
class _$Keys // ignore: unused_element
{}

extension KeysExts on String {
  String get trans => translate(this);
  String transArgs(Map<String, dynamic> args) => translate(this, args: args);
  String transPlural(int num) => translatePlural(this, num);
}
