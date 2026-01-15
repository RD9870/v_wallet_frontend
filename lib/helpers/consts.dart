import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------------- API CONSTS -------------------
String baseUrl = "http://10.122.109.127:8000/api";

// ------------------- COLORS CONSTS -------------------

const Color primaryColor = Color(0xfff16872);
const Color secondaryColor = Color(0xff2a255f);

const Color whiteColor = Color(0xffEAF1FF);
const Color blackColor = Color(0xff000C23);

const Color recivedIconColor = Color(0xff9E3996);
const Color recivedIconBackground = Color(0xffCC96C7);
const Color recivedIconBackgroundShadow = Color(0xffAB1E9F);
const Color recivedMoneyColor = Color(0xff63F058);

const Color transferIconColor = Color(0xffF40C1F);
const Color transferIconBackground = Color(0xffCC96C7);
const Color transferIconBackgroundShadow = Color(0xffFF191D);
const Color transferMoneyColor = Color(0xffCB3B49);

const Color redColor = Color(0xffC63E3E);
const Color orangeColor = Color(0xffBA6A0F);
const Color greenColor = Color(0xff029802);

const Color grayColor = Color.fromARGB(255, 167, 164, 164);

// ------------------- TEXT CONSTS -------------------

Duration animationDuration = Duration(milliseconds: 300);

TextStyle displaySmall = GoogleFonts.cairo(fontSize: 20);
TextStyle displayMedium = GoogleFonts.cairo(fontSize: 24);
TextStyle displayLarge = GoogleFonts.cairo(fontSize: 28);

TextStyle labelSmall = GoogleFonts.cairo(
  fontSize: 14,
  fontWeight: FontWeight.bold,
);
TextStyle labelMedium = GoogleFonts.robotoMono(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
TextStyle labelLarge = GoogleFonts.cairo(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

TextStyle labelExtraLarge = GoogleFonts.cairo(
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

TextStyle bodySmall = GoogleFonts.cairo(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);
TextStyle bodyMedium = GoogleFonts.cairo(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);
TextStyle bodyLarge = GoogleFonts.cairo(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);
