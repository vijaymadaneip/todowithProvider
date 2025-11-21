import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class appBarWidgetCustom extends StatefulWidget implements PreferredSizeWidget {
  const appBarWidgetCustom({super.key});

  @override
  State<appBarWidgetCustom> createState() => _appBarWidgetCustomState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _appBarWidgetCustomState extends State<appBarWidgetCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent.shade700, Colors.lightBlueAccent.shade200],
        ),
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 50,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //call
              //exit
              //dialog for exit

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Exit From the App"),
                    content: const Text("You want to exit from app ?"),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          //exit
                          SystemNavigator.pop();
                        },
                        child: const Text("Exit"),
                      ),
                    ],
                  );
                },
              );
              // Dialog(
              //   child: SimpleDialog(
              //     title: Text("Exit from the app"),
              //     children: [
              //       SimpleDialogOption(
              //         onPressed: () {
              //           SystemNavigator.pop();
              //         },
              //         child: Text("Exit"),
              //       ),
              //     ],
              //   ),
              // );
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
