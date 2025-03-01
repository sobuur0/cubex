import 'package:flutter/material.dart';

class AppColorScheme {
  static const Color primaryOrange = Color(0xFFE57C23);
  static const Color secondaryGreen = Color(0xFF3F7D20);
  static const Color tertiaryRed = Color(0xFFD62828);
  static const Color neutralBrown = Color(0xFF774936);

  static const Color accentYellow = Color(0xFFF4A261);
  static const Color accentBlue = Color(0xFF118AB2);
  static const Color accentPurple = Color(0xFF6A4C93);

  // Light scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryOrange,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFDCC3),
    onPrimaryContainer: Color(0xFF541F00),
    secondary: secondaryGreen,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFC3F0C3),
    onSecondaryContainer: Color(0xFF002201),
    tertiary: tertiaryRed,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFFDAD6),
    onTertiaryContainer: Color(0xFF410002),
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFF8F5),
    onBackground: Color(0xFF251000),
    surface: Color(0xFFFFF8F5),
    onSurface: Color(0xFF251000),
    outline: Color(0xFF85746B),
    outlineVariant: Color(0xFFD7C3B7),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: primaryOrange,
    inverseSurface: Color(0xFF402B1A),
    onInverseSurface: Color(0xFFFFEDE4),
    inversePrimary: Color(0xFFFFB77C),
  );

  // Dark scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB77C),
    onPrimary: Color(0xFF5C2900),
    primaryContainer: Color(0xFF843C00),
    onPrimaryContainer: Color(0xFFFFDCC3),
    secondary: Color(0xFFA8D894),
    onSecondary: Color(0xFF00390E),
    secondaryContainer: Color(0xFF1F531A),
    onSecondaryContainer: Color(0xFFC3F0C3),
    tertiary: Color(0xFFFFB4AB),
    onTertiary: Color(0xFF690006),
    tertiaryContainer: Color(0xFF930010),
    onTertiaryContainer: Color(0xFFFFDAD6),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF251000),
    onBackground: Color(0xFFFFEDE4),
    surface: Color(0xFF251000),
    onSurface: Color(0xFFFFEDE4),
    outline: Color(0xFF9F8D82),
    outlineVariant: Color(0xFF52443B),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB77C),
    inverseSurface: Color(0xFFFFEDE4),
    onInverseSurface: Color(0xFF402B1A),
    inversePrimary: primaryOrange,
  );
}
