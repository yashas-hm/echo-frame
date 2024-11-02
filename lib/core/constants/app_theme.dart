import 'package:echo_frame/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EchoFrameTheme {
  EchoFrameTheme(this.context);

  final BuildContext context;

  ThemeData get light => ThemeData(
        primaryColor: primaryLight,
        scaffoldBackgroundColor: backgroundLight,
        // TODO: Change text style
        textTheme: GoogleFonts.robotoMonoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: backgroundDark,
                displayColor: backgroundDark,
              ),
        ),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: primaryLight,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 5,
          iconTheme: IconThemeData(
            color: backgroundDark,
          ),
          backgroundColor: primaryLight,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryLight,
          primary: primaryLight,
          secondary: secondaryLight,
          tertiary: elementLight,
          background: backgroundLight,
          shadow: backgroundDark,
          brightness: Brightness.light,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: secondaryLight,
          cursorColor: primaryLight,
          selectionColor: primaryLight.withOpacity(0.3),
        ),
      );

  ThemeData get dark => ThemeData(
        primaryColor: primaryDark,
        scaffoldBackgroundColor: backgroundDark,
        textTheme: GoogleFonts.robotoMonoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: backgroundLight,
                displayColor: backgroundLight,
              ),
        ),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: elementDark,
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 5,
          iconTheme: IconThemeData(
            color: backgroundLight,
          ),
          backgroundColor: elementDark,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryDark,
          primary: primaryDark,
          secondary: secondaryDark,
          tertiary: elementDark,
          background: backgroundDark,
          shadow: backgroundLight,
          brightness: Brightness.dark,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: primaryDark,
          cursorColor: secondaryDark,
          selectionColor: primaryDark.withOpacity(0.3),
        ),
      );
}
