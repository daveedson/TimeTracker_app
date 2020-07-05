import 'package:time_tracker_app_original/services/Database.dart';

class FireBaseDatabase implements Database {
  FireBaseDatabase({this.uid}) : assert(uid != null);
  final String uid;
}
