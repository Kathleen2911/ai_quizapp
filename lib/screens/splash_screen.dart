import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:2), (){
      Navigator.pushNamed(context, '/signin');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 110.0),
                        child: Image.asset(
                          'assets/icon_transparent.png',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0, bottom: 15.0),
                        child: Column(
                          children: <Widget>[
                            Text('WILLKOMMEN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40,
                                  height: 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                            Text('bei deiner Lernapp für Angewandte Informatik',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
