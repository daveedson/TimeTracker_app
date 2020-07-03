import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.authController, @required this.isLoading});
  final AuthController authController;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async =>
      await _signIn(authController.signInWithGoogle);

  Future<User> loginInWithFacebook() async =>
      await _signIn(authController.loginInWithFacebook);

  Future<User> signInAnonymously() async =>
      await _signIn(authController.signInAnonymously);
}
