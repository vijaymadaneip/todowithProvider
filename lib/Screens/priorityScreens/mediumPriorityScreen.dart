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

class Mediumpriorityscreen extends StatefulWidget {
  const Mediumpriorityscreen({super.key});

  @override
  State<Mediumpriorityscreen> createState() => _MediumpriorityscreenState();
}

class _MediumpriorityscreenState extends State<Mediumpriorityscreen> {
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
                builder: (context, todoProvidermedium, child) {
                  //extract task
                  //which
                  //are having
                  //only medium priority
                  final taskwithMediumPriority = todoProvidermedium.allTask
                      .where((task) => task.priority == "Medium")
                      .toList();
                  return taskwithMediumPriority.isEmpty
                      ? Text("Medium Priority Task list is empt")
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: taskwithMediumPriority.length,
                          itemBuilder: (context, index) {
                            //extract single
                            //task
                            //which has
                            //medium priority
                            final finalMediumPriorytytask =
                                taskwithMediumPriority[index];
                            return Container(
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
                                        //title
                                      Expanded(
                                          child: ReadMoreText(
                                            finalMediumPriorytytask.title,
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
                                        //priority
                                        Text(
                                          "Priority: ${finalMediumPriorytytask.priority}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ReadMoreText(
                                      //description
                                      finalMediumPriorytytask.description,
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
                                          "Date : ${finalMediumPriorytytask.date}",
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
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: requiredINDEX,
                                                );
                                              },
                                            );
                                            //show our
                                            //custom snakbar
                                            showCustomSnackBar(
                                              context,
                                              "Task Edited Succesfully",
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
                                            // final indextodel = todo[index];
                                            // todoProvidermedium.deleteTask(
                                            //   index,
                                            // );
                                            final realIndex = todoProvidermedium
                                                .allTask
                                                .indexOf(
                                                  finalMediumPriorytytask,
                                                );
                                              //Delete
                                            todoProvidermedium.deleteTask(
                                              realIndex,
                                            );

                                            //show our
                                            //custom snakbar
                                            showCustomSnackBar(
                                              context,
                                              "Task Deleted Succesfully",
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
