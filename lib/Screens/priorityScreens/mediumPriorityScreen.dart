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

class Mediumpriorityscreen extends StatefulWidget {
  const Mediumpriorityscreen({super.key});

  @override
  State<Mediumpriorityscreen> createState() => _MediumpriorityscreenState();
}

class _MediumpriorityscreenState extends State<Mediumpriorityscreen> {
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
                  //extract task
                  //which
                  //are having
                  //only medium priority
                  final taskwithMediumPriority = todoProviderObj.allTask
                      .where((task) => task.priority == "Medium")
                      .toList();
                  return taskwithMediumPriority.isEmpty
                      ? Center(
                          child: Text("Medium Priority Task list is empty"),
                        )
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
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.yellow,
                                    width: 5,
                                  ),
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
                                    Text(
                                      finalMediumPriorytytask.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                    ),

                                    ReadMoreText(
                                      //description
                                      finalMediumPriorytytask.description,
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
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: Colors.blueGrey,
                                        ),
                                        const SizedBox(width: 10),
                                        //Date
                                        Text(
                                          "${finalMediumPriorytytask.date}",
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
                                                  finalMediumPriorytytask,
                                                );
                                            //document to pass for update
                                            final doctoEdit = todoProviderObj
                                                .allTask[index]
                                                .id;
                                            //Call Edit
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: realIndex,
                                                  documentID: doctoEdit,
                                                );
                                              },
                                            );
                                            // //show our
                                            // //custom snakbar
                                            // showCustomSnackBar(
                                            //   context,
                                            //   "Task Edited Succesfully",
                                            // );
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
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("Delete"),
                                                  content: const Text(
                                                    "Are You Sure its Medium Priority?",
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
                                                                  finalMediumPriorytytask,
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

                                            // final indextodel = todo[index];
                                            // todoProvidermedium.deleteTask(
                                            //   index,
                                            // );
                                            // final realIndex = todoProvidermedium
                                            //     .allTask
                                            //     .indexOf(
                                            //       finalMediumPriorytytask,
                                            //     );
                                            //Delete
                                            // todoProvidermedium.deleteTask(
                                            //   realIndex,
                                            // );

                                            //show our
                                            //custom snakbar
                                            // showCustomSnackBar(
                                            //   context,
                                            //   "Task Deleted Succesfully",
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
        child: Icon(Icons.add_task, color: Colors.blueAccent),
      ),
    );
  }
}
