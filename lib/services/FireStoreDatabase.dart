import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/Api_path.dart';
import 'package:time_tracker_app_original/services/Database.dart';

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  // method to use current date and time as DocumentId..
  String documentDateAndTime() => DateTime.now().toIso8601String();

  //this method writes data to the cloudfirestore Database..
  @override
  Future<void> createJob(Job job) async {
    /*
   To write data in firestore you need to follow some steps..
   1. specify the path to the collection
   2. retrieve a document Reference that would be an instance of firestore.instance.documents("Store path created");
   3. Write the job data into this reference path location..
    */
    final path = ApiPath.job(uid, documentDateAndTime());
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
    print('$path: ${job.toMap()}');
  }

  //this method reads data reads data from cloudFireStore..
  Stream<List<Job>> readJobs() {
    final path = ApiPath.jobs(uid);
    final collectionReference = Firestore.instance.collection(path);
    final snapshots = collectionReference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents
          .map(
            (snapshot) => Job.fromMap(snapshot.data),
          )
          .toList(),
    );
  }

//  Future<void> _setData({String path, Map<String, dynamic> data}) async {
//    final reference  = Firestore.instance.document(path);
//    await reference.setData(data);
//  }
}
