import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';
import 'package:todowithprovider/Provider/todoprovider.dart';
import 'package:todowithprovider/Screens/SplashScreen/splashScreen.dart';
import 'package:todowithprovider/Screens/homescreen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("In Build");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Todoprovider()),
        ChangeNotifierProvider(create: (context) => Drawerprovider()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: splashScreen()),
    );
  }
}
