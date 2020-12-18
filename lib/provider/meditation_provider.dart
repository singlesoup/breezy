import 'package:breezy/models/sound_details.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';


class MeditationProvider extends ChangeNotifier {
  var audioPlayer = AssetsAudioPlayer();
  PausableTimer sngTimer;

  String timerString = ' ';
  String chipsTxt = '';
  String chipsT2 = '';
  String chipsT3 = '';

  int value; // this to sort out various cat. of meditaions
  int valT = 0;
  int soundAccess = 0;
  int selectedChip = 0;

  bool isPaused = false;
  bool isplaying = false;
  bool isSongSelected = false;
  bool isStop = false;
  bool isChipSelected = false;
  bool meditaionsPressed = false;
  bool isRestarted = true;

  List<String> timer = [
    '5:00',
    '10:00',
    '20:00',
    '30:00',
  ];

  List<Sounds> sounds = [
    Sounds(
      title: 'Body Scan (20 mins)',
      audio: Audio(
        'assets/audios/bodyScan.mp3',
      ),
    ),
    Sounds(
      title: 'Guided Visualization (9 mins)',
      audio: Audio(
        'assets/audios/guidedVisualization.mp3',
      ),
    ),
    Sounds(
      title: 'Iam (6 mins)',
      audio: Audio(
        'assets/audios/iam.mp3',
      ),
    ),
    Sounds(
      title: 'Mindfulness of Breathing (16 mins)',
      audio: Audio(
        'assets/audios/mindfulness_of_breathing.mp3',
      ),
    ),
    Sounds(
      title: 'Yoga Nidra (21 mins)',
      audio: Audio(
        'assets/audios/yogaNidra.mp3',
      ),
    ),
  ];

  List<Sounds> sounds1 = [
    Sounds(
      title: 'Om (6mins)',
      audio: Audio(
        'assets/audios/ohm.mp3',
      ),
    ),
    Sounds(
      title: 'Navajo Night (24mins)',
      audio: Audio(
        'assets/audios/navajonight.mp3',
      ),
    ),
  ];

  String formatHHMMSS({int seconds}) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  void getDuration() {
    // for guided
    if (value == 1) {
      switch (soundAccess) {
        case 0:
          valT = (20 * 60) + 25; // into seconds
          break;
        case 1:
          valT = 9 * 60;
          break;
        case 2:
          valT = (6 * 60) + 26;
          break;
        case 3:
          valT = (16 * 60) + 9;
          break;
        case 4:
          valT = (21 * 60) + 24;
          break;
        default:
          print('wrong input');
      }
    } else if (value == 2) {
      switch (soundAccess) {
        case 0:
          valT = (6 * 60) + 10; // into seconds
          break;

        case 1:
          valT = 24 * 60;
          break;

        default:
          print('wrong input');
      }
    } else {
      switch (soundAccess) {
        case 0:
          valT = 5 * 60;
          break;
        case 1:
          valT = 10 * 60;
          break;
        case 2:
          valT = 20 * 60;
          break;
        case 3:
          valT = 30 * 60;
          break;
        default:
          print('wrong input');
      }
    }

    timerString = formatHHMMSS(seconds: valT);
    print('TimerString: $timerString');
    notifyListeners();

    //? taking total duration of the song as for the timer, this works but doesn't update
    // audioPlayer.current.listen((playing) {
    //   valT = playing.audio.duration.inSeconds;
    //   // notifyListeners();
    // });
  }

  void songsTimer() {
    sngTimer = PausableTimer(Duration(seconds: 1), () {
      valT--;
      if (valT > 0) {
        sngTimer
          ..reset()
          ..start();
      } else {
        isRestarted = false;
        print('Is Restarted: $isRestarted');
        notifyListeners();
      }
      //print('valT ========> $valT');
      timerString = formatHHMMSS(seconds: valT);
      notifyListeners();
    });
    // notifyListeners();
  }

  void opensong() {
    if (value == 1) {
      audioPlayer.open(
        sounds[soundAccess].audio,
      );
      notifyListeners();
    } else if (value == 2) {
      audioPlayer.open(
        sounds1[soundAccess].audio,
      );
      notifyListeners();
    }
    sngTimer.start();
    notifyListeners();
  }

  void restartsong() {
    // kill the playing song
    audioPlayer.stop();

    // re open it again
    getDuration();
    if (value == 1) {
      audioPlayer.open(
        sounds[soundAccess].audio,
      );
      notifyListeners();
    } else if (value == 2) {
      audioPlayer.open(
        sounds1[soundAccess].audio,
      );
      notifyListeners();
    }
    sngTimer.start();
    isPaused = false;
    //print('isPaused (restart) : $isPaused');
    notifyListeners();
  }

  void playOrPause() {
    print('value : $value');
    if (value == 1 || value == 2) {
      audioPlayer.playOrPause();
      notifyListeners();
    }
    isPaused ? sngTimer.start() : sngTimer.pause();
    notifyListeners();
  }

  void play() {
    if (value == 1 || value == 2) {
      audioPlayer.play();
    }
    sngTimer.start(); // to resume
    notifyListeners();
  }

  void pause() {
    if (value == 1 || value == 2) {
      audioPlayer.pause();
    }
    sngTimer.pause(); // to pause
    notifyListeners();
  }

  void assign(int val) {
    if (value == 1) {
      //print('chips $val');
      chipsTxt = sounds[val].title;
      notifyListeners();
    } else if (value == 2) {
      //print('chips $val');
      chipsT2 = sounds1[val].title;
      notifyListeners();
    } else {
      // print('chips $val');
      chipsT3 = timer[val];
      notifyListeners();
    }
    soundAccess = val;
    selectedChip = val;
    notifyListeners();
  }
}
