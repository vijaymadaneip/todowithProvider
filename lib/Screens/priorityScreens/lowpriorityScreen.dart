import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';
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
                builder: (context, todoproviderobj, child) {
                  //extract
                  //list with low priority
                  //from all task list
                  final taskwithlowPriorityList = todoproviderobj.allTask
                      .where((task) => task.priority == "Low")
                      .toList();

                  return taskwithlowPriorityList.isEmpty
                      ? Center(child: Text("List With Low Priority is Empty"))
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
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.green,
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
                                padding: EdgeInsetsGeometry.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lowPriorityTask.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                    ),

                                    ReadMoreText(
                                      //description
                                      lowPriorityTask.description,
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
                                        Text(
                                          "${lowPriorityTask.date}",
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
                                            final realIndex = todoproviderobj
                                                .allTask
                                                .indexOf(lowPriorityTask);

                                            log(
                                              "$realIndex passed to dailog screen",
                                            );
                                            //Document id to pass for update
                                            final doctoEdit = todoproviderobj
                                                .allTask[realIndex]
                                                .id;

                                            //call edit
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return todoFormWidget(
                                                  editingIndexID: realIndex,
                                                  documentID: doctoEdit,
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
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("Delete"),
                                                  content: const Text(
                                                    "Are You Sure its low Priority?",
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
                                                            todoproviderobj
                                                                .allTask
                                                                .indexOf(
                                                                  lowPriorityTask,
                                                                );

                                                        String doctodelId =
                                                            todoproviderobj
                                                                .allTask[realIndex]
                                                                .id;
                                                        todoproviderobj
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

                                            // final realIndex = todoproviderobj
                                            //     .allTask
                                            //     .indexOf(lowPriorityTask);
                                            //Delete
                                            // todoproviderobj.deleteTask(
                                            //   realIndex,
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
