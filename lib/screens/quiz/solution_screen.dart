import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_quiz/screens/foliensatz/pdfviewScreen.dart';

class SolutionScreen extends StatefulWidget {
  final questionList;

  SolutionScreen({Key key, @required this.questionList}) : super(key: key);

  @override
  _SolutionScreenState createState() => _SolutionScreenState(questionList);
}

class _SolutionScreenState extends State<SolutionScreen> {
  var questionList;

  _SolutionScreenState(this.questionList);

  @override
  Widget build(BuildContext context) {
    print(questionList);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Lösung"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).highlightColor,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // question
              Text(
                "Frage: ",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).cardColor,
                ),
              ),
              Text(
                questionList['question'],
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),

              // solution
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  "Richtige Antwort: ",
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 14.0,
                  ),
                ),
              ),

              Text(
                questionList['solution'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  height: 1.5,
                ),
              ),

              // get to chapter content
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfKurzVersion(chapter: questionList['chapter']),
                      ),
                    );
                  },

                  /// Text in Choicebutton
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 22, 70, 22),
                    child: Text("Zu den Folien",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
