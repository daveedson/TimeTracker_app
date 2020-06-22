import 'dart:async';

class SignInBloc {
  //create a new stream controller
  final StreamController<bool> _isLoadingController =
      new StreamController<bool>();

  //create a new stream
  Stream get isloading => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  //this method adds values to a stream
  void setIsLoading(bool valuesStreams) {
    _isLoadingController.add(valuesStreams);
  }
}
