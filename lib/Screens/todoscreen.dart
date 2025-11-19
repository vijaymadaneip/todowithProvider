import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:todowithprovider/Provider/drawerProvider.dart';
import 'package:todowithprovider/Provider/todoprovider.dart';
import 'package:todowithprovider/widgets/appBarWidget.dart';
import 'package:todowithprovider/widgets/appDrawerWidget.dart';
import 'package:todowithprovider/model/todomodel.dart';
import 'package:todowithprovider/widgets/customSnackBarWidget.dart';

class todoScreen extends StatefulWidget {
  const todoScreen({super.key});

  @override
  State<todoScreen> createState() => _todoScreenState();
}

class _todoScreenState extends State<todoScreen> {
  //FORM KEY
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //controller
  final titlecontroller = TextEditingController();
  final despcontroller = TextEditingController();
  final datecontroller = TextEditingController();

  //store editing variable in variable

  int? editingIndex;

  //dropdown priority for task
  String? selectedPriority = "Select";
  final List<String> priorityList = ["Select", "Low", "Medium", "High"];

  @override
  Widget build(BuildContext context) {
    //instace of provider
    // 3 ways to use
    final todoprovider = Provider.of<Todoprovider>(context, listen: false);
    // final drawerprovider = Provider.of<Drawerprovider>(context,listen: true);
    // final todoprovider = context.read<Todoprovider>();

    return Scaffold(
      drawer: appDrawerWidget(),
      appBar: appBarWidgetCustom(),
      // appBar: AppBar(
      //   title: Text(
      //     "Todo App",
      //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      //   ),
      //   elevation: 50,
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomRight: Radius.circular(25),
      //       bottomLeft: Radius.circular(25),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      //   ],
      // ),
      // drawer: Drawer(

      //   child: ListView(
      //     padding: EdgeInsets.all(2),
      //     children: [
      //       Container(
      //         padding: EdgeInsets.all(5),
      //         height: 90,
      //         child: DrawerHeader(
      //           margin: EdgeInsets.all(0),
      //           padding: EdgeInsetsGeometry.all(0),
      //           child: Text(
      //             "Categories of Task",
      //             style: TextStyle(fontSize: 24),
      //           ),
      //         ),
      //       ),
      //        ListTile(
      //         leading: Icon(Icons.list_alt),
      //         title: Text('All Task'),
      //         onTap: () {
      //           drawerprovider.changeCurrentScreen(AllScreenPagesEnum.allTaskScreen);
      //         },
      //       ),
      //       Divider(),
      //       ListTile(
      //         leading: Icon(Icons.low_priority),
      //         title: Text('Low'),
      //         onTap: () {
      //           drawerprovider.changeCurrentScreen(AllScreenPagesEnum.Lowpriorityscreen);
      //         },
      //       ),
      //       Divider(),
      //       ListTile(
      //         leading: Icon(Icons.info_outline),
      //         title: Text('Medium'),
      //         onTap: () {
      //           drawerprovider.changeCurrentScreen(AllScreenPagesEnum.Mediumpriorityscreen);
      //         },
      //       ),
      //       Divider(),
      //       ListTile(
      //         leading: Icon(Icons.priority_high),
      //         title: Text('High'),
      //         onTap: () {
      //           drawerprovider.changeCurrentScreen(AllScreenPagesEnum.Highpriorityscreen);
      //         },
      //       ),
      //       Divider(),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TITLE
                  Text(
                    "Task Title",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: titlecontroller,
                    decoration: InputDecoration(
                      labelText: "title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //DESCRIPTION
                  Text(
                    "Task Despcription",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: despcontroller,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //DATE
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        //ADD
                        //TO OUR CONTORLLER
                        //
                        datecontroller.text = formattedDate;
                      }
                    },
                    controller: datecontroller,
                    decoration: InputDecoration(
                      labelText: "Date",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                      ),
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Date";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Priority",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonFormField(
                    initialValue: selectedPriority,
                    items: priorityList.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // validator: (value) {
                    //   if (value == null) {
                    //     return "Plese Select priority";
                    //   }
                    //   return null;
                    // },
                    validator: (value) {
                      if (value == null || value == "Select") {
                        return "Please choose a valid priority";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            log("Validated..");
                            //using
                            //task
                            ///class and passing data

                            final newTask = Task(
                              title: titlecontroller.text.trim(),
                              description: despcontroller.text.trim(),
                              date: datecontroller.text.trim(),
                              priority: selectedPriority!,
                            );

                            //call add
                            //methodo from provider class
                            // todoprovider.addTask(newTask);

                            // titlecontroller.clear();
                            // despcontroller.clear();
                            // datecontroller.clear();
                            // log("${newtask}");
                            if (editingIndex == null) {
                              // ADD NEW TASK
                              todoprovider.addTask(newTask);
                              //calling custom snackbar

                              showCustomSnackBar(
                                context,
                                "Task Added Successfully",
                              );
                            } else {
                              // UPDATE EXISTING TASK
                              todoprovider.updateTask(editingIndex!, newTask);
                              //calling custom snackbar

                              showCustomSnackBar(
                                context,
                                "Task Edited Successfully",
                              );

                              editingIndex = null;
                            }

                            // Clear fields after add/update
                            titlecontroller.clear();
                            despcontroller.clear();
                            datecontroller.clear();
                            selectedPriority = "Select";

                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // child: Text("Add Task"),
                        child: Text(
                          editingIndex == null ? "Add Task" : "Update Task",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
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
                      child: Center(
                        child: Text(
                          "List of Task",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<Todoprovider>(
                builder: (context, todo, child) {
                  return todo.allTask.isEmpty
                      ? Text("No data in list")
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: todo.allTask.length,
                          itemBuilder: (context, index) {
                            //extract
                            //sinle
                            //task
                            //with its index
                            final task = todo.allTask[index];

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
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Text(
                                        //   "Title : ${task.title}",
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: 18,
                                        //   ),
                                        // ),
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
                                        Spacer(),
                                        Text(
                                          "Priority: ${task.priority}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Text(
                                    //   "Description : ${task.description}",
                                    //   style: TextStyle(
                                    //     color: Colors.grey,
                                    //     // fontWeight: FontWeight.bold,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
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
                                          "Date : ${task.date}",
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              editingIndex = index;
                                              titlecontroller.text = task.title;
                                              despcontroller.text =
                                                  task.description;
                                              datecontroller.text = task.date;
                                              selectedPriority = task.priority;
                                            });
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
                                            // final indextodel = todo[index];
                                            final indextodel = index;
                                            todo.deleteTask(indextodel);

                                            try {
                                              todo.deleteTask(index);
                                            } catch (e) {
                                              log("$e");
                                            } finally {
                                              log("Inside Finally...");
                                            }
                                            // show our
                                            //custom snackbar
                                            showCustomSnackBar(
                                              context,
                                              "Data Deleted Succesfully from List ",
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
