import 'package:time_tracker_app_original/Home/Job.dart';

abstract class Database {
  Future<void> createJob(Job job);
}
