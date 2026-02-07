
import 'package:flutter/material.dart';

// === Adjustable Theme Colors ===
// Change these values to update the app's color palette
const Color kPrimaryColor = Color(0xFFFF9800);
const Color kLightScaffoldBg = Color(0xFFF7F8FA);
const Color kLightAppBarBg = Colors.white;
const Color kLightText = Colors.black;
const Color kLightTextSecondary = Colors.black87;
const Color kDarkScaffoldBg = Color(0xFF202124);
const Color kDarkAppBarBg = Color(0xFF202124);
const Color kDarkText = Colors.white;
const Color kDarkTextSecondary = Colors.white70;


final ThemeData lightTheme = ThemeData(
	brightness: Brightness.light,
	primaryColor: kPrimaryColor,
	scaffoldBackgroundColor: kLightScaffoldBg,
	appBarTheme: AppBarTheme(
		backgroundColor: kLightAppBarBg,
		elevation: 0,
		iconTheme: const IconThemeData(color: kLightText),
		titleTextStyle: const TextStyle(color: kLightText, fontSize: 20, fontWeight: FontWeight.bold),
	),
	colorScheme: ColorScheme.fromSwatch().copyWith(
		secondary: kPrimaryColor,
		brightness: Brightness.light,
	),
	textTheme: const TextTheme(
		bodyLarge: TextStyle(color: kLightText),
		bodyMedium: TextStyle(color: kLightTextSecondary),
	),
);

final ThemeData darkTheme = ThemeData(
	brightness: Brightness.dark,
	primaryColor: kPrimaryColor,
	scaffoldBackgroundColor: kDarkScaffoldBg,
	appBarTheme: AppBarTheme(
		backgroundColor: kDarkAppBarBg,
		elevation: 0,
		iconTheme: const IconThemeData(color: kDarkText),
		titleTextStyle: const TextStyle(color: kDarkText, fontSize: 20, fontWeight: FontWeight.bold),
	),
	colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
		secondary: kPrimaryColor,
		brightness: Brightness.dark,
	),
	textTheme: const TextTheme(
		bodyLarge: TextStyle(color: kDarkText),
		bodyMedium: TextStyle(color: kDarkTextSecondary),
	),
);
