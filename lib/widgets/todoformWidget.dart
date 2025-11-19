import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/Provider/todoprovider.dart';
import 'package:todowithprovider/model/todomodel.dart';
import 'package:todowithprovider/widgets/customSnackBarWidget.dart';

class todoFormWidget extends StatefulWidget {
  const todoFormWidget({super.key, required this.editingIndexID});
  //taking
  //edit index
  //form edit
  //icon previous click
  final int? editingIndexID;

  @override
  State<todoFormWidget> createState() => _todoFormWidgetState();
}

class _todoFormWidgetState extends State<todoFormWidget> {
  //our form key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //her form cntrls
  final titlecontroller = TextEditingController();
  final despcontroller = TextEditingController();
  final datecontroller = TextEditingController();

  ///dropdown priotity selct
  String? selectedPriority = "Select";
  final List<String> priorityList = ["Select", "Low", "Medium", "High"];

  //initi state
  //for pre fill our data
  //inside our
  //textfileds

  @override
  void initState() {
    super.initState();

    if (widget.editingIndexID != null) {
      final provider = Provider.of<Todoprovider>(context, listen: false);
      final task = provider.allTask[widget.editingIndexID!];

      titlecontroller.text = task.title;
      despcontroller.text = task.description;
      datecontroller.text = task.date;
      selectedPriority = task.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<Todoprovider>(context, listen: true);
    return Container(
      child: Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(6, 6),
                  spreadRadius: 2,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            child: Consumer(
              builder: (context, todoedit, child) {
                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TITLE
                      Text(
                        "Task Title",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                                if (widget.editingIndexID == null) {
                                  // ADD NEW TASK
                                  todoprovider.addTask(newTask);
                                } else {
                                  // UPDATE EXISTING TASK
                                  todoprovider.updateTask(
                                    widget.editingIndexID!,
                                    newTask,
                                  );
                                }
                                //reset
                                selectedPriority = "Select";

                                //back to screen
                                Navigator.of(context).pop();
                                // Clear fields after add/update
                                titlecontroller.clear();
                                despcontroller.clear();
                                datecontroller.clear();
                                selectedPriority = "Select";

                                //call custom snackbar
                                // customSnackBarWidget(message: "Task Added Sucessfully",);
                                // Show snackbar
                                showCustomSnackBar(
                                  context,
                                  widget.editingIndexID == null
                                      ? "Task added successfully"
                                      : "Task updated successfully",
                                );
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
                              widget.editingIndexID == null
                                  ? "Add Task"
                                  : "Update Task",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
