import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppStyle {
  //ICON COLOR
  static Color iconActivated = Color(0xFF668964);
  static Color iconUnactivated = Color(0xFF757573);
  static Color iconFilled = Color(0xFF668964);

  //TEXT COLOR
  static Color titleAndText = Color(0xFF050A05);
  static Color buttonText = Color(0xFFFAF1E2);
  static Color textAllert = Color(0xFFC57B58);
  static Color analysisTextColor = Color(0xFF668964);

  //BACKGROUND COLOR
  static Color bgCard = Color(0xFFBEE5AA);
  static Color bgButtonNegative = Color(0xFFC57B58);
  static Color bgButtonPositive = Color(0xFF5E975B);

  //ANALYSIS TEXT STYLE
  static TextStyle analysisTitle = GoogleFonts.quicksand(
    fontSize: 70,
    fontWeight: FontWeight.bold,
    color: analysisTextColor,
  );
  static TextStyle analysisText = GoogleFonts.quicksand(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: analysisTextColor,
  );

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

  //CARD TEXT STYLE
  static TextStyle cardTitle = GoogleFonts.quicksand(
    fontSize: 60,
    color: titleAndText,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cardSubTitle = GoogleFonts.quicksand(
    fontSize: 30,
    color: titleAndText,
    fontWeight: FontWeight.bold,
  );

  //MOBILE CARD TEXT STYLE
  static TextStyle cardMobile = GoogleFonts.quicksand(
    fontSize: 20,
    color: titleAndText,
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
  //MOBILE ALLERT TEXT STYLE
  static TextStyle mobileTextAllert = GoogleFonts.quicksand(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textAllert,
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

  //💧droplet
  //🪴potted plant
  //🪚carpentry saw
  //🥰smiling face
  //🤕banded
  //😔pensive

  //EMOJI ICON
  static Text dropletEmojiMobile = Text("💧", style: TextStyle(fontSize: 30));
  static Text pottedPlantEmojiMobile = Text(
    "🪴",
    style: TextStyle(fontSize: 30),
  );
  static Text carpentrySawEmojiMobile = Text(
    "🪚",
    style: TextStyle(fontSize: 30),
  );

  static Text dropletEmoji = Text("💧", style: TextStyle(fontSize: 50));
  static Text pottedPlantEmoji = Text("🪴", style: TextStyle(fontSize: 50));
  static Text carpentrySawEmoji = Text("🪚", style: TextStyle(fontSize: 50));

  static Text smilingFaceEmoji = Text("🥰", style: TextStyle(fontSize: 50));
  static Text bandedEmoji = Text("🤕", style: TextStyle(fontSize: 50));
  static Text pensiveEmoji = Text("😔", style: TextStyle(fontSize: 50));

  static Text smilingFaceEmojiMobile = Text(
    "🥰",
    style: TextStyle(fontSize: 30),
  );
  static Text bandedEmojiMobile = Text("🤕", style: TextStyle(fontSize: 30));
  static Text pensiveEmojiMobile = Text("😔", style: TextStyle(fontSize: 30));

  static Text analysisSmilingFaceEmoji = Text(
    "🥰",
    style: TextStyle(fontSize: 70),
  );
  static Text analysisBandedEmoji = Text("🤕", style: TextStyle(fontSize: 70));
  static Text analysisPensiveEmoji = Text("😔", style: TextStyle(fontSize: 70));

  static Text analysisIndeterminateEmoji = Text(
    "🤔",
    style: TextStyle(fontSize: 70),
  );

  //NAVIGATION ICON FILLED
  static FaIcon houseActive = FaIcon(
    FontAwesomeIcons.house,
    color: iconActivated,
    size: 60,
  );
  static FaIcon searchActive = FaIcon(
    FontAwesomeIcons.magnifyingGlass,
    color: iconActivated,
    size: 60,
  );
  static FaIcon categoryActive = FaIcon(
    FontAwesomeIcons.hashtag,
    color: iconActivated,
    size: 60,
  );
  static FaIcon analysisActive = FaIcon(
    FontAwesomeIcons.chartColumn,
    color: iconActivated,
    size: 60,
  );

  //MOBILE NAVIGATION ICON FILLED
  static FaIcon houseMobileActive = FaIcon(
    FontAwesomeIcons.house,
    color: iconActivated,
    size: 30,
  );
  static FaIcon searchMobileActive = FaIcon(
    FontAwesomeIcons.magnifyingGlass,
    color: iconActivated,
    size: 30,
  );
  static FaIcon categoryMobileActive = FaIcon(
    FontAwesomeIcons.hashtag,
    color: iconActivated,
    size: 30,
  );
  static FaIcon analysisMobileActive = FaIcon(
    FontAwesomeIcons.chartColumn,
    color: iconActivated,
    size: 30,
  );

  //NAVIGATION ICON
  static FaIcon house = FaIcon(
    FontAwesomeIcons.house,
    color: iconUnactivated,
    size: 60,
  );
  static FaIcon search = FaIcon(
    FontAwesomeIcons.magnifyingGlass,
    color: iconUnactivated,
    size: 60,
  );
  static FaIcon category = FaIcon(
    FontAwesomeIcons.hashtag,
    color: iconUnactivated,
    size: 60,
  );
  static FaIcon analysis = FaIcon(
    FontAwesomeIcons.chartColumn,
    color: iconUnactivated,
    size: 60,
  );

  //MOBILE NAVIGATION ICON
  static FaIcon houseMobile = FaIcon(
    FontAwesomeIcons.house,
    color: iconUnactivated,
    size: 30,
  );
  static FaIcon searchMobile = FaIcon(
    FontAwesomeIcons.magnifyingGlass,
    color: iconUnactivated,
    size: 30,
  );
  static FaIcon categoryMobile = FaIcon(
    FontAwesomeIcons.hashtag,
    color: iconUnactivated,
    size: 30,
  );
  static FaIcon analysisMobile = FaIcon(
    FontAwesomeIcons.chartColumn,
    color: iconUnactivated,
    size: 30,
  );

  static FaIcon categoryItem = FaIcon(
    FontAwesomeIcons.hashtag,
    color: iconActivated,
    size: 30,
  );
  static FaIcon categoryItemMobile = FaIcon(
    FontAwesomeIcons.hashtag,
    color: iconActivated,
    size: 20,
  );
}
