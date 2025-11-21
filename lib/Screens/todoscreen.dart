import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

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

  final List<Color> colors = const <Color>[
    Colors.yellow,
    Colors.green,
    Colors.deepPurple,
  ];

   //check is checked or not 
  //bool variable
  // bool statusIsChecked = false;
  // @override

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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TITLE
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 5),
                  //DESCRIPTION
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 5),
                  //DATE
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        //ADd TO OUR CONTORLLER

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
                  const SizedBox(height: 5),
                  Text(
                    "Priority",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
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
                  // const SizedBox(height: 5),
                  //  Text(
                  //   "Status",
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(height: 5),
                  

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
                            Task newTask = Task(
                              title: titlecontroller.text.trim(),
                              description: despcontroller.text.trim(),
                              date: datecontroller.text.trim(),
                              priority: selectedPriority!,
                              //initially id is empty
                              //will take it from firstore reference
                              id: '',
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
                              // UPDATE EXISTING
                              todoprovider.edtingOftheTask(
                                editingIndex!,
                                newTask,
                              );
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
                            // color: editingIndex ==null ?Colors.white :Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 40,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Consumer<Todoprovider>(
                builder: (context, todo, child) {
                  return todo.allTask.isEmpty
                      ? Center(child: Text("No Data Found"))
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 6);
                          },
                          itemCount: todo.allTask.length,
                          itemBuilder: (context, index) {
                            //extract
                            //sinle
                            //task
                            //with its index
                            final task = todo.allTask[index];

                            Color borderColor = task.priority == "Low"
                                ? colors[0]
                                : task.priority == "Medium"
                                ? colors[1]
                                : colors[2];
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),

                                border: Border(
                                  left: BorderSide(
                                    color: borderColor,
                                    width: 4,
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
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                       
                                      ],
                                    ),
                                    ReadMoreText(
                                      //description
                                      task.description,
                                      trimLines: 1,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: " More",
                                      trimExpandedText: "Less",
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
                                        Text(
                                          "Date : ${task.date}",
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        //EDIT ICON
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
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        //DELTE ICON
                                        GestureDetector(
                                          onTap: () {
                                            //call
                                            //delter from provider
                                            // final indextodel = todo[index];
                                            // final indextodel = index;
                                            // todo.deleteTask(indextodel);

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
                                                        String doctodelId = todo
                                                            .allTask[index]
                                                            .id;
                                                        int indexofTask = index;
                                                        todo.deletetheTaskFromFirestore(
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

                                                      child: const Text(
                                                        "Delete",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
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
    );
  }
}
