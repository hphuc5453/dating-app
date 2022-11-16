import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../extensions/extensions.dart';

class TextUtils {
  static final textHeaderDefault = TextStyle(
      fontFamily: AppConstants.fontFiraSan,
      color: HexColor.fromHex("#cbcbe3"),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  static final textHeaderActive = TextStyle(
      fontFamily: AppConstants.fontFiraSan,
      color: HexColor.fromHex("#7f70f7"),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  static final textProfileInfoTitle = TextStyle(
      fontFamily: AppConstants.fontFiraSan,
      color: HexColor.fromHex("#3e3a6b"),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  static final textProfileInfoDescription = TextStyle(
      fontFamily: AppConstants.fontFiraSan,
      color: HexColor.fromHex("#7f70f7"),
      fontSize: 16,
      fontWeight: FontWeight.normal);
}