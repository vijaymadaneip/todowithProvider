import 'package:flutter/material.dart';
import 'package:todowithprovider/Screens/priorityScreens/allTaskScreen.dart';
import 'package:todowithprovider/Screens/priorityScreens/highpriorityScreen.dart';
import 'package:todowithprovider/Screens/priorityScreens/lowpriorityScreen.dart';
import 'package:todowithprovider/Screens/priorityScreens/mediumPriorityScreen.dart';
import 'package:todowithprovider/Screens/todoscreen.dart';

class Drawerprovider extends ChangeNotifier {
  //used late
  //cause
  //initilized later
  late Widget _currentScreen = todoScreen();

  //used
  //getter
  //for the screen
  Widget get currentScreen => _currentScreen;

  //setting on click for
  // list tile of our drawer
  set currentScreen(Widget newScreen) {
    _currentScreen = newScreen;
    notifyListeners();
  }

  void changeCurrentScreen(AllScreenPagesEnum screen) {
    switch (screen) {
      case AllScreenPagesEnum.allTaskScreen:
        currentScreen = allTaskScreen();
        break;
      case AllScreenPagesEnum.Lowpriorityscreen:
        currentScreen = Lowpriorityscreen();
        break;
      case AllScreenPagesEnum.Mediumpriorityscreen:
        currentScreen = Mediumpriorityscreen();
        break;
      case AllScreenPagesEnum.Highpriorityscreen:
        currentScreen = Highpriorityscreen();
        break;
      case AllScreenPagesEnum.todoScreen:
        currentScreen = todoScreen();
        break;
    }
  }
}

enum AllScreenPagesEnum {
  todoScreen(),
  allTaskScreen(),
  Lowpriorityscreen(),
  Mediumpriorityscreen(),
  Highpriorityscreen(),
}
