import 'package:flutter/foundation.dart';

class Job {
  Job({@required this.id, @required this.name, @required this.ratePerHour});
  final String name;
  final int ratePerHour;
  final String id;

  //this factory constructor allows us to read data from firebase
  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];
    return Job(
      id: documentId,
      name: name,
      ratePerHour: ratePerHour,
    );
  }

  //create a method to map t the objects in the database to the model class, to enable data writing
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "ratePerHour": ratePerHour,
    };
  }
}
