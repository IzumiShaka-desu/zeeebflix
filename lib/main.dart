import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme() , primarySwatch:Colors.red,visualDensity: VisualDensity.adaptivePlatformDensity,),
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}