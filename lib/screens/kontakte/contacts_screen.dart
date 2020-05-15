
import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/sidemenue_screen.dart';

class ContactScreen extends StatelessWidget {


  final h = 120.0;

  // TODO: Arrays durch models ersetzen
  final List<String> images = [
    'https://www.hs-fulda.de/fileadmin/_processed_/7/8/csm_Wald_01_3405290c55.jpg',
    'https://www.hs-fulda.de/fileadmin/_processed_/c/2/csm_Bomsdorf_31a25c29b8.jpg',
    'https://www.hs-fulda.de/fileadmin/_processed_/e/b/csm_Kreiker_454b6a5950.jpg',
    'https://www.hs-fulda.de/fileadmin/_processed_/7/f/csm_Milde_web_02_8347c852f5.jpg',
    'https://www.hs-fulda.de/fileadmin/_processed_/7/1/csm_Hirth_ba06ac0fa9.jpg',
    'https://www.hs-fulda.de/fileadmin/_processed_/5/6/csm_Wiegand_a0bad4700e.jpg'
  ];

  final List<String> names = [
    'Sekretariat',
    'Prof.Dr. Birgit Bomsdorf, Fachbereichsdekanin',
    'Prof.Dr. Jörg Kreiker,\nStudiendekan',
    'Prof.Dr. Jan-Torsten Milde, Studiengangsleiter',
    'Merethe Hirth, Studiengangskoordinatorin',
    'Lisa Wiegand, Studiengangskoordinatorin',
  ];

  final List<String> telephone = [
    '+49 661 9640-300/302/3053\n',
    '+49 661 9640-327\n',
    '+49 661 9640-331\n',
    '+49 661 9640-332\n',
    '+49 661 9640-343\n',
    '+49 661 9640-3044\n'
  ];

  final List<String> mail = [
    'dekanat.ai@informatik.hs-fulda.de\n',
    'birgit.bomsdorf@informatik.hs-fulda.de\n',
    'joerg.kreiker@informatik.hs-fulda.de\n',
    'jan-torsten.milde@informatik.hs-fulda.de\n',
    'merete.hirth@informatik.hs-fulda.de\n',
    'lisa.wiegand@informatik.hs-fulda.de\n',
  ];
  final List<String> sprechzeiten = [
    'Mo, Mi, Fr: 8:30-11:30,\nDo: 8:30-11:30 & 13:30-15:30\n',
    'Di: 14:00-15:00\n',
    'Do: 15:15-16:45\n',
    'Fr: 10:00-11:00\n',
    'Mo: 15:00-16:00, Mi: 11:00-12:00\n',
    'Mo: 15:00-16:00, Mi: 11:00-12:00\n',
  ];

  //TODO: Bilder klappen noch nicht
  //TODO: noch weiter ausbauen

  Widget customcard(BuildContext context, int index){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
            width: 1,
          )

        ),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListTile(
              leading:CircleAvatar(
                radius: 30,
                // no matter how big it is, it won't overflow
                backgroundImage: NetworkImage(images[index]),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                  names[index],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                (sprechzeiten[index]) + 'Tel.: ' + (telephone[index]) + 'e-Mail: ' + (mail[index]),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              isThreeLine: true,
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
          'Kontakte',
        ),
      ),
      drawer: Drawer(
        child: NavigationScreen(),
      ),
      body: ListView(
          children: <Widget>[
            customcard(context, 0),
            customcard(context, 1),
            customcard(context, 2),
            customcard(context, 3),
            customcard(context, 4),
            customcard(context, 5),
          ],
        ),
    );
  }
}