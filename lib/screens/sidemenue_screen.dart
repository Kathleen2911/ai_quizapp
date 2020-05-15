import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/app_theme.dart';

import '../route_generator.dart';
import 'home_screen.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String loggedInUser = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    // get current user from firebase
    final currentUser = await _auth.currentUser();
    try {
      if (currentUser != null) {
        loggedInUser = currentUser.email;
        userdata['mail'] = loggedInUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Side menu: profile
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('user').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final allUser = snapshot.data.documents;
              for (var currentUser in allUser) {
                // get the current user
                if (currentUser.data['mail'] == loggedInUser) {
                  userdata['mail'] = currentUser.data['mail'];
                  userdata['user'] = currentUser.data['user'];
                }
              }
            }
            return UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).highlightColor
                    ]),
              ),
              accountName: Text(userdata['user']),
              accountEmail: Text(userdata['mail']),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/girl.png'),
              ),
            );
          },
        ),

        // side menu: navigation
        Expanded(
          child: new ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: routes.length,
            itemBuilder: (context, index) {
              return AppNavigationList(
                title: routes[index]['title'],
                onTap: () {
                  // sign out current user
                  if (routes[index]['title'] == 'Abmelden') {
                    _auth.signOut();
                    userdata['mail'] = '';
                    userdata['user'] = '';
                  }
                  Navigator.pushNamed(context, routes[index]['route']);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
