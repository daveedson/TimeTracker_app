import 'package:flutter/foundation.dart';

class Job {
  Job({@required this.name, @required this.ratePerHour});
  final String name;
  final int ratePerHour;

  //create a method  so i can convert objects of this type into a map of key value pairs
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "ratePerHour": ratePerHour,
    };
  }
}
