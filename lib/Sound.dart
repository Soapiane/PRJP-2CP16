import 'package:audioplayers/audioplayers.dart';
import 'package:projet2cp/Info/Info.dart';

class Sound {
  static final Sound _instance = Sound._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory Sound() {
    return _instance;
  }

  final audioPlayer = AudioPlayer();


  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  Sound._internal() {
    // initialization logic
  }


  Future<void> iniState() async {
    // await audioPlayer
    //   ..setSource(AssetSource("audio/sound.m4a"))
    //   ..setReleaseMode(ReleaseMode.loop)
    //   ..setVolume(0.5)
    // ..resume();
    await audioPlayer.play(
      AssetSource("audio/sound.m4a"),
      volume: 0.5,
    );
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    if (!Info.sound) {
      audioPlayer.pause();
    }
  }


  // rest of class as normal
  void playSound() {
    if (!Info.sound) {
      audioPlayer.resume();
    }
  }

  void pauseSound() {
    if (!Info.sound) {
      audioPlayer.pause();
    }
  }

  void changeSoundState(bool state){
    if(state){
      audioPlayer.resume();
    }else{
      audioPlayer.pause();
    }
  }





}