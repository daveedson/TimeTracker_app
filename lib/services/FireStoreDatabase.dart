import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/Api_path.dart';
import 'package:time_tracker_app_original/services/Database.dart';

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  //this method writes data to the cloudfirestore Database..
  @override
  Future<void> createJob(Job job) async {
    /*
   To write data in firestore you need to follow some steps..
   1. specify the path to the collection
   2. retrieve a document Reference that would be an instance of firestore.instance.documents("Store path created");
   3. Write the job data into this reference path location..
    */
    final path = ApiPath.job(uid, 'jobs_abc');
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
  }
}
