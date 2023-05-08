

import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet2cp/Authentication/AuthMainBody.dart';
import 'package:projet2cp/Authentication/AvatarSelectionBody.dart';
import 'package:projet2cp/Info/Difficulty.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/MiniGames/MiniGameMainScreen.dart';
import 'package:projet2cp/MiniGames/Puzzle/PuzzleGame.dart';
import 'package:projet2cp/Navigation/Body.dart';
import 'package:projet2cp/Authentication/DifficultySelectionBody.dart';
import 'package:projet2cp/Authentication/LogInBody.dart';
import 'package:projet2cp/Authentication/RegisterBody.dart';
import 'package:projet2cp/Navigation/DefiState.dart';
import 'package:projet2cp/Navigation/Defis.dart';
import 'package:projet2cp/Navigation/LevelSelectionBody.dart';
import 'package:projet2cp/Navigation/Livre.dart';
import 'package:projet2cp/Navigation/Loading.dart';
import 'package:projet2cp/Navigation/Mode.dart';
import 'package:projet2cp/Navigation/ModeSelectionBody.dart';
import 'package:projet2cp/Navigation/Notifications/ChallengeNotification.dart';
import 'package:projet2cp/Navigation/Notifications/TrophyNotification.dart';
import 'package:projet2cp/Navigation/Profile/Profile.dart';
import 'package:projet2cp/Navigation/QuizSelectionBody.dart';
import 'package:projet2cp/Navigation/Settings.dart';
import 'package:projet2cp/Navigation/Trophies.dart';
import 'package:projet2cp/Navigation/Warning.dart';
import 'package:projet2cp/Navigation/Zone/ZoneBody.dart';
import 'package:projet2cp/Navigation/ZoneSelectionBody.dart';
import 'package:projet2cp/ButtonGenerator.dart';
import 'package:projet2cp/ImageGenerator.dart';
import 'package:projet2cp/Info/Language.dart';
import 'package:projet2cp/Repository/DatabaseRepository.dart';
import 'package:projet2cp/Repository/GuestRepository.dart';
import 'package:projet2cp/Sound.dart';
import 'package:projet2cp/StandardWidgets.dart';
import 'package:projet2cp/TextGenerator.dart';
import 'package:projet2cp/TextStyles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:projet2cp/Color.dart' as color;
import 'package:projet2cp/Navigation/Zones.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projet2cp/Authentication/MainScreen.dart' as ref;



class MainScreen extends StatefulWidget {



  static const String networkErrorString = "Pas de connexion internet!";
  static const String inputErrorString = "Les données entrées sont invalides!";

  bool signedIn;


  MainScreen({super.key, this.signedIn = false});



  @override
  State<StatefulWidget> createState() {

    return MainState();
  }

}


class MainState extends State<MainScreen> {

  late Function onExitPressed;
  static const double blurRadius = 2;
  late StandardWidgets standardWidgets;
  late Widget bookButton;
  late Body body;
  late ImageFilter blur;
  late AuthMainBody authMainBody;
  late LogInBody logInBody;
  late RegisterBody registerBody;
  late DifficultySelectionBody difficultySelectionBody;
  late ModeSelectionBody modeSelectionBody;
  late ZoneSelectionBody zoneSelectionBody;
  late LevelSelectionBody levelSelectionBody;
  late AvatarSelectionBody avatarSelectionBody;
  late Widget challengesButton, trophiesWidget;
  bool accountButtonVisible = true, bookButtonVisible = true;



