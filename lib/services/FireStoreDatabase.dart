import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/Api_path.dart';
import 'package:time_tracker_app_original/services/Database.dart';

import 'FirestoreService.dart';

String documentDateAndTime() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  @override
  Future<void> createJob(Job job) async => FireStoreService.setData(
        path: ApiPath.job(uid, documentDateAndTime()),
        data: job.toMap(),
      );

  @override
  Stream<List<Job>> readJobs() => FireStoreService.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
