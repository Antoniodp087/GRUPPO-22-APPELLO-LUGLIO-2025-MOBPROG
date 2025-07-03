import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  //ICON COLOR
  static Color iconActivated = Color(0xFF668964);
  static Color iconUnactivated = Color(0xFF757573);
  static Color iconFilled = Color(0xFF668964);

  //TEXT COLOR
  static Color titleAndText = Color(0xFF050A05);
  static Color buttonText = Color(0xFFFAF1E2);

  //BACKGROUND COLOR
  static Color bgCard = Color(0xFFBEE5AA);
  static Color bgButtonNegative = Color(0xFFC57B58);
  static Color bgButtonPositive = Color(0xFF5E975B);

  //TITLE TEXT STYLE
  static TextStyle headLine0 = GoogleFonts.quicksand(
    fontSize: 70,
    fontWeight: FontWeight.bold,
  );
  //SUBTITLE TEXT STYLE
  static TextStyle headLine1 = GoogleFonts.quicksand(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  //CIRCUMSTANTIAL TEXT STYLE
  static TextStyle headLine2 = GoogleFonts.quicksand(
    fontSize: 35,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headLine3 = GoogleFonts.quicksand(
    fontSize: 30,
    fontWeight: FontWeight.normal,
  );

  //BUTTON TEXT STYLE
  static TextStyle button = GoogleFonts.quicksand(
    fontSize: 30,
    color: buttonText,
    fontWeight: FontWeight.bold,
  );

  //MOBILE TITLE TEXT STYLE
  static TextStyle mobileHeadLine0 = GoogleFonts.quicksand(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );
  //MOBILE SUBTITLE TEXT STYLE
  static TextStyle mobileHeadLine1 = GoogleFonts.quicksand(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  //MOBILE CIRCUMSTANTIAL TEXT STYLE
  static TextStyle mobileHeadLine2 = GoogleFonts.quicksand(
    fontSize: 25,
    fontWeight: FontWeight.normal,
  );
  static TextStyle mobileHeadLine3 = GoogleFonts.quicksand(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  //MOBILE BUTTON TEXT STYLE
  static TextStyle mobileButton = GoogleFonts.quicksand(
    fontSize: 20,
    color: buttonText,
    fontWeight: FontWeight.bold,
  );
}
