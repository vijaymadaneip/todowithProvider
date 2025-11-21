import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';

class appDrawerWidget extends StatefulWidget {
  const appDrawerWidget({super.key});

  @override
  State<appDrawerWidget> createState() => _appDrawerWidgetState();
}

class _appDrawerWidgetState extends State<appDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    //instace
    //of
    //drawerprovider
    final drawerprovider = Provider.of<Drawerprovider>(context, listen: false);
    return Drawer(
      // surfaceTintColor: Colors.brown,
      child: ListView(
        padding: EdgeInsets.all(2),
        children: [
          Container(
            padding: EdgeInsets.all(4),
            height: 90,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsetsGeometry.all(5),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueAccent.shade700,
                      Colors.lightBlueAccent.shade200,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Center(
                  child: Text(
                    "Categories of Task",

                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_task, color: Colors.blue, size: 30),
            title: Text(
              "Add New Task",
              style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              drawerprovider.changeCurrentScreen(AllScreenPagesEnum.todoScreen);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt, size: 30, color: Colors.brown),
            title: Text(
              'All Task',
              style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              drawerprovider.changeCurrentScreen(
                AllScreenPagesEnum.allTaskScreen,
              );
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.priority_high,
              color: Colors.deepPurple,
              size: 30,
            ),
            title: Text(
              'High',
              style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
            ),
            onTap: () {
              drawerprovider.changeCurrentScreen(
                AllScreenPagesEnum.Highpriorityscreen,
              );
              Navigator.pop(context);
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.amberAccent,
              size: 30,
            ),
            title: Text('Medium', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            onTap: () {
              drawerprovider.changeCurrentScreen(
                AllScreenPagesEnum.Mediumpriorityscreen,
              );
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.low_priority,
              color: const Color.fromARGB(255, 0, 143, 5),
              size: 30,
            ),
            title: Text('Low', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            onTap: () {
              drawerprovider.changeCurrentScreen(
                AllScreenPagesEnum.Lowpriorityscreen,
              );
              Navigator.pop(context);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
