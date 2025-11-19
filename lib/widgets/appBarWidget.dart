import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class appBarWidgetCustom extends StatefulWidget implements PreferredSizeWidget {
  const appBarWidgetCustom({super.key});

  @override
  State<appBarWidgetCustom> createState() => _appBarWidgetCustomState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _appBarWidgetCustomState extends State<appBarWidgetCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Todo App",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      elevation: 50,
      centerTitle: true,
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
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
                    TextButton(onPressed: () {
                      //exit
                      SystemNavigator.pop();
                    }, child: const Text("Exit")),
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
    );
  }
}
