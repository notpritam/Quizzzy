import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Museo",
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}

//Buttons

final ButtonStyle formButtonTheme = ElevatedButton.styleFrom(
    primary: Colors.purple.withOpacity(0.4),
    elevation: 0,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
final ButtonStyle buttonTheme = ElevatedButton.styleFrom(
    primary: Color.fromRGBO(255, 255, 255, 0.2),
    elevation: 0,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

final ButtonStyle quizButtonTheme = ElevatedButton.styleFrom(
    primary: Color.fromRGBO(255, 255, 255, 0.2),
    elevation: 0,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

final ButtonStyle resultButtonTheme = ElevatedButton.styleFrom(
    primary: Color.fromRGBO(255, 255, 255, 0.2),
    elevation: 0,
    minimumSize: const Size.fromHeight(50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

//Text

final TextStyle headingStyle = TextStyle(
  fontFamily: "Museo",
  fontSize: 40,
);

final TextStyle levelStyle = TextStyle(
  fontSize: 20,
);
final TextStyle noStyle = TextStyle(
  fontSize: 20,
);
final TextStyle captionStyle = TextStyle(
  fontSize: 14,
);

final TextStyle levelCaptionStyle = TextStyle(
  fontSize: 14,
);

final TextStyle resultText = TextStyle(
  fontSize: 14,
);
