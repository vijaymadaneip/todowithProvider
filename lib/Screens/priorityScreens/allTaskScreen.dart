import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';
// import 'package:todowithprovider/Provider/drawerProvider.dart';
import 'package:todowithprovider/Provider/todoprovider.dart';
import 'package:todowithprovider/widgets/DescriptionWidget.dart';
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

  final List<Color> colors = const <Color>[
    Colors.yellow,
    Colors.green,
    Colors.deepPurple,
  ];

  //check is checked or not 
  //bool variable
  bool statusIsChecked = false;
  @override
  Widget build(BuildContext context) {
    //drawerprovider
    final drawerprovider = Provider.of<Drawerprovider>(context, listen: false);
    return Scaffold(
      appBar: appBarWidgetCustom(),
      drawer: appDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<Todoprovider>(
            builder: (context, todoProvideralltaskobj, child) {
              return todoProvideralltaskobj.allTask.isEmpty
                  ? Center(child: Text("All Task List is Empty"))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.65,
                      ),
                      itemCount: todoProvideralltaskobj.allTask.length,
                      itemBuilder: (context, index) {
                        //Extract Single Task

                        final task = todoProvideralltaskobj.allTask[index];

                        Color borderColor = task.priority == "Low"
                            ? colors[0]
                            : task.priority == "Medium"
                            ? colors[1]
                            : colors[2];

                        return GestureDetector(
                          onTap: () {
                            showDescriptionDialog(
                              context,
                              task.title,
                              task.description,
                              task.priority,
                              task.date,
                              borderColor,
                            );
                          },
                          child: Container(
                            // height: 20,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.amber
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),

                              border: Border(
                                left: BorderSide(color: borderColor, width: 4),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  //title
                                  Row(
                                    children: [
                                      Text(
                                        task.title,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // Checkbox(value: statusIsChecked, onChanged: (bool? value){
                                      //   setState(() {
                                      //     statusIsChecked = value!;
                                      //   });
                                      // })
                                    ],
                                  ),
                                  //Description
                                  Text(
                                    task.description,
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        task.date,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          log(
                                            "Edit icon clecked in all task screen",
                                          );
                                          //index to pass for update
                                          final requiredINDEX = index;
                                          //doc id to pass for update
                                          String doctodeledit =
                                              todoProvideralltaskobj
                                                  .allTask[index]
                                                  .id;
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
                                                documentID: doctodeledit,
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
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Delete"),
                                                content: const Text(
                                                  "Are You Sure?",
                                                ),

                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // final indextodel =
                                                      //     index;
                                                      // todo.deleteTask(
                                                      //   indextodel,
                                                      // );
                                                      String doctodelId =
                                                          todoProvideralltaskobj
                                                              .allTask[index]
                                                              .id;
                                                      final indexofTask = index;
                                                      todoProvideralltaskobj
                                                          .deletetheTaskFromFirestore(
                                                            doctodelId,
                                                            indexofTask,
                                                          );
                                                      showCustomSnackBar(
                                                        context,
                                                        "$doctodelId Data Deleted Succesfully from List ",
                                                      );
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },

                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          ///show
                                          ///custom
                                          ///snackbar

                                          // showCustomSnackBar(
                                          //   context,
                                          //   "Task Deleted Successfully",
                                          // );
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
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          drawerprovider.changeCurrentScreen(AllScreenPagesEnum.todoScreen);
        },
        child: Icon(Icons.add_task, color: Colors.blueAccent),
      ),
    );
  }
}


    // : ListView.separated(
              //     separatorBuilder: (context, index) {
              //       return const SizedBox(height: 10);
              //     },
              //     itemCount: todoProvideralltaskobj.allTask.length,
              //     itemBuilder: (context, index) {
              //       //extract
              //       //sinle
              //       //task
              //       //with its index
              //       final task = todoProvideralltaskobj.allTask[index];

              //       return Container(
              //         width: MediaQuery.of(context).size.width,
              //         // height: 100,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20),

              //           border: Border.all(
              //             // color: Colors.black,
              //             color: Colors.grey.shade300,
              //             width: 2.0,
              //             style: BorderStyle.solid,
              //           ),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black12,
              //               blurRadius: 6,
              //               offset: Offset(0, 3),
              //             ),
              //           ],
              //         ),
              //         child: Padding(
              //           padding: EdgeInsets.all(10),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Expanded(
              //                     child: ReadMoreText(
              //                       task.title,
              //                       trimLines: 1,
              //                       trimMode: TrimMode.Line,
              //                       trimCollapsedText: "Read More",
              //                       trimExpandedText: "Read Less",
              //                       moreStyle: const TextStyle(
              //                         fontSize: 14,
              //                         // fontWeight: FontWeight.bold,
              //                         fontWeight: FontWeight.w600,
              //                         // color: Colors.black,
              //                         color: Colors.blueGrey,
              //                       ),

              //                       lessStyle: const TextStyle(
              //                         fontSize: 14,
              //                         // fontWeight: FontWeight.bold,
              //                         color: Colors.blueGrey,
              //                         fontWeight: FontWeight.w600,
              //                         // color: Colors.black,
              //                       ),

              //                       style: TextStyle(
              //                         fontSize: 18,
              //                         color: Colors.black87,
              //                         fontWeight: FontWeight.w700,
              //                       ),
              //                     ),
              //                   ),
              //                   // Spacer(),
              //                   Text(
              //                     //priority
              //                     "Priority: ${task.priority}",
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),

              //               ReadMoreText(
              //                 //description
              //                 task.description,
              //                 trimLines: 1,
              //                 trimMode: TrimMode.Line,
              //                 trimCollapsedText: "Read More",
              //                 trimExpandedText: "Read Less",
              //                 moreStyle: const TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black,
              //                 ),

              //                 lessStyle: const TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black,
              //                 ),

              //                 style: TextStyle(
              //                   fontSize: 15,
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //               Row(
              //                 children: [
              //                   Text(
              //                     //Date
              //                     "Date : ${task.date}",
              //                     style: TextStyle(
              //                       // fontWeight: FontWeight.bold,
              //                       fontSize: 14,
              //                     ),
              //                   ),
              //                   Spacer(),
              //                   GestureDetector(
              //                     onTap: () {
              //                       log(
              //                         "Edit icon clecked in all task screen",
              //                       );
              //                       //index to pass for update
              //                       final requiredINDEX = index;
              //                       //doc id to pass for update
              //                        String doctodeledit = todoProvideralltaskobj
              //                                       .allTask[index]
              //                                       .id;
              //                       log(
              //                         "$requiredINDEX passed to dailog screen",
              //                       );
              //                       //open dailog
              //                       //for editing
              //                       //purpose
              //                       showDialog(
              //                         context: context,
              //                         builder: (context) {
              //                           return todoFormWidget(
              //                             editingIndexID: requiredINDEX, documentID: doctodeledit,
              //                           );
              //                         },
              //                       );

              //                       ///show
              //                       ///custom
              //                       ///snackbar

              //                       showCustomSnackBar(
              //                         context,
              //                         "Task Edited Successfully",
              //                       );
              //                     },

              //                     child: Icon(Icons.edit),
              //                   ),
              //                   GestureDetector(
              //                     onTap: () {
              //                       //call
              //                       //delter from provider
              //                       // final indextodel = todo[index];
              //                       // todoalltask.deleteTask(index);
              //                       // final indextodel = index;
              //                       // todoalltask.deleteTask(indextodel);
              //                       showDialog(
              //                         context: context,
              //                         builder: (context) {
              //                           return AlertDialog(
              //                             title: const Text("Delete"),
              //                             content: const Text(
              //                               "Are You Sure?",
              //                             ),

              //                             actions: [
              //                               TextButton(
              //                                 onPressed: () {
              //                                   Navigator.of(
              //                                     context,
              //                                   ).pop();
              //                                 },
              //                                 child: Text("Cancel"),
              //                               ),
              //                               TextButton(
              //                                 onPressed: () {
              //                                   // final indextodel =
              //                                   //     index;
              //                                   // todo.deleteTask(
              //                                   //   indextodel,
              //                                   // );
              //                                   String doctodelId = todoProvideralltaskobj
              //                                       .allTask[index]
              //                                       .id;
              //                                   final indexofTask =
              //                                       index;
              //                                   todoProvideralltaskobj.deletetheTaskFromFirestore(
              //                                     doctodelId,
              //                                     indexofTask,
              //                                   );
              //                                   showCustomSnackBar(
              //                                     context,
              //                                     "$doctodelId Data Deleted Succesfully from List ",
              //                                   );
              //                                   Navigator.of(
              //                                     context,
              //                                   ).pop();
              //                                 },

              //                                 child: const Text(
              //                                   "Delete",
              //                                 ),
              //                               ),
              //                             ],
              //                           );
              //                         },
              //                       );

              //                       ///show
              //                       ///custom
              //                       ///snackbar

              //                       // showCustomSnackBar(
              //                       //   context,
              //                       //   "Task Deleted Successfully",
              //                       // );
              //                       // ScaffoldMessenger.of(
              //                       //   context,
              //                       // ).showSnackBar(
              //                       //   SnackBar(
              //                       //     content: Text(
              //                       //       "Data Deleted Succesfully from List ",
              //                       //     ),
              //                       //   ),
              //                       // );
              //                     },
              //                     child: Icon(Icons.delete),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   );
