import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/Api_path.dart';
import 'package:time_tracker_app_original/services/Database.dart';
import 'package:time_tracker_app_original/services/fireStore_service.dart';

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  // method to use current date and time as DocumentId..
  String documentDateAndTime() => DateTime.now().toIso8601String();
  FireStoreService _service = new FireStoreService();

  /*
   To write data in firestore you need to follow some steps..
   1. specify the path to the collection
   2. retrieve a document Reference that would be an instance of firestore.instance.documents("Store path created");
   3. Write the job data into this reference path location..
    */

  //this method writes data to the cloudfirestore Database..
  @override
  Future<void> setJob(Job job) async {
    return await _service.setData(
      path: ApiPath.job(uid, documentDateAndTime()),
      data: job.toMap(),
    );
  }

  //this method reads data reads data from cloudFireStore..
  Stream<List<Job>> readJobs() {
    return _service.collectionStream(
        path: ApiPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId));
  }
}
