/*
    this will include
    -breathe for given time
    -meditate for asked time ; timer, which notifies after the timer is up
    -meditate with tracks
 */

import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:breezy/constants/globals.dart';
import 'package:breezy/painter/meditation_painter.dart';
import 'package:breezy/provider/meditation_provider.dart';
import 'package:breezy/widgets/settings_radioButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/meditation_animation_screen.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final audio = AssetsAudioPlayer();
  bool isDisposed = false;
  // bool isSelected = true;
  MeditationProvider provider;

  @override
  void dispose() {
    if (isDisposed) {
      audio.dispose();
      provider.sngTimer.cancel();
      print('dispose : $isDisposed');
      isDisposed = true;
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of(context, listen: false);
  }

  // Legacy code

  // void showMessage(BuildContext context) {
  //   Flushbar(
  //     padding: EdgeInsets.all(10),
  //     borderRadius: 8,
  //     backgroundGradient: LinearGradient(
  //       colors: [
  //         Colors.blue[400],
  //         Colors.blue[800],
  //       ],
  //     ),
  //     boxShadows: [
  //       BoxShadow(
  //         color: Colors.black45,
  //         offset: Offset(3, 3),
  //         blurRadius: 3,
  //       ),
  //     ],
  //     duration: Duration(seconds: 5),
  //     //dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //     forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  //     title: 'A Gentle Remainder',
  //     messageText: Text(
  //       'Please don\'t go back in the middle of the meditation session. It will clear all the saved infomation.',
  //       style: Theme.of(context).textTheme.bodyText1.copyWith(
  //             color: Colors.grey[50],
  //             fontSize: Global.screenWidth * 0.035,
  //           ),
  //     ),
  //   ).show(context);
  // }

  Future<bool> songExist() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            title: Text(
              'Please choose something from settings ?',
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'cancel'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        color: Colors.blue[300],
                        fontWeight: FontWeight.bold,
                        fontSize: Global.screenWidth * 0.035,
                      ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  'okay'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        color: Colors.blue[300],
                        fontSize: Global.screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Global().init(
        context); // This is self defined class which help us to pass MediaQuery ScreenSize
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Global.screenHeight,
            width: Global.screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[400],
                  Colors.blue[800],
                ],
              ),
            ),
          ),
          CustomPaint(
            painter: MeditationPainter(),
            child: Container(
              height: Global.screenHeight,
              width: Global.screenWidth,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            // A container that expands to the full available space.
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Text(
              'breezy',
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.grey[50],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // child: GestureDetector(
            //   onTap: closingProcesses,
            //   child: Icon(
            //     Icons.close,
            //     size: 30,
            //     color: Theme.of(context).iconTheme.color,
            //   ),
            // ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: InkWell(
              splashColor: Colors.grey,
              onTap: () {
                openSettings(context);
              },
              child: Icon(
                Icons.settings,
                size: 30,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Find a Comfortable place to Seat..',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.grey[200],
                            fontSize: Global.screenWidth * 0.08,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'The Aim is not to fight your mind but to acknowledge and embrace everything that\'s happening around you and let go.',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: Global.screenWidth * 0.05,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: RaisedButton(
              onPressed: meditateProcesses,
              padding: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              // This is used to make the button with gradient colors
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[100],
                      Colors.blue[500],
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Meditate".toUpperCase(),
                    style: Theme.of(context).textTheme.button.copyWith(
                        //color: Colors.white.withOpacity(0.85),
                        color: Colors.grey[50],
                        fontSize: Global.screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openSettings(BuildContext ctx) {
    Navigator.of(ctx).push(
      CupertinoPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }

  void meditateProcesses() {
    MeditationProvider provider = Provider.of(context, listen: false);
    if (provider.isSongSelected) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => MedationAnimationScreen(),
        ),
      );
      //print('Playing: ${provider.isplaying}');
      setState(() {
        provider.isplaying == false ? provider.play() : provider.opensong();

        isDisposed = true;
      });
    } else {
      songExist(); // Alert Dialog
    }
    provider.meditaionsPressed = true;
  }

  // Legacy code
  // void closingProcesses() {
  //   MeditationProvider provider = Provider.of(context, listen: false);
  //   if (isDisposed) {
  //     Navigator.pop(context);
  //     provider.audioPlayer.stop();
  //     provider.sngTimer.cancel();
  //     provider.isSongSelected = false;

  //     //print('isSelected (c1): $isSelected');
  //   } else {
  //     Navigator.pop(context);
  //     provider.isSongSelected = false;
  //     //print('isSelected (c): $isSelected');
  //   }
  //   // if (provider.meditaionsPressed && isDisposed) {
  //   //   showMessage(context);
  //   // }
  //   provider.value = 0;

  //   // for showing the selected radio button
  // }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Global().init(context);
    return Stack(
      children: [
        Container(
          height: Global.screenHeight,
          width: Global.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[400],
                Colors.blue[800],
              ],
            ),
          ),
        ),
        CustomPaint(
          painter: MeditationPainter(),
          child: Container(
            height: Global.screenHeight,
            width: Global.screenWidth,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: 30,
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontSize: Global.screenWidth * 0.04,
                  //letterSpacing: 1,
                  fontStyle: FontStyle.normal),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Meditation Type'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white70,
                              fontSize: Global.screenWidth * 0.032,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.3,
                  color: Colors.white70,
                ),
                SettingRadioButtons(
                  height: Global.screenHeight * 0.8,
                  width: Global.screenWidth * 0.8,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Feedback'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white70,
                              fontSize: Global.screenWidth * 0.032,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.3,
                  color: Colors.white70,
                ),
                ListTile(
                  title: Text(
                    'Have some feedback?',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontSize: Global.screenWidth * 0.048,
                          color: Colors.grey[50],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  trailing: RaisedButton(
                    color: Colors.grey[100],
                    onPressed: getFeedback,
                    child: Text(
                      'Tell us!',
                      style: Theme.of(context).textTheme.button.copyWith(
                            //fontSize: Global.screenWidth * 0.048,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void getFeedback() async {
    const url = 'https://forms.gle/kydxayfPycLYzVos7';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
