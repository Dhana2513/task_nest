import 'package:flutter/material.dart';

import '../extension/box_padding.dart';

abstract class UITextStyle {
  //fontSize 18
  static const title = TextStyle(
    fontSize: BoxPadding.xStandard,
    fontWeight: FontWeight.w700,
  );

  //fontSize 16
  static const subtitle1 = TextStyle(
    fontSize: BoxPadding.standard,
    fontWeight: FontWeight.w700,
  );

  //fontSize 15
  static const subtitle2 = TextStyle(
    fontSize: BoxPadding.xMedium + 1,
    fontWeight: FontWeight.w700,
  );

  //fontSize 14
  static const body = TextStyle(
    fontSize: BoxPadding.xMedium,
    fontWeight: FontWeight.w400,
  );

  //fontSize 16
  static const bodyLarge = TextStyle(
    fontSize: BoxPadding.standard,
    fontWeight: FontWeight.w400,
  );
}
