import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todowithprovider/model/todomodel.dart';

class Todoprovider extends ChangeNotifier {
  //create instance of firebasefirestore one time only
  static final FirebaseFirestore _dbServiceofFirebase =
      FirebaseFirestore.instance;

  //List of task

  final List<Task> _task = [];

  //getter for list

  List<Task> get allTask => _task;

  Future<void> addTask(Task task) async {
    //convert task to json cause firestore need json format
    Map<String, dynamic> addthistaskfirestore = task.toJSON();
    //here we add data to firebase firestore
    DocumentReference refofDocument = await _dbServiceofFirebase
        .collection("AllTasks")
        .add(addthistaskfirestore);
    //print refof documetn
    log("$refofDocument");
    //we need to store refofDocument in list of map for the each documet
    //causeso we can delete it from both list and firestore
    _task.add(
      Task(
        id: refofDocument.id,
        title: task.title,
        description: task.description,
        date: task.date,
        priority: task.priority,
      ),
    );
    // for(dynamic singletask in _task){
    //   log("${singletask}");
    // }

    notifyListeners(); //ui reflects
    log("Lenth of taklist: ${_task.length}");
  }

  //GET FUNCTION FROM THE FIREBAE
  Future<void> gettingDataFromFirestore() async {
    //getting data from firestore
    QuerySnapshot responsefromthefirestore = await _dbServiceofFirebase
        .collection("AllTasks")
        .get();

    //checking by log
    log("${responsefromthefirestore.docs}");

    //before adding to list empty the list usin clear() to handle repetation
    _task.clear();

    //looping on the each document from list of Map coming from firestore response
    for (dynamic singledocumentfromlistofmap in responsefromthefirestore.docs) {
      log("This is data from: ${singledocumentfromlistofmap.data()}");
      //okay data coming form firestore now add to local list it can reflect in ui itself because of provider and consumer
      _task.add(
        Task.fromFirestoretoMap(
          singledocumentfromlistofmap.data() as Map<String, dynamic>,
          singledocumentfromlistofmap.id,
        ),
      );
    }
    notifyListeners();
    log("Lenth of taklist: ${_task.length}");
  }

  //delete fucntion for firestore
  Future<void> deletetheTaskFromFirestore(
    String doctodelId,
    int indexofTask,
  ) async {
    log("Inside the delete function");
    //Delete From Firestore
    await _dbServiceofFirebase.collection("AllTasks").doc(doctodelId).delete();
    //Call getdata
    gettingDataFromFirestore();
    //call notifierlister to immdetiley relflect on ui
    notifyListeners();
    log("Lenth of taklist: ${_task.length}");
    log("Delted from both list and firestore");
  }

  //EDITING Function for the firestore and list

  Future<void> edtingOftheTask(int index, Task updatedTask) async {
    log("Inside the Editing Fucntion");
    log("$index and $updatedTask");

    Map<String, dynamic> addthisupdatedtasktofirestore = updatedTask.toJSON();

    //Id of the document
    String doctoEdit = _task[index].id;

    //update to firestore
    await _dbServiceofFirebase
        .collection("AllTasks")
        .doc(doctoEdit)
        .update(addthisupdatedtasktofirestore);
    log(("updated to firestore"));
    //once update
    //call getdata to reflect on UI
    gettingDataFromFirestore();
    notifyListeners();
  }



  // delete task method
  // void deleteTask(int index) {
  //   _task.removeAt(index);
  //   log("${index} item removed from list");
  //   notifyListeners();
  // }

  // //edit task method
  // void editTask(int index, Task updatedTask) {
  //   _task.add(updatedTask);
  // }

  // // UPDATE TASK
  // void updateTask(int index, Task updatedTask) {
  //   _task[index] = updatedTask;
  //   notifyListeners();
  // }

  // // ADD TASK
  // void addTask(Task task) async {
  //   _task.add(task);
  //   DocumentReference docRef =  await _dbService.collection("AllTasks").add(task.toJSON());
  //   log("Task with ${task.title} is added to firebase firestore");
  //   notifyListeners();
  // }


}