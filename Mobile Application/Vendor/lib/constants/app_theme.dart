import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //
  ThemeData lightTheme() {
    return ThemeData(
      // fontFamily: GoogleFonts.poppins().fontFamily,
      accentColor: AppColor.accentColor,
      primaryColor: AppColor.primaryColor,
      primaryColorDark: AppColor.primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColor.cursorColor,
      ),
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        headline3: TextStyle(
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      brightness: Brightness.light,
      // CUSTOMIZE showDatePicker Colors
      dialogBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      highlightColor: Colors.grey[400],
    );
  }

  //
  ThemeData darkTheme() {
    return ThemeData(
      // fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      accentColor: AppColor.accentColor,
      primaryColor: AppColor.primaryColor,
      primaryColorDark: AppColor.primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColor.cursorColor,
      ),
      backgroundColor: Colors.grey[850],
      textTheme: TextTheme(
        headline3: TextStyle(
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
      ),
    );
  }
}
