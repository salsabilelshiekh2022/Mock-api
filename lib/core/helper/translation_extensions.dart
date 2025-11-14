import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

extension TranslationExtension on BuildContext {
  String get welcome => tr('welcome');
  String get arabic => tr('arabic');
  String get english => tr('english');
}
