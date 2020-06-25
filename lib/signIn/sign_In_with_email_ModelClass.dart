enum FormType { signIn, register }

class EmailSignInModelClass {
  EmailSignInModelClass({
    this.email = "",
    this.password = "",
    this.formType = FormType.signIn,
    this.isLoading = false,
  });

  final String email;
  final String password;
  final FormType formType;
  final bool isLoading;

  EmailSignInModelClass copyWith({
    String email,
    String password,
    FormType formType,
    bool isLoading,
  }) {
    return EmailSignInModelClass(
      email: email ?? this.email,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      password: password ?? this.password,
    );
  }
}
