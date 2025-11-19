import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';
import 'package:todowithprovider/widgets/appDrawerWidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    //instace
    //of
    //drawerprovider
    // final drawerprovider = Provider.of<Drawerprovider>(context, listen: false);
    return Scaffold(
      drawer: appDrawerWidget(),
      body: Consumer<Drawerprovider>(
        builder: (context, drawerproviderobj, child) {
          return drawerproviderobj.currentScreen;
        },
      ),
    );
  }
}
