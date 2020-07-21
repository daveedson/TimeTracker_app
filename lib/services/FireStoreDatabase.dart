import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/Api_path.dart';
import 'package:time_tracker_app_original/services/Database.dart';

import 'FirestoreService.dart';

String documentDateAndTime() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  @override
  Future<void> setJob(Job job) async => FireStoreService.setData(
        path: ApiPath.job(uid, job.id),
        data: job.toMap(),
      );
  @override
  Future<void> deleteJob(Job job) async =>
      await FireStoreService.deleteData(path: ApiPath.job(uid, job.id));

  @override
  Stream<List<Job>> readJobs() => FireStoreService.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );
}
