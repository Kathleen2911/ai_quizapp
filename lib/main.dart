import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/splash_screen.dart';
import 'route_generator.dart' as router;

import 'package:google_fonts/google_fonts.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      title: 'Quiz App',
      theme: ThemeData(
        primaryTextTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).primaryTextTheme,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).primaryTextTheme,


        ),

          // dark blue/purple
          primaryColor: Color.fromRGBO(25, 0, 62, 1),
          primaryColorLight: Color.fromRGBO(115, 77,255, 1),

          // pink
          accentColor: Color.fromRGBO(219, 89, 222, 1),


          // light blue/purple
          highlightColor: Color.fromRGBO(105, 0, 255, 1),

          // weiß
          cardColor: Color.fromRGBO(255, 255, 255, 0.8),



      ),
      home: SplashScreen(),


    );
  }
}

