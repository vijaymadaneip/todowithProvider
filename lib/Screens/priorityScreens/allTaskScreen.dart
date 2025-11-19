import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';
import 'package:todowithprovider/Provider/todoprovider.dart';
import 'package:todowithprovider/widgets/addTaskwidget.dart';
import 'package:todowithprovider/widgets/appBarWidget.dart';
import 'package:todowithprovider/widgets/appDrawerWidget.dart';
import 'package:todowithprovider/widgets/customSnackBarWidget.dart';
import 'package:todowithprovider/widgets/todoformWidget.dart';

class allTaskScreen extends StatefulWidget {
  const allTaskScreen({super.key});

  @override
  State<allTaskScreen> createState() => _allTaskScreenState();
}

class _allTaskScreenState extends State<allTaskScreen> {
  //FORM KEY-------=-=-=-=-=-=-=-=-
  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //controller-
  //to store
  //data from user input
  final titlecontroller = TextEditingController();
  final despcontroller = TextEditingController();
  final datecontroller = TextEditingController();

  //store editing
  //variable in variable

  int? editingIndex = null;

  //dropdown priority
  //for task
  String? selectedPriority = "Select";
  final List<String> priorityList = ["Low", "Medium", "High", "Select"];

  @override
  Widget build(BuildContext context) {
    //drawerprovider
    // final drawerprovider = Provider.of<Drawerprovider>(context,listen: true);
    return Scaffold(
      appBar: appBarWidgetCustom(),
      drawer: appDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Addtaskwidget(),
            // Center(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width / 2,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),

            //       border: Border.all(
            //         color: Colors.green,
            //         width: 2.0,
            //         style: BorderStyle.solid,

            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Icon(Icons.add_task,color: Colors.green,),
            //         GestureDetector(
            //           onTap: (){
            //             drawerprovider.changeCurrentScreen(AllScreenPagesEnum.todoScreen);
            //           },
            //           child: Text(
            //             "Add New Task",
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.green
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Expanded(
              //used
              //consumer here
              //it will listen updtes
              //form our list
              //which is in the
              //provider: TOdoProvider
              child: Consumer<Todoprovider>(
                builder: (context, todoalltask, child) {
                  return todoalltask.allTask.isEmpty
                      ? Text("List Is Empty")
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: todoalltask.allTask.length,
                          itemBuilder: (context, index) {
                            //extract
                            //sinle
                            //task
                            //with its index
                            final task = todoalltask.allTask[index];

                            return Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),

                                border: Border.all(
                                  // color: Colors.black,
                                  color: Colors.grey.shade300,
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReadMoreText(
                                            task.title,
                                            trimLines: 1,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: "Read More",
                                            trimExpandedText: "Read Less",
                                            moreStyle: const TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              fontWeight: FontWeight.w600,
                                              // color: Colors.black,
                                              color: Colors.blueGrey,
                                            ),

                                            lessStyle: const TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w600,
                                              // color: Colors.black,
                                            ),

                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        Text(
                                          //priority
                                          "Priority: ${task.priority}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ReadMoreText(
                                      //description
                                      task.description,
                                      trimLines: 1,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: "Read More",
                                      trimExpandedText: "Read Less",
                                      moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),

                                      lessStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),

                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          //Date
                                          "Date : ${task.date}",
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            log(
                                              "Edit icon clecked in all task screen",
                                            );

                                            final requiredINDEX = index;
                                            log(
                                              "$requiredINDEX passed to dailog screen",
                                            );
                                            //open dailog
                                            //for editing
                                            //purpose
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: requiredINDEX,
                                                );
                                              },
                                            );

                                            ///show
                                            ///custom
                                            ///snackbar

                                            showCustomSnackBar(
                                              context,
                                              "Task Edited Successfully",
                                            );
                                          },

                                          child: Icon(Icons.edit),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
                                            // final indextodel = todo[index];
                                            // todoalltask.deleteTask(index);
                                            final indextodel = index;
                                            todoalltask.deleteTask(indextodel);

                                            ///show
                                            ///custom
                                            ///snackbar

                                            showCustomSnackBar(
                                              context,
                                              "Task Deleted Successfully",
                                            );
                                            // ScaffoldMessenger.of(
                                            //   context,
                                            // ).showSnackBar(
                                            //   SnackBar(
                                            //     content: Text(
                                            //       "Data Deleted Succesfully from List ",
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
