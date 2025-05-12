import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff864b6e),
      surfaceTint: Color(0xff864b6e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd8ea),
      onPrimaryContainer: Color(0xff6b3455),
      secondary: Color(0xff715764),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffcd9e9),
      onSecondaryContainer: Color(0xff58404c),
      tertiary: Color(0xff80543c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdbca),
      onTertiaryContainer: Color(0xff653d27),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f8),
      onSurface: Color(0xff211a1d),
      onSurfaceVariant: Color(0xff504349),
      outline: Color(0xff827379),
      outlineVariant: Color(0xffd3c2c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362e32),
      inversePrimary: Color(0xfffbb1d8),
      primaryFixed: Color(0xffffd8ea),
      onPrimaryFixed: Color(0xff370728),
      primaryFixedDim: Color(0xfffbb1d8),
      onPrimaryFixedVariant: Color(0xff6b3455),
      secondaryFixed: Color(0xfffcd9e9),
      onSecondaryFixed: Color(0xff291520),
      secondaryFixedDim: Color(0xffdfbecd),
      onSecondaryFixedVariant: Color(0xff58404c),
      tertiaryFixed: Color(0xffffdbca),
      onTertiaryFixed: Color(0xff311302),
      tertiaryFixedDim: Color(0xfff3ba9c),
      onTertiaryFixedVariant: Color(0xff653d27),
      surfaceDim: Color(0xffe5d6db),
      surfaceBright: Color(0xfffff8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f5),
      surfaceContainer: Color(0xfff9eaef),
      surfaceContainerHigh: Color(0xfff3e4e9),
      surfaceContainerHighest: Color(0xffeddfe4),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbb1d8),
      surfaceTint: Color(0xfffbb1d8),
      onPrimary: Color(0xff511d3e),
      primaryContainer: Color(0xff6b3455),
      onPrimaryContainer: Color(0xffffd8ea),
      secondary: Color(0xffdfbecd),
      onSecondary: Color(0xff402a36),
      secondaryContainer: Color(0xff58404c),
      onSecondaryContainer: Color(0xfffcd9e9),
      tertiary: Color(0xfff3ba9c),
      onTertiary: Color(0xff4a2713),
      tertiaryContainer: Color(0xff653d27),
      onTertiaryContainer: Color(0xffffdbca),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff181115),
      onSurface: Color(0xffeddfe4),
      onSurfaceVariant: Color(0xffd3c2c9),
      outline: Color(0xff9c8d93),
      outlineVariant: Color(0xff504349),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeddfe4),
      inversePrimary: Color(0xff864b6e),
      primaryFixed: Color(0xffffd8ea),
      onPrimaryFixed: Color(0xff370728),
      primaryFixedDim: Color(0xfffbb1d8),
      onPrimaryFixedVariant: Color(0xff6b3455),
      secondaryFixed: Color(0xfffcd9e9),
      onSecondaryFixed: Color(0xff291520),
      secondaryFixedDim: Color(0xffdfbecd),
      onSecondaryFixedVariant: Color(0xff58404c),
      tertiaryFixed: Color(0xffffdbca),
      onTertiaryFixed: Color(0xff311302),
      tertiaryFixedDim: Color(0xfff3ba9c),
      onTertiaryFixedVariant: Color(0xff653d27),
      surfaceDim: Color(0xff181115),
      surfaceBright: Color(0xff40373b),
      surfaceContainerLowest: Color(0xff130c10),
      surfaceContainerLow: Color(0xff211a1d),
      surfaceContainer: Color(0xff251e21),
      surfaceContainerHigh: Color(0xff30282b),
      surfaceContainerHighest: Color(0xff3b3236),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );
}