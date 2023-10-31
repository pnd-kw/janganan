part of 'sign_in_cubit.dart';

enum SignInStatus {
  initial,
  sendingRequest,
  success,
  failure,
}

enum UserVerificationStatus {
  initial,
  verifiedUser,
  unverifiedUser,
}

enum SignInMethod {
  initial,
  emailAndPassword,
  googleSignIn,
}

class SignInState extends Equatable {
  const SignInState({
    this.email = '',
    this.password = '',
    this.errorMessage,
    this.status = SignInStatus.initial,
    this.userVerificationStatus = UserVerificationStatus.initial,
    this.method = SignInMethod.initial,
  });

  final String email;
  final String password;
  final String? errorMessage;
  final SignInStatus status;
  final UserVerificationStatus userVerificationStatus;
  final SignInMethod method;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignInState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    SignInStatus? status,
    UserVerificationStatus? userVerificationStatus,
    SignInMethod? method,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      userVerificationStatus:
          userVerificationStatus ?? this.userVerificationStatus,
      method: method ?? this.method,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, errorMessage, status, userVerificationStatus, method];
}
