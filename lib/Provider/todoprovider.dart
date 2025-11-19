import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todowithprovider/model/todomodel.dart';

class Todoprovider extends ChangeNotifier {
  //List of task
  final List<Task> _task = [];

  //getter for list
  List<Task> get allTask => _task;

  
  

  // ADD TASK
  void addTask(Task task) {
    _task.add(task);
    notifyListeners();
  }

  //delete task method
  void deleteTask(int index) {
    _task.removeAt(index);
    log("${index} item removed from list");
    notifyListeners();
  }

  // //edit task method
  // void editTask(int index, Task updatedTask) {
  //   _task.add(updatedTask);
  // }
  
  // UPDATE TASK
  void updateTask(int index, Task updatedTask) {
    _task[index] = updatedTask;
    notifyListeners();
  }
}
