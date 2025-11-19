import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:todowithprovider/Provider/todoprovider.dart';
import 'package:todowithprovider/widgets/addTaskwidget.dart';
import 'package:todowithprovider/widgets/appBarWidget.dart';
import 'package:todowithprovider/widgets/appDrawerWidget.dart';
import 'package:todowithprovider/widgets/todoformWidget.dart';

class Lowpriorityscreen extends StatefulWidget {
  const Lowpriorityscreen({super.key});

  @override
  State<Lowpriorityscreen> createState() => _LowpriorityscreenState();
}

class _LowpriorityscreenState extends State<Lowpriorityscreen> {
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
                builder: (context, todoproviderobj, child) {
                  //extract
                  //list with low priority
                  //from all task list
                  final taskwithlowPriorityList = todoproviderobj.allTask
                      .where((task) => task.priority == "Low")
                      .toList();

                  return taskwithlowPriorityList.isEmpty
                      ? Text("List With Low Priority is Empty")
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            //Extract
                            //single task
                            //form its index
                            //accroding Low prioirity herr

                            final lowPriorityTask =
                                taskwithlowPriorityList[index];
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
                                padding: EdgeInsetsGeometry.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReadMoreText(
                                            lowPriorityTask.title,
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
                                          "Priority: ${lowPriorityTask.priority}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ReadMoreText(
                                      //description
                                      lowPriorityTask.description,
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
                                          "Date : ${lowPriorityTask.date}",
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

                                            
                                            final realIndex = todoproviderobj.allTask.indexOf(lowPriorityTask);

                                            log(
                                              "$realIndex passed to dailog screen",
                                            );
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: realIndex,
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
       

                                            final realIndex = todoproviderobj
                                                .allTask
                                                .indexOf(lowPriorityTask);
                                            //Delete    
                                            todoproviderobj.deleteTask(
                                              realIndex,
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
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: taskwithlowPriorityList.length,
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
