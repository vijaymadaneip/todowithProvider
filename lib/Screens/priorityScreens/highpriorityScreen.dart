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

class Highpriorityscreen extends StatefulWidget {
  const Highpriorityscreen({super.key});

  @override
  State<Highpriorityscreen> createState() => _HighpriorityscreenState();
}

class _HighpriorityscreenState extends State<Highpriorityscreen> {
  @override
  Widget build(BuildContext context) {
    final drawerprovider = Provider.of<Drawerprovider>(context, listen: false);
    return Scaffold(
      appBar: appBarWidgetCustom(),
      drawer: appDrawerWidget(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            // Addtaskwidget(),
            // const SizedBox(height: 20),
            Expanded(
              child: Consumer<Todoprovider>(
                builder: (context, todoProviderObj, child) {
                  //extraactlist of the
                  //task which has high priority
                  final taskwithHigherpriority = todoProviderObj.allTask
                      .where((task) => task.priority == "High")
                      .toList();
                  log("${taskwithHigherpriority.length}");

                  return taskwithHigherpriority.isEmpty
                      ? Center(child: Text("High Priority Task list is empty"))
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: taskwithHigherpriority.length,
                          itemBuilder: (context, index) {
                            //Extract single task
                            //form its index accroding High prioirity herr
                            final highprioritySingleTask =
                                taskwithHigherpriority[index];
                            log("${highprioritySingleTask.title}");
                            return Container(
                              // height: 20,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                    width: 4,
                                  ),
                                ),

                                // border: Border.all(
                                //   // color: Colors.black,
                                //   color: Colors.grey.shade300,
                                //   width: 2.0,
                                //   style: BorderStyle.solid,
                                // ),
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
                                    Text(
                                      highprioritySingleTask.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                    ),

                                      ReadMoreText(
                                      //description
                                      highprioritySingleTask.description,
                                      trimLines: 1,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: " More",
                                      trimExpandedText: " Less",
                                      moreStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),

                                      lessStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),

                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        //Date
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: Colors.blueGrey,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "${highprioritySingleTask.date}",
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
                                            //index to pass for update
                                            final realIndex = todoProviderObj
                                                .allTask
                                                .indexOf(
                                                  highprioritySingleTask,
                                                );
                                            // log(
                                            //   "$realIndex passed to dailog screen",
                                            // );
                                            //document to pass for update
                                            String doctoeditId = todoProviderObj
                                                .allTask[realIndex]
                                                .id;

                                            // EDIT
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: realIndex,
                                                  documentID: doctoeditId,
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
                                            // final indextodel = todo[index];
                                            // todoProviderObj.deleteTask(index);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("Delete"),
                                                  content: const Text(
                                                    "Are You Sure its High Priority?",
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
                                                        // );
                                                        final realIndex =
                                                            todoProviderObj
                                                                .allTask
                                                                .indexOf(
                                                                  highprioritySingleTask,
                                                                );

                                                        String doctodelId =
                                                            todoProviderObj
                                                                .allTask[realIndex]
                                                                .id;
                                                        todoProviderObj
                                                            .deletetheTaskFromFirestore(
                                                              doctodelId,
                                                              realIndex,
                                                            );
                                                        showCustomSnackBar(
                                                          context,
                                                          "Task Deleted Succesfully",
                                                        );
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                      child: Text(
                                                        "Delete Task",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            // DELETE
                                            // todoProviderObj.deleteTask(
                                            //   realIndex,
                                            // // );
                                            // final realIndex = todoProviderObj
                                            //     .allTask
                                            //     .indexOf(highprioritytasklist);

                                            // String doctodelId = todoProviderObj
                                            //     .allTask[index]
                                            //     .id;
                                            // todoProviderObj
                                            //     .deletetheTaskFromFirestore(
                                            //       doctodelId,
                                            //       realIndex,
                                            //     );
                                            //show custom
                                            //snackbar
                                            //once deleted
                                            // showCustomSnackBar(
                                            //   context,
                                            //   "Task Deleted SuccessFully",
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
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          drawerprovider.changeCurrentScreen(AllScreenPagesEnum.todoScreen);
        },
        child: Icon(Icons.add_task,color: Colors.blueAccent,),
      
      ),
    );

    // return Scaffold(
    //   appBar: appBarWidgetCustom(),
    //   drawer: appDrawerWidget(),
    //   body: Padding(
    //     padding: EdgeInsets.all(10),
    //     child: Column(
    //       children: [
    //         Addtaskwidget(),
    //         const SizedBox(height: 20),
    //         Expanded(
    //           child: Consumer<Todoprovider>(
    //             builder: (context, todoProviderObj, child) {
    //               //extraact
    //               //list of the
    //               //task which has
    //               //high priority
    //               final taskwithHigherpriority = todoProviderObj.allTask
    //                   .where((task) => task.priority == "High")
    //                   .toList();
    //               log("${taskwithHigherpriority.length}");

    //               return taskwithHigherpriority.isEmpty
    //                   ? Text("High Priority Task list is empt")
    //                   : ListView.separated(
    //                       separatorBuilder: (context, index) {
    //                         return const SizedBox(height: 10);
    //                       },
    //                       itemCount: taskwithHigherpriority.length,
    //                       itemBuilder: (context, index) {
    //                         //Extract
    //                         //single task
    //                         //form its index
    //                         //accroding High prioirity herr
    //                         final highprioritytasklist = todoProviderObj.allTask[index];
    //                         log("${highprioritytasklist.title}");
    //                         return Container(
    //                           // height: 20,
    //                           width: MediaQuery.of(context).size.width,
    //                           decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.circular(15),

    //                             border: Border.all(
    //                               color: Colors.black,
    //                               width: 2.0,
    //                               style: BorderStyle.solid,
    //                             ),
    //                           ),
    //                           child: Padding(
    //                             padding: EdgeInsets.all(10),
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       "Title : ${highprioritytasklist.title}",
    //                                       style: TextStyle(
    //                                         fontWeight: FontWeight.bold,
    //                                         fontSize: 18,
    //                                       ),
    //                                     ),
    //                                     Spacer(),
    //                                     Text(
    //                                       "Priority: ${highprioritytasklist.priority}",
    //                                       style: TextStyle(
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.bold,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),

    //                                 ReadMoreText(
    //                                   //description
    //                                   highprioritytasklist.description,
    //                                   trimLines: 1,
    //                                   trimMode: TrimMode.Line,
    //                                   trimCollapsedText: "Read More",
    //                                   trimExpandedText: "Read Less",
    //                                   moreStyle: const TextStyle(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.bold,
    //                                     color: Colors.black,
    //                                   ),

    //                                   lessStyle: const TextStyle(
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.bold,
    //                                     color: Colors.black,
    //                                   ),

    //                                   style: TextStyle(
    //                                     fontSize: 15,
    //                                     color: Colors.grey,
    //                                   ),
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       "Date : ${highprioritytasklist.date}",
    //                                       style: TextStyle(
    //                                         // fontWeight: FontWeight.bold,
    //                                         fontSize: 14,
    //                                       ),
    //                                     ),
    //                                     Spacer(),
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         log("Edit icon clecked in all task screen");

    //                                         final requiredINDEX = index;
    //                                         log("$requiredINDEX passed to dailog screen");
    //                                         showDialog(context: context, builder: (context){
    //                                           return todoFormWidget(editingIndexID: requiredINDEX,);
    //                                         });
    //                                       },
    //                                       child: Icon(Icons.edit),
    //                                     ),
    //                                     GestureDetector(
    //                                       onTap: () {
    //                                         //call
    //                                         //delter from provider
    //                                         // final indextodel = todo[index];
    //                                         todoProviderObj.deleteTask(index);

    //                                         // try {
    //                                         //   todoProviderObj.deleteTask(index);
    //                                         // } catch (e) {
    //                                         //   log("$e");
    //                                         // } finally {
    //                                         //   log("Inside Finally...");
    //                                         // }
    //                                         ScaffoldMessenger.of(
    //                                           context,
    //                                         ).showSnackBar(
    //                                           SnackBar(
    //                                             content: Text(
    //                                               "Data Deleted Succesfully from List ",
    //                                             ),
    //                                           ),
    //                                         );
    //                                       },
    //                                       child: Icon(Icons.delete),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     );
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
