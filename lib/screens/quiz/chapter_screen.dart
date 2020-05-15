import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/foliensatz/pdfviewScreen.dart';
import 'package:flutter_app_quiz/screens/app_theme.dart';
import 'package:flutter_app_quiz/screens/quiz/module_screen.dart';
import 'package:flutter_app_quiz/screens/quiz/quiz_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterScreen extends StatelessWidget {
  final module;
  final _firestore = Firestore.instance;
  final chapterList = [];

  final String ctx; // context of the screen: to build specific routes


  ChapterScreen({Key key, @required this.module, this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget buildList(int i) {
      return new PrimaryCard(
          padding: const EdgeInsets.all(30.0),
          title: chapterList[i],
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                  // differ if you are on the way to the chapter slides or quiz
                  builder: (context) => (ctx == "slide") ? PdfKurzVersion(chapter: chapterList[i]) : QuizScreen(chapter: chapterList[i]),

                ),
            );
          },
      );
    }
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>(ctx == 'slide') ? ModuleScreen(ctx:'slide'): ModuleScreen(),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
                module,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),


        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("Fragenkatalog").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  final catalogue = snapshot.data.documents;
                  for (var chapter in catalogue) {
                    /// checks if the value is already in the list
                    if (!chapterList.contains(chapter.data["chapter"]) && (chapter.data["module"]==module)) {
                      /// if value is unique, add it to list
                      chapterList.add(chapter.data["chapter"]);
                    }
                  }
                }
                return ListView.builder(
                  itemCount: chapterList.length,
                  itemBuilder: (context, x) {
                    return buildList((x));
                  },
                );
              },
            ),
          ),
      ),
    );
  }

}
