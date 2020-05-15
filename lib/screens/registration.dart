import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/home_screen.dart';
import 'package:flutter_app_quiz/screens/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'app_theme.dart';

// Login (without real login function)
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _isVisible = false;
  String _email;
  String _username;
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
    return ModalProgressHUD(
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
              child: ListView(
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
                      AppTextFormField(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: 'Nutzername',
                        validator: (value) {
                          if (value.length < 2) {
                            return 'Dein Nutzername muss mind. 2 Zeichen haben.';
                          }
                          return '';
                        },
                        onChanged: (value) => _username = value,
                      ),

                      SizedBox(height: 20.0),

                      AppTextFormField(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'E-Mail-Adresse',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Deine E-Mail-Adresse muss mind. 6 Zeichen haben.';
                          }
                          return '';
                        },
                        onChanged: (value) => _email = value,
                      ),
                      SizedBox(height: 20.0),
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
                            return 'Das Passwort muss mind. 6 Zeichen haben';
                          }
                          return '';
                        },
                        onChanged: (value) => _password = value,
                      ),

                      SizedBox(height: 20.0),
                      AppTextFormField(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () => toggleVisibility(),
                          icon: _isVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                        hintText: 'Passwort Wiederholung',
                        obscureText: _isVisible ? false : true,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'das Passwort wurde falsch eingegeben';
                          }
                          return '';
                        },
                        onChanged: (value) => _password = value,
                      ),

                      SizedBox(height: 40.0),

                      // submit button
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(32.0),
                        ),
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          'Registrieren',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () async {
                          try {
                            setState(() {
                              showSpinner = true;
                            });

                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: _email, password: _password);
                            if (newUser != null) {
                              _firestore.collection('user').add({
                                'user': _username,
                                'mail': _email,
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePageScreen()));
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Registrierung fehlgeschlagen',
                                      style: TextStyle(
                                          color: Theme.of(context).highlightColor),
                                    ),
                                    content: Text(
                                      (e.message != null) ? e.message : 'Etwas ist schiefgelaufen. Bitte versuche es erneut.',
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
                          }
                        },
                      ),

                      // create new password (not yet implemented)
                      Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: FlatButton(
                            child: Text(
                              'bereits registriert?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                          )),
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
