import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreService {
  //helper method to write data to fireStore
  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    await reference.setData(data);
    print('$path:$data');
  }

  //helper method to read data to fireStore..
  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
  }) {
    final collectionReference = Firestore.instance.collection(path);
    final snapshots = collectionReference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .toList(),
    );
  }
}
