import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clubhouse_ui/app_router.dart';
import 'package:flutter_clubhouse_ui/constants/palette.dart';
import 'package:flutter_clubhouse_ui/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clubhouse UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.background,
          iconTheme: const IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Palette.background,
          ),
        ),
        scaffoldBackgroundColor: Palette.background,
        primaryColor: Colors.white,
        accentColor: Palette.green,
        iconTheme: const IconThemeData(color: Colors.black),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: HomeScreen(),
      onGenerateRoute: AppRouter().pageRoute,
    );
  }
}
