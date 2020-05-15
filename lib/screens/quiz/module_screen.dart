import 'package:flutter/material.dart';
import 'package:flutter_app_quiz/screens/app_theme.dart';
import 'package:flutter_app_quiz/screens/quiz/chapter_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../home_screen.dart';
import '../sidemenue_screen.dart';

class ModuleScreen extends StatefulWidget {
  final String ctx;

  ModuleScreen({
    Key key,
    this.ctx,
  });

  @override
  _ModuleScreenState createState() => _ModuleScreenState(this.ctx);
}

class _ModuleScreenState extends State<ModuleScreen> {
  double h = 70.0;
  String ctx;

  _ModuleScreenState(this.ctx);

  // look of the module cards
  Widget buildList(int i, BuildContext context) {
    return PrimaryCard(
      padding: EdgeInsets.fromLTRB(8.0, 38.0, 8.0, 8.0),
      title: moduleList[i],
      fontSize: 28,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            // differs if you are on the way to the slides or if you are on the way to the modules
            builder: (context) => (ctx == "slide")
                ? ChapterScreen(
                    ctx: "slide",
                    module: moduleList[i],
                  )
                : ChapterScreen(module: moduleList[i]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Modulübersicht",
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),

        // Hamburger-Menue
        drawer: Drawer(
          child: NavigationScreen(),
        ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),

            // dynamic list with modules
            child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Container(
                        child: buildList(index, context),
                      ),
                    );
                  },
                  itemCount: moduleList.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Theme.of(context).primaryColorLight,
                    ),
                  ),
            ),

          ),
        ),
    );
  }
}
