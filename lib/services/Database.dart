import 'package:time_tracker_app_original/Home/Job.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> readJobs();
  Future<void> deleteJob(Job job);
}
