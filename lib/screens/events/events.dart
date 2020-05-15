import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/sidemenue_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gradient_widgets/gradient_widgets.dart';


class EventScreen extends StatelessWidget {
  final List<String> title = [
    '',
    'Veranstaltung 1',
    'Veranstaltung 2',
    'Veranstaltung 3',
    'Veranstaltung 4',
    'Veranstaltung 5',
  ];

  final List<String> date = [
    '',
    '24.03.2020, 8 Uhr',
    '26.03.2020, 9 Uhr',
    '27.03.2020, 13 Uhr',
    '22.04.2020, 14 Uhr',
    '22.04.2020, 14:45 uhr',
  ];

  final List<String> room = [
    '',
    'AV Labor',
    'G 209',
    'G 203',
    'E 009',
    'E 009',
  ];

  final List<String> description = [
    '',
    'Präsentationsprüfung Audioprogrammierung',
    'Präsentationsprüfung Konzepte der Androidprogrammierung',
    'Präsentationsprüfung Bachelorprojekt',
    'Präsentation der neuen Prüfungsordnung',
    'Vollversammlung des Fachbereichs AI',
  ];



  Widget buildList(int i, BuildContext context) {
    return GradientCard(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
        colors: [Colors.white, Theme.of(context).primaryColorLight], // whitish to gray
        tileMode: TileMode.repeated, // repeats the gradient over the canvas
      ),
      child: InkWell(

        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              child: Center(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(date[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(room[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        description[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                        )),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Events & wichtige Termine',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      // Hamburger-Menue
      drawer: Drawer(
        child: NavigationScreen(),
      ),

      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),

              // dynamische Liste mit den Events
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 70),
                        child: Container(
                          child: buildList(
                              (index + 1),
                              context,
                              ),
                        ));
                  },
                  itemCount: 5,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                    activeColor: Theme.of(context).primaryColorLight,
                  )),
                ),
              )),
        ),

    );
  }
}
