class Task {
  // our firestore document ID
  String id; 
  String title;
  String description;
  String date;
  String priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });

  Map<String, dynamic> toJSON() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "priority": priority,
    };
  }

  factory Task.fromFirestoretoMap(Map<String, dynamic> singletaskfromListofmap, String documentId) {
    return Task(
      id: documentId,
      title: singletaskfromListofmap["title"],
      description: singletaskfromListofmap["description"],
      date: singletaskfromListofmap["date"],
      priority: singletaskfromListofmap["priority"],
    );
  }
}

// class Task {
//   String title;
//   String description;
//   String date;
//   String priority;
//   //id for firestore document


//   Task({
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.priority,

//   });

//   //convert
//   //user
//   //model
//   //to JSCON
//   Map<String, dynamic> toJSON() {
//     return {
//       "title": title,
//       "description": description,
//       "date": date,
//       "priority": priority,
//     };
//   }

//   //convert
//   //JSCON
//   //to Model

//   factory Task.fromJson(Map<String, dynamic> singletaskfromListofmap, String id) {
//     return Task(

//       title: singletaskfromListofmap['title'],
//       description: singletaskfromListofmap['description'],
//       date: singletaskfromListofmap['date'],
//       priority: singletaskfromListofmap['priority'],
//     
//     );
//   }
// }
