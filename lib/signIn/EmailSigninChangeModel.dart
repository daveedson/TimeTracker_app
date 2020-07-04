import 'package:flutter/foundation.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/validators.dart';

import 'EmailSigninModel.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.submitted = false,
    this.isLoading = false,
    this.authController,
  });

  final AuthController authController;
  String email;
  String password;
  EmailSignInFormType formType;
  bool submitted;
  bool isLoading;

  String get primaryButton {
    return formType == EmailSignInFormType.signIn ? 'Sign In' : 'Register';
  }

  String get secondaryButton {
    return formType == EmailSignInFormType.signIn
        ? "Don't have an Account? Register"
        : "Already have an account Sign In";
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        emailValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? "Password can not be empty" : null;
  }

  String get emailErrorText {
    bool emailValid = submitted && !emailValidator.isValid(email) && !isLoading;
    return emailValid ? "Email can not be empty" : null;
  }

  //this method submits the form for login or registration.
  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await authController.signInWthEmailAndPassword(email, password);
      } else if (formType == EmailSignInFormType.register) {
        await authController.RegisterUserInWthEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false, submitted: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  //this method toogles the form type between registration and login..
  void ToogleFormType() {
    final typeOfForm = formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: typeOfForm,
      submitted: false,
      isLoading: false,
    );
  }

  //this method creates a mutable copy of variables defined in the constructor
  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool submitted,
    bool isLoading,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
