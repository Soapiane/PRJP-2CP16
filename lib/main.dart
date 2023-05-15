import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet2cp/Authentication/MainScreen.dart';
import 'package:projet2cp/Info/Info.dart';
import 'package:projet2cp/Sound.dart';
import 'package:projet2cp/SplashScreen/SplashScreen.dart';
import 'package:projet2cp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



void setLandscapeMode() {

  /*
      * this code locks the rotation into landscape mode
      * */
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  /*******************************************/


  /*
  * this code makes the UI go into full screen mode
  * */
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  /*******************************************/


}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); //this line is to make sure that the main widget is fully initialized

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Info.iniState();

  await Sound().iniState();


  setLandscapeMode();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver{
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   WidgetsBinding.instance.addObserver(this);


    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      Sound().playSound();
    } else {

      Sound().audioPlayer.pause();
    }
  }



}
