import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';

class Addtaskwidget extends StatefulWidget {
  const Addtaskwidget({super.key});

  @override
  State<Addtaskwidget> createState() => _AddtaskwidgetState();
}

class _AddtaskwidgetState extends State<Addtaskwidget> {
  @override
  Widget build(BuildContext context) {
    final drawerprovider = Provider.of<Drawerprovider>(context, listen: false);
    return Center(
      child: GestureDetector(
        onTap: (){
          drawerprovider.changeCurrentScreen(AllScreenPagesEnum.todoScreen);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
        
            border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.add_task, color: Colors.black),
              Text(
                "Add New Task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
