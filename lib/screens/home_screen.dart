import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/events/events.dart';
import 'package:flutter_app_quiz/screens/kontakte/contacts_screen.dart';
import 'package:flutter_app_quiz/screens/sidemenue_screen.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../route_generator.dart';
import 'quiz/module_screen.dart';

/// [userdata] stores the data of the current user to show it on navigation drawer
Map<String, String> userdata = {
  'mail': '',
  'user': '',
};

List<String> moduleList = [];

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _firestore = Firestore.instance;

  var h = 70.0; // height of card

  // style of the topic list
  Widget buildList(int i, BuildContext context, neu) {
    return GradientCard(
      // background gradient of the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
        colors: [
          Colors.white,
          Theme.of(context).primaryColorLight
        ], // whitish to gray
        tileMode: TileMode.repeated, // repeats the gradient over the canvas
      ),

      // Inkwell to make the card clickable
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => neu));
        },
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: h,
              child: Center(
                child: Text(
                  routes[i]['title'], // name of the module
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getModules() async {
    final modules = await _firestore.collection('Fragenkatalog').getDocuments();
    for (var module in modules.documents) {
      if (!moduleList.contains(module.data['module'])) {
        moduleList.add(module.data['module']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getModules();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'QuizStar DigitalMedia',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // Hamburger-Menue
      drawer: Drawer(
        child: NavigationScreen(),
      ),

      body: SafeArea(
        // background gradient of the screen

        // content: build the list of the topics
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              buildList(0, context, ModuleScreen()),
              // get to quiz
              buildList(
                  1,
                  context,
                  ModuleScreen(
                    ctx: 'slide',
                  )),
              // get the ppt presentations (as pdf)
              buildList(2, context, EventScreen()),
              // show events of 'Angewandte Informatik'
              buildList(3, context, ContactScreen()),
              // show relevant contacts of 'Angewandte Informatik'
            ],
          ),
        ),
      ),
    );
  }
}
