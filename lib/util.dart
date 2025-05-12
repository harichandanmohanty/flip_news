import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(BuildContext context, String bodyFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  return GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
}

///
/// all business entertainment general health science sports technology

enum Category {
  all("All"),
  business("Business"),
  entertainment("Entertainment"),
  general("General"),
  health("Health"),
  science("Science"),
  sports("Sports"),
  technology("Technology");

  const Category(this.name);

  final String name;
}
