import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xfff2f2f2),
        colorScheme: const ColorScheme.light(
          primary: Color(0xff034703),
          secondary: Color(0xffE5EEC3),
        ),
        textTheme: TextTheme(
            headlineMedium: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
            bodyMedium: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  overflow: TextOverflow.fade),
            ),
            titleMedium: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.fade))));
  }
}