  void goToAvatarSelectionBody() async {

    Loading.ShowLoading(context);

    for (int i=0; i<=9; i++) {

      await precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          "assets/avatars/avatar$i.svg",
        ),
        context,
      );

    }

    Loading.HideLoading(context);

    changeBodyWithNoBlur(newBody: avatarSelectionBody);
  }


  void getNotification(SharedPreferences prefs) async {

    String user = FirebaseAuth.instance.currentUser != null ? "" : "Guest";

      String? trophy =  prefs.getString("newTrophy$user");
      if (trophy != null) {

        prefs.remove("newTrophy$user");
        await showDialog(context: context, builder: (context) => TrophyNotification(title: trophy));


      }

      String? challenge = prefs.getString("newChallenge$user");
      if (challenge != null) {

        prefs.remove("newChallenge$user");
        await showDialog(context: context, builder: (context) => ChallengeNotification(title: challenge));

      }

  }

  Future<void> LoadAnimal(Zones zone) async {
    if(zone==Zones.mer){
      await Flame.images.loadAll([
        'AnimalGames/images/trashTurtle/trash2.png',
        'AnimalGames/images/trashTurtle/trash1.png',
        'AnimalGames/images/trashTurtle/trash3.png',
        'AnimalGames/images/trashTurtle/trash4.png',
        'AnimalGames/images/trashTurtle/trash5.png',
      ]
      );
    }else{
      if(zone==Zones.foret){
        await Flame.images.loadAll([
          'AnimalGames/images/trashBird/trash1.png',
          'AnimalGames/images/trashBird/trash2.png',
          'AnimalGames/images/trashBird/trash3.png',
          'AnimalGames/images/trashBird/trash4.png',
          'AnimalGames/images/trashBird/trash5.png',
        ]
        );
      }
    }
  }

  FutureOr<void> LoadPuzzle(Zones zone) async {
    int LevelDiff;
    if(Info.difficulty==Difficulty.EASY){
      LevelDiff=2;
    }else{
      if(Info.difficulty==Difficulty.MEDIUM){
        LevelDiff=3;
      }else{
        LevelDiff=4;
      }
    }
    for (int j = 1; j <= 5; j++) {
      if(zone==Zones.zoneIndustrielle){
        await Flame.images.load("Puzzle/images/zone_industrielle/"+LevelDiff.toString()+"x"+LevelDiff.toString()+"/"+j.toString()+ ".png");
        await Flame.images.load("Puzzle/images/zone_industrielle/images/$j.png");
      }else{
        if(zone==Zones.mer){
          await Flame.images.load("Puzzle/images/Mer/"+LevelDiff.toString()+"x"+LevelDiff.toString()+"/"+j.toString()+ ".png");
          await Flame.images.load("Puzzle/images/Mer/images/"+j.toString()+".png");
        }
      }
    }
    await Flame.images.load("Puzzle/images/Grid"+LevelDiff.toString()+".png");

    await Flame.images.load("Puzzle/images/zone_industrielle/images/1.png");

  }


  FutureOr<void> loadArrangerForet() async {

    await Flame.images.load("Runner_Forest/foret.png");
    await Flame.images.load("Runner_Forest/looking_curious.png");
    await Flame.images.load("Runner_Forest/captured_rabbit.png");
    await Flame.images.load("Runner_Forest/plant_umpty.png");
    await Flame.images.load("Runner_Forest/tap.png");
    await Flame.images.load("Runner_Forest/fixed_tap.png");
    await Flame.images.load("Runner_Forest/fixed_organic_trash.png");
    await Flame.images.load("Runner_Forest/organic_trash.png");
    await Flame.images.load("Runner_Forest/fixed_captured_rabbit.png");
    await Flame.images.load("Runner_Forest/fixed_plant_umpty.png");
    await Flame.images.load("Runner_Forest/coin.png");
    await Flame.images.load("Runner_Forest/leaf_coin.png");
    await Flame.images.load('Runner_Forest/plastic_tash.png');
    await Flame.images.load("Runner_Forest/fixed_plastic_trash.png");
    await Flame.images.load("Runner_Forest/avertissement.png");
  }

  FutureOr<void> loadArrangerVille() async {
    await Flame.images.load("Runner_Ville/ville.png");
    await Flame.images.load("Runner_Ville/looking_curious.png");
    await Flame.images.load("Runner_Ville/fixed_organic_trash.png");
    await Flame.images.load("Runner_Ville/organic_trash.png");
    await Flame.images.load("Runner_Ville/coin.png");
    await Flame.images.load("Runner_Ville/leaf_coin.png");
    await Flame.images.load('Runner_Ville/plastic_tash.png');
    await Flame.images.load("Runner_Ville/fixed_plastic_trash.png");
    await Flame.images.load("Runner_Ville/car.png");
    await Flame.images.load("Runner_Ville/lamp.png");
    await Flame.images.load("Runner_Ville/house.png");
    await Flame.images.load("Runner_Ville/paper_trash.png");
    await Flame.images.load("Runner_Ville/fixed_car.png");
    await Flame.images.load("Runner_Ville/fixed_lamp.png");
    await Flame.images.load("Runner_Ville/fixed_house.png");
    await Flame.images.load("Runner_Ville/fixed_paper_trash.png");
    await Flame.images.load("Runner_Ville/avertissement.png");
  }

  FutureOr<void> loadArrangerZoneIndustrielle() async {
    await Flame.images.load("Runner_Zone/foret.png");
    await Flame.images.load("Runner_Zone/looking_curious.png");
    await Flame.images.load("Runner_Zone/coin.png");
    await Flame.images.load("Runner_Zone/leaf_coin.png");
    await Flame.images.load('Runner_Zone/plastic_tash.png');
    await Flame.images.load("Runner_Zone/fixed_plastic_trash.png");
    await Flame.images.load("Runner_Zone/paper_trash.png");
    await Flame.images.load("Runner_Zone/fixed_paper_trash.png");
    await Flame.images.load("Runner_Zone/fixed_paper_trash.png");
    await Flame.images.load("Runner_Zone/broken_eolienne.png");
    await Flame.images.load("Runner_Zone/fixed_broken_eolienne.png");
    await Flame.images.load("Runner_Zone/avertissement.png");
    await Flame.images.load("Runner_Zone/fixed_broken_eolienne.png");
    await Flame.images.load("Runner_Zone/fixed_polluting_factory.png");
    await Flame.images.load("Runner_Zone/nuclear_trash.png");
    await Flame.images.load("Runner_Zone/polluting_factory.png");
  }


  void levelTaped(bool unlocked, Zones zone, int order, {bool? restart}) async {
    if (unlocked){
      restart ??= false;
      Loading.ShowLoading(context);


      MiniGameMainScreen miniGameMainScreen = MiniGameMainScreen(miniGameOrder: order, zone: zone, mainScreenRef: this as ref.MainState, restart: restart!,);


      for (int i=0; i<=3; i++) {

        await precachePicture(
          ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder,
            "assets/hud/score_screen/stars/${i}_stars_score.svg",
          ),
          context,
        );

      }

      await precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          "assets/hud/score_screen/image.svg",
        ),
        context,
      );

      print(zone.toString() + order.toString());

      if ((zone == Zones.zoneIndustrielle || zone == Zones.mer) && order == 3) {
        await LoadPuzzle(zone);
      } else if ((zone == Zones.mer && order == 1) || (zone == Zones.foret && order == 3)) {
        await LoadAnimal(zone);
      } else if (zone == Zones.foret && order == 1) {
        await loadArrangerForet();
      } else if (zone == Zones.ville && order == 2){
        await loadArrangerVille();
      } else if (zone == Zones.zoneIndustrielle && order ==  1) {
        await loadArrangerZoneIndustrielle();
      }



      Loading.HideLoading(context);

      bool? restarting = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context)  => miniGameMainScreen
          )
      );

      restarting ??= false;

      if (!restarting) {
        print("SYNCING");

        Loading.ShowLoading(text: "synchronisation...", context);
        await DatabaseRepository().sync(); //this one is to sync the challenges
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Loading.HideLoading(context);

        if (body.toString().compareTo("QuizSelectionBody") == 0) {
          await goToQuizMode();
        } else if (body.toString().compareTo("LevelSelectionBody") == 0) {
          await goToLevelSelectionBody(zone);
        }

        getNotification(prefs);


      }
    }
  }







  Future<List<List<int>>> getZonesInfo() async {

    List<int> starsCollected = [], starsMax = [];

    User? user = FirebaseAuth.instance.currentUser;
    Database database;
    if(user != null){
      database = DatabaseRepository().database!;
    }else{
      database = GuestRepository().database!;
    }

    List<Map> zones = await database.rawQuery("SELECT * FROM zone ORDER BY id ASC");

    for (Zones zone in Zones.values) {
      starsCollected.add(zones[zone.index]["stars"]);
      starsMax.add(zones[zone.index]["levelsNb"]*3);
    }

    return [starsCollected, starsMax];



  }

  void goToAdventureMode() async {

    Loading.ShowLoading(context);

    List<int> starsCollected = [], starsMax = [];
    List<List<int>> zonesInfo = await getZonesInfo();
    starsCollected = zonesInfo[0];
    starsMax = zonesInfo[1];


    await precacheImage(
      Image.asset("assets/zones/cards/foret.png").image,
      context,
    );

    await precacheImage(
      Image.asset("assets/zones/cards/mer.png").image,
      context,
    );

    await precacheImage(
      Image.asset("assets/zones/cards/ville.png").image,
      context,
    );

    await precacheImage(
      Image.asset("assets/zones/cards/zoneIndustrielle.png").image,
      context,
    );



    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/zones/star.svg",
      ),
      context,
    );


    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/nav_buttons/challenges.svg",
      ),
      context,
    );

    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/nav_buttons/trophies.svg",
      ),
      context,
    );

    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/nav_buttons/back.svg",
      ),
      context,
    );

    Loading.HideLoading(context);

    changeBodyWithBlur(
      newBody: ZoneSelectionBody(
        onCardTap: goToLevelSelectionBody, starsCollected: starsCollected, starsMax: starsMax,
      ),
      lastBody: modeSelectionBody,
    );



  }



  Future<List<Map>> getQuizzesInfo() async {

    List<Map> quizzes = [];

    User? user = FirebaseAuth.instance.currentUser;
    Database database;
    if(user != null){
      database = DatabaseRepository().database!;
    }else{
      database = GuestRepository().database!;
    }

    quizzes = await database.query(
      "level",
      where: "isQuiz = ?",
      whereArgs: [1],
      orderBy: "zone_id",
    );


    if (quizzes.isEmpty) {
      List<Map> inCase = [];
      for (Zones zone in Zones.values) {
        Map<String, Object?> map = {
          "stars": 0,
          "isLocked": 1,
        };
        inCase.add(map);
      }
      return inCase;
    }

    return quizzes;



  }



  FutureOr<void> goToQuizMode() async {

    List<Map> quizzesInfo = await getQuizzesInfo();


    await precacheImage(
      Image.asset("assets/zones/cards/foret.png").image,
      context,
    );

    await precacheImage(
      Image.asset("assets/zones/cards/mer.png").image,
      context,
    );

    await precacheImage(
      Image.asset("assets/zones/cards/ville.png").image,
      context,
    );

    await precacheImage(
      Image.asset("assets/zones/cards/zoneIndustrielle.png").image,
      context,
    );



    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/zones/star.svg",
      ),
      context,
    );


    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/zones/cards/lock.svg",
      ),
      context,
    );




    changeBodyWithBlur(
      newBody: QuizSelectionBody(
        onCardTap: levelTaped, quizzesInfo: quizzesInfo,
      ),
      lastBody: modeSelectionBody,
    );



  }




  FutureOr<void> goToLevelSelectionBody(Zones zone) async {
    Loading.ShowLoading(context);


    List<Map> levelsinfo = [];

    if (FirebaseAuth.instance.currentUser != null) {
      levelsinfo = await DatabaseRepository().database!.query(
        "level",
        where: "zone_id = ?",
        whereArgs: [zone.id],
        orderBy: "id ASC",
      );
    } else {
      levelsinfo = await GuestRepository().database!.query(
        "level",
        where: "zone_id = ?",
        whereArgs: [zone.id],
        orderBy: "level ASC",
      );
    }




    await precacheImage(
      Image.asset(zone.backgroundImagePath).image,
      context,
    );



    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Bird_level_selection.svg",
      ),
      context,
    );

    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Locked_level.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Pipes_level_selection.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Puzzle_level_selection.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Quiz_level_selection.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Recycler_level_selection.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Runner_level_selection.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/images/Turtle_level_selection.svg",
      ),
      context,
    );

    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/stars/left_star_off.svg",
      ),
      context,
    );

    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/stars/left_star_on.svg",
      ),
      context,
    );

    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/stars/middle_star_off.svg",
      ),
      context,
    );
    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/stars/middle_star_on.svg",
      ),
      context,
    );


    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/stars/right_star_off.svg",
      ),
      context,
    );


    await precachePicture(
      ExactAssetPicture(
        SvgPicture.svgStringDecoderBuilder,
        "assets/stars/right_star_on.svg",
      ),
      context,
    );



    Loading.HideLoading(context);


    setState(() {

      levelSelectionBody = LevelSelectionBody(zone: zone, onLevelSelected: levelTaped, levelsInfo: levelsinfo,);
      changeBodyWithBlur(newBody: levelSelectionBody);

    });
  }

  void changeBodyWithBlur({required Body newBody, Body? lastBody}){
    setState(() {

      blur = ImageFilter.blur(
        sigmaX: blurRadius,
        sigmaY: blurRadius,
      );
      changeBody(newBody: newBody, lastBody: lastBody);
    });
  }

  void changeBodyWithNoBlur({required Body newBody, Body? lastBody}){
    setState(() {

      blur = ImageFilter.blur(
        sigmaX: 0,
        sigmaY: 0,
      );
      changeBody(newBody: newBody, lastBody: lastBody);
    });
  }


  void changeBody({required Body newBody, Body? lastBody}){
      lastBody ??= body;
      newBody.lastScreen = lastBody;
      body = newBody;

  }



  @override
  void initState() {
    super.initState();


    blur = ImageFilter.blur(
      sigmaX: 0,
      sigmaY: 0,
    );



    // zoneSelectionBody = ZoneSelectionBody(
    //   onCardTap: goToZoneBody,
    // );

    modeSelectionBody = ModeSelectionBody(
      onModeSelected: (mode){
        if (mode == Mode.adventure) {
          goToAdventureMode();
        } else if (mode == Mode.quiz) {
          goToQuizMode();
        }
      },
    );

    avatarSelectionBody = AvatarSelectionBody(
      onFinally: (){


        changeBodyWithBlur(newBody: modeSelectionBody, lastBody: authMainBody);
      },
    );

    difficultySelectionBody = DifficultySelectionBody(
      onContinue: (){
        goToAvatarSelectionBody();
      },
    );


    registerBody = RegisterBody(
      onRegister: (){

        register();
      },
      showErrorDialog: showError,
      mainContext: context,
    );


    logInBody = LogInBody(
      onConnexion: (){

        logIn();
      },
      onRegister: (){
        goToRegister();
      },
      showErrorDialog: showError,
      mainContext: context,
    );


    authMainBody = AuthMainBody(
      onConnexionPressed: (){
        goToLogIn();
      },
      onPlay: (){
        changeBodyWithBlur(newBody: modeSelectionBody);
      },
    );





    body = widget.signedIn ? modeSelectionBody : authMainBody;





  }





  @override
  Widget build(BuildContext context) {


    onExitPressed = onExit;

    logInBody.mainContext = context;
    registerBody.mainContext = context;


    standardWidgets = StandardWidgets(context: context);
    Function? onBackButtonTapped, onChallengeButtonTapped, onTrophiesButtonTapped, onBookButtonTapped;


    switch (body.toString()){
      case "AuthMainBody":{
        accountButtonVisible = false;
        onBackButtonTapped = null;
        onExitPressed = SystemNavigator.pop;
      }
      break;
      case "DifficultySelectionBody":{
        accountButtonVisible = false;
        onBackButtonTapped = null;
      }
      break;
      case "AvatarSelectionBody":{
        accountButtonVisible = false;
        onBackButtonTapped = null;
      }
      break;
      case "ModeSelectionBody":{
        accountButtonVisible = true;
        onBackButtonTapped = null;

          onBookButtonTapped = () {
            openTheBook();
          };


      }
      break;
      default:{

        if (body.toString().compareTo("LogInBody") != 0 && body.toString().compareTo("RegisterBody") != 0 ) {
          onBookButtonTapped = () {
            openTheBook();
          };

        }



        accountButtonVisible = true;
        if (body.toString().compareTo("ZoneSelectionBody") == 0 || body.toString().compareTo("LevelSelectionBody") == 0 ) {
          onChallengeButtonTapped = () {

            showChallenges();
          };
          onTrophiesButtonTapped = () {
            showTrophies();
          };
        }
        onBackButtonTapped = () {
          setState(() {
            blur = ImageFilter.blur(
              sigmaX: body.lastScreen!.isBlured ? blurRadius : 0,
              sigmaY: body.lastScreen!.isBlured ? blurRadius : 0,
            );
            body = body.lastScreen ?? body;
          });
        };


        if (body.toString().compareTo("LevelSelectionBody") == 0 ) {
          onBackButtonTapped = () {
            goToAdventureMode();
          };
        }

      }
      break;
    }

    if (FirebaseAuth.instance.currentUser == null) {
      print("LOGGING IN");
      accountButtonVisible = false;
    }






    // onBackButtonTapped = body.toString().compareTo("AuthMainBody") == 0 ? null : (){
    //   setState(() {
    //     blur = ImageFilter.blur(
    //       sigmaX: body.lastScreen!.isBlured ? blurRadius : 0,
    //       sigmaY: body.lastScreen!.isBlured ? blurRadius : 0,
    //     );
    //     body = body.lastScreen ?? body;
    //   });
    // };


    Widget foreground = createForeground(
      onBackButtonTapped: onBackButtonTapped,
      onChallengeButtonTapped: onChallengeButtonTapped,
      onTrophiesButtonTapped: onTrophiesButtonTapped,
      onBookButtonTapped: onBookButtonTapped,
    );

    Widget background = Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
            image: Image.asset("assets/main_background.png").image,
            fit: BoxFit.cover
        ),
      ),
      child: BackdropFilter(
        filter: blur,
        child: body,
      ),
    );




    return Scaffold(
      body: Stack(
        children: [
          background,

          foreground,



        ],
      ),
    );


  }

  Future<void> signOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await DatabaseRepository().signOut();
    } else {
      await GuestRepository().closeDB();
    }
  }

  void onExit(){
    setState(() {
      Navigator.of(context).pop();
      body.lastScreen = authMainBody;
      blur = ImageFilter.blur(
        sigmaX: body.lastScreen!.isBlured ? blurRadius : 0,
        sigmaY: body.lastScreen!.isBlured ? blurRadius : 0,
      );
      body = body.lastScreen ?? body;
      signOut();

    });
  }




  Widget createForeground({
    Function? onBackButtonTapped,
    Function? onChallengeButtonTapped,
    Function? onTrophiesButtonTapped,
    Function? onBookButtonTapped,
  }){
    ButtonGenerator buttonGenerator = ButtonGenerator(context: context);
    double topPadding = buttonGenerator.calculateY(10);
    double horizontalPadding = buttonGenerator.calculateX(21);
    return Stack(
      children: [Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, left: horizontalPadding, right: horizontalPadding),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              onBackButtonTapped!=null ? standardWidgets.backButton(onBackButtonTapped: onBackButtonTapped) : SizedBox.shrink(),
              onChallengeButtonTapped!=null ? standardWidgets.challengesButton(onChallengesButtonTapped: onChallengeButtonTapped) : SizedBox.shrink(),
              onTrophiesButtonTapped!=null ? standardWidgets.trophiesButton(onTrophiesButtonTapped: onTrophiesButtonTapped) : SizedBox.shrink(),
              standardWidgets.settingsButton((){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Settings(onDeconnexion: onExitPressed, onBackButtonTapped: Navigator.of(context).pop);
                  },
                );
              }),

            ],
          ),
        ),
      ),
        FirebaseAuth.instance.currentUser != null && accountButtonVisible ? Padding(
          padding:  EdgeInsets.only(bottom: topPadding, right: horizontalPadding),
          child: Align(
            alignment: Alignment.bottomRight,
            child:
            buttonGenerator.generateImageButtom(
              height: standardWidgets.dim,
              width: standardWidgets.dim,
              borderRadius: BorderRadius.circular(23.5),
              imagePath: "assets/nav_buttons/account.svg",
              onTap: (){
                showProfileSetting();
              },
            ),
          ),
        ) : const SizedBox.shrink(),
        onBookButtonTapped != null ?
        Padding(
          padding:  EdgeInsets.only(bottom: topPadding, left: horizontalPadding),
          child: Align(
            alignment: Alignment.bottomLeft,
            child:
            buttonGenerator.generateImageButtom(
              height: standardWidgets.dim,
              width: standardWidgets.dim,
              borderRadius: BorderRadius.circular(23.5),
              imagePath: "assets/nav_buttons/book.svg",
              onTap: onBookButtonTapped,
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }

  void goToLogIn() async {

    Loading.ShowLoading(context);
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {

      await precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          "assets/terra/earth_sleeping.svg",
        ),
        context,
      );


      await precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          "assets/nav_buttons/back.svg",
        ),
        context,
      );

      Loading.HideLoading(context);

      changeBodyWithNoBlur(newBody: logInBody);
    } else {
      showError("Pas de connexion internet!");
    }

  }


  void logIn() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      Loading.HideLoading(context);
      changeBodyWithBlur(newBody: modeSelectionBody);
    } else {
      showError(MainScreen.networkErrorString);
    }

  }

  void goToRegister() async {



    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {

      await precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          "assets/terra/earth_hi.svg",
        ),
        context,
      );


      changeBodyWithNoBlur(newBody: registerBody);
    } else {
      
      showError(MainScreen.networkErrorString);
    }
  }

  void register() async {

      bool result = await InternetConnectionChecker().hasConnection;
      if(result == true) {
        Loading.HideLoading(context);
        changeBodyWithNoBlur(newBody: difficultySelectionBody);
      } else {
        showError(MainScreen.networkErrorString);
      }

  }

  void showError(String error){
    Loading.HideLoading(context);
    setState(() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => Warning(onOk: (){Navigator.of(context).pop();}, text: error,),
      );
    });
  }

  void openTheBook() async {

    Loading loading = Loading.ShowLoading(context, progressBar: true);



    await Future.delayed(Duration(milliseconds: 300),(){});

    for (var i = 1; i < 60; ++i) {

      await precacheImage(
        Image.asset("assets/livre/book_png/page$i.png").image,
        context,
      );

      loading.updateProgress(i/59);

    }



    Loading.HideLoading(context);

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Livre()),
    );

    Sound().playSound();

  }

  void showProfileSetting() async{

    Loading.ShowLoading(context);

    for (int i=0; i<=9; i++) {

      await precachePicture(
        ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          "assets/avatars/avatar$i.svg",
        ),
        context,
      );

    }

    Loading.HideLoading(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Profile();
      },
    );
  }


  void showChallenges() async {

    Loading.ShowLoading(context);

    List<List<String>> challenges = await getChallenges();

    Loading.HideLoading(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Defis(Rea : challenges[0], NonRea : challenges[1]);
      },
    ).then((value) {

      FirebaseAuth.instance.currentUser != null ? DatabaseRepository().uploadChallenges() : null;
    });

  }

  Future<List<List<String>>> getChallenges() async {

    List<String> Rea = [], NonRea = [];

    if (FirebaseAuth.instance.currentUser != null) {

      void afterSyncingChallenges() async {


        List<Map> challengesCollected = await (DatabaseRepository().database!.query(
          "challenge",
          where: "state = ?",
          whereArgs: [DefiState.collected.index],
        ));


        List<Map> challengesDone = await   DatabaseRepository().database!.query(
          "challenge",
          where: "state = ?",
          whereArgs: [DefiState.done.index],
        );


        for (Map challenge in challengesCollected) {
          NonRea.add(challenge["title"]);
        }


        for (Map challenge in challengesDone) {
          Rea.add(challenge["title"]);
        }

      }

      await DatabaseRepository().syncChallenges(afterSyncingChallenges);
    } else {
      List<Map> challengesCollected = await (GuestRepository().database!.query(
        "challenge",
        where: "state = ?",
        whereArgs: [DefiState.collected.index],
      ));

      List<Map> challengesDone = await GuestRepository().database!.query(
        "challenge",
        where: "state = ?",
        whereArgs: [DefiState.done.index],
      );
      for (Map challenge in challengesCollected) {
          NonRea.add(challenge["title"]);
      }


      for (Map challenge in challengesDone) {
        Rea.add(challenge["title"]);
      }


    }

    return [Rea, NonRea];
  }


  void showTrophies() async {



    Loading.ShowLoading(context);
      List<String> Accomplis = [];
      List<String> NonAccomplis = [];

      Database database = FirebaseAuth.instance.currentUser != null ? DatabaseRepository().database! : GuestRepository().database!;

      List<Map> trophiesCollected = await database.query(
        "trophy",
        where: "isCollected = ?",
        whereArgs: [1],
      );

      List<Map> trophiesNonCollected = await database.query(
        "trophy",
        where: "isCollected = ?",
        whereArgs: [0],
      );

      setState(() {
        for (Map trophy in trophiesCollected) {
          Accomplis.add(trophy["title"]);
        }

        for (Map trophy in trophiesNonCollected) {
          NonAccomplis.add(trophy["title"]);
        }
      });

      Loading.HideLoading(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Trophies(Accomplis: Accomplis, NonAccomplis: NonAccomplis,);
        },
      );






  }










}