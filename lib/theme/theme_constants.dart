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
  fontFamily: 'lato',
  scaffoldBackgroundColor: Colors.grey.shade100,
  colorScheme: ColorScheme(
    brightness: Brightness.light,

    primary: PRIMARY_COLOR,
    onPrimary: NEAR_WHITE,
    secondary: SECONDARTY_COLOR,
    onSecondary: NEAR_WHITE,
    background: NEAR_WHITE,
    onBackground: PRIMARY_COLOR,

    error: Colors.red.shade300,
    onError: Colors.white,

    surface: ACCENT_COLOR,
    onSurface: FONT_COLOR2,

    //active card background / finished calendar card background
    surfaceVariant: BG_COLOR,
    //inactive card background / inactive calendar card background
    tertiary: Colors.grey.shade300,
    //finished card background /active calendar card background
    primaryContainer: ACCENT_COLOR,
    //star
    surfaceTint: STAR_COLOR,
    //calendar format button color
    onTertiary: SECONDARTY_COLOR,

    //calendar today
    inversePrimary: PRIMARY_COLOR,
    //calendar select day
    inverseSurface:Color(0xff4A8E8B),
  ),


  //card Theme
    cardTheme: const CardTheme(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(FONT_COLOR2),
      fillColor: MaterialStateProperty.all(SECONDARTY_COLOR),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      side:const BorderSide(
        color: SECONDARTY_COLOR,
        width: 2.0,
      ),
    ),
    appBarTheme: const AppBarTheme(
      // foregroundColor: NEAR_WHITE,
      // backgroundColor: PRIMARY_COLOR,
      elevation: 1.0,
      shadowColor: PRIMARY_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(500.0, 50.0),
        ),
      ),
    ),
  //bottom nav bar
  canvasColor: PRIMARY_COLOR,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    unselectedItemColor:ACCENT_COLOR,
    selectedItemColor: NEAR_WHITE,
  ),

  //Form text input color
  textTheme: TextTheme(
      subtitle1: TextStyle(
        color: PRIMARY_COLOR,
      ),
  ),
    //Form input theme
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
    ),

  //time picker theme
  timePickerTheme: const TimePickerThemeData(
    helpTextStyle: TextStyle(
      color: PRIMARY_COLOR,
      fontWeight: FontWeight.w500,
      fontSize: 20.0
    ),
    dialBackgroundColor: NEAR_WHITE,
    dialHandColor: SECONDARTY_COLOR,
    backgroundColor: ACCENT_COLOR,
    // dayPeriodTextColor: SECONDARTY_COLOR,
    // dayPeriodColor: CARD_BG,
    hourMinuteTextColor: PRIMARY_COLOR,
    hourMinuteColor: BG_COLOR,
  ),
);

//Dark theme data

const DARK_GREY = Color(0xFF212121);
const DPRIMARY_COLOR = Color(0xFF7be495);
const DSECONDARY_COLOR = Color(0xFF56c596);
const DNEAR_WHITE = Color(0xFFcff4d2);

const DSURFACE_COLOR =Color(0xffcff4d2);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'lato',
  scaffoldBackgroundColor: Color(0xff2e2e2e),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary:DPRIMARY_COLOR,
    onPrimary: DARK_GREY,
    secondary: DPRIMARY_COLOR,
    onSecondary: DARK_GREY,

    error: Colors.red.shade300,
    onError: Colors.white,

    background: DARK_GREY,
    onBackground: DPRIMARY_COLOR,

    surface:DARK_GREY,
    onSurface:DPRIMARY_COLOR,


    //active card background / finished calendar card background
    surfaceVariant: DARK_GREY,
    //inactive card background
    tertiary: Colors.grey.shade800,
    //finished card background / active calendar card background
    primaryContainer: Color(0xff214b39),
    //star
    surfaceTint: DPRIMARY_COLOR,
    //calendar format button style
    onTertiary: DPRIMARY_COLOR,

    //calendar today
    inversePrimary: Color(0xff214b39),
    //calendar select day
    inverseSurface:Color(0xff419471),
  ),

  //card Theme
  cardTheme: const CardTheme(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  ),

  //Check Box Theme
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(DARK_GREY),
    fillColor: MaterialStateProperty.all(DPRIMARY_COLOR),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2.0),
    ),
    side:const BorderSide(
      color: DPRIMARY_COLOR,
      width: 2.0,
    ),
  ),

  //appBarTheme
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(500.0, 50.0),
      ),
    ),
  ),
  //bottom nav bar
  canvasColor: DARK_GREY,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    unselectedItemColor:DPRIMARY_COLOR,
    selectedItemColor: DPRIMARY_COLOR,
   ),

  textTheme: const TextTheme(
    subtitle1: TextStyle(
      color: DPRIMARY_COLOR,
    )
  ),

  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: DPRIMARY_COLOR,
        width: 2.0,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: DPRIMARY_COLOR,
        width: 4.0,
      ),
    ),
    fillColor: SECONDARTY_COLOR,
    focusColor: SECONDARTY_COLOR,
  ),

  timePickerTheme: const TimePickerThemeData(
    helpTextStyle: TextStyle(
        color: DPRIMARY_COLOR,
        fontWeight: FontWeight.w500,
        fontSize: 20.0
    ),
  ),
);
