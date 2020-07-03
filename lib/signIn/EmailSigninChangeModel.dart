import 'package:flutter/foundation.dart';
import 'package:time_tracker_app_original/validators.dart';

import 'EmailSigninModel.dart';


class EmailSignInModel with EmailAndPasswordValidators,ChangeNotifier {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.submitted = false,
    this.isLoading = false,
  });

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

  /*
  because the variables are immutable we have to create a method to
  create a copy of those variables listed above via a method
   */

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