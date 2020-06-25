import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.authController});
  final AuthController authController;

  //create a new stream controller that controls the loading state of our SignInPage
  final StreamController<bool> _isLoadingController =
      new StreamController<bool>();

  //create a new stream,this would be the input Stream for the stream builder that we would add to the signInPage
  Stream get isloading => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  //this method adds values to a stream
  void _setIsLoading(bool valuesStreams) {
    _isLoadingController.add(valuesStreams);
  }

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<User> signInWithGoogle() async =>
      await _signIn(authController.signInWithGoogle);

  Future<User> loginInWithFacebook() async =>
      await _signIn(authController.loginInWithFacebook);

  Future<User> signInAnonymously() async =>
      await _signIn(authController.signInAnonymously);
}
