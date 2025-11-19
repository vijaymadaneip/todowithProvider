import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
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
    return Scaffold(
      appBar: appBarWidgetCustom(),
      drawer: appDrawerWidget(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            Addtaskwidget(),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<Todoprovider>(
                builder: (context, todoProviderObj, child) {
                  //extraact
                  //list of the
                  //task which has
                  //high priority
                  final taskwithHigherpriority = todoProviderObj.allTask
                      .where((task) => task.priority == "High")
                      .toList();
                  log("${taskwithHigherpriority.length}");

                  return taskwithHigherpriority.isEmpty
                      ? Text("High Priority Task list is empty")
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: taskwithHigherpriority.length,
                          itemBuilder: (context, index) {
                            //Extract
                            //single task
                            //form its index
                            //accroding High prioirity herr
                            final highprioritytasklist =
                                taskwithHigherpriority[index];
                            log("${highprioritytasklist.title}");
                            return Container(
                              // height: 20,
                              width: MediaQuery.of(context).size.width,
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
                                            highprioritytasklist.title,
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
                                          //Priority
                                          "Priority: ${highprioritytasklist.priority}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ReadMoreText(
                                      //description
                                      highprioritytasklist.description,
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
                                        //Date
                                        Text(
                                          "Date : ${highprioritytasklist.date}",
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

                                            // final requiredINDEX = index;
                                            final realIndex = todoProviderObj
                                                .allTask
                                                .indexOf(highprioritytasklist);
                                            log(
                                              "$realIndex passed to dailog screen",
                                            );

                                            // EDIT
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: realIndex,
                                                );
                                              },
                                            );
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) {
                                            //     return todoFormWidget(
                                            //       editingIndexID: requiredINDEX,
                                            //     );
                                            //   },
                                            // );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
                                            // final indextodel = todo[index];
                                            // todoProviderObj.deleteTask(index);

                                            final realIndex = todoProviderObj
                                                .allTask
                                                .indexOf(highprioritytasklist);

                                            // DELETE
                                            todoProviderObj.deleteTask(
                                              realIndex,
                                            );

                                            //show custom
                                            //snackbar
                                            //once deleted
                                            showCustomSnackBar(
                                              context,
                                              "Task Deleted SuccessFully",
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
