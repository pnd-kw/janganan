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

enum GoogleVerificationStatus {
  initial,
  verifiedUser,
  unverifiedUser,
  failed,
}

enum SignInMethod {
  initial,
  emailAndPassword,
  googleSignIn,
}

enum GetExistingUserStatus {
  initial,
  getExistingUser,
  failed,
}

enum LinkStatus {
  initial,
  linking,
  linked,
  failed,
}

class SignInState extends Equatable {
  const SignInState({
    this.email = '',
    this.password = '',
    this.errorMessage,
    this.status = SignInStatus.initial,
    this.userVerificationStatus = UserVerificationStatus.initial,
    this.googleVerificationStatus = GoogleVerificationStatus.initial,
    this.method = SignInMethod.initial,
    this.getExistingUserStatus = GetExistingUserStatus.initial,
    this.linkStatus = LinkStatus.initial,
  });

  final String email;
  final String password;
  final String? errorMessage;
  final SignInStatus status;
  final UserVerificationStatus userVerificationStatus;
  final GoogleVerificationStatus googleVerificationStatus;
  final SignInMethod method;
  final GetExistingUserStatus getExistingUserStatus;
  final LinkStatus linkStatus;

  // bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignInState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    SignInStatus? status,
    UserVerificationStatus? userVerificationStatus,
    GoogleVerificationStatus? googleVerificationStatus,
    SignInMethod? method,
    GetExistingUserStatus? getExistingUserStatus,
    LinkStatus? linkStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      userVerificationStatus:
          userVerificationStatus ?? this.userVerificationStatus,
      googleVerificationStatus:
          googleVerificationStatus ?? this.googleVerificationStatus,
      method: method ?? this.method,
      getExistingUserStatus:
          getExistingUserStatus ?? this.getExistingUserStatus,
      linkStatus: linkStatus ?? this.linkStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        errorMessage,
        status,
        userVerificationStatus,
        googleVerificationStatus,
        method,
        getExistingUserStatus,
        linkStatus
      ];
}
