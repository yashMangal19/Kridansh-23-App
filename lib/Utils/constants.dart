import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// All the colors used in the Kridansh App.
const primaryColor = Color(0xff121212);
const secondaryColor = Color(0xff393939);
const secondaryColorDark = Color(0xff222322);
const secondaryColorLight = Colors.white;

const lightGrey = Color(0xffD9D9D9);

// Logos of each hostel
Map<String, dynamic> logos = {
  "G1": "",
  "G2": "",
  "G3": "",
  "G4": "",
  "G5": "",
  "G6": "",
  "B1": "",
  "B2": "",
  "B3": "",
  "B4": "",
  "B5": "",
  "B6": "",
  "I2": "",
  "I3": "",
  "Y4": "",
};

// Style which is implemented at the page header appbar.
TextStyle pageHeaderStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 26.0,
  fontWeight: FontWeight.w600,
);

// Style which is implemented in pages where largest heading is used in body.
TextStyle heading1Style = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 22.0,
  fontWeight: FontWeight.w600,
);

// Style which is implemented in pages where regular text is used.
TextStyle regularTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
);

// Style which is implemented in pages where regular text is used.
TextStyle mediumTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
);

// Style which is implemented in pages where thin text is used.
TextStyle thinTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.w200,
);

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.green,
  }) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
          maxLines: 2,
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

