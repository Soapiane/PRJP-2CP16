
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet2cp/Generator.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Navigation/Zones.dart';


class LevelSelectionBody extends Body {

  final Zones zone;
  Function(bool, Zones, int) onLevelSelected;
  List<Map> levelsInfo;


  LevelSelectionBody({required this.zone, required this.onLevelSelected, required this.levelsInfo});


  @override
  Widget build(BuildContext context) {

    print("levels Info: ${levelsInfo.toString()}");

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    late Scaffold body  = ZoneVilleSelection(screenWidth, context);

    switch (zone){
      case Zones.ville: {
        body = ZoneVilleSelection(screenWidth, context);
        break;
      }
      case Zones.mer: {
        body = ZoneMerSelection(screenWidth, context);
        break;
      }
      case Zones.zoneIndustrielle: {
        body = ZoneInduSelection(screenWidth, context);
        break;
      }
      case Zones.foret: {
        body = ZoneForetSelection(screenWidth, context);
        break;
      }
    }

    return body;
  }

  Scaffold ZoneMerSelection(double screenWidth, BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(zone.backgroundImagePath),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        createContainer(
                            "assets/images/Quiz_level_selection.svg",
                          2, // levelsInfo[0]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1,
                            context,
                          level: 1,),
                        const SizedBox(
                          width: 10,
                        ),
                        createContainer(
                            "assets/images/Turtle_level_selection.svg",
                          2, // levelsInfo[1]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1,
                            context,
                          level: 1,),
                        const SizedBox(
                          width: 10,
                        ),
                        createContainer(
                            "assets/images/Puzzle_level_selection.svg",
                          3, // levelsInfo[2]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1,
                            context,
                          level: 1,),
                        const SizedBox(
                          width: 10,
                        ),
                        createContainer(
                          "assets/images/Recycler_level_selection.svg",
                          -1, // levelsInfo[3]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //                          1,
                          context,
                            level: 1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold ZoneInduSelection(double screenWidth, BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(zone.backgroundImagePath),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      createContainer(
                          "assets/images/Quiz_level_selection.svg",
                        2, // levelsInfo[0]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //3,
                          context,
                        level: 1,),
                      const SizedBox(
                        width: 10,
                      ),
                      createContainer(
                          "assets/images/Runner_level_selection.svg",
                        3, // levelsInfo[1]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //3,
                          context,
                        level: 1,),
                      const SizedBox(
                        width: 10,
                      ),
                      createContainer(
                          "assets/images/Puzzle_level_selection.svg",
                        1, // levelsInfo[2]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //2,
                          context,
                        level: 1,),
                      const SizedBox(
                        width: 10,
                      ),
                      createContainer(
                        "assets/images/Recycler_level_selection.svg",
                        -1, // levelsInfo[3]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //2,
                        context,
                        level: 1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold ZoneForetSelection(double screenWidth, BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(zone.backgroundImagePath),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        createContainer(
                            "assets/images/Quiz_level_selection.svg",
                          2, // levelsInfo[0]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //  3,
                            context,
                          level: 1,),
                        const SizedBox(
                          width: 10,
                        ),
                        createContainer(
                            "assets/images/Runner_level_selection.svg",
                          1, // levelsInfo[1]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //  3,
                            context,
                          level: 1,),
                        const SizedBox(
                          width: 10,
                        ),
                        createContainer(
                            "assets/images/Bird_level_selection.svg",
                          3, // levelsInfo[2]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //  0,
                            context,
                          level: 1,),
                        const SizedBox(
                          width: 10,
                        ),
                        createContainer(
                          "assets/images/Recycler_level_selection.svg",
                          -1, // levelsInfo[3]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //1,
                          context,
                            level: 1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold ZoneVilleSelection(double screenWidth, BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(zone.backgroundImagePath),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Center(
            child: Container(
              width: screenWidth,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      createContainer(
                          "assets/images/Puzzle_level_selection.svg",
                          3, // levelsInfo[0]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //3,
                          context,
                        level: 1,),
                      const SizedBox(
                        width: 10,
                      ),
                      createContainer(
                          "assets/images/Runner_level_selection.svg",
                          1, // levelsInfo[1]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //3,
                          context,
                        level: 1,),
                      const SizedBox(
                        width: 10,
                      ),
                      createContainer(
                          "assets/images/Pipes_level_selection.svg",
                          -1, // levelsInfo[2]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1, //2,
                          context,
                        level: 1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      createContainer(
                        "assets/images/Recycler_level_selection.svg",
                        -1 ,// levelsInfo[3]["isLocked"] == 0 ? levelsInfo[0]["stars"] : -1,
                        context,
                        level: 1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  InkWell createButtonFromAsset(String imagePath) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/icons/${imagePath}',
              ),
            )),
        width: 30.0,
        height: 30.0,
      ),
      onTap: () {
        // Do something when the button is pressed.
      },
    );
  }

  Widget createContainer(
      String imagePath, int numberOfStars, BuildContext context, {required int level}) {

    Generator generator = Generator(context: context);

    return GestureDetector(
      child: (numberOfStars > -1)
          ? SizedBox(
          width: generator.calculateX(203),
          height: generator.calculateY(147),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                width: generator.calculateX(203),
                height: generator.calculateY(147),
              ),
              Align(
                alignment: Alignment.center,
                child: getStars(numberOfStars),
              )
            ],
          ))
          : Container(
        child: SvgPicture.asset('assets/images/Locked_level.svg'),
      ),
      onTap: () {
        onLevelSelected(numberOfStars > -1 ? true : false, zone, level);
      },
    );
  }

}

class NewPage extends StatelessWidget {
  final String text;
  const NewPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 49, 69, 103),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 48.0,
        ),
      ),
    );
  }
}

void navigateToNewPage(BuildContext context, NewPage page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

Container getStars(int numberOfStars) {
  return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (numberOfStars == 0)
              ? SvgPicture.asset(
            'assets/stars/left_star_off.svg',
            width: 25.0,
          )
              : SvgPicture.asset(
            "assets/stars/left_star_on.svg",
            width: 25.0,
          ),
          (numberOfStars > 1)
              ? SvgPicture.asset('assets/stars/middle_star_on.svg', width: 25.0)
              : SvgPicture.asset("assets/stars/middle_star_off.svg", width: 25.0),
          (numberOfStars == 3)
              ? SvgPicture.asset(
            'assets/stars/right_star_on.svg',
            width: 25.0,
          )
              : SvgPicture.asset(
            "assets/stars/right_star_off.svg",
            width: 25.0,
          ),
        ],
      ));
}