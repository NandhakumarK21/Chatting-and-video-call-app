import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, Brightness>(
  (ref) => ThemeNotifier(),
  name: (ThemeNotifier).toString(),
);

class ThemeNotifier extends StateNotifier<Brightness> {
  ThemeNotifier() : super(_systemBrightness);

  static Brightness get _systemBrightness {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  void toggle() {
    state = state == Brightness.dark ? Brightness.light : Brightness.dark;
  }
}

// Blue and white theme
const kPrimaryColor = Color.fromRGBO(0, 122, 255, 1); // Bright blue
const kPrimaryButtonColor = Color.fromRGBO(0, 82, 204, 1); // Custom color for buttons (darker blue)
const kDarkBgColor = Color.fromRGBO(19, 28, 33, 1); // Dark background for dark theme
const kLightBgColor = Color.fromRGBO(255, 255, 255, 1); // White background
const kTextHighlightColor = Color.fromRGBO(0, 122, 255, 1); // Blue for highlighted text
const kDarkAppBarColor = Color.fromRGBO(31, 44, 52, 1); // Dark blue-grey app bar
const kUnselectedLabelColor = Color.fromRGBO(190, 196, 201, 1); // Grey for unselected labels
const kReceiverMessageColorDark = Color.fromRGBO(37, 45, 49, 1); // Dark for receiver's messages
const kSenderMessageColorDark = Color.fromRGBO(0, 122, 255, 1); // Bright blue for sender
const kSenderMessageColorLight = Color.fromRGBO(215, 235, 251, 1); // Light blue for sender in light mode
const kDarkTextFieldBgColor = Color.fromRGBO(37, 45, 49, 1); // Dark text field background
const kLightTextFieldBgColor = Color.fromRGBO(240, 240, 240, 1); // Light grey text field background
const kReplyMessageColor = Color.fromRGBO(31, 37, 40, 1); // Dark for reply message background

// Light theme with blue and white, and custom primary button color
final lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: kPrimaryColor,
  ),
  scaffoldBackgroundColor: kLightBgColor, // White background
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor, // Blue app bar
    foregroundColor: Colors.white, // White text and icons
    elevation: 0.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryButtonColor, // Custom primary button color (darker blue)
      elevation: 2.0, // Adjust elevation if necessary
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Optional padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners for buttons
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor, // Blue FAB
  ),
);

// Dark theme with blue and white, and custom primary button color
final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kDarkBgColor, // Dark background
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: Brightness.dark,
  ),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: kDarkAppBarColor, // Dark blue-grey app bar
    foregroundColor: Colors.white, // White text and icons
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: kDarkBgColor, // Dark background for bottom sheets
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2.0,
      backgroundColor: kPrimaryButtonColor, // Custom primary button color (darker blue)
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Optional padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners for buttons
      ),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kDarkTextFieldBgColor, // Dark snack bar
    contentTextStyle: TextStyle(color: Colors.white), // White text in snack bar
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 2.0), // Blue underline for text fields
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor, // Blue FAB
    foregroundColor: Colors.white, // White icon on FAB
  ),
);
