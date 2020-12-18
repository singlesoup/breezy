import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/meditation_provider.dart';


import 'screens/meditation_screen.dart';
import 'themes/app_theme.dart';

int initScreen;

void main() {
  runApp(
    Breezy(),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class Breezy extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return ChangeNotifierProvider<MeditationProvider>(
      create: (_) => MeditationProvider(),
      child: MaterialApp(
        title: 'Breezy',
        theme: appTheme(),
        home: MeditationScreen(),
        
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
