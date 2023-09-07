part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  success,
  failure,
}

class SignUpState extends Equatable {
  const SignUpState({
    this.email = '',
    this.password = '',
    this.confirmedPassword = '',
    this.emailError,
    this.passwordError,
    this.confirmedPasswordError,
    this.errorMessage,
    this.isTermsAccepted = false,
    this.status = SignUpStatus.initial,
  });

  final String email;
  final String password;
  final String confirmedPassword;
  final String? emailError;
  final String? passwordError;
  final String? confirmedPasswordError;
  final String? errorMessage;
  final bool isTermsAccepted;
  final SignUpStatus status;

  bool get isValid =>
      emailError == null &&
      passwordError == null &&
      confirmedPasswordError == null &&
      isTermsAccepted;

  SignUpState copyWith({
    String? email,
    String? password,
    String? confirmedPassword,
    String? emailError,
    String? passwordError,
    String? confirmedPasswordError,
    String? errorMessage,
    bool? isTermsAccepted,
    SignUpStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmedPasswordError:
          confirmedPasswordError ?? this.confirmedPasswordError,
      errorMessage: errorMessage ?? this.errorMessage,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        emailError,
        passwordError,
        confirmedPasswordError,
        errorMessage,
        isTermsAccepted,
      ];
}
