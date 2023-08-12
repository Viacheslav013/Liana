import 'package:flutter/cupertino.dart';

const barBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFDFCFF),
  darkColor: Color(0xFF1A1C1E),
);

const scaffoldBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFDFCFF),
  darkColor: Color(0xFF1A1C1E),
);

const textColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF1A1C1E),
  darkColor: Color(0xFFE2E2E6),
);

const tabOutlineColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF73777F),
  darkColor: Color(0xFF8C9199),
);

final navigationBarBordersColor = const CupertinoDynamicColor.withBrightness(
  color: Color(0xFF526070),
  darkColor: Color(0xFFBAC8DB),
).withOpacity(0.7);

final tabBarBordersColor = const CupertinoDynamicColor.withBrightness(
  color: Color(0xFF526070),
  darkColor: Color(0xFFBAC8DB),
).withOpacity(0.4);

Color getFormBottomSheetSheetBackgroundColor(BuildContext context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.light) {
    return const Color(0xFFF2F2F7);
  }

  return const Color(0xFF1C1C1E);
}

const progressIndicatorColor = Color(0xFF338AD3);

TextStyle getCupertinoListSubtitleTextStyle(BuildContext context) {
  return CupertinoTheme.of(context).textTheme.textStyle.merge(
        TextStyle(
          fontSize: 15,
          color: CupertinoColors.secondaryLabel.resolveFrom(context),
        ),
      );
}

const cupertinoTheme = CupertinoThemeData(
  primaryColor: Color(0xFF338AD3),
  primaryContrastingColor: Color(0xFFFFFFFF),
  barBackgroundColor: barBackgroundColor,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  textTheme: CupertinoTextThemeData(
    primaryColor: Color(0xFF338AD3),
    textStyle: TextStyle(
      inherit: false,
      fontSize: 17,
      letterSpacing: -0.41,
      color: textColor,
    ),
    actionTextStyle: TextStyle(
      inherit: false,
      fontSize: 17,
      letterSpacing: -0.41,
      color: Color(0xFF338AD3),
      decoration: TextDecoration.none,
    ),
    tabLabelTextStyle: TextStyle(
      inherit: false,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
      color: tabOutlineColor,
    ),
    navTitleTextStyle: TextStyle(
      inherit: false,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.41,
      color: textColor,
    ),
    navLargeTitleTextStyle: TextStyle(
      inherit: false,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.41,
      color: textColor,
    ),
    navActionTextStyle: TextStyle(
      inherit: false,
      fontSize: 17,
      letterSpacing: -0.41,
      color: Color(0xFF338AD3),
      decoration: TextDecoration.none,
    ),
    pickerTextStyle: TextStyle(
      inherit: false,
      fontSize: 21,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.6,
      color: textColor,
    ),
    dateTimePickerTextStyle: TextStyle(
      inherit: false,
      fontSize: 21,
      fontWeight: FontWeight.normal,
      color: textColor,
    ),
  ),
);
