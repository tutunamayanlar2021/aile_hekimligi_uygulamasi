import 'package:flutter/material.dart';

import 'color_constant.dart';

class StyleConstants {
  //static StyleConstants instance = StyleConstants._init();
  //StyleConstants._init();
  final lTitle =
      TextStyle(fontSize: 55, color: ColorConstants.instance.blackBrown);
  final lTitleBlack =
      TextStyle(fontSize: 55, color: ColorConstants.instance.blackBrown);
  final lTitle2 =
      TextStyle(fontSize: 25, color: ColorConstants.instance.blackBrown);
  final mTitle = TextStyle(
      fontSize: 20,
      color: ColorConstants.instance.blackBrown,
      fontWeight: FontWeight.bold);
  final mTitleBlack = TextStyle(
      fontSize: 20,
      color: ColorConstants.instance.black,
      fontWeight: FontWeight.bold);
  final sbTitle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: ColorConstants.instance.flower);
  final sbTitleBrown = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: ColorConstants.instance.blackBrown);
}
