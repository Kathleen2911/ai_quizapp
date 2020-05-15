import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_quiz/screens/app_theme.dart';
import 'package:flutter_app_quiz/screens/home_screen.dart';
import 'package:flutter_app_quiz/screens/registration.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  final brand = Text(
    'AI Lernapp',
    style: TextStyle(color: Colors.white, fontSize: 50.0),
  );

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // alert, when user clicks on back button
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("AI Lernapp",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      )),
                  content: Text(
                    "Möchtest du die App wirklich beenden?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text('Ja',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Nein',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ));
      },

      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          // no resizing of the widgets, when keyboard appears (to avoid overflow!)
          body: Container(
            // gradient in the background
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).highlightColor
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                children: <Widget>[
                  // Show name of the App
                  SizedBox(height: 110.0),
                  Center(
                    child: brand,
                  ),

                  // Login Formfields
                  SizedBox(height: 48.0),
                  Form(
                    autovalidate: true,
                    key: _formKey,
                    child: Column(children: <Widget>[
                      /// [AppTextFormField] is a TextFormField which fits to our needs and our app theme
                      /// the look is defined in app_theme.dart
                      AppTextFormField(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'E-Mail-Adresse',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Deine E-Mail-Adresse ist nicht korrekt.';
                          }
                          return '';
                        },
                        onChanged: (value) => _email = value,
                      ),
                      SizedBox(height: 30.0),

                      AppTextFormField(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () => toggleVisibility(),
                          icon: _isVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                        hintText: 'Passwort',
                        obscureText: _isVisible ? false : true,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'das Passwort muss mind. 6 Zeichen haben';
                          }
                          return '';
                        },
                        onChanged: (value) => _password = value,
                      ),
                    ]),
                  ),
                  SizedBox(height: 40.0),

                  // submit button
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(32.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: _email, password: _password);
                        if (user != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePageScreen()));
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        // show Pop-up alert if user is not in database
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Login fehlgeschlagen',
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor),
                                ),
                                content: Text(
                                  (e.message != null)
                                      ? e.message
                                      : 'Etwas ist schiefgelaufen. Bitte versuche es erneut',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                actions: [
                                  FlatButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showSpinner = false;
                                      });

                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        print(e);
                      }
                    },
                  ),

                  FlatButton(
                    child: Text(
                      'Noch nicht registriert?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
