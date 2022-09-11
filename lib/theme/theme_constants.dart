import 'package:flutter/material.dart';

const FONT_COLOR1 = Color(0xFF0d1f22);
const FONT_COLOR2 = Color(0xFF11282d);
const FONT_COLOR3 = Color(0xFF214f58);

const PRIMARY_COLOR = Color(0xFF2c6975);
const SECONDARTY_COLOR = Color(0xFF68B2A0);
const ACCENT_COLOR = Color(0xFFCDE0C9);
const BG_COLOR = Color(0xFFE0ECDE);

const CARD_BG = Color(0xFFF0F6EF);
const NEAR_WHITE = Color(0xfff8fbf7);

const STAR_COLOR = Colors.amber;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: PRIMARY_COLOR,
  //backgroundColor: Color(0xFFF8FBF7),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'lato',
  //app bar theme
  appBarTheme: const AppBarTheme(
    elevation: 1.0,
    shadowColor: PRIMARY_COLOR,
    foregroundColor: NEAR_WHITE,
    backgroundColor: PRIMARY_COLOR,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(10.0),
      ),
    ),
  ),
  //floating Auction Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: NEAR_WHITE,
    backgroundColor: SECONDARTY_COLOR,
  ),
  //card theme
  cardTheme: const CardTheme(
    color: CARD_BG,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(FONT_COLOR2),
    fillColor: MaterialStateProperty.all(SECONDARTY_COLOR),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
  ),

  //Form Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      primary: NEAR_WHITE,
      backgroundColor: PRIMARY_COLOR,
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: SECONDARTY_COLOR,
        width: 2.0,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: PRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    fillColor: SECONDARTY_COLOR,
    focusColor: SECONDARTY_COLOR,
  ),

  //bottom nav bar
  canvasColor: PRIMARY_COLOR,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    unselectedItemColor:ACCENT_COLOR,
    selectedItemColor: NEAR_WHITE,
  ),

  timePickerTheme: TimePickerThemeData(
    dialBackgroundColor: NEAR_WHITE,
    dialHandColor: SECONDARTY_COLOR,
    backgroundColor: ACCENT_COLOR,

    dayPeriodTextColor: SECONDARTY_COLOR,
    dayPeriodColor: NEAR_WHITE,
  ),


  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: PRIMARY_COLOR,
    onPrimary: NEAR_WHITE,
    secondary: SECONDARTY_COLOR,
    onSecondary: NEAR_WHITE,
    error: Colors.red.shade300,
    onError: NEAR_WHITE,
    background: BG_COLOR,
    onBackground: NEAR_WHITE,
    surface: ACCENT_COLOR,
    onSurface: PRIMARY_COLOR,
    outline: FONT_COLOR2,
    //star
    surfaceTint: STAR_COLOR,
    //
    surfaceVariant: CARD_BG,
    //error container for calendar todotile background
    errorContainer: ACCENT_COLOR,
    //Donetile
    onErrorContainer: CARD_BG,
    //Calendar selected day marker color
    inverseSurface: SECONDARTY_COLOR,
    //Calendar today marker color
    inversePrimary: ACCENT_COLOR,

  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
