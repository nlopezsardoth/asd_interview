import 'package:flutter/material.dart';

class SeekTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color alertColor;
  final Color cardColor;

  SeekTheme({
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.white,
    this.alertColor = Colors.red,
    this.cardColor = const Color.fromRGBO(
      238,
      238,
      238,
      1,
    ), //Colors.grey.shade200
  });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: secondaryColor,
    textTheme: _textTheme(),
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    appBarTheme: _appBarTheme(),
    cardTheme: _cardTheme(),
    listTileTheme: _listTileTheme(),
  );

  SeekTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? alertColor,
    Color? logoFilterColor,
  }) => SeekTheme(
    primaryColor: primaryColor ?? this.primaryColor,
    secondaryColor: secondaryColor ?? this.secondaryColor,
    alertColor: alertColor ?? this.alertColor,
  );

  TextTheme _textTheme() {
    return TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    ).apply(bodyColor: primaryColor, fontFamily: "Monserrat");
  }

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );

  OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        side: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: secondaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      backgroundColor: secondaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: primaryColor),
    );
  }

  CardTheme _cardTheme() {
    return CardTheme(
      color: cardColor, // Background color
      elevation: 0, // Elevation for depth effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      margin: const EdgeInsets.all(8), // Default margin
    );
  }

  ListTileThemeData _listTileTheme() {
    return ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      tileColor: secondaryColor, // Background color
      iconColor: primaryColor, // Default icon color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
    );
  }
}

final SeekTheme lightTheme = SeekTheme();
