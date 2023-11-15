part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  sendingRequest,
  success,
  failure,
}

class SignUpState extends Equatable {
  const SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.phoneNumber = '',
    this.errorMessage,
    this.status = SignUpStatus.initial,
    // this.isLoading = true,
  });

  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String? errorMessage;
  final SignUpStatus status;
  // final bool isLoading;

  // bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
    String? errorMessage,
    SignUpStatus? status,
    // bool? isLoading,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      // isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [username, email, password, phoneNumber, errorMessage, status];
}
