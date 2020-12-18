import 'package:breezy/animation/pulsating_circle.dart';
import 'package:breezy/constants/globals.dart';
import 'package:breezy/provider/meditation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedationAnimationScreen extends StatefulWidget {
  @override
  _MedationAnimationScreenState createState() =>
      _MedationAnimationScreenState();
}

class _MedationAnimationScreenState extends State<MedationAnimationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // for only timer
    MeditationProvider provider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (provider.sngTimer.isExpired &&
          //provider.value == 3 &&
          provider.isRestarted == false) {
        showGreetDialog();
      }
    });
  }

  Future showGreetDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            title: Text(
              'Congrats 🎉🎉.  You have completed this session. How do you feel? Same again Tomorrow ?',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
            ),
            content: Text(
              'Thank you for Breathing',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).popUntil(
                        ModalRoute.withName(Navigator.defaultRouteName));
                    MeditationProvider provider =
                        Provider.of(context, listen: false);
                    provider.isSongSelected = false;
                    provider.value = 0;
                  });
                },
                child: Text(
                  'cancel'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                      ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).popUntil(
                        ModalRoute.withName(Navigator.defaultRouteName));
                    MeditationProvider provider =
                        Provider.of(context, listen: false);
                    provider.isSongSelected = false;
                    provider.value = 0;
                  });
                },
                child: Text(
                  'okay'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                      ),
                ),
              ),
            ],
          );

          // Experiment

          // CupertinoAlertDialog(
          //   content: Text(
          //     'Congrats 🎉🎉.  You have completed this session. How do you feel? Same again Tomorrow ?',
          //     style: Theme.of(context).textTheme.bodyText1.copyWith(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.grey[700],
          //         ),
          //   ),
          //   title: Text(
          //     'Thank you for Breathing',
          //     style: Theme.of(context).textTheme.bodyText1.copyWith(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.grey[800],
          //         ),
          //   ),
          //   actions: [
          //     FlatButton(
          //       onPressed: () {
          //         setState(() {
          //           Navigator.of(context).popUntil(
          //               ModalRoute.withName(Navigator.defaultRouteName));
          //           MeditationProvider provider =
          //               Provider.of(context, listen: false);
          //           provider.isSongSelected = false;
          //           provider.value = 0;
          //         });
          //       },
          //       child: Text(
          //         'okay',
          //         style: Theme.of(context).textTheme.bodyText1.copyWith(
          //               fontWeight: FontWeight.bold,
          //               color: Colors.blue[300],
          //             ),
          //       ),
          //     ),
          //   ],
          // );
        });
  }

// Also when back is pressed from the mobile
  Future<bool> restart() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            title: Text(
              'Are you sure you want to restart the meditation ?',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'NO',
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        fontSize: 14,
                      ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  MeditationProvider provider =
                      Provider.of(context, listen: false);
                  provider.restartsong();
                  setState(() {
                    provider.isRestarted = true;
                  });
                },
                child: Text(
                  'YES',
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        fontSize: 14,
                      ),
                ),
              ),
            ],
          );
        });
  }

  Future<bool> goBack() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            title: Text(
              'Are you sure you want to close this meditation session?',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'NO',
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        fontSize: 14,
                      ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  MeditationProvider provider =
                      Provider.of(context, listen: false);
                  provider.pause();
                  provider.isplaying = false;

                  setState(() {
                     provider.value = 0;
                    provider.isSongSelected = false;
                    provider.isChipSelected = false;
                  });

                  // provider.restartsong();
                  // setState(() {
                  //   provider.isRestarted = true;
                  // });
                },
                child: Text(
                  'YES',
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                        fontSize: 14,
                      ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Global().init(context);
    MeditationProvider provider = Provider.of(context, listen: false);
    return WillPopScope(
      onWillPop: provider.audioPlayer.isPlaying != null ? goBack : null,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  provider.pause();
                  provider.isplaying = false;
                },
                child: Icon(Icons.close, size: Global.screenWidth * 0.1, color: Colors.black87),
              ),
            ),
            Align(
              child: PulsatingCircle(
                color: Colors.blue,
                paddingSize: 100,
              ),
            ),
            Positioned(
              bottom: Global.screenHeight / 2 - 10,
              left: 130,
              right: 130,
              child: Center(
                child: Text(
                  Provider.of<MeditationProvider>(context, listen: true)
                      .timerString,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: Global.screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            Positioned(
              bottom: Global.screenHeight / 2 - 30,
              left: 130,
              right: 130,
              child: GestureDetector(
                onTap: () {
                  restart();
                  //print('Restart pressed');
                },
                child: Center(
                  child: Text(
                    'Restart'.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: Global.screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 75,
              right: 75,
              child: Center(
                child: FlatButton(
                  splashColor: Colors.blue.withOpacity(0.2),
                  onPressed: () {
                    setState(() {
                      provider.playOrPause();
                      provider.isPaused = !provider.isPaused;
                      //print('isPaused:${provider.isPaused}');
                    });
                  },
                  child: Text(
                    provider.isPaused
                        ? 'Tap to rejoin'.toUpperCase()
                        : 'Tap to pause'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.blue[300],
                          fontSize: Global.screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
