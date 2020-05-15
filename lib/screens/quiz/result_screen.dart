import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/quiz/chapter_screen.dart';
import 'package:flutter_app_quiz/screens/quiz/solution_screen.dart';
import 'package:sliver_fab/sliver_fab.dart';

class ResultScreen extends StatefulWidget {
  final List questionList;
  final Map<String, Color> resultColor;
  final int points;

  ResultScreen({
    Key key,
    @required this.questionList,
    @required this.resultColor,
    @required this.points,
  }) : super(key: key);

  @override
  _ResultScreenState createState() =>
      _ResultScreenState(questionList, resultColor, points);
}

class _ResultScreenState extends State<ResultScreen> {
  List questionList;
  Map<String, Color> resultColor;
  int points;

  _ResultScreenState(this.questionList, this.resultColor, this.points);

  @override
  Widget build(BuildContext context) {
    double media = ((MediaQuery.of(context).size.width - 100) / 2);

    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ChapterScreen(module: questionList[0]["module"]),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: new Builder(
            builder: (context) {
              // Score Fab
              return new SliverFab(
                floatingWidget: Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(left: 15.0),
                  child: Center(
                    child: Text(
                      "$points",
                      style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      )),
                ),
                floatingPosition: FloatingPosition(left: media, top: -10),
                expandedHeight: 256.0,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    iconTheme:
                        IconThemeData(color: Theme.of(context).primaryColor),
                    expandedHeight: 256.0,
                    pinned: true,
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 14),
                        child: Text(
                          "ERGEBNISSE",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: (points > 15)
                          ? Image.asset(
                              'assets/success.png',
                              fit: BoxFit.fitWidth,
                            )
                          : Image.asset(
                              'assets/failure.png',
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(
                        5,
                        (int index) {
                          if (index == 0) {
                            return Column(
                              children: <Widget>[
                                // 1. Zeile
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).cardColor,
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, bottom: 12),
                                    child: ListTile(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SolutionScreen(
                                                    questionList:
                                                        questionList[index])),
                                      ),
                                      leading: Container(
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                              child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    Theme.of(context).cardColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                          )),
                                      title: Text(
                                        questionList[index]['question'],
                                        style: TextStyle(
                                          color: Theme.of(context).cardColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: Wrap(
                                          direction: Axis.vertical,
                                          spacing: 12,
                                          // defines the (vertical) space between items before break
                                          runSpacing: 15,
                                          // defines the (horizontal) space between items after break
                                          children: <Widget>[
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: resultColor[
                                                    (index + 1).toString()],
                                              ),
                                            ),
                                            Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          // weitere Listzeilen
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).cardColor,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: ListTile(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SolutionScreen(
                                      questionList: questionList[index],
                                    ),
                                  ),
                                ),
                                leading: Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).cardColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                ),
                                title: Text(
                                  questionList[index]['question'],
                                  style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Wrap(
                                    direction: Axis.vertical,
                                    spacing: 12,
                                    runSpacing: 15,
                                    children: <Widget>[
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: resultColor[
                                              (index + 1).toString()],
                                        ),
                                      ),
                                      Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
