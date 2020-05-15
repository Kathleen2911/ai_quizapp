import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_quiz/screens/quiz/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String chapter;

  QuizScreen({Key key, @required this.chapter,}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(chapter);
}

class _QuizScreenState extends State<QuizScreen> {
  String chapter;

  _QuizScreenState(this.chapter);

  // variables
  final _firestore = Firestore.instance;
  var questionList = [];
  String answer;

  Color colorToShow = Color.fromRGBO(255, 255, 255, 0.8);
  Color right = Colors.greenAccent;
  Color wrong = Colors.red[900];

  int points = 0;
  int qCounter = 0;
  int x = 1;


  // Color of choice buttons
  Map<String, Color> btncolor = {
    "a": Color.fromRGBO(255, 255, 255, 0.8),
    "b": Color.fromRGBO(255, 255, 255, 0.8),
    "c": Color.fromRGBO(255, 255, 255, 0.8),
    "d": Color.fromRGBO(255, 255, 255, 0.8),
  };

  // result color
  Map<String, Color> resultColor = {
    "1": Colors.red,
    "2": Colors.red,
    "3": Colors.red,
    "4": Colors.red,
    "5": Colors.red,
  };

  // continue to next question or get result
  void nextquestion() {
    setState(() {
      if (qCounter < 4) {
        print(qCounter.toString());
        qCounter++;

        // new question
      } else {
        // no question left: get the result of the quiz
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultScreen(questionList: questionList, resultColor: resultColor, points: points),
        ),
        );
      }

      // set btn color back to initial color
      btncolor["a"] = Theme.of(context).cardColor;
      btncolor["b"] = Theme.of(context).cardColor;
      btncolor["c"] = Theme.of(context).cardColor;
      btncolor["d"] = Theme.of(context).cardColor;
    });
  }

  void checkanswer(String t) {

    if (questionList[qCounter]['answers'][t] == questionList[qCounter]['solution']) {

      points = points + 5;
      colorToShow = right;
      resultColor[(qCounter+1).toString()] = right;

      x++;
    } else {
      colorToShow = wrong;
      x++;
    }
    setState(() {
      btncolor[t] = colorToShow;
    });

    Timer(Duration(milliseconds: 300), nextquestion);
  }


  // get back to module overview screen
  backToOverview() {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // alert, when user clicks on back button
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(
                      "QUIZ: " + chapter,
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                      )

                  ),
                  content: Text(
                    "Möchtest du das Quiz wirklich abbrechen?",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        backToOverview();
                      },
                      child: Text('Ja',
                          style:
                          TextStyle(color: Theme
                              .of(context)
                              .primaryColor)),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Nein',
                        style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor),
                      ),
                    )
                  ],
                ));
      },

      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "QUIZ: " + chapter,
            style:
            TextStyle(fontSize: 18),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme
                    .of(context)
                    .primaryColor, Theme
                    .of(context)
                    .highlightColor
                ]),
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),

                // build row with number icons
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildNumberIcon("1"),
                    buildNumberIcon("2"),
                    buildNumberIcon("3"),
                    buildNumberIcon("4"),
                    buildNumberIcon("5"),
                  ],
                ),
              ),

              //Quiz question
              Column(children: <Widget>[
                  SizedBox(
                    child:  StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection("Fragenkatalog").where(
                            'chapter', isEqualTo: chapter).snapshots(),
                        builder: (context, snapshot) {

                          if (snapshot.hasData) {
                            final catalogue = snapshot.data.documents;
                            for (var question in catalogue) {
                              if(!questionList.contains(question.data)) {
                                questionList.add(question.data);
                              }
                            }
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(30, 20, 18, 20),
                                  child:
                                  Center(

                                    // Question
                                    child: Text(
                                      questionList[qCounter]['question'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ),

                              // choices
                              choicebutton("a"),
                              choicebutton("b"),
                              choicebutton("c"),
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: choicebutton("d"),
                              )
                            ],
                          );
                        }

                    ),


                  )
                ],
                ),
              submitbutton(),
            ],
          ),
        ),
      ),
    );
  }

  // Icon Row: shows the number of questions and highlights the current question number
  Widget buildNumberIcon(String number) {
    if (number == (qCounter+1).toString()) {
      // current number
      return Container(
          width: 30,
          height: 30,
          child: Center(
              child: Text(
                number,
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ));
    } else {
      // other numbers
      return Container(
          width: 30,
          height: 30,
          child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.white),
          ));
    }
  }

  choicebutton(String t) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 1),
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: btncolor[t],
            onPressed: () {
              answer = t;
              setState(() {
                // reset the btn color when you click on a different button
                btncolor["a"] = Theme.of(context).cardColor;
                btncolor["b"] = Theme.of(context).cardColor;
                btncolor["c"] = Theme.of(context).cardColor;
                btncolor["d"] = Theme.of(context).cardColor;

                // set the highlight color only for the clicked button
                btncolor[t] = Theme.of(context).primaryColorLight;



              });
            },

            // Text in Choicebutton
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 22, 5, 22),
              child: Text(
                questionList[qCounter]['answers'][t],
                style: TextStyle(
                  color: (
                      (btncolor[t] == Theme.of(context).primaryColorLight) || (btncolor[t] == wrong)) ? Colors.white : Theme.of(context).primaryColor,
                  fontSize: 14.0,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            height: 50.0,
            shape:
            RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColorLight,
                ),
                borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
    );
  }

  submitbutton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
        child: MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            checkanswer(answer);
          },
          child: Text(
            "WEITER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
            maxLines: 1,
          ),
          minWidth: 150.0,
          height: 60.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
        ),
    );
  }
}
