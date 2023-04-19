import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet2cp/Authentication/AuthMainScreen.dart';
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

  setLandscapeMode();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
