import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/events/events.dart';
import 'package:flutter_app_quiz/screens/home_screen.dart';
import 'package:flutter_app_quiz/screens/kontakte/contacts_screen.dart';
import 'package:flutter_app_quiz/screens/login.dart';
import 'package:flutter_app_quiz/screens/quiz/module_screen.dart';
import 'package:flutter_app_quiz/screens/splash_screen.dart';

// navigation items
Map<int, dynamic> routes = {
  0: {"title": "Quiz", "route": "/quiz"},
  1: {"title": "Foliensätze", "route": "/slides"},
  2: {"title": "Events & wichtige Termine", "route": "/events"},
  3: {"title": "Kontakte", "route": "/contacts"},
  4: {"title": "Abmelden", "route": "/signout"}
};


// route generator for the main navigation items
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => HomePageScreen());

    case '/splash':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case '/quiz':
      return MaterialPageRoute(builder: (context) => ModuleScreen());

    case '/slides':
      return MaterialPageRoute(
          builder: (context) => ModuleScreen(ctx: "slide"));

    case '/contacts':
      return MaterialPageRoute(builder: (context) => ContactScreen());

    case '/events':
      return MaterialPageRoute(builder: (context) => EventScreen());

    case '/signin':
    case '/signout':
      return MaterialPageRoute(builder: (context) => LoginScreen());

    default:
      return MaterialPageRoute(builder: (context) => HomePageScreen());
  }
}
