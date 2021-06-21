import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fonts utilities.
/// Make it easier to work with online Google fonts.
///
/// See https://github.com/material-foundation/google-fonts-flutter/issues/35
class FontsUtils {
  static String? fontFamily = GoogleFonts.raleway().fontFamily;

  /// Return main text style for this app.
  static TextStyle mainStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 16.0,
    double? height,
    Color? color,
    Color? backgroundColor,
    TextDecoration? decoration,
  }) {
    if (color == null) {
      return GoogleFonts.raleway(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        decoration: decoration,
        backgroundColor: backgroundColor,
      );
    }

    return GoogleFonts.raleway(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      decoration: decoration,
      backgroundColor: backgroundColor,
    );
  }

  static TextStyle title({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 16.0,
    double? height,
    Color? color,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.pacifico(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      decoration: decoration,
    );
  }
}
